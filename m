Return-Path: <stable+bounces-65984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F994B4C3
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 03:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC4BEB21256
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 01:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4038F6E;
	Thu,  8 Aug 2024 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QULpqcDy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A98C0B
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 01:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723081710; cv=none; b=iH1Tgzvcpy0Azn+kqR1fh9WpsWAXjhHiezWsKKle/zVVvFygzgNeGdkZcv0Uty19UyijueefN70d6vZPRWOhyM7oc52GtnCqV+vJtAC7fyB0f39R0xbGLql85WPg92OC9WSSCbukiKmbIo2viCZ54XdwEfI1IUJi+cuuILTzybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723081710; c=relaxed/simple;
	bh=6kniANUbgbJIQd+oMjEkgOnnY1/134tK6Kt7vfRhOd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ot6nfJsc2hlDUnL4LKAnIPWQqEYjLthOPm4nin2RFnBuKwtEgCtRYvdL5v6TwBsIwE4QMc3EJtHw8lUdh2BdZk3fwpDhvIyRepQyOuvaJ9oeVERn0Vkngdu7amtYYZZdZe/OVr0pptj7xzRIw7wZQp+ah8M8Pme0LpGnMcYt4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QULpqcDy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7bd04f8396cso32231a12.2
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 18:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723081707; x=1723686507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgEdk/efCLokweNU/OQMz9jU5fZj6geKuOMQjp3pUWM=;
        b=QULpqcDylZSaQPkMVe4W3xbLvoWyJdXizpcrfxDSo3rQMFJu4SEphNu45p0ffAfEMh
         a2j9LbhcrnXbKe/iEAOHOD4ukZU1WgrTurQmrezskoKizGPRwsDYvVGPD44oXDp/m3Yc
         v/wmbZ68+YpQpHS7Kd6V9Jh80QcFpAfHqqCT2g1JX2o03b6mfIZ+lSKJx1XFV9A0H4OF
         ammlDiK56mLhj7YO7jw39FfNFyLe1IIDAoI37DIYa4exiH6n5tgxtOrVT1JEwCLQQSkL
         MszpyVNcLd9IYTnK8aJUnQXt7yqA8Eq7HBL8M1+SjpvALaX+tl7cBsKABDiSuQHoPJg6
         Gq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723081707; x=1723686507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgEdk/efCLokweNU/OQMz9jU5fZj6geKuOMQjp3pUWM=;
        b=jgANLzhJ9VYYBXspTMsPeuNTULnW88meIA2DrzhhtmXXGeOC9+Fbu04YwBND/LJ23r
         NKXMxjAZrDsUQxA9yqquhgTyFsqPc8y+WSqr1FZVtj4KijRIfd8pt/NNo/Xf5s2MA/FA
         aTjjh0LzDljgt0L7LSw6Tn4oVcUlStQbh4LR1HT+DdRUGj4VBhB5EYyxcR6QTufE2syo
         RI0RNGaBS53JTGfJ8KLZ0heN5WNU/DkN7VfRluyvFtqkB2+1kncd3/yW9C17asfZLaoZ
         Vr5rkhgR8zrpMPM7Gqt2ABRdBNSPaeuS9qpsckVvnrnZbA4zj1roTG1+ElmSHO4FBdJs
         lOAw==
X-Forwarded-Encrypted: i=1; AJvYcCVWLZ3DWcYD4fJiO2+75vmP7bTu6BJZF6f7ia0B/+Vds4lP/XOdo/79jzf1gMatgvlCOBizQNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuh5izprmQnuOEOYiw7Wef2DuH9uM6KC27i4mTdhoZ1vIEK+ev
	kip1HeMxBPsvbJw2UKxN7IRlanUulqRUN7P21yGnlCIrh9nBWlYzEqzRgFINmF8=
X-Google-Smtp-Source: AGHT+IE64GyHq67VE8pirrW2FDU4RlqAjMQcz240MEYAq93zw87nqh1hYjRQUSstvSI4s0z8NpJcwg==
X-Received: by 2002:a05:6a00:a8d:b0:70b:705f:8c5d with SMTP id d2e1a72fcca58-710caf37c8emr334551b3a.4.1723081707421;
        Wed, 07 Aug 2024 18:48:27 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20a104sm150771b3a.21.2024.08.07.18.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 18:48:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] io_uring/net: ensure expanded bundle recv gets marked for cleanup
Date: Wed,  7 Aug 2024 19:47:27 -0600
Message-ID: <20240808014823.272751-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808014823.272751-1-axboe@kernel.dk>
References: <20240808014823.272751-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the iovec inside the kmsg isn't already allocated AND one gets
expanded beyond the fixed size, then the request may not already have
been marked for cleanup. Ensure that it is.

Cc: stable@vger.kernel.org
Fixes: 2f9c9515bdfd ("io_uring/net: support bundles for recv")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/net.c b/io_uring/net.c
index 594490a1389b..97a48408cec3 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1094,6 +1094,7 @@ static int io_recv_buf_select(struct io_kiocb *req, struct io_async_msghdr *kmsg
 		if (arg.iovs != &kmsg->fast_iov && arg.iovs != kmsg->free_iov) {
 			kmsg->free_iov_nr = ret;
 			kmsg->free_iov = arg.iovs;
+			req->flags |= REQ_F_NEED_CLEANUP;
 		}
 	} else {
 		void __user *buf;
-- 
2.43.0


