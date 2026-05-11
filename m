Return-Path: <stable+bounces-245308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFyfDuQQAmqIngEAu9opvQ
	(envelope-from <stable+bounces-245308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:24:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF1513602
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2201F315E5F4
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5038D46AF0A;
	Mon, 11 May 2026 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjhzhaPR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F946AEE8
	for <stable@vger.kernel.org>; Mon, 11 May 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519548; cv=none; b=fYdxQws/vErOqERzoOTbn7jweIhx3ILWVVGreF+ADqStjGDPbv90UMSUgCKkg182XMmwLea1+eAOyb0OZjvGbTXJ6rshNFxb4tpAROmzc7/csnSrPo8E+RhBfuTBpjQqDAI/pdo5dh3L/erSE8qTIIg0nLRfMvjZY9zHCefE0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519548; c=relaxed/simple;
	bh=EB/e87XuFCPUJ72NiJ6scGbM1z6scuWykz1rqgsY/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJjiWljXFUGehnEGXlqjWgH13CUCo/FLgBlTEfbfAJ0i+ijntEi1tuyDYbqJ1AdFFFJic0otQzVUERvb2mqS+n47yDrQZVUaQZIhW2WxMAouEkVfd4qpDkWVbVHso7i6C+ixVCKIF7+o673tjWinM+C6ybTm8SDJ6d9JfGesDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjhzhaPR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a8c6fc5fd3so1465015e87.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519544; x=1779124344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxqdxYVfNyLoxNKHswDJZT0z/g1AEcUqUWKcspgGBc8=;
        b=PjhzhaPReJcaowg8zFxZPNbzVtMQAnjvdXilDrhccdbcSwsqziux/y5gSUAPeW7sGH
         1RbUt5Nc/oUawa9unvDwS/dmL1T/uYchbX8Cvkq6a22Pl5/UB9vooV6rNiHgHjTO9/6Q
         UvQ1tE2XDKNahZ9+tXOtZiAOwzgdzziRevnpBE8/vTRuVJNuQ91qN0Vg1fojsEkjMUT7
         V6TNx43ZaQnhpY9XSaL2mHV/iCDH1DDErlco4EpzNvbiAcqHfQytiFpdaa0AWWWhR1ax
         Mi9uTKwi7AzBmgRwO1O/X3MU2zsosOfPxJzScnqv7u5sfDZ7AT73ddm98wxK0ASS02qK
         Q5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519544; x=1779124344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fxqdxYVfNyLoxNKHswDJZT0z/g1AEcUqUWKcspgGBc8=;
        b=tSjJMW7SL5H+PiyAasV+kvZ9Gr4gVfFwVkIy4XHQH5yCyrQ7w6hUmUYWatYLjsR/O1
         IZcaUprRLQySMDzb3+lAI+QJ11AXmCdCQ0vZpcidnR9JQvUuvC/sqdaeCJIVrd1cHvjE
         1jFoFGQ6kkbzlrXAdAuQ3sD0GcpbZhoEbVAD14Zro2gT4lq1Z1zIuO77SnJMIQKL/f/D
         sgO0exuzpu3no6XgbGUCSZKW22y68sTZsqm1dkCePH1SHTgXFbmmac8tLFmO0mljjFGA
         OeqHhKXCFdGYL8ys4FvSQnt7TdMwpoMRnpAJjPVGiNkI97vLsByH+WLjDnUYXIntF89N
         8WKA==
X-Forwarded-Encrypted: i=1; AFNElJ+mPPSuJgct9TTuuwOMLJgg5YKO9VSMe4VMLfKxbgyziZy77aFRjfNPGzs/LuBsKxMd6vqs78o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLSQR/5P9JnR+kvZm7i94rZ1J3EoSyWVOg5tFFn0iPD2vqPUpI
	zF5NesvGVfWa3rSw06Am3/plqaghtfC4FRDbhQBGTGIgiAK78KdKCbiv
X-Gm-Gg: Acq92OGSK/+5PVHFBegJ9XRFCl1sATnoyeRbGeEXKJeuMenLac2pg3WxG7Pta9jpzto
	urfazOlGDbG0z4Ht0K7kmECNIKtrbovlhg7FYRQfobcA6GDgbSqLvDMtW7v+anB/HLI2RhPFmP5
	aExGdrnaOVoveBX5XF0Ww8VO1D0pHoKVN6vovnSzYlZqK6TQHWuLvlffLk3UaN6GRMNMwdG4LLb
	b1imGjsdi5hv5ewB34CJQdEOl8RHz0s/8crG/o1prG/qWfhe8J22EPEUIwt18g5CtoOd8aOExHk
	q6B5NegarcPzAboiXaYtJDyeq3vVliCwF+5Kyrm2kO8wJrUP6N6W7jvOv3EiBnKDg2scBwwx5BG
	H3ZYZvZliIvd9r4P7ZrrLfP2TE85te15bRAQjn2UTcD3zvNs5AV3aJ3d0EJ1gNkB4eP6/P07FUZ
	NNxFbqzaNlezFEUESyE/S6mFEbYyx+r5cZVnPNfpkzemTF/VTsEo/i34+fSzU7
X-Received: by 2002:a05:6512:2309:b0:5a2:b86b:56c2 with SMTP id 2adb3069b0e04-5a8e0f35137mr91615e87.21.1778519544242;
        Mon, 11 May 2026 10:12:24 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95660b6sm2765488e87.62.2026.05.11.10.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:12:23 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil@kernel.org,
	hansg@kernel.org,
	hugues.fruchet@foss.st.com,
	alain.volmat@foss.st.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	sakari.ailus@linux.intel.com,
	mripard@kernel.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Valery Borovsky <vebohr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/6] media: stm32-dcmipp: Return queued buffers on start_streaming() failure
Date: Mon, 11 May 2026 20:12:10 +0300
Message-ID: <3b7c3d1be61bcf092484016e25e7b8add98bbe0d.1778518085.git.vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1778518085.git.vebohr@gmail.com>
References: <cover.1778518085.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0BF1513602
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,foss.st.com,gmail.com,linux.intel.com,sholland.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-245308-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The vb2 framework hands buffers to the driver via buf_queue() before
calling start_streaming().  If start_streaming() returns an error
without first returning those buffers via vb2_buffer_done(),
vb2_start_streaming() fires WARN_ON(owned_by_drv_count) and the queued
buffers leak.

dcmipp_bytecap_start_streaming() returned -EINVAL when the source
subdevice could not be resolved from the media graph, before
pm_runtime_resume_and_get() and media_pipeline_start() had been called.
The remaining error paths already converge on the err_buffer_done
label, which calls dcmipp_bytecap_all_buffers_done(...,
VB2_BUF_STATE_QUEUED).  Jump to that label directly: the intermediate
err_pm_put / err_media_pipeline_stop labels are skipped, which is
correct because nothing they would undo has happened yet.

This mirrors the uvcvideo fix in commit 4cf3b6fd54eb ("media: uvcvideo:
Return queued buffers on start_streaming() failure").

Fixes: 28e0f3772296 ("media: stm32-dcmipp: STM32 DCMIPP camera interface driver")
Cc: stable@vger.kernel.org
Signed-off-by: Valery Borovsky <vebohr@gmail.com>
---
 .../media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c   | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
index a42f43d19f9e..f0e809458489 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
@@ -401,8 +401,10 @@ static int dcmipp_bytecap_start_streaming(struct vb2_queue *vq,
 	 */
 	if (!vcap->s_subdev) {
 		pad = media_pad_remote_pad_first(&vcap->vdev.entity.pads[0]);
-		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
-			return -EINVAL;
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity)) {
+			ret = -EINVAL;
+			goto err_buffer_done;
+		}
 		vcap->s_subdev = media_entity_to_v4l2_subdev(pad->entity);
 		vcap->s_subdev_pad_nb = pad->index;
 	}
-- 
2.51.0


