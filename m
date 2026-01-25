Return-Path: <stable+bounces-211488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GeiKDvgvdmmjNAEAu9opvQ
	(envelope-from <stable+bounces-211488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 16:00:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EB581186
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47B803004C6E
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2531B80D;
	Sun, 25 Jan 2026 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgS5R1GF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455B1F461D
	for <stable@vger.kernel.org>; Sun, 25 Jan 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769353204; cv=none; b=me3OGFlzCoYe5vE5/CVoW5rhGloTdym+kdZ0PMNOFmA5cC4xeR1mSZF/zVmaIru6AYlheNVufYs21XYoDddSOdPzzIasjhA74mIFBFNBkUytx0jwCc2fzkPo98IMBwOBSenGNWcrHNHXsM1V/E6Oh9ucK026N6D3jTrjBf0TrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769353204; c=relaxed/simple;
	bh=IIaOkiMl0+0OniP81s+srZPjVFERVFHSDf8B5qCgaXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/9Jz0o5+9wb/9FOSPDhgNBl3IHyGslWqPMDEKnBS5kwU6nCS+SJCAZEstHIBAEC9Ts1oWXVNcuXwbfvfAss27Af5ikKYGWRI1x+Yp+IQ7OA6OHA9+NSK4LnM9dnkLuI7X6LBin7Csh0aC+OGsbY3MO6M0dW8ARbr5RpJQQb4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgS5R1GF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81e93c5961cso3257487b3a.0
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769353202; x=1769958002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtPcAa/eA0+6dIk9uSAqy9NJNwcCQhRCZhxbQHlEB6E=;
        b=TgS5R1GF9OIObnRMDpm2l+XceOGnw0AbII+B6aSIFD+BSXDHNoVMnbHrrsusRcT99V
         9CyzcP/rPlxAYjGF0K8V2ZQRefujaECSkxIPYF4PouAvVlPuU4ZwpjhPmZqM1UtgWuqZ
         8Mp6fG0dQoLrAQILErhtY9kzAogvBPYKo3y4jxMZuFPzItlRJ4rr/uk00bNRoiI+DtsW
         Mc/MVBN0B4pk40YYC4ZwhbBtJEEA/pxZozVQvcYLgzvlRTpLpImmc80KMCcFEfJ9hk0K
         S5Da49BxtjYnQfo5vBmrbGTIQEEPTz5QfWrSdVdeo/zHPS7cRpokK1FhscVQsVsOwdbN
         O9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769353202; x=1769958002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vtPcAa/eA0+6dIk9uSAqy9NJNwcCQhRCZhxbQHlEB6E=;
        b=EklrH1BbwJtaeRR1k+OiEGc8c3KNjDoZezQdPp1MtCfwcaIiUFVZVsaPj7MwOgnNvI
         7wKXKsd9p2mQ24duJ1OnveziaItNvrc5GHNrHlsY7mXl76hkpjecPSh535+Eo6n12kTD
         HwfI3n85szK1o0qKsB8ZoAx7rjzHSYInmrVgk1kEeYHjFbGrd6aaNLIy26DHbc0MEAm4
         wOIo/JRwLOf2D5FdX5TRqoa1c3QgnC8VwPnzGkKsf9M0i/GDdbaGn+YCX/zDmH8LuIz5
         apKEgGtnEbScbdBwekxeKCKQb04/H2u3ZpHzhhAmtMtlsdeXUvEipSemywZfxZlpDmUy
         Zd3w==
X-Gm-Message-State: AOJu0YzYdhYnRLyVYEwYP3FQu2B3fxWxLiUHkhYmWE+Mt5DFCR9aOKDv
	yWvSdZSgRgJvsTv2mI16ZFbRiRSb6tw8K4nDu9smD41unXcm3jbcqquF+rNiKszW
X-Gm-Gg: AZuq6aJw8MJUtpKz1iVGz5Sr9VAyShfYadD1YPXbAdUTW/hfYn8ufL5iejJx93OXK25
	FOQBRdNQtKURriqtkoAPhOshGyS/pWZhdrH/1tTN8a18bGakFxlE5Mm+MpKie3Hf1gyl+4htUPK
	fsWsCs8a4iTc3SjyiNjlflYVQd4974ZqFovp3kwFD26YF//HHHuHLfgQQF9a4g8IEIfIUJCs1Vt
	s8bbo6hL3qi6/sZHvQbBTNT1P/EDTm7PPdx+dwpWqU5IgM41fDjtjkPP3TeM4J+x8Hm4juT6jQt
	mDduDeh7gk0D5oDs3d8Y+wKfTJBe7MxVCaFWRP8RHP/qXUM07Y6m3z7I9pjjM8r8D8Yu5e2se6z
	ZRW+ad010cw+uk3my/oatUcWwp18NFccXWCSsdcW1t88ztxcZgmVKP/U0exobUy0IXddky4dkoP
	G/n7Uw3dl8Jv4F8cxA3mMEdbY6T9c9w7Tuxjwf
X-Received: by 2002:a05:6a00:7609:b0:823:878:dd40 with SMTP id d2e1a72fcca58-823411b8199mr1595565b3a.4.1769353202266;
        Sun, 25 Jan 2026 07:00:02 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:9eef:365d:4ce8:fead])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231871dd7bsm7053317b3a.39.2026.01.25.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 07:00:01 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: bjsaikiran@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] media: qcom: camss: Fix pipeline lock leak in stop_streaming
Date: Sun, 25 Jan 2026 20:29:54 +0530
Message-ID: <20260125145955.54069-2-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125145955.54069-1-bjsaikiran@gmail.com>
References: <20260125145955.54069-1-bjsaikiran@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211488-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 82EB581186
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


