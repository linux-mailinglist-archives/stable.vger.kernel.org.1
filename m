Return-Path: <stable+bounces-221053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP1KEDhIo2mm/AQAu9opvQ
	(envelope-from <stable+bounces-221053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9574E1C78C6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF0DA3478715
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5461A4C0420;
	Sat, 28 Feb 2026 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ5dO5dK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392C47CC96;
	Sat, 28 Feb 2026 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301397; cv=none; b=qi0ky4QiIrcFQ1nWGtHZLCaDVeF6nsQLKQ6en9tWGmwME+w+HLpAp8Qla3J8wkwFfOtOpnw6Ars4UTdgUIkaFtVqAqwzcBRQm5qTq8zDCsonT9pRyOxyClqq8RI2k3S535uoYRI/mlY+bA/39AamqioZyhv7lkXFcLmaPK2SvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301397; c=relaxed/simple;
	bh=ERqG7+7TcdUzvV8LO+YQRDPeUQH7NLyuGGHIqXUpaP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCJaLtlGndTjleRjP8Q3Yen1yRHNzp73zQZbrbaP/6wemftkGKQV5fHHA46Hoeo1bKI3myrxp6dBj1envtnlgFm6MCsMnudgTY7gLPlWRLTcLw0vxeckN4XYgXjXX6OWz6e/icuwr4XM1zexKm0ecXdSW/LKOi6pnVVGrI0VieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ5dO5dK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD37C2BC87;
	Sat, 28 Feb 2026 17:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301397;
	bh=ERqG7+7TcdUzvV8LO+YQRDPeUQH7NLyuGGHIqXUpaP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJ5dO5dKa/8IrEMPkf+WzXX5jIKI1qgyHWRhfhMDnVrGmJcMod5SbZTXyZq3kQa1C
	 WB0DsDH0oKmMk5f8nVmvmMDiz7GcLiq1nmD4cVIpcX/UeJYg7CIT0zut1uC5CuUyfv
	 TWWSAwtL25EaYH2bEkFgM9o42C5wFIb+lHzYqkL40LkOKV3QG7Rt9BuNYJRu0i3NqF
	 yy1EbLSYj4SFUZXKPPmwFnS29G9SYQB+ymt5nxv1DpHn70VV+a8LZ1wORXer1l16Dk
	 D5IXc291gbfE+TCPVtmzfASOEn9IfjHS7e5R7LCM5AxjguNmtdB7QpKLkdbKIrnu+i
	 X2IWxOVu0NIMw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	stable@vger.kernel.org,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 585/752] media: verisilicon: AV1: Fix tile info buffer size
Date: Sat, 28 Feb 2026 12:44:56 -0500
Message-ID: <20260228174750.1542406-585-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221053-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9574E1C78C6
X-Rspamd-Action: no action

From: Benjamin Gaignard <benjamin.gaignard@collabora.com>

[ Upstream commit a505ca2db89ad92a8d8d27fa68ebafb12e04a679 ]

Each tile info is composed of: row_sb, col_sb, start_pos
and end_pos (4 bytes each). So the total required memory
is AV1_MAX_TILES * 16 bytes.
Use the correct #define to allocate the buffer and avoid
writing tile info in non-allocated memory.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Fixes: 727a400686a2c ("media: verisilicon: Add Rockchip AV1 decoder")
Cc: stable@vger.kernel.org
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index 500e94bcb0293..e4e21ad373233 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -381,12 +381,12 @@ int rockchip_vpu981_av1_dec_init(struct hantro_ctx *ctx)
 		return -ENOMEM;
 	av1_dec->global_model.size = GLOBAL_MODEL_SIZE;
 
-	av1_dec->tile_info.cpu = dma_alloc_coherent(vpu->dev, AV1_MAX_TILES,
+	av1_dec->tile_info.cpu = dma_alloc_coherent(vpu->dev, AV1_TILE_INFO_SIZE,
 						    &av1_dec->tile_info.dma,
 						    GFP_KERNEL);
 	if (!av1_dec->tile_info.cpu)
 		return -ENOMEM;
-	av1_dec->tile_info.size = AV1_MAX_TILES;
+	av1_dec->tile_info.size = AV1_TILE_INFO_SIZE;
 
 	av1_dec->film_grain.cpu = dma_alloc_coherent(vpu->dev,
 						     ALIGN(sizeof(struct rockchip_av1_film_grain), 2048),
-- 
2.51.0


