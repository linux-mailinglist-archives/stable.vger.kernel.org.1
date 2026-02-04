Return-Path: <stable+bounces-213578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIZ9FSlig2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:13:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A88FFE8261
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC02E30FCD1B
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B7341B36A;
	Wed,  4 Feb 2026 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dD97PvOH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4EA41B360;
	Wed,  4 Feb 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216802; cv=none; b=RnPZ3n/+zXdsImFmBR5T8Cbuyr6eA88IuseZMJUgoHuI2Ki8wYizXznscs/NbDcG1USv5j0PuIh9SBy4WY35puunRwhBIQdUb8MfXdVQSSoU2PmEYmvMLyJ6UknAz47BmTt4TmJ7SZMPecVXf8psmRtE6bWiFa0acjl5/mx+hzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216802; c=relaxed/simple;
	bh=qiHk+c1XPwUt83e003wExTR7/zK0cTydjRS4rpX15BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5w0DAEKoh/5+YuJDG+u1mPyknRZoqMOaoXX0XjvK1rS5NYa9qN84Vl0oxwjq54bnLLz1oQYwaCnS6xv/c6EeyWxTCKmKEbzi1f5EbPi8GcDdWNxdMc9ryVGnDjKg0xmvOQ5Ptbexy5VE2g74qXmjBGy2XE3ws6zR2RA0zzNTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dD97PvOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4CEC116C6;
	Wed,  4 Feb 2026 14:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216802;
	bh=qiHk+c1XPwUt83e003wExTR7/zK0cTydjRS4rpX15BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dD97PvOH3oj+JQdXzJSzddj6kvje3sfyVDUKBQN2qUbH11P/flzDtPth2hrY36CDi
	 uDQYYZBEZQV757owaHz+g1dLwt+GjSQBttw+tRlWy9vyMAzq/p5agESJIdFOvkM+3W
	 kl2iyhl/In7+ACVhq9Z1mrvlcQd6BVbSGTqU/bQ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 036/206] EDAC/x38: Fix a resource leak in x38_probe1()
Date: Wed,  4 Feb 2026 15:37:47 +0100
Message-ID: <20260204143859.509434744@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-213578-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,alien8.de:email]
X-Rspamd-Queue-Id: A88FFE8261
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

commit 0ff7c44106b4715fc27a2e455d9f57f1dfcfd54f upstream.

If edac_mc_alloc() fails, also unmap the window.

  [ bp: Use separate labels, turning it into the classic unwind pattern. ]

Fixes: df8bc08c192f ("edac x38: new MC driver module")
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251223124350.1496325-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/x38_edac.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -341,9 +341,12 @@ static int x38_probe1(struct pci_dev *pd
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = x38_channel_num;
 	layers[1].is_virt_csrow = false;
+
+
+	rc = -ENOMEM;
 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
 	if (!mci)
-		return -ENOMEM;
+		goto unmap;
 
 	edac_dbg(3, "MC: init mci\n");
 
@@ -403,9 +406,9 @@ static int x38_probe1(struct pci_dev *pd
 	return 0;
 
 fail:
+	edac_mc_free(mci);
+unmap:
 	iounmap(window);
-	if (mci)
-		edac_mc_free(mci);
 
 	return rc;
 }



