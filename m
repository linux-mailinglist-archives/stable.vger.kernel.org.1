Return-Path: <stable+bounces-98319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C5E9E3F9A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C55282107
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8920420CCD7;
	Wed,  4 Dec 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHtWyHxu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C83188587
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329624; cv=none; b=TrHUQv9gtBfocdMNzDSj/B0cqpx+EgWw8/fHT0AWzCWUi3HyxwYXS7OHLWb+UkTMQm6JbxOJ/Bdag1xd9T+X2tci8A5x+kBKS912/cVSyhBhrPPpixIdn869LwLOb98ZdyY1BQLaB4Y2+mfucfSgLlKrMJDUJawKd7UeBmspQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329624; c=relaxed/simple;
	bh=Tb4zTg8gwUbDaogCnGrqjqwGKOpD1jahUvTB+lbqtzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sflQ+LFsTDBQJN99FbN4hHMt4vbHA8AhzSf44lZr4xJzjkJzh6ASFUqaAufvCEjpWu4WkZ8XeSozdNl1dNtUll9cljsDPte7du+CDa5aQOLjmeLzYCXLmji8z6o5fYyNtsLdOmErD7CQC1BRP3LPPSOcZJ9tOfFCHbEpbLXV+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHtWyHxu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a9f9a225so60235e9.1
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733329621; x=1733934421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9G1+IA4HE6z5Jl984QuG0eTi6gYVIS+JAIiJpGUT64=;
        b=nHtWyHxuXQRjOMdNrhEB6NLoK3rnkKQbbuBVs9TqL3+5rdKYuiAzoaG+vv508D/rfB
         UoJGmSYPjwXmsBGamgihduaUltJIpDcRgY/r9rV2wGxgTsZH40yPJPa3pJpUxc37rky1
         U6bTdxGhky8+oHiClGs2maV725B3l/+fm+6+RCiKt31IqGU7HRlG7+QP7rULXgFzXDbL
         exWO6ALc2aAwu3YKMwGeX6c5uqnDGK++9DVz/uUepkrwhD0egCEU2x1EI3qUTRe+t8Hk
         rHuRvAgTD6guaSlBsGyWfWUmJxJ+9nMPiRhe7WhHFoVX30SGZsb/x7fKqEDWvi1bl2Fo
         08hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733329621; x=1733934421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9G1+IA4HE6z5Jl984QuG0eTi6gYVIS+JAIiJpGUT64=;
        b=YAW6p8tXlmPXeRvOBDfrgUnByUDwOJyEoRdIxxTu16vP3/SANfMG9vUjQhU0ngnDo9
         Y0PaX1RaUqY8XuydWnIOrZHJbN5CHf3mIJeM0ynorKbCvtTYS59PmWYbjk7N3uZTDeh/
         8pfJUJNtcigWmTdozX/ZxisUD/HmZgUN+ZEbr57NeIUanNq/jngnuFmI310hrwowv/GK
         tLrFYC6DJ89ZiknISKcT3oEzwZBKvCkty3T4McKup6CF86rlLU9vLWPZVzfNPelHVIEN
         5oK/06hUC9macZv9Ng1GFJSF/CCuG/lvfn6rCPvS/OXZ1WpWZD6+48mvT4adlDabR09u
         M2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOWEotoxOW/bB3hGRTSsiVyV2Mpeq+X8c6LZ2xQprPx2Ej108pQ4Ife4bGVKbFFZ2FkcqB+iM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+F9XhMAtGWh8Po3Fy6Qei7eO1rBpzfyzUJxeQnyj0KP15IjNG
	T/iRa6v4PcW7E+w6vTf2XwMlVWC11DiCXMV6jF59+T8IiBTVKW1S/BS6zu0wje7Rv85giEHPhPa
	FIZbW
X-Gm-Gg: ASbGncvTP8V2IXYkhHxwJnYBrZvgIzYo/wQ6fwJtUhJxYZsPaTr9IPtOym0+6vOPoWD
	nB2+13P7dVlMBl5buzjf6TQqmc6kpbo/Cy8Z/at9edPn3tYIKH9/TUtuz1mAwNZCZ9GHurWfRV4
	i62mrznp2d9L5ijD3sRWArJKayimJNMudkAWbO4+jwEDkNQf/m7KMpg924FacPIoUGaPo/EYq/H
	gjLCPoc27pTOwEqV1Qtb9qvMgdLdZTD4sA6Ew==
X-Google-Smtp-Source: AGHT+IG9U1RkmAjCsaZkbHJvJ5nu4yp+BcYJp90LiOTeDBKduQ1hWfRCwdTnNEzAhSGitcQ4jLpnsQ==
X-Received: by 2002:a05:600c:138c:b0:434:9d76:5031 with SMTP id 5b1f17b1804b1-434d52a1a87mr1200475e9.1.1733329620387;
        Wed, 04 Dec 2024 08:27:00 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:4606:5fa1:8ade:6950])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dd99504csm16808066f8f.85.2024.12.04.08.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:26:59 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Wed, 04 Dec 2024 17:26:19 +0100
Subject: [PATCH v2 1/3] udmabuf: fix racy memfd sealing check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-udmabuf-fixes-v2-1-23887289de1c@google.com>
References: <20241204-udmabuf-fixes-v2-0-23887289de1c@google.com>
In-Reply-To: <20241204-udmabuf-fixes-v2-0-23887289de1c@google.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, John Stultz <jstultz@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, Julian Orth <ju.orth@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733329589; l=1788;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Tb4zTg8gwUbDaogCnGrqjqwGKOpD1jahUvTB+lbqtzQ=;
 b=x0rM9Iqs4R9cqZm4OwMo3VWit21K6SeS2leyIeQreRfqXoZoMTJdgc0TRz3BeylxDekXItOM6
 v3yPm+oXfdYAGerYEcgb+A8uMYKhMtEJ8Hr0uOzDDVLWGCHtKOz9Wou
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The current check_memfd_seals() is racy: Since we first do
check_memfd_seals() and then udmabuf_pin_folios() without holding any
relevant lock across both, F_SEAL_WRITE can be set in between.
This is problematic because we can end up holding pins to pages in a
write-sealed memfd.

Fix it using the inode lock, that's probably the easiest way.
In the future, we might want to consider moving this logic into memfd,
especially if anyone else wants to use memfd_pin_folios().

Reported-by: Julian Orth <ju.orth@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219106
Closes: https://lore.kernel.org/r/CAG48ez0w8HrFEZtJkfmkVKFDhE5aP7nz=obrimeTgpD+StkV9w@mail.gmail.com
Fixes: fbb0de795078 ("Add udmabuf misc device")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/dma-buf/udmabuf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 8ce1f074c2d32a0a9f59ff7184359e37d56548c6..c1d8c2766d6d36fc5fe1b3d73057f6e01ec6678f 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -436,14 +436,19 @@ static long udmabuf_create(struct miscdevice *device,
 			goto err;
 		}
 
+		/*
+		 * Take the inode lock to protect against concurrent
+		 * memfd_add_seals(), which takes this lock in write mode.
+		 */
+		inode_lock_shared(file_inode(memfd));
 		ret = check_memfd_seals(memfd);
-		if (ret < 0) {
-			fput(memfd);
-			goto err;
-		}
+		if (ret)
+			goto out_unlock;
 
 		ret = udmabuf_pin_folios(ubuf, memfd, list[i].offset,
 					 list[i].size, folios);
+out_unlock:
+		inode_unlock_shared(file_inode(memfd));
 		fput(memfd);
 		if (ret)
 			goto err;

-- 
2.47.0.338.g60cca15819-goog


