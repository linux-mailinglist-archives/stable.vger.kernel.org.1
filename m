Return-Path: <stable+bounces-90342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4229BE7D3
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3131C2240F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A71DED49;
	Wed,  6 Nov 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3zOO+xs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666BC1DF737
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895489; cv=none; b=H8s7wZTKIgaLN/8M4UxXrth0ApfDOnscyyivBe8sa1xPY8bwhiANb2MrnZ0BYvo4dqU3vT73sSuIgWWnmBF1YOp5DMekVlievkd+8ppyCIbse5rKU25PmgQkyvzvVnR5VCsvVXlWtSheyguP9PnQ5M/nM4UMSke3XWl0WoWvha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895489; c=relaxed/simple;
	bh=jq9tjZSX0Nz5KCSVZOVTjQtRL4Y/3PyO8+4tqUHxnaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNbGoFuvG4jvZOiOHQaEuNpwJNgung8S4xuMxb2WGBp4iSEFfLHN7POuffPkxQoQva81XvlW1aiduYgbKLvV7vaK3gqqf5Il+mzFGSO+y87a+7NNhfoVjc86kQzNZrRXvQdVmbxSPk4seVGc9byfeDZx9pZgYI6fLb0jYuF21o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3zOO+xs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3894633f8f.1
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 04:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730895486; x=1731500286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5OicbYssJvQct2Lr3N97//AIKa0PvpzaGyzW7UkpsfA=;
        b=C3zOO+xsiDCTIU46rrqqvkA/8GrXJvkz80x+s3ol8apjCIj692b/yKSwI0Szx0jmYm
         zmfgfjIoeVsFYrOPQxvOcZu5COYs4JsZN2W36Nj7fvxqueLegTszksUgRfMqRN8nwj4q
         ZzR6WL8B1Wr6TXlVTtfWkDtYf85FjksCaXINjH6WvQ0H/zsSNxAofjoaVI8b4Gn6uxLe
         kH8o0tZQG6isSOhsCxoG3IsTAXYHDEjFk0/VAPG0Tcc7Z2vTEzY/U9QZwgRgddkOfRoj
         ka+hWz7WmiZ1saQh2UZFFh1YVvjqwFP+EZuXunVkeGNKtQdcUix5D2K0n4nPMVUVriSa
         vjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730895486; x=1731500286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OicbYssJvQct2Lr3N97//AIKa0PvpzaGyzW7UkpsfA=;
        b=w/bmMpfsuO+HFWegiRJpS9qBaNorN3CFDm5I8RfQR2Twcdogu883+nS1+/6peEjGRI
         EAzwotOm23MKHLz09SHLyzEvaxln98Pf+yToYvlyo23yi2wZZ7FiUoYgeEqQKnXU/Z6j
         dX2dPTalNoiMEM3CCmvkNxFBCy/gl3EZON3IoXFYrR9iFlgviojYlsbsXJWZW/Up04Kz
         EEirByoW6ld+0fnTtVmsFH/KkaiVHsZrMP3dvbVCtT5g2a+Jv11vrA4qYlE23kQbfr5n
         o8BAePLoO2lH4IavqvNXiz+76Bit86LjxKUDRSOOygaWbsn39323A7ePd17Wsz51hvhm
         oxpw==
X-Forwarded-Encrypted: i=1; AJvYcCWw9PtQUFKs7zqqt20C1p2baGro48F9GFiEn98vaPQLQqrSA1xxYoe1xVwS/B+slMK4uUVDdZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+3xpN/up/p1z+UXRumoHHVv4nsBj5MA31HQ3eKEBXCHRkJ4T
	yC786D6gEyhAKsFOfvWByLzqgtDLEZENgcRqSQZaJuxJeXcmCUr0592Coo9Nuvk=
X-Google-Smtp-Source: AGHT+IFtoT40eHtnrwAXHz8QyKy5z9wGpQ/l1+VvPX0Bfheczjk+XNbJChmqz+SINZws6jncoVrfXw==
X-Received: by 2002:a5d:48ce:0:b0:37c:d001:856f with SMTP id ffacd0b85a97d-38061220ac3mr26699965f8f.56.1730895485623;
        Wed, 06 Nov 2024 04:18:05 -0800 (PST)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116ac7dsm18938607f8f.105.2024.11.06.04.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:18:05 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: tfiga@chromium.org
Cc: m.szyprowski@samsung.com,
	mchehab@kernel.org,
	yunkec@chromium.org,
	hverkuil@xs4all.nl,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] media: videobuf2-core: copy vb planes unconditionally
Date: Wed,  6 Nov 2024 12:18:02 +0000
Message-ID: <20241106121802.2939237-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy the relevant data from userspace to the vb->planes unconditionally
as it's possible some of the fields may have changed after the buffer
has been validated.

Keep the dma_buf_put(planes[plane].dbuf) calls in the first
`if (!reacquired)` case, in order to be close to the plane validation code
where the buffers were got in the first place.

Cc: stable@vger.kernel.org
Fixes: 95af7c00f35b ("media: videobuf2-core: release all planes first in __prepare_dmabuf()")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../media/common/videobuf2/videobuf2-core.c   | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index f07dc53a9d06..c0cc441b5164 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1482,18 +1482,23 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
 			}
 			vb->planes[plane].dbuf_mapped = 1;
 		}
+	} else {
+		for (plane = 0; plane < vb->num_planes; ++plane)
+			dma_buf_put(planes[plane].dbuf);
+	}
 
-		/*
-		 * Now that everything is in order, copy relevant information
-		 * provided by userspace.
-		 */
-		for (plane = 0; plane < vb->num_planes; ++plane) {
-			vb->planes[plane].bytesused = planes[plane].bytesused;
-			vb->planes[plane].length = planes[plane].length;
-			vb->planes[plane].m.fd = planes[plane].m.fd;
-			vb->planes[plane].data_offset = planes[plane].data_offset;
-		}
+	/*
+	 * Now that everything is in order, copy relevant information
+	 * provided by userspace.
+	 */
+	for (plane = 0; plane < vb->num_planes; ++plane) {
+		vb->planes[plane].bytesused = planes[plane].bytesused;
+		vb->planes[plane].length = planes[plane].length;
+		vb->planes[plane].m.fd = planes[plane].m.fd;
+		vb->planes[plane].data_offset = planes[plane].data_offset;
+	}
 
+	if (reacquired) {
 		/*
 		 * Call driver-specific initialization on the newly acquired buffer,
 		 * if provided.
@@ -1503,9 +1508,6 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
 			dprintk(q, 1, "buffer initialization failed\n");
 			goto err_put_vb2_buf;
 		}
-	} else {
-		for (plane = 0; plane < vb->num_planes; ++plane)
-			dma_buf_put(planes[plane].dbuf);
 	}
 
 	ret = call_vb_qop(vb, buf_prepare, vb);
-- 
2.47.0.199.ga7371fff76-goog


