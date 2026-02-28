Return-Path: <stable+bounces-221034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHDUIy1do2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:25:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E5B1C9048
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 730B036078A9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C294BCADE;
	Sat, 28 Feb 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuLRW2r5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85804175A6A;
	Sat, 28 Feb 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301376; cv=none; b=Y9xSOSYWjeBUmZruyFDgfAPo1Rwx3bOpAsOdDjLe//2KE3JLEr9fbaF/3HM+6YkNLsQYn0mRzVxUJd1j9JVZc0ON2tBKjZDzlo6M+eEKkqsxOboJjbBPAvbLAp3RATH6MNJRAeNCtpb9b+eR8fIbPbrgp5YJYVN1nf28y+lWtOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301376; c=relaxed/simple;
	bh=OWCOhCGZi+/pG6EbYCRtEvhHzqHBeIEHKtlrL4Iz5IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPqUm2wkLP+Q2XGfXqYzKqhF3y38h6PsNFmCoP7d456+J2ZTdG5SFmIhOpF0UgCfMGZjOrtGaA1hPIfCUhTQ18XMEFSC9HVGI9Axt/b5iNu/G95lC6i2For7tb1TJTiG0leeumiAhnnPAV3RoEN8BRrc9isCRW8isIadX6RA8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuLRW2r5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCF2C19423;
	Sat, 28 Feb 2026 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301376;
	bh=OWCOhCGZi+/pG6EbYCRtEvhHzqHBeIEHKtlrL4Iz5IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuLRW2r5d/mxHACWL8o/VHsTnv7bOuko3ewMPt7OoHOthw9p5cw1CeZ4iSltaegd1
	 fvuIC/ZBmh8GRb7qEbkRNzyrhoGs5hTiHYI9mC1PqlI1QWeMFEhFJVzlz8ua9p+gwy
	 YnN8wPRtVvogVj/+RhoUWhHQPvlvIVpb/wguLDz0auOW9NkJM4J4MP2yg0tFk4eLAb
	 cL/Ztxy+edBf6zxlXje7NSivmmDoFpN9jLR7hu3zxUFStwRaB5HS90HS0j0fGbSP2P
	 mTOM6jWmfbkk4ZdqvXD9X1AzH4C5CVk0SoZCfhw3SqHPX+tpn1n5mHC+jzX3eUVgNC
	 KHMUCreAwj2cg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Mecid <mecid@mecomediagroup.de>,
	Renjiang Han <renjiang.han@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 565/752] media: venus: vdec: restrict EOS addr quirk to IRIS2 only
Date: Sat, 28 Feb 2026 12:44:36 -0500
Message-ID: <20260228174750.1542406-565-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221034-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,mecomediagroup.de:email]
X-Rspamd-Queue-Id: B3E5B1C9048
X-Rspamd-Action: no action

From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

[ Upstream commit 63c072e2937e6c9995df1b6a28523ed2ae68d364 ]

On SM8250 (IRIS2) with firmware older than 1.0.087, the firmware could
not handle a dummy device address for EOS buffers, so a NULL device
address is sent instead. The existing check used IS_V6() alongside a
firmware version gate:

    if (IS_V6(core) && is_fw_rev_or_older(core, 1, 0, 87))
        fdata.device_addr = 0;
    else
	fdata.device_addr = 0xdeadb000;

However, SC7280 which is also V6, uses a firmware string of the form
"1.0.<commit-hash>", which the version parser translates to 1.0.0. This
unintentionally satisfies the `is_fw_rev_or_older(..., 1, 0, 87)`
condition on SC7280. Combined with IS_V6() matching there as well, the
quirk is incorrectly applied to SC7280, causing VP9 decode failures.

Constrain the check to IRIS2 (SM8250) only, which is the only platform
that needed this quirk, by replacing IS_V6() with IS_IRIS2(). This
restores correct behavior on SC7280 (no forced NULL EOS buffer address).

Fixes: 47f867cb1b63 ("media: venus: fix EOS handling in decoder stop command")
Cc: stable@vger.kernel.org
Reported-by: Mecid <mecid@mecomediagroup.de>
Closes: https://github.com/qualcomm-linux/kernel-topics/issues/222
Co-developed-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
Signed-off-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Tested-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index ba4d9087bff5d..27cb024427b83 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -567,7 +567,13 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 
 		fdata.buffer_type = HFI_BUFFER_INPUT;
 		fdata.flags |= HFI_BUFFERFLAG_EOS;
-		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
+
+		/* Send NULL EOS addr for only IRIS2 (SM8250),for firmware <= 1.0.87.
+		 * SC7280 also reports "1.0.<hash>" parsed as 1.0.0; restricting to IRIS2
+		 * avoids misapplying this quirk and breaking VP9 decode on SC7280.
+		 */
+
+		if (IS_IRIS2(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
 			fdata.device_addr = 0;
 		else
 			fdata.device_addr = 0xdeadb000;
-- 
2.51.0


