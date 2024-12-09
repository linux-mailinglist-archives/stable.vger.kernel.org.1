Return-Path: <stable+bounces-100114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7448F9E8F2D
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 10:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D9E28281A
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 09:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F6216E14;
	Mon,  9 Dec 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TKugvTDf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB343215706
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737777; cv=none; b=uUKuUwdh6NRTPqZfR+PeSlGac9hWlXSXGfF+MKrUH8D6ZgepMqpyRM22fodQaDRF4xkeDAe0lFPMEiS+/dOkiUQp+o8cB/7+m5qG+IGgjlOmL0iyAnSZ3jrc7tqZIljrXL4Lr5VdjdLiMZC0Ega565cXPDAKJdMF2b+m2AAOmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737777; c=relaxed/simple;
	bh=gvzytYw4sbSQU/ATlBNgaGw+c3UqmAd600g9QF+80xI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtAiRpevVR7x7SpSV4wmaskHaAnvW4q+/yFgzKN61Fsr3y3BDrOFhX817rzzQAinSxvxREVakQraqq10jdHIvsxXiYdCgvv88zIHBLMugpZ6WVRfmTVv2MzFzoq+yKvv3q6Ki4gc967idG0bEbxGQS3kdlcHX3Gm2nxJZGR33FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TKugvTDf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46753242ef1so21643081cf.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 01:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733737774; x=1734342574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3Tsa9g564W559Vpb/AnoUfrIQ3XajXQIt2s3wRsgwk=;
        b=TKugvTDfoBjOS6n5X6dlr8+LRrTGoK+Bdp0iBq1DSpt/J9guRKpqF+/duZEsnGtn7S
         46zDbcnV4SGVVXJqbNgkpj/lIEKZFS8lujrYx3TLBr3+BVcx7GA1Mx3dvN1gInwBl13Y
         YRRzQmjmRArCK33HI5ijbNz5UX9mEXAqohZH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737774; x=1734342574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3Tsa9g564W559Vpb/AnoUfrIQ3XajXQIt2s3wRsgwk=;
        b=gYfKdtfh6RvifRWVfX+I3jQRowOGUQVqBVy9+5RQgGHqcvJxFVVWouiWKcwux1edym
         9NJ99W9i7rNEIo+2KICZJS3kHpvlestk25EzLBlOb5j1cK6WwliROb128LWYXxozJpfT
         8V9/ZcCIN508BJsyX+3hMQieNzdyIPXxRSG33O3OCS0bb5UaZanJ0poTY/vG/qle35aw
         PILjGBwccRN3Hj0UKXmwxFGnUTwkMR7X93NaHRLpgQNWZAMXfeiq1ypD0Tv+vul0Lh1F
         HIkn33nPOjhnAV2MtKkQQhEGpihqdHFjGjnaEpMU+4g91L8hdnhXwC6F7BiEOLN8GnvS
         T+GA==
X-Gm-Message-State: AOJu0YxPhNcXb0S7IRD2qF51bfFOfCm+geNwzCgtyExdFvFCgJGmIKpq
	zTHCjYPxFtY/GXGY9WMXw7h5jICxkhoMBnNnQPjLR9844NjCD2iAvJGpLvHSEOobnhMoRDP+KRK
	+SDy/Gjtvj6CTlBdIJT7qaLHZ4/PUslFeTeY/wD4elh6iRHeI0UriDo4XJy3U9VZauEbpQq/eUw
	wGp5TCdC6eqAuJkOeiLx1orWqgTDefQ9pEYtcqNH85
X-Gm-Gg: ASbGncuK9p5Eten9dQA27YCtKi/VSJ7VgNcktmtlPdhKYwGySvZDmbGs/uzBN0aNsnP
	ihb0HE4sVB5D77iYpJxeO8uCD2/nOqI9YAYoC/Fr/KrsQtUGWfhXQV1ET9eOX4W1BpoS3BtzOpO
	2vtU+rmc/X/73I8eoOJDEEpgHLjJ0lfRBzoh3s7ujXMyjdhIf07yjOXqyNMZizDrVmYbU0g3eNP
	Dxdmp0yLtqKHFfwT85fpiXjZR6t6kVwEHuDxk0qa0TgqjufIbSm7ALBlKl8m2lz8lkbp7rjC4l4
	Jw0=
X-Google-Smtp-Source: AGHT+IGmY9glarrXNarZaAo9mWvdbYU7LPRt4v3eMj8NpeG7c1QvpqnB5GcbMm9FjHW0BzZ2wvAZkA==
X-Received: by 2002:a05:622a:15c9:b0:466:9938:91f3 with SMTP id d75a77b69052e-46734ee9e07mr201445901cf.49.1733737774204;
        Mon, 09 Dec 2024 01:49:34 -0800 (PST)
Received: from photon-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d2147ff2sm128409085a.70.2024.12.09.01.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:49:33 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: zack.rusin@broadcom.com,
	thomas.hellstrom@linux.intel.com,
	christian.koenig@amd.com,
	ray.huang@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Ye Li <ye.li@broadcom.com>
Subject: [PATCH v6.1.y 2/2] drm/ttm: Print the memory decryption status just once
Date: Mon,  9 Dec 2024 09:49:04 +0000
Message-Id: <20241209094904.2547579-3-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20241209094904.2547579-1-ajay.kaher@broadcom.com>
References: <20241209094904.2547579-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zack Rusin <zack.rusin@broadcom.com>

commit 27906e5d78248b19bcdfdae72049338c828897bb upstream.

Stop printing the TT memory decryption status info each time tt is created
and instead print it just once.

Reduces the spam in the system logs when running guests with SEV enabled.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 71ce046327cf ("drm/ttm: Make sure the mapped tt pages are decrypted when needed")
Reviewed-by: Christian König <christian.koenig@amd.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # v5.14+
Link: https://patchwork.freedesktop.org/patch/msgid/20240408155605.1398631-1-zack.rusin@broadcom.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ye Li <ye.li@broadcom.com>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/gpu/drm/ttm/ttm_tt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 91e1797..d3190aa 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -90,7 +90,7 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
 	 */
 	if (bdev->pool.use_dma_alloc && cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		page_flags |= TTM_TT_FLAG_DECRYPTED;
-		drm_info(ddev, "TT memory decryption enabled.");
+		drm_info_once(ddev, "TT memory decryption enabled.");
 	}
 
 	bo->ttm = bdev->funcs->ttm_tt_create(bo, page_flags);
-- 
2.39.4


