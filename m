Return-Path: <stable+bounces-45986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574768CDA26
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12087282965
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1CF849C;
	Thu, 23 May 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDfCNcTl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEAE187F
	for <stable@vger.kernel.org>; Thu, 23 May 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489966; cv=none; b=ktjcGJI15h8ydeNCcWoX+YhVPFWRXsZCG/xAvFbDsxABl12JR0t+D/QVjXfm7tRlDFovoaOPaR+QcXIqufD9Pq4+7kJX9+SDb+St2ZNYeiwhFpfyZnDExbv7RrTpQCHxFbDX/FSpjT1K9bT6uJfd2JfXDvxLB50T1LWqAZDRKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489966; c=relaxed/simple;
	bh=tCJ5BoEdL2E1NCXIbcQZv/EmvzR61Nzhn3jNYyGCu/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mx84LNjipeJEQ4SZa4LIHlw6yJ0IF4lJU0Xzcupz9rX8MCnWdGIoSqVYo30MtKW579Txq79MTe8c5dXwOUugTstwvKfcipJlZgFG8ML9S9wcdeDMKBBdi/uW3iVAU+Fsq5/EqD7rmtE0xOhsZJo6FSn5XjpVRQTXqll3SsUs2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDfCNcTl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-67631fbc1d5so1406095a12.2
        for <stable@vger.kernel.org>; Thu, 23 May 2024 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716489964; x=1717094764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CU82G3hmuosaKrjEemkKR3D22sLfSdY296zMmKQVzQI=;
        b=eDfCNcTlKGkmmS9LIC3smGe9+WTYpDSbU0MiEgHfXyjkZ1ORXqMgF9gGWkyeveJC2o
         GM1nnsczH8znEMEX0YUV4j92LydRdtUdM3zaeAakY7pT/Z0hse2v6V4oT6X1lMF23hOO
         sB8UpQ1GDYQWoIP6uHxq0QJyDCwQZA/jMqJrE1NYSqNUYFq/TXixEol2Hu/qyWxuIEy+
         /heX1EZ1CL4eMvsOKbMAKBFIYIJvtRu7LuFCocINwFr9dTnExzyxwEDidu9g6yyAvYtg
         an+fvCCoIcGDdxT8R1Q35I4FMChIZYoVcOiSm2pSLaHFMrbGiJR0BKk5glCc+ybiIN9D
         0W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716489964; x=1717094764;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CU82G3hmuosaKrjEemkKR3D22sLfSdY296zMmKQVzQI=;
        b=ElWbXu//8KT/JdQ7kXb2V2YLv+lXKru42fW2uIeI9Q5NLgCNwK2GXYDDhsQfYrWxoB
         pjDdNsIA9rROZQshzyV8tEbU6+yYI12bpyBePyEFGYOmlyxs0NqADURkKsiUith06qjg
         DEHp87smKJjsaLuIjXqi9ELPQH2kxH6BTKVRvfkXD/dWs7g5f4Rda2huQq9ctF75agYb
         TK/nOe1ymtfrzObDqduPIM2tn5nLFWZufomrA21D1+VrNBQQhftiBmyNac8O5j63xuAa
         M6aAfCTenB49PmH/D1j7beLDqg77QeyhIzs19Ch+/dCsggVzP9MI4XmsOnQt2sSgKqZP
         Z1Pw==
X-Gm-Message-State: AOJu0Yx4lpEx0QgTaBwmBgXs4THxwQ5Lu9wKFXDvHl1GFWXnbD/Q2SBf
	hpuwHEi0iuV55rOxv5bzCHHvQnvqPLPMTuX1kv4tQoHoPn1tx1neAGgR+wOytcpQtnxda2GctjD
	BBT12KwSCVgaRCYSpwbJ885K9DfL0H1HgzIBMPiWyAeYKG48cZ5WGD+4+wjl81ZMX6LG8OCAt3C
	JUgC+AmwCAk5FYF0Y3l1I4hMyCtCpapftw/i82H9Dm1BQ=
X-Google-Smtp-Source: AGHT+IGmOWwhLw08ovYTHgCBvaFEf/E/sXRXWZD0xCbY09ZeFBlBIlJf2qizifgnJPim+q4QmwfS/rVf0zyUCw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a02:610:b0:659:237f:ed1a with SMTP
 id 41be03b00d2f7-681b0841608mr211a12.7.1716489964289; Thu, 23 May 2024
 11:46:04 -0700 (PDT)
Date: Thu, 23 May 2024 18:45:57 +0000
In-Reply-To: <2024052314-demeanor-mushy-46bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024052314-demeanor-mushy-46bb@gregkh>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523184557.1542981-1-cmllamas@google.com>
Subject: [PATCH 4.19.y] binder: fix max_thread type inconsistency
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

commit 42316941335644a98335f209daafa4c122f28983 upstream.

The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
size_t to __u32 in order to avoid incompatibility issues between 32 and
64-bit kernels. However, the internal types used to copy from user and
store the value were never updated. Use u32 to fix the inconsistency.

Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS =
declaration")
Reported-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20240421173750.3117808-1-cmllamas@google.co=
m
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: resolve minor conflicts due to missing commit 421518a2740f]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 2232576cbe2b..4150f8751658 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -540,7 +540,7 @@ struct binder_proc {
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
-	int max_threads;
+	u32 max_threads;
 	int requested_threads;
 	int requested_threads_started;
 	int tmp_ref;
@@ -4658,7 +4658,7 @@ static long binder_ioctl(struct file *filp, unsigned =
int cmd, unsigned long arg)
 			goto err;
 		break;
 	case BINDER_SET_MAX_THREADS: {
-		int max_threads;
+		u32 max_threads;
=20
 		if (copy_from_user(&max_threads, ubuf,
 				   sizeof(max_threads))) {
--=20
2.45.1.288.g0e0cd299f1-goog


