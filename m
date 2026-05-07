Return-Path: <stable+bounces-244638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK26BDH9/Gk9WQAAu9opvQ
	(envelope-from <stable+bounces-244638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 22:59:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A50364EF106
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 22:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C42F3043390
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 20:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F734216C;
	Thu,  7 May 2026 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YvSM6sac"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C733451B0
	for <stable@vger.kernel.org>; Thu,  7 May 2026 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187504; cv=none; b=uJlBR6CzrXlFiTq/iaF9oXN4XHBz8+nXhwNw5/47HUk8907ve3/897cTNLmkjdxmX76J9auCbjFWCz/e5LFHcWFkO1aqyhf/bLY0GaFK1PzLEcu2vEBCR9D6GDzKbjR2Nyv4xMichbukO8PN62Ghz5xo+Pu5dBsJGg3A6xhgAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187504; c=relaxed/simple;
	bh=d+O67gl2GIGylI6phsIj9TBlpbKokc/OVLyxskjLlYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kTTCTi3RHbZQF7BH9jyREXa7a9s3HgdBp/1kTUPUw5cupqRMTzbTMEUS36f8ucbZpZsrwMcLwEKuE56iZFpP4FMwFMvphhNupxBmbYe5tqVerO8evpaMSxvkS62o9mNvHnPoXuSYPb9s7IbUg7W4ghcJ1Yk7Sc1tijpROQfZ3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YvSM6sac; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39380e79936so17331171fa.2
        for <stable@vger.kernel.org>; Thu, 07 May 2026 13:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778187501; x=1778792301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62sCEoVz1H20Bvb3z6VX8x/23MkbndGwBQZwPeDoJW4=;
        b=YvSM6sacUMKa5ReKxmV7Q6pj41AlEYXrqcgW7YQSTTQhdE1QTtPNvF4irkpkkSJtUB
         8B1tPznI35SNAR73xrdhf4ZMOqTFI30H884e8NwPDMUdEtbVTgxiqpe+361SEe2CRi+v
         4mv12opnfXkfMF6RV033R4C+XztH7q+uy1Ex4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778187501; x=1778792301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=62sCEoVz1H20Bvb3z6VX8x/23MkbndGwBQZwPeDoJW4=;
        b=MJHszCIoaH0XF/LAdR0KyYUcEqx4akM9ChH09ctAzIw2jEh16syWxeQaBzB9YYdjhQ
         JE+nDg56exZOa4G+mBPmrDh6AUJapMkOzPYnr1Ek22/NOfv64wm+b3IsKnr3+rpQfZq1
         mDp/zA52EpvB+/dvSJOR7sCXUBQ9em5B98wXWB/RsfF7GTdrMy3rPCL40q2qDlPIHMzN
         7wDVGFc2ZhM5PtiIRDTDLOSTKMnbauf0dNDGg/BCBqtPyB145z+GyVyn17F8gBUEr/X5
         YgUIcDppp0WFvacOXgjmGUqoSiyY3qoZ5vuIV/bjU6xQ1PfGl0k0NsC7QKQHkBE26o1x
         aBdA==
X-Forwarded-Encrypted: i=1; AFNElJ9heUBy0/vSU2rG1WNCnGQhYL/ZbJaVVevzwwPQAzxuu/yuN03hiA7PCI/GaPxK+jV5NlAphEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJag4jvKzHemmJeAssfpT3LZNMHQ8+hif1ZGPWSdbTSNpAl6S
	IJx78W59De0yzw+OBMUv0f+Rnn0dQZQ8Q1jrtxTNB5WowWlsAyW9dLSLFQN80Z2Kxw==
X-Gm-Gg: AeBDiesqadTpQVGVjZwwO4C5to1aOdUAk58GftBwvbCCGPsDns0R1CrgkGV25rqmAX3
	ZcjdP5Mvxx3KQN7cY/7k7WpCnDU4gN8vblaybOiog1vzNdrx52DwhROrD5N5uzaO5H5t1bd4ZLZ
	gTUB5aYemsgl1uSdmU1Eccd/lNjnh7GTjsKo8k1pklJ1nPhgDbZ5f7ZmARqGpQX/LWZJt6kMr+T
	VSYmglBBO/aKjKHGLPgvwlb6skiL0K74qlKfnlbeoEi/OE8jiXmUXSfC8LyZOvfT8FI2qlWBtKY
	oTqigrbqlX8bTGhiryqVzQy68ipt7LYPeRRQCX46cai2palQdw4VoYIiJCORjWh4LbYHIkcb7mE
	XQDvG7gbEp8a6Iw95MBeUTY1Mqn1Jw+eK2HJRoSAQ8sh5zx//sxTbEKbw9A1jwVWOTPbuwjX+qd
	HwiU9lqS1PCM8K3yz3agd09r29o9cmTdU6xIJPhKDYheLkKYL+pAuC+HlDT16j7JfjiFv2O7t5W
	4Q7uf8=
X-Received: by 2002:a2e:9783:0:b0:393:903c:225b with SMTP id 38308e7fff4ca-393c4338719mr27191651fa.31.1778187501297;
        Thu, 07 May 2026 13:58:21 -0700 (PDT)
Received: from ribalda.c.googlers.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393eee53655sm2325571fa.0.2026.05.07.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:58:19 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 07 May 2026 20:58:11 +0000
Subject: [PATCH v4 6/6] media: amlogic-c3: Add validations for ae and awb
 config
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-smatch-7-1-v4-6-cc195f142167@chromium.org>
References: <20260507-smatch-7-1-v4-0-cc195f142167@chromium.org>
In-Reply-To: <20260507-smatch-7-1-v4-0-cc195f142167@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>, 
 Jackson Lee <jackson.lee@chipsnmedia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Keke Li <keke.li@amlogic.com>, Yong Zhi <yong.zhi@intel.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: A50364EF106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-244638-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,samsung];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Avoid invalid memory access if the zones_num is bigger than
zone_weight.

This patch fixes the following smatch errors:
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:111 c3_isp_params_awb_wt() error: buffer overflow 'cfg->zone_weight' 768 <= u32max
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:111 c3_isp_params_awb_wt() error: buffer overflow 'cfg->zone_weight' 768 <= u32max
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:227 c3_isp_params_ae_wt() error: buffer overflow 'cfg->zone_weight' 255 <= u32max
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:227 c3_isp_params_ae_wt() error: buffer overflow 'cfg->zone_weight' 255 <= u32max

Cc: stable@vger.kernel.org
Fixes: fb2e135208f3 ("media: platform: Add C3 ISP driver")
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/amlogic/c3/isp/c3-isp-params.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
index 6f9ca7a7dd88..aec3eed0e443 100644
--- a/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
+++ b/drivers/media/platform/amlogic/c3/isp/c3-isp-params.c
@@ -104,6 +104,8 @@ static void c3_isp_params_awb_wt(struct c3_isp_device *isp,
 	c3_isp_write(isp, ISP_AWB_BLK_WT_ADDR, 0);
 
 	zones_num = cfg->horiz_zones_num * cfg->vert_zones_num;
+	if (zones_num > C3_ISP_AWB_MAX_ZONES)
+		zones_num = C3_ISP_AWB_MAX_ZONES;
 
 	/* Need to write 8 weights at once */
 	for (i = 0; i < zones_num / 8; i++) {
@@ -220,6 +222,8 @@ static void c3_isp_params_ae_wt(struct c3_isp_device *isp,
 	c3_isp_write(isp, ISP_AE_BLK_WT_ADDR, 0);
 
 	zones_num = cfg->horiz_zones_num * cfg->vert_zones_num;
+	if (zones_num > C3_ISP_AE_MAX_ZONES)
+		zones_num = C3_ISP_AE_MAX_ZONES;
 
 	/* Need to write 8 weights at once */
 	for (i = 0; i < zones_num / 8; i++) {

-- 
2.54.0.563.g4f69b47b94-goog


