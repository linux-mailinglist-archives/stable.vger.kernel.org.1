Return-Path: <stable+bounces-35471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A94894484
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0391C2159C
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B8E4DA0F;
	Mon,  1 Apr 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tzDeCbPU"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9031DFE3
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993994; cv=none; b=KzfNxFANdlHahkmXCjG/6ueMMkiEJQfGaFu87r7q4+aTsib+cUy5EJVvPhvbW1k9Pf7eC4rDoCnIiEeTxf0qLsDHWhqvD8NXMIo2+iCb7A2X3oHmNWKUr58jR2XBJqDe+yLhCmhj+G4yWMj2grRojE2AntGDO0rhKhzjwiYLtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993994; c=relaxed/simple;
	bh=6eg0n59KBs0zRUKBf6SOF/jApkG2l9N6XA2aasOeg+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtHO6sm1SbcbFyboHkfaEh2Bv3dShNCO6Ll2WEEFeYOxFUf42HaxlimqCl42rMo1WzC3sIYbvFOIvLZlmOe+9odIv62BMCX6/HlDxJuAAnDgXjwiTQOEWIg8gZ+WQMHhrv2jPHSoa8YV03v+r6rc7UNhu+6BSgJOzgdn3YN/Z3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tzDeCbPU; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3688f1b7848so2652245ab.0
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711993992; x=1712598792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8W3ugZY2UxWd610/Dfdbazi+rTB2V6f48BemOSZe18=;
        b=tzDeCbPUpU2iTXqs+sjR0S16Rj57eDA4pM0UKcTeKBq9itVhBS0eBCoJTvhmqB3FlK
         EE2C266gTqOfPA9ZA0fZ1tOE1tVEyZRLfGgiSBN0PUAx+Sn2bUmspX4Ss3WZMaakvQSw
         EzFHXYAoIWREcQ01QLF2X6kkzEISL1QuM84wX+ZgELyjv0PdXgje2PL2e0UTBLNnkWj4
         it/vY0njyKvhG0Ak17hLcoGmy/qWTkygxz2nFQjXiubsX51sB6yray26ajBXfWrqiSWa
         JRJq5oiYor7CqgqTPKgN3EzZPBsKBgGyoZwp2MgkT4gz80wAXq+K8wDwkyxaQvkIzSzX
         BdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711993992; x=1712598792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8W3ugZY2UxWd610/Dfdbazi+rTB2V6f48BemOSZe18=;
        b=t6ilcRJTAqXj8bTRlZ5m4NgSKpMDr19xRiusn0JJo1GuY35CrHWOyptOvCIITDdMTx
         QM7xm8Sjl8DEVuHoLWdYua1AVMj4BxtG5u2qWjJrUwTuwyAdP4I+bqCRqgMBNyW4mkc1
         MWyCzOpq63Rs+T2zXEQsf2vZb/O5gj6n8FqpZZfJNnOktDQWSh6QxUV7L9vodKU6IJbe
         XzrcPRjvahXKrOLPb2IquskJdpmrG1Yd96nTBDRiRFKgT2JqfW0zwfhgli7SuvFEBPmk
         IwPH1uN6rCvMdLdcMLKVV9nOy6do20k7a8BqxJnei9ZLKHSzjK0IOdIRiwCVFQcfMJRC
         I2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXMFTT7cDOelq0to0KypAEXdzUfNgaw81XCMRapiW3U415zL5jz1zRd189Y1QYyH7J6VFn4L78dCE94+dh5Sky9UsCwb7SS
X-Gm-Message-State: AOJu0Yx5qMoiZtrYNvagiarJ+ppZeqiUqVEVXAH+05t7boZ0Qg2STx4s
	+25eYL0QRB2zAs2sxBdpO87HmtBCB/6/UBDC17VBJMrD+Av3hZBSFETLDOKEJ0wtQ7KG1mpekO9
	Y
X-Google-Smtp-Source: AGHT+IHS+PG6hIvtQRPJ9iRsByiCDr4J6r5jhTZPO8kgLm1EJHahQtiOqlIXUZ7gcNZIXIzUO6SPTg==
X-Received: by 2002:a6b:f118:0:b0:7d0:c4db:39f2 with SMTP id e24-20020a6bf118000000b007d0c4db39f2mr3860239iog.2.1711993992249;
        Mon, 01 Apr 2024 10:53:12 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gm14-20020a0566382b8e00b004773d7a010dsm2663829jab.76.2024.04.01.10.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:53:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring: disable io-wq execution of multishot NOWAIT requests
Date: Mon,  1 Apr 2024 11:49:16 -0600
Message-ID: <20240401175306.1051122-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401175306.1051122-1-axboe@kernel.dk>
References: <20240401175306.1051122-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do the same check for direct io-wq execution for multishot requests that
commit 2a975d426c82 did for the inline execution, and disable multishot
mode (and revert to single shot) if the file type doesn't support NOWAIT,
and isn't opened in O_NONBLOCK mode. For multishot to work properly, it's
a requirement that nonblocking read attempts can be done.

Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 5d4b448fdc50..8baf8afb79c2 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1982,10 +1982,15 @@ void io_wq_submit_work(struct io_wq_work *work)
 		err = -EBADFD;
 		if (!io_file_can_poll(req))
 			goto fail;
-		err = -ECANCELED;
-		if (io_arm_poll_handler(req, issue_flags) != IO_APOLL_OK)
-			goto fail;
-		return;
+		if (req->file->f_flags & O_NONBLOCK ||
+		    req->file->f_mode & FMODE_NOWAIT) {
+			err = -ECANCELED;
+			if (io_arm_poll_handler(req, issue_flags) != IO_APOLL_OK)
+				goto fail;
+			return;
+		} else {
+			req->flags &= ~REQ_F_APOLL_MULTISHOT;
+		}
 	}
 
 	if (req->flags & REQ_F_FORCE_ASYNC) {
-- 
2.43.0


