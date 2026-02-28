Return-Path: <stable+bounces-220959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAmEDcZco2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:23:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6F1C8F89
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D3DF34F260A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDA4A3411;
	Sat, 28 Feb 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO0lecyz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AC4A340D;
	Sat, 28 Feb 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301305; cv=none; b=OkYSRdcfsRUpLyO93JwCOdUMImBnC9meCSxQOVsWFyBewM1/w3CpW8ocYBq0NpvkViAJ2E9dQ9r9JcFxWSDgrGcWoiDWWqWyYFQNy9pONoRnwsneT7zvNcx/O5Z2ZmpWWq247IhTbG97+GxAgaLOR297zjbvDzQ7r6ho11rEznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301305; c=relaxed/simple;
	bh=zg1h++2Onp1Py0Wdm8niZwzIbpzCaE8f1VPplrFScIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A83lTEkGW2wj6vgpcK6Ed3Uu+lcyz1xhzMkQQAxvd6+ADNj7Fc/sIc4eJ1kE3YesNyai2tJzmAmEgT7moSPercRtslMUXbNBDpITXaUUqyVSFCdcYKBoleAdn4V4AhnDTpIBhj46cecwwgC6sCRyQnmJ3Tro1vMEOpKJgn46Y20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO0lecyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6AFC19423;
	Sat, 28 Feb 2026 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301305;
	bh=zg1h++2Onp1Py0Wdm8niZwzIbpzCaE8f1VPplrFScIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BO0lecyzZnC/P+SkIP1r0dLipzGcN5JQ6JV5mn/DXSreX7JFfzbFoBLbqNzaBUzEa
	 Q0Fe5LIppUD17U6NZuuRlMX6V7NOYHyTLHvtUZhlLflXuiJI0Klh0bD+eRbA20JYIl
	 JNfQ6usriLop9mqMIw5rLW/4kbW7u071AxKlhW20HXBvaXXMWMtpxVu6v/oBxs7vf2
	 SsYUiYX0wGGMXExhn2g+hJokeIyPJs4YR8jPHUziHcPz4Z73WImoLEUiWQzfOfTFdY
	 Kph4/ehozy727TglHOo1RIQU4UdGpMXtVZO/gryTdX4N+kxcdr2RvTi4yopXI6um3U
	 GcBQwiAmOFmMw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	stable@vger.kernel.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 490/752] media: verisilicon: AV1: Fix enable cdef computation
Date: Sat, 28 Feb 2026 12:43:21 -0500
Message-ID: <20260228174750.1542406-490-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[collabora.com,vger.kernel.org,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220959-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url,collabora.com:email]
X-Rspamd-Queue-Id: 9EB6F1C8F89
X-Rspamd-Action: no action

From: Benjamin Gaignard <benjamin.gaignard@collabora.com>

[ Upstream commit e0f99b810e1181374370f91cd996d761549e147f ]

If all the fields of the CDEF parameters are zero (which is the default),
then av1_enable_cdef register needs to be unset
(despite the V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF possibly being set).

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Fixes: 727a400686a2c ("media: verisilicon: Add Rockchip AV1 decoder")
Cc: stable@vger.kernel.org
Reported-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4786
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[hverkuil: dropped Link tag since it just duplicated the Closes: URL]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/verisilicon/rockchip_vpu981_hw_av1_dec.c  | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index e4703bb6be7c1..f4f7cb45b1f1b 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -1396,8 +1396,16 @@ static void rockchip_vpu981_av1_dec_set_cdef(struct hantro_ctx *ctx)
 	u16 luma_sec_strength = 0;
 	u32 chroma_pri_strength = 0;
 	u16 chroma_sec_strength = 0;
+	bool enable_cdef;
 	int i;
 
+	enable_cdef = !(cdef->bits == 0 &&
+			cdef->damping_minus_3 == 0 &&
+			cdef->y_pri_strength[0] == 0 &&
+			cdef->y_sec_strength[0] == 0 &&
+			cdef->uv_pri_strength[0] == 0 &&
+			cdef->uv_sec_strength[0] == 0);
+	hantro_reg_write(vpu, &av1_enable_cdef, enable_cdef);
 	hantro_reg_write(vpu, &av1_cdef_bits, cdef->bits);
 	hantro_reg_write(vpu, &av1_cdef_damping, cdef->damping_minus_3);
 
@@ -1953,8 +1961,6 @@ static void rockchip_vpu981_av1_dec_set_parameters(struct hantro_ctx *ctx)
 			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_SHOW_FRAME));
 	hantro_reg_write(vpu, &av1_switchable_motion_mode,
 			 !!(ctrls->frame->flags & V4L2_AV1_FRAME_FLAG_IS_MOTION_MODE_SWITCHABLE));
-	hantro_reg_write(vpu, &av1_enable_cdef,
-			 !!(ctrls->sequence->flags & V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF));
 	hantro_reg_write(vpu, &av1_allow_masked_compound,
 			 !!(ctrls->sequence->flags
 			    & V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND));
-- 
2.51.0


