Return-Path: <stable+bounces-232286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPuFAhgGzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B5836EFC5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A118330B7EC9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56058425CC5;
	Tue, 31 Mar 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7Fqz9DJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023E423A62;
	Tue, 31 Mar 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976357; cv=none; b=OgpYZWX/yUqkVrBPKyDraH3Cqexj8/X0pb61NmZOdg3NXD6JqyGqc0Tt4ZZKtX4JKnMp7w7uKsXmRQ8qE4UlnxfW+lWrWOkC1GjmjdprR5pr4JpGDwugpULqvM59aTOKHOXL1yTCwVKamrG/MJOZtPcE0m4jy2BvMEPf3yusfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976357; c=relaxed/simple;
	bh=AzU/cS4ZkHL8EDkKxYl/pNQ2/7ynCP2r4B9O3RinjJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7cZM/XUHhwCbBUMMjt8WyZU5v6b6EY8d5vusqrP815DxRV6W7LQM8hdijXED9mBF4AYqK+JTrzTkT7S55k56u+P+6zrV70iAbzAKoXay7PytBiYH8q+5ZBvpZUPfCoKH4fC2O73+vh2Gl0dkujwXuKfsNmp2+oI/C1metXjY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7Fqz9DJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F46C19424;
	Tue, 31 Mar 2026 16:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976356;
	bh=AzU/cS4ZkHL8EDkKxYl/pNQ2/7ynCP2r4B9O3RinjJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7Fqz9DJjUZ1zk5GvPRP8FbM/lAOKjm0iXfcOTRHdlfDl593GIUmJSNmxobm6pTjF
	 S9+k7TBAZxAbmx+Go7Eh/p7BNe0unE5Ho/tZDHNjMfewfgcZSXSg5oF93s2v5MGcEx
	 2JzhkOaWVXRmTWHBEwPfbTb52s0DTesA72OMVy6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 028/309] HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
Date: Tue, 31 Mar 2026 18:18:51 +0200
Message-ID: <20260331161754.516736077@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232286-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 24B5836EFC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Günther Noack <gnoack@google.com>

[ Upstream commit 91e8c6e601bdc1ccdf886479b6513c01c7e51c2c ]

The magicmouse_report_fixup() function was returning a
newly kmemdup()-allocated buffer, but never freeing it.

The caller of report_fixup() does not take ownership of the returned
pointer, but it *is* permitted to return a sub-portion of the input
rdesc, whose lifetime is managed by the caller.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-magicmouse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index f4cf29c2e8330..9eadf3252d0dc 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -994,9 +994,7 @@ static const __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev,
 			 "fixing up magicmouse battery report descriptor\n");
 		*rsize = *rsize - 1;
-		rdesc = kmemdup(rdesc + 1, *rsize, GFP_KERNEL);
-		if (!rdesc)
-			return NULL;
+		rdesc = rdesc + 1;
 
 		rdesc[0] = 0x05;
 		rdesc[1] = 0x01;
-- 
2.51.0




