Return-Path: <stable+bounces-220352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBruET0zo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:26:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB91C5C81
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59BB132777B7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75339DB86;
	Sat, 28 Feb 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QT1/8tEc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F047F2FF;
	Sat, 28 Feb 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300250; cv=none; b=Rce2sY6rJ9iWjKRuERQXObrwPMcrO/+TWlYIAxdsKYSxdiy7kOD9i9uO5Ldh0ohQ0iOWYv5lUP5jdFjRqnA5cgqt5fv9ISdmY7+E6y2Lqko9rhqhH89xmwoNLX0umrDIR8T82ETMZITfx2WnNP0PKCyK2lXIIZ9ikm/hMotrDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300250; c=relaxed/simple;
	bh=FCb30k1Yk5xOQOk0x/m/+4XhFlQeC+CWlzsrZHCYduM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvTBGDHaQxUVrRFz3a7m+M8MiDyjkNqyqTAZox60jbGCgRySMwXSoM2QURe4iZRCQ68M890J5SBwZhZRGaEGCQsLrO4hDYXOiKPHW/RLA4hKjso8piyMZsi6dq7/P3b9gKsZ+grSWMbGsk8x5QPSX1DmJEUmWw65YBhOojbCdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QT1/8tEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B155C19425;
	Sat, 28 Feb 2026 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300249;
	bh=FCb30k1Yk5xOQOk0x/m/+4XhFlQeC+CWlzsrZHCYduM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QT1/8tEc0gAVrD7zwd75xy+liT6uPe1HTfDuyF04v61x2YA/GqGPhoSDxGRcmKuQ/
	 9/qKm1sHxM5wJdXC+z7/B0gKp5QjVpBXdxJY/2Z5akK6+FX966WyjrQYDTcxkB86Ie
	 iVPgcUsVcNJiHblomOsekU1R/eGiDWhBTO6yNxWTbfm1287IsjhDVnoJ4CbQYFw41F
	 CU2SJ3W6Cjobwrxu9aw9ClGCqWje6YWj+wsjpfsa3lzhtIMPFQ5x0Jx1voa2YMhcrW
	 yYfb2yvvIKR2QXS3asZ3MVBw0PVOnbLZ3h5jwU816MaPIil7yg9ArCRPhaJrZ6FoXv
	 cpcao/PzQiGtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 274/844] wifi: rtw89: mac: correct page number for CSI response
Date: Sat, 28 Feb 2026 12:23:07 -0500
Message-ID: <20260228173244.1509663-275-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220352-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 10DB91C5C81
X-Rspamd-Action: no action

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit aa2a44d0d22d45d659b9f01638809b1735e46cff ]

For beamforming procedure, hardware reserve memory page for CSI response.
The unit of register is (value - 1), so add one accordingly as expected.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260110022019.2254969-7-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 9b9e646487346..dee5ff71b75fe 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1175,7 +1175,7 @@ static int resp_pktctl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RESP_CSI_RESERVED_PAGE, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_START_PAGE_MASK, qt_cfg.pktid);
-	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_PAGE_NUM_MASK, qt_cfg.pg_num);
+	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_PAGE_NUM_MASK, qt_cfg.pg_num + 1);
 
 	return 0;
 }
-- 
2.51.0


