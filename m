Return-Path: <stable+bounces-183574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D887BC323B
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 03:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A6F24E5425
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 01:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADBC29AB02;
	Wed,  8 Oct 2025 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/c90Ws1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6910B29A307
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759888669; cv=none; b=bsbZ0wJyR1J2hijSkKvfc11uXLOr4XLndDlPWqW1Oikh5/NnuxAdinuV937BxUsxl4wTacBoDTlCuGvo1cvEQIQQRibey86TPjtyUeWCLLDXgHrH8DE1UkwRAGe57AfUwqr+fiIRNIvaF7kozEJUPyKh5E5IdC78TamZDhQqcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759888669; c=relaxed/simple;
	bh=nYWUxbqqzq5QQ6EmGRf9P1x3GCe3p++g87Rn6siR5m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSDJscd2gJfJt1P66liyuU57PEndddFuCcKjKLBPF6pK2zliMnc/PireeJ0WJE2eTtgKSPyyYJBJlt9dawL9r0sz+nrSqPc4e9EoOdUgz+IBDF2AI36DMUFIeJzO2nLTemsHIBrvpoSL56T14rFifZDDgavMxSa53M8rY/EwQRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/c90Ws1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-879b99b7ca8so61958706d6.0
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759888665; x=1760493465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTB+YSGmu0bpbLnHjtaDTbYodJCzl2qjGAMNG+RlZjI=;
        b=D/c90Ws1G+GGV44Yzj+RjcvoAc1Zet0BgdzuPGpPaYujFKJst/3ugUE2hhE8Uz8gah
         EbbmQxbZWV0tw/Ry02bUL6v3IHx2pvHW/SlOar74hTdTKPSX4UbVlVms1tShnV0GSuhs
         x547f41Rq60OKnZz4wRJaqoxAEg8lOhg1x4rexoG+jApGLWKRfcL8ks49+GlNp3Yk/MD
         7NpkIIkrd3bM3bZczqtHXSbP8hAjzEqZGSoYosC47ssBZZNN9H2wYti5eBf654L4Xg4l
         h1DS39BZZQu3ORlBuQQZiFXYMz3OYXOsaI4Q7ltPMz7iiGakOc5pPsTuVRJvv8zPFLnc
         jVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759888665; x=1760493465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTB+YSGmu0bpbLnHjtaDTbYodJCzl2qjGAMNG+RlZjI=;
        b=WvoSHazGbSITkpOQ5FTXURxJZbsKNlHv+L5ZE+dQaH8be09FiBpIlx/Md69a9Zbd48
         BUqtY6KyaRA/Lnig32lNiPjGI1c2bKOBH4dKXbn8HXWIW3bpkvYaX9aHgSrKXEC4gCcI
         QKyPcZ0Luk42zzNpkYPQ3MB5ctlnZlDX1k9D9g4Ua3cs5fjfM/Vqeex5WnPM9YGaBX8L
         KtWVjdPZnnV+seldRd8nUo1jkvnt2OffV/gk1cUgE+2cv7Nokq7K2lH/S9yZsC+zy6AC
         YmDVoVW4DJ0xADqTKUS3UQnGCbr5Pn7h2n2mkPg1pGGsls6ZawPzbn6+57s5JFEzrOPd
         y98Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9+arIfWhy+44P2QeAgHhjyoTOt8ocVO7AikK6XO2ZUc+roXcjNb43a89+OQ4RtExEzTBEMm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4PSZoAewsQykTf5Nus0ye0Tj+j3hw3ZA360ryJMU+JO02I/V
	tzmgrn9kag4gyUNoI+vwf7UqJTmn4QWsZMWCGxjN56gW3rG+pDOgwSrM
X-Gm-Gg: ASbGnctORN5z/BazB64l/dlQ+AfrMDckiUVfF0xZpZwLc3WdahU5wF/j/nLNr9W7Fy2
	E/zPUEY0F4JPi/bly47TnEBRWB6HadjMh+wt8+bHq0Ii5H3VRKM1ptqLPi7LO8SUiIF5T4Rrk2S
	yaRVVxHQ4wc6BD68HJ+vjx3cRnzZ7kQptyOxGPBZsLdRmwHZwffck9szyMWOKh/r38FoKKRiMsI
	PdKj0ycg7ymxWpeVbrolcJOw6WmgO0khV3zKgGdjWE9eGzQci0RJHvKWOFwMVqG6xNnQwoxcFGa
	R7aXLjd/ecRCwF7wqPbZJO4efqrx3QSJoeOO/wT41XAnNkbmK5oumYHNMX10akE280oSLb7cv5s
	rQi0P/dVVr49v9PXPwoXtoD0nSU1WGNjEEFEOuHy7vO79vy8qbg5WWTygtpOnzDUukAcgcAZeCU
	0mscw4ksKN8MUqQFBUup1KEtOCk5umHCbga7y63IUhtQ==
X-Google-Smtp-Source: AGHT+IGoHjbRgqWNn7pWfYsSMs1tXQxTjaq25oW+rI7yvaco4w9zmjYdtsj6ViMdN47X51D41+1jkQ==
X-Received: by 2002:ad4:5aa4:0:b0:809:19ab:599f with SMTP id 6a1803df08f44-87b2106da26mr22488656d6.27.1759888665253;
        Tue, 07 Oct 2025 18:57:45 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60146sm154303896d6.11.2025.10.07.18.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 18:57:44 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
Date: Tue,  7 Oct 2025 21:56:41 -0400
Message-ID: <20251008015640.3745834-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007232941.3742133-2-eeodqql09@gmail.com>
References: <20251007232941.3742133-2-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The bfusb_rx_complete() function parses incoming URB data in while loop.
The logic does not sufficiently validate the remaining buffer size(count)
accross loop iterations, which can lead to a buffer over-read.

For example, with 4-bytes remaining buffer, if the first iteration takes
the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
only 2-bytes remain, but the else branch is trying to access the third
byte(buf[2]). This causes an out-of-bounds read and a potential kernel panic.

This patch fixes the vulnerability by adding checks to ensure enough
data remains in the buffer before it is accessed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Fixing the error function name
 
 drivers/bluetooth/bfusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..45f4ec5b6860 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -360,6 +360,10 @@ static void bfusb_rx_complete(struct urb *urb)
 			count -= 2;
 			buf   += 2;
 		} else {
+            if (count < 3) {
+                bt_dev_err(data->hdev, "block header is too short");
+                break;
+            }
 			len = (buf[2] == 0) ? 256 : buf[2];
 			count -= 3;
 			buf   += 3;
-- 
2.43.0


