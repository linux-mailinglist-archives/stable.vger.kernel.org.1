Return-Path: <stable+bounces-40118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8628A8BEC
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 21:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991C3289700
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A562E64C;
	Wed, 17 Apr 2024 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEXbZHfC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C023772
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381324; cv=none; b=CvcmOEm7si5NhZlG5JyvIdftRFYbWjRafxggzkeF/i8ysn4ccbNdUKch+2ZpxLLCGZav1ORdv2zBZ3SWE6Ark8D9ao/se3TWjkqq8YCnoawxayJhZLYJc8v9aCcTc0MtKtEI3ad6EA7N43jzTr9XEN8PPot5XUfbCrk3NYo0UPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381324; c=relaxed/simple;
	bh=uI8tSqgzNQr2KV6CBwiC+zzrx9zKH+jxJVnlJoO9Zao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DX5HrE11Cb6+vJYBv3liMi7AqmzPmF/4DC9Sp84FwxEyqpyUmFAk7F3O39/YPdwfqPXe3utNQBMjSqptIKMFXRYy65mkaAhba0wb3RPxTWfMKGbiV8Dw0wJ1EoFvwxJ//F83pWntXdT6aJulWU6wsazV0AfPcl3NM/XgO4H+G7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEXbZHfC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ed663aa4a7so152986b3a.3
        for <stable@vger.kernel.org>; Wed, 17 Apr 2024 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713381322; x=1713986122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw0xNn0IGHj4PbZTLDlFMunyd5B02kMRO4eEUv/pl/M=;
        b=kEXbZHfCH6F29rWHamKyLmCvDghnNAajhN9huaYMs3Bm46ZHq6zRtVQ8A1YsC2GSap
         Omp+ti1qPuBT7z4lYm+hgXxTk4UIsL8sTfGl0Yuligni4vePa8QtLWSj2sPCvlYUZA+k
         PAw7wxoAebc/CgmgY1Pez/gz1vWvYjekN36zxEYf2tqFGZdLqrfi104k+D7s2CnNXSRX
         TkljiW8fRTY6T+f272Xb8UKKW3D5oH6zRJOuDC+1YD1EF7rwz3MggYy6XNKAnfq6nh6E
         gu7QNMrfKNYyJhQiHkM6nQlgXtQJvM2rLzsaM/LOeYjd9eTliY1LXaDS6ktXzWTRldhG
         b2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713381322; x=1713986122;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yw0xNn0IGHj4PbZTLDlFMunyd5B02kMRO4eEUv/pl/M=;
        b=jY09WKhv3OO5KJTuBs3dsFG7Mvl7vixWUBdBhqwAN+wRZE0rOZ8FjtVayeHVrIsHgh
         mQqSrSwgVtNPQ+bhavkVBehpERE04flg36rDnc1SpQemmBtv3SdEipz0qp6I/fefoAFd
         XFTiPx7VJjLIhpA3VU5BlGsjDNriwwjeQCiKeykCYh8x0b3ScqFBYKavsU7m/GYKygly
         DwR2tIHNP1OJUDXA76KYVY0l6I2fC5HlFnxF0FzzCoKSStRGk+gSsMaQFCkxbDiulmSD
         Nl2dc4bjRWFs6r3NuVGFLdohHJmfG9jeJZCeeHlCXrRBS3Z63LyXRGaAm+JLe1+q4skP
         pudA==
X-Forwarded-Encrypted: i=1; AJvYcCUp9ooNsWmdkTj15/a6XWQd4aLq+4t6LkBTARkVgIlBxBoWGqpvKRj4LsudofBC/E3Fw6DGUXdtQWVTwMeSKKqFw+2NOc/z
X-Gm-Message-State: AOJu0Yyc7yNKWWaDQiibrnIDSlyg/4OTSEmn+L3ERh3R9cj0WMbntqXE
	zNrnZABG45Y9aFcmuFVypkt5wEMjeoA+x0PDFXMnTkzsfdqFcfKMiodpBMzH8Mzqqr6wDtbz9s1
	Ki7Kb6kY0gQ==
X-Google-Smtp-Source: AGHT+IH38TtfKM2Mr8apHkGPxGYU2dAh7XueTrQaf5Unr5eg1HhWygxnsjTkNpU67yyve2aPRl/L3z7Y3tlbcw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:98f:b0:6ed:344:9faa with SMTP id
 u15-20020a056a00098f00b006ed03449faamr51828pfg.1.1713381321996; Wed, 17 Apr
 2024 12:15:21 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:13:44 +0000
In-Reply-To: <20240417191418.1341988-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417191418.1341988-1-cmllamas@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417191418.1341988-5-cmllamas@google.com>
Subject: [PATCH 4/4] binder: fix max_thread type inconsistency
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Serban Constantinescu <serban.constantinescu@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
size_t to __u32 in order to avoid incompatibility issues between 32 and
64-bit kernels. However, the internal types used to copy from user and
store the value were never updated. Use u32 to fix the inconsistency.

Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS =
declaration")
Reported-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c          | 2 +-
 drivers/android/binder_internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f120a24c9ae6..2596cbfa16d0 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5408,7 +5408,7 @@ static long binder_ioctl(struct file *filp, unsigned =
int cmd, unsigned long arg)
 			goto err;
 		break;
 	case BINDER_SET_MAX_THREADS: {
-		int max_threads;
+		u32 max_threads;
=20
 		if (copy_from_user(&max_threads, ubuf,
 				   sizeof(max_threads))) {
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_int=
ernal.h
index 221ab7a6384a..3c522698083f 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -426,7 +426,7 @@ struct binder_proc {
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
-	int max_threads;
+	u32 max_threads;
 	int requested_threads;
 	int requested_threads_started;
 	int tmp_ref;
--=20
2.44.0.683.g7961c838ac-goog


