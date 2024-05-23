Return-Path: <stable+bounces-45985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680988CDA22
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26CE1C21DB3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92CE41A87;
	Thu, 23 May 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+QmQg80"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2482D90
	for <stable@vger.kernel.org>; Thu, 23 May 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489910; cv=none; b=TSpM/VG8XWXOs3ujdMTES5cE99gU43lVDfaxrPgZLyMG8nfykdj3iFiVJI3hNp+8L6yum0z9vD05jpmfsjLi0KbyIpB18NxZlI6HH/d4h4RbZKWz3b0mPJ0W4X2zXmVKhBuH9AOzIFmF2oi253XPEbYmtPZc8M4jYdp2TQN4f80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489910; c=relaxed/simple;
	bh=PLArmMor4L6qgrAtKXDWEYQIoluGaKDHKGLzAO+0C+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VjFQE+AnMcxAqslnmDF7yddX6703SAHL/nGGbQZSf/lFWRUOo0wjWhLzuJVYYmfM9a749S3BeDjrm3g0I6RbgslkmxcystX1eozrOsjhGDQbHetR7YVfBOz1xNu52SRqxSuIpn+8TsaCkMQn8vtGd05PX5l2EtVyPq79ZoKHNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+QmQg80; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627ee6339d6so35191357b3.3
        for <stable@vger.kernel.org>; Thu, 23 May 2024 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716489908; x=1717094708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKYjpo2pUrLoX2BGlBs6KW7QBUTJU4mkWEEaIg08XEA=;
        b=k+QmQg80S2B9V1rQ9CQSfJPlLRfgL/b6TqJ6GOdSyqDeYpJkgRhNL5jso9hSHAl3G6
         zC7NHpTpiLA/G89YfmFo8/gbuo6yrCCieTGRMtoJc+aI8m/ZplF5N3WWdCeRPTfdGFZx
         UAETAu+DxCKBO9i1dJlXKY8hlxQc6bRvcoyr9K49c/xXf0+bpstxNYr6AW84SuPR2o1C
         cp4NleinzQhkvNww+mhUncI5hN+6JW4IPBvJ7xNdgPvQMpwGh8wev2Elfol/StFHSv7Z
         6Dxy4nzG+SKOAWHDZHltF/6eoM7zH9pCOM1zQ63ul9j1DxtcYj6h+H0N8n6cDyFmeTdS
         Sh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716489908; x=1717094708;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yKYjpo2pUrLoX2BGlBs6KW7QBUTJU4mkWEEaIg08XEA=;
        b=OYC4ax1oN0j5suAN4pBg5nKe8TKLr1vTOIou8LSTW3q79Swnn+F/3QAaOpJmNGzC9K
         U9WW5ca89kK29HLYw8+amH9GqwimALzB41hmZ+J/HyEH4a4PjS7MGVb3GvMAGDjQDfdm
         tpgBLozUN7lOLFTICMDArTLEkwZgwwsUCvSNuJ4CVQR2eDSJeAc0cn40mVLu4IBw2WHC
         H8iO4uqksi8pp6IXt3zNCd3lHlD43FwOnzMaXosOPC1xmpzz12arZ4SOXVvFnjOaOC96
         jG16py3/l2TnmU1O+LRn8rY0v0hn3lkNiJohNlhs4rZvmmzQZja+RxQeiB9hMoOmogA9
         13DQ==
X-Gm-Message-State: AOJu0Yyd3KHBmssZ66kabzAo7pAcXubZh3g4rDbwvXTSlfzgk1gHRJ2r
	PmTf/PugEYJeISBKF3Mt2DTbXybPoZeuFLyfeYUx4Tmzk+DLKSfwnRPe76fikLNNPOk6WxigMZy
	NJIK+PYElqG1M4tMBxX8oXOjMfBpgM359Nb4d2HqlyhIcpdX9pZ00iamJ7ghH8kprBq0Bi8S996
	ZSbDmDhEXUBehnUShv675+LFYGDsZ1/YoeKtFj+1IYLTw=
X-Google-Smtp-Source: AGHT+IHfyGkU160rzADqenwHJVC+nkOAfeaIRPnvss2felh025FsWvw/dYAnWqF1WC6wp4KnUU8xzEOySHagzw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a0d:e2cb:0:b0:61b:ebab:ce9b with SMTP id
 00721157ae682-627e46c9c86mr12792517b3.3.1716489907922; Thu, 23 May 2024
 11:45:07 -0700 (PDT)
Date: Thu, 23 May 2024 18:45:03 +0000
In-Reply-To: <2024052314-pardon-confider-6160@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024052314-pardon-confider-6160@gregkh>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523184503.1542416-1-cmllamas@google.com>
Subject: [PATCH 5.4.y] binder: fix max_thread type inconsistency
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
index 0fe56dcdf441..a53d7f9458ff 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -480,7 +480,7 @@ struct binder_proc {
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
-	int max_threads;
+	u32 max_threads;
 	int requested_threads;
 	int requested_threads_started;
 	int tmp_ref;
@@ -5412,7 +5412,7 @@ static long binder_ioctl(struct file *filp, unsigned =
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


