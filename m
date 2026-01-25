Return-Path: <stable+bounces-211486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id U1wrA/8udmk8NAEAu9opvQ
	(envelope-from <stable+bounces-211486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 15:55:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0832F81165
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 15:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 358FA3004C68
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634131E5B9E;
	Sun, 25 Jan 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxdzTRFs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610014BF92
	for <stable@vger.kernel.org>; Sun, 25 Jan 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769352954; cv=none; b=Bj7TB5GiXUtxQdVtKywzMH9Jv6NUCheb4M3DUQIijrGiMbdIGvm7O0MHYDkkhp8Gw8Dq9AP5UU5mzfPo9aUoL9eJ4XiwtqzYm0mo2Z0JEfilyKgsusYQrqdpiyCSxTiSdR1pg73w6h0SfCQj6rK8oXcvqu/Jp4atbH/sj3K+Gqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769352954; c=relaxed/simple;
	bh=IIaOkiMl0+0OniP81s+srZPjVFERVFHSDf8B5qCgaXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpIL+yxbpFVgRNNXNXgkyRLhFfm+0bLh9/ROZiuKiczsy6wPnGsgUuEi2GTKKsTmvs8Azg146bb0XIwc/zdjEo/IgymAVTABEtwnsyknobyC4B68k99HY79ApOWhjqBWRHmw3s8zopVixQcntvE5G0/NZTU98zT3UlYBOEYLe98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxdzTRFs; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c47ee987401so1489078a12.1
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769352952; x=1769957752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtPcAa/eA0+6dIk9uSAqy9NJNwcCQhRCZhxbQHlEB6E=;
        b=QxdzTRFsNJ76W6Aimhh7YwOBL3hXkWiKUZ903RoCp3DbbUxSFp3vQOR1UWU/uuYe/F
         ZQ6kCMaLGLucwCvz+uI+2eODnM07pUeS3zR+b9owrRuVBuOFLr/+SYGmDctP9laE9Jld
         uORxp5kU6Jo9bqpcFtXH2hxT//MdU00JJ2FlZmn7iE/HfDfWDBSF2Mzc+3A6QId6nKgV
         eQjiDHcAG7VgsvjAwiap734u2n6eTCciNlQfAxnstLaW//pcHH4CR+1SXWXjkxOFf2/5
         I15+t1noSiRnz47gSO2CavB4GCgIGO4R2SOF8x/aCoBjt3io4yKNEBcE5mC1B10brzz8
         d30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769352952; x=1769957752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vtPcAa/eA0+6dIk9uSAqy9NJNwcCQhRCZhxbQHlEB6E=;
        b=G8oB1ZH2jATyhbJ8pUiEc7qBt3VvkvNk721IHdoivrGOdgE+gDvZkHMeAJQur+l6wL
         uHW1zgirOl8vG0xslULJJ7hFvM/W1sXfh9SXy3Of7ZEvSbKuM61XPgz36UJaTbyYjhvr
         h5zngw/5v4ougGh7vNfLquRbUc0GK4iGdSMk3A+qfyUXOkNDGwOE0Y6nlRkW0LQ0vSXl
         R/kUL8NymbjFFFYgkTi440pOR6NBJvEnk/QVD8aOxh7FERLQNn0L8KRArvweOKfJ5T+P
         gPzio7BgzSHnUAS7/xP5Fe1Cnq3V1jFKSi8o3Pkfpc0FZpcwWh56sX75T8kFJRf74Upu
         XmeQ==
X-Gm-Message-State: AOJu0YzEme1jmPHwcQkMPFla38fa6u35SmKoOk9k7UgH0NwyxoSFn9FP
	soMkvV6K1skek6d+pC0BL0WdQ1dp1qoJtYx4qS64hqNuFyhKurVMz5u/sXni+iSh
X-Gm-Gg: AZuq6aJgJjQciCY+jJxMIduTGjE7PzCRDBclP8qoUcvbtcTaeHjbwc0BH84ZDS+LBJU
	macFt2wXk/ozqdQUh7WBGeD+2BTUsh8M9Fk20viMF8dDgnjiBcDJIDeqxsv6rL1Ke/Eu0y0hjTt
	h0kAdm7LZnSJIlG52WYRWelzlsf4tp+9yeZDmWq8MveQFR27WnH74uT49KRRMCVYhuFjItBA8pP
	zlvc5CjG2Q/mKIqZjvXio2O0OjSyyuOIdSrKPFn7kCagBv+ESTU9v/d+w0kn6CUQrBypwyc6yLe
	8JfQkTGkScfBNWnig8MFMzZ1kiq1XsivSWaCiD0EmaujyTE6lW5OmGuXdcol0nNLR6btL8sBbCn
	jwh6zlkDlk+Jq3dbHVSlVhhgN9NowAX9MWnsg+OzA3tkk6U+TNsq/bYzCMuQABelhWF41AlCVPA
	SHvFGkf8HPVKlN4RFDBA/T8nWp0JaU7K+3C4qF
X-Received: by 2002:a05:6a21:e598:b0:35d:8881:e69b with SMTP id adf61e73a8af0-38e9e5eafe6mr1580590637.18.1769352952142;
        Sun, 25 Jan 2026 06:55:52 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:9eef:365d:4ce8:fead])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a42e8ecsm6452382a12.32.2026.01.25.06.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 06:55:51 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: bjsaikiran@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] media: qcom: camss: Fix pipeline lock leak in stop_streaming
Date: Sun, 25 Jan 2026 20:25:43 +0530
Message-ID: <20260125145544.50785-2-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125145544.50785-1-bjsaikiran@gmail.com>
References: <20260125145544.50785-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211486-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0832F81165
X-Rspamd-Action: no action

When a browser or application closes the camera, if any subdevice fails
to stop streaming, video_stop_streaming() returns early without calling
video_device_pipeline_stop(). This leaves the pipeline permanently locked,
preventing any future camera access until reboot.

Fix this by logging errors but continuing to stop all remaining subdevices
and always releasing the pipeline lock, even when errors occur during the
stop sequence.

Fixes: 89013969e232 ("media: camss: sm8250: Pipeline starting and stopping for multiple virtual channels")
Cc: stable@vger.kernel.org
Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite, ov02c10 camera)
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/media/platform/qcom/camss/camss-video.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index 831486e14754..242c44f97801 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -312,9 +312,15 @@ static void video_stop_streaming(struct vb2_queue *q)
 
 		ret = v4l2_subdev_call(subdev, video, s_stream, 0);
 
+		/*
+		 * Don't return early on error - we must continue to stop
+		 * remaining subdevices and release the pipeline lock to
+		 * prevent the camera from being permanently locked.
+		 */
 		if (ret) {
-			dev_err(video->camss->dev, "Video pipeline stop failed: %d\n", ret);
-			return;
+			dev_err(video->camss->dev,
+				"Failed to stop subdev '%s': %d\n",
+				subdev->name, ret);
 		}
 	}
 
-- 
2.51.0


