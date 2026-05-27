Return-Path: <stable+bounces-254663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OPVLINLF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:52:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2305E9BB3
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7D39311B253
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54A13B19B4;
	Wed, 27 May 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVFU/fEQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D373B0AF8
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911302; cv=none; b=Zi/xlkjhTt9YueCdHuVtCXjCYFS0xMWAahdG7wV/ZPWeIqHg4hCjYVB+qsGgq9RR3H7+dPTE0zqyQyt1onGsucHfMISIs8sMNRs9YuK2zwuo8iCOXYyeyCLFy6kcdmAUKxHqR/rpX2IcNhCR6+AFopLgixUJnukcewxBW4lKDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911302; c=relaxed/simple;
	bh=I53hd6CWTc3R94gXD+1qGG83yFt3BgYNnue52JOpibA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9IpkcxqFbgtEa9aTz70zLnMmQS2mmkO4o0nalY1ztv/cPU9rQpK3W0zHmRJqB0qPfA6g64irRUvKN6SQuuUs0aS4/2SbF6f3OfTwmhGPtguVqosrS29N2ii/4JPfjZ2TrU1uHVC+kE7N9tO/V/uG79mjrE4HydZnnPDSWpgE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVFU/fEQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-911449d9d03so1360711485a.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779911299; x=1780516099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvwC2v7tf0bP6Dcjl3lKTCXZwlNlpqu4CB+86cy9Tlo=;
        b=eVFU/fEQPAp0ZdXRZjGxp829SgOYsKhhyBzp3VQBI8jySwgmIR1tA9zRrGRYKKdfOn
         YGCxwfyj+fwsw4R1JUNuFz4uYo05WlITufcQfx77Wo6EiGtwqup36/r41J46/rDAcriO
         OyjRpaWSHnQ7HradsvDffiMbWHhGbrWfuNXXP39Rtg+TwL5Fv8Wt70W3qrEa+61OeUnB
         N1NHYeNg+6GmfvGn3icrc3lHaDWdSeAwxmWXRr9B78NDdqLKcaBXn7/Gu7YS8a/pN2A9
         nLiZ4UgjOuS9wPqEx+jHfWLHu/Ow1HSdKLrUraWp3nNu/cu4+jPmnq3s8mnXSk/mBloQ
         EAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911299; x=1780516099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvwC2v7tf0bP6Dcjl3lKTCXZwlNlpqu4CB+86cy9Tlo=;
        b=cHV46DT00qSyDf/Oe71gpE4Fpm7pomEzwWr5bClzMkAE0miRdvsP4CnzeHpTwTuZ3h
         ycuGJVErXbEGqkJy6PjJWSNwBE3fJkBy4s5yfQ2WcXwRoJ41GrDEo9lXpA/kiUqxkBKx
         wvpd+SNdrvIuibCss3CIMORxACs+R6hJJ+YlwppCEDtdTIKQJ2gaX7jw7DS9kqFOxZGP
         7/RgSU/LIEnVzr3gLBZ4Cso9hXDVgOPcwEWzvNzMNcvhaABPOYPQmEpmpmnKYS0JnL9V
         rl0Wr2Cjgl5/ny9tmoR03kh6ybV+f7kfOWlizZGxpzxOOjawrqPbFwbVEYHd2UX+OHHc
         YASA==
X-Forwarded-Encrypted: i=1; AFNElJ/5Q7yU3casDS5+Y3h70kgf1LzP7TSotVaL70SGou+uajFq9F7LNrlynyMVjPgWJGZ9Kye2ngw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTTPtLm6wcRs84hJcAxuCmOTnhh4Y+qMp8lOEvBMWfqefpkmEJ
	v1+fg6pebOIo7tZ02UyEtLVzz9oJ1lUOe8td37ni4gUppURWw07asHDmvfADepZfVWA=
X-Gm-Gg: Acq92OF6Q5D9U3W9kzTYb2nrOLFu3jPxffaUCvvfmbjYMwUysEo5/3jBYHTfpvNA1x7
	kbFBEXgWiocYHkOfUiIPG+K6kQKs9dawVG5rb5K6+tIdrbcbNZkb1ukw6as+fhI9RaAYiiDE9bq
	YCRCIqAcjVAqZKcy2XiuB8mCPH2vBApAk4lu58lpBnAB9oXERrmrO9xq8M4fi4JqpXtaw08QebP
	vw6n4wqx5iVbF8sBkhYjJF42o05avXC6WqBrpSQTACD7NTXhQ54Xj2iTs6mQVA+pwKqhskcm1C2
	VH41BvBjRwsASHchaTZ9UtzNQQBJ8BvpuE3HvGzV2Gtwx2W8yiCHQbIGk1hcHNI7dSiuwn4Q4tW
	1F4a+O8r249sRwRoS6cX1VJDUNa6KrB0FVYZ0Fa6Fvh5gDfJStwRowxWjoiXD/zTzO1EYbSX4Kj
	eZ6y4mYMrD2+lCAaBk9lphqlzTSmeYZBHhRtW8TnKq3BdLqkdw5ghTVbQAOBCerP76qQNmrJyNu
	LzOk1iai+K6Ru+vxqXbssF36md9HHiNbGXuPxLvdMbybpC5h0PlaQ==
X-Received: by 2002:a05:620a:2b45:b0:914:da39:eadb with SMTP id af79cd13be357-914da39ee49mr2225042385a.12.1779911298765;
        Wed, 27 May 2026 12:48:18 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87017a0sm564942385a.15.2026.05.27.12.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:48:18 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] media: v4l2-ctrls: validate HEVC EXT SPS RPS counts
Date: Wed, 27 May 2026 15:47:36 -0400
Message-ID: <20260527194737.1999409-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527194737.1999409-1-michael.bommarito@gmail.com>
References: <20260513181922.2075438-1-michael.bommarito@gmail.com>
 <20260527194737.1999409-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-254663-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4C2305E9BB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The HEVC SPS control carries the short-term and long-term RPS counts
that decoder drivers use to walk the matching EXT SPS dynamic arrays.
Reject SPS values that exceed the HEVC limits of 64 short-term sets and
32 long-term references so drivers cannot later index beyond those
controls.

Also reject EXT SPS ST RPS entries whose negative or positive picture
counts exceed the 16-entry arrays, or whose combined delta-POC count
exceeds the HEVC DPB maximum.

Fixes: c9a59dc2acc7 ("media: rkvdec: Add HEVC support for the VDPU381 variant")
Cc: stable@vger.kernel.org
Suggested-by: Detlev Casanova <detlev.casanova@collabora.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 6b375720e395c..a1d773e5de20c 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -16,6 +16,9 @@
 
 static const union v4l2_ctrl_ptr ptr_null;
 
+#define V4L2_HEVC_MAX_SHORT_TERM_REF_PIC_SETS	64
+#define V4L2_HEVC_MAX_LONG_TERM_REF_PICS_SPS	32
+
 static void fill_event(struct v4l2_event *ev, struct v4l2_ctrl *ctrl,
 		       u32 changes)
 {
@@ -1213,6 +1216,10 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 	case V4L2_CTRL_TYPE_HEVC_SPS:
 		p_hevc_sps = p;
 
+		if (p_hevc_sps->num_short_term_ref_pic_sets >
+		    V4L2_HEVC_MAX_SHORT_TERM_REF_PIC_SETS)
+			return -EINVAL;
+
 		if (!(p_hevc_sps->flags & V4L2_HEVC_SPS_FLAG_PCM_ENABLED)) {
 			p_hevc_sps->pcm_sample_bit_depth_luma_minus1 = 0;
 			p_hevc_sps->pcm_sample_bit_depth_chroma_minus1 = 0;
@@ -1223,6 +1230,9 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 		if (!(p_hevc_sps->flags &
 		      V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT))
 			p_hevc_sps->num_long_term_ref_pics_sps = 0;
+		else if (p_hevc_sps->num_long_term_ref_pics_sps >
+			 V4L2_HEVC_MAX_LONG_TERM_REF_PICS_SPS)
+			return -EINVAL;
 		break;
 
 	case V4L2_CTRL_TYPE_HEVC_PPS:
@@ -1267,6 +1277,11 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 
 		if (p_hevc_st_rps->flags & ~V4L2_HEVC_EXT_SPS_ST_RPS_FLAG_INTER_REF_PIC_SET_PRED)
 			return -EINVAL;
+		if (p_hevc_st_rps->num_negative_pics > 16 ||
+		    p_hevc_st_rps->num_positive_pics > 16 ||
+		    p_hevc_st_rps->num_negative_pics +
+		    p_hevc_st_rps->num_positive_pics > 16)
+			return -EINVAL;
 		break;
 
 	case V4L2_CTRL_TYPE_HEVC_EXT_SPS_LT_RPS:
-- 
2.53.0

