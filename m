Return-Path: <stable+bounces-255284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFeMByegGGpvlggAu9opvQ
	(envelope-from <stable+bounces-255284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:05:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE8E5F7D0B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D00BF307AF1D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50CC409623;
	Thu, 28 May 2026 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTbgxTp7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836591AA1D2;
	Thu, 28 May 2026 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998477; cv=none; b=Z4pFqjzUrX8Wgm54PxBSsht6VmpI16VAhbOqGqAy/7vCygj2RtyTlKoaH/tau5g85x/9fN1FjnCJUWY+5LFEzedf7ZrmwvgMLW0uOlYR4urZ+JDvYIxbW+BkNfAi6lDJnGV5nwuNIadYmbLQZCnqLWX9oEy5aGvNqJcjeyOxMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998477; c=relaxed/simple;
	bh=opHldEzE8sKeNMPCecOmkTn3UkSFTRVbgDmfOMP09wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKZFc3Xeouzx7WI0Ou0YrK2uFoJXtAGKbbPLBHdgVFYfb48dTy7Rv12HlIcqrRS8PXZEdEFSMDHGq7fIKEJsq7G1viA0PcYFqjA1q/SiwvN2LlSJ2oaKAlqEe4ARwClE8/7Fy/QJBWUnhGB0ASbpNCE9BxpsQvePjSCt8z76h7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTbgxTp7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05231F00A3A;
	Thu, 28 May 2026 20:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998476;
	bh=BPT5S4TltYcx7QfnK2LYSP6675mcwohyDFkC34D9+Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BTbgxTp7XJEISp9qdAhPUBo/mCaUSwfz8XMaon8OggwjeUTkgNSThdY2bgLcAT+fY
	 oldzWhNhVuWQleQ9m5Sbx/lFs4OJog5IYqyX/StA7B8RVW9jPFurrzUTcZ4+vJLRd4
	 SOY4VxaQAeV/a3R4kxQHi5lBoFwhAJglxNFE/9dY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 186/461] HID: uclogic: Fix regression of input name assignment
Date: Thu, 28 May 2026 21:45:15 +0200
Message-ID: <20260528194652.459923440@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255284-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9DE8E5F7D0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 487359284509a6745e14b8c0518768bc277809b0 ]

The previous fix for adding the devm_kasprintf() return check in the
commit bd07f751208b ("HID: uclogic: Add NULL check in
uclogic_input_configured()") changed the condition of hi->input->name
assignment, and it resulted in missing the proper input device name
when no custom suffix is defined.

Restore the conditional to the original content to address the
regression.

Fixes: bd07f751208b ("HID: uclogic: Add NULL check in uclogic_input_configured()")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-uclogic-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index bd7f93e96e4e4..b73f09d26688a 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -184,7 +184,9 @@ static int uclogic_input_configured(struct hid_device *hdev,
 			suffix = "System Control";
 			break;
 		}
-	} else {
+	}
+
+	if (suffix) {
 		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						 "%s %s", hdev->name, suffix);
 		if (!hi->input->name)
-- 
2.53.0




