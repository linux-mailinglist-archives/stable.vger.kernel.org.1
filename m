Return-Path: <stable+bounces-223901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGv+J4T7r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:07:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E9249FDF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8DF8304024E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779EE3859E7;
	Tue, 10 Mar 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clCSv9GK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0A346E7A;
	Tue, 10 Mar 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140800; cv=none; b=GkN5+8D/c3a+p4wds6Kijty+fcjv8Y2vv+pkg8SllHya9d5yxEakMeu0s1/Zf9K2nDKBMaurcBzgxGYQQVJSBSG+1pzYHEJFgEYh40lWy0Y08JqEvf3DhQsrGGqp4P551fR6uD4OvqoIip0zEjJQSOWBJRTXmcJfn2BHtohZpSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140800; c=relaxed/simple;
	bh=/cCS9y9HRhdSKdJiAmw2BPTfl0mSf2Fmwc0xanRtO2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwLbj9bgo5EXLFrvZcGnfM9dtn+hkEnykwWZjyFH7TIqT1tcYrBQhSEUnkGTQr71IhffRbJ7z+ocSoJVDgAENa6Nog5lIY514Wx6OAiI6yoi9DKRsCMHsXs6mGzLFGKSD/pjzv+mtXby2cRLli19Ejq0GTeguxJkXqBtDi3bTcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clCSv9GK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58710C2BC86;
	Tue, 10 Mar 2026 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140799;
	bh=/cCS9y9HRhdSKdJiAmw2BPTfl0mSf2Fmwc0xanRtO2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clCSv9GK9d4U4y1fT2O40BLPQVMSyNXqOWOo2JjcjaAsPkRHUDnRKNdjVMCAgmOij
	 VQ4CUrY2rloXvYEGwRmoJqSfDsLXAMz01NKcs4VbhrSHUu2TF1caNfjF8cUhIjVZPv
	 yIMOJ+SHCwp9wzTPVLoB0EeSit+h/7/F9D5crXBS0dueo/MAR8OlZAKEDyfN4DRP9o
	 T2PZxYFADjIW4KlwiULc9kE8BvhQ0aTCaElRDPBLSHOws7l3FVS+Ag93/4TeeChEL6
	 lpJNE5Ewh3hsoueU/RSQwcCmoyIa2QaUHv+wqYWnkB9pjtRua/xfFVIH1I8LKB8HqM
	 xHlk77FTRdaoQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 037/311] accel/amdxdna: Fix suspend failure after enabling turbo mode
Date: Tue, 10 Mar 2026 07:01:24 -0400
Message-ID: <436d3e5362de44889e975a0873b2845f66610260.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3C1E9249FDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223901-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,amd.com:email]
X-Rspamd-Action: no action

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit fdb65acfe655f844ae1e88696b9656d3ef5bb8fb ]

Enabling turbo mode disables hardware clock gating. Suspend requires
hardware clock gating to be re-enabled, otherwise suspend will fail.
Fix this by calling aie2_runtime_cfg() from aie2_hw_stop() to
re-enable clock gating during suspend. Also ensure that firmware is
initialized in aie2_hw_start() before modifying clock-gating
settings during resume.

Fixes: f4d7b8a6bc8c ("accel/amdxdna: Enhance power management settings")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260211204716.722788-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/aie2_pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 20568d0f9a639..3356c9ed079a8 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -341,6 +341,7 @@ static void aie2_hw_stop(struct amdxdna_dev *xdna)
 		return;
 	}
 
+	aie2_runtime_cfg(ndev, AIE2_RT_CFG_CLK_GATING, NULL);
 	aie2_mgmt_fw_fini(ndev);
 	xdna_mailbox_stop_channel(ndev->mgmt_chann);
 	xdna_mailbox_destroy_channel(ndev->mgmt_chann);
@@ -424,15 +425,15 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 		goto stop_psp;
 	}
 
-	ret = aie2_pm_init(ndev);
+	ret = aie2_mgmt_fw_init(ndev);
 	if (ret) {
-		XDNA_ERR(xdna, "failed to init pm, ret %d", ret);
+		XDNA_ERR(xdna, "initial mgmt firmware failed, ret %d", ret);
 		goto destroy_mgmt_chann;
 	}
 
-	ret = aie2_mgmt_fw_init(ndev);
+	ret = aie2_pm_init(ndev);
 	if (ret) {
-		XDNA_ERR(xdna, "initial mgmt firmware failed, ret %d", ret);
+		XDNA_ERR(xdna, "failed to init pm, ret %d", ret);
 		goto destroy_mgmt_chann;
 	}
 
-- 
2.51.0


