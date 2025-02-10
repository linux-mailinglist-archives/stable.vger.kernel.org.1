Return-Path: <stable+bounces-114697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD47A2F538
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB74E188A676
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D538D24FC04;
	Mon, 10 Feb 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIH0qN1X"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BD824BD0C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208418; cv=none; b=naGgoI1/NpBbHPHWtGITjSTfpHzNCu6HGM4HPmpcdelydMmc4SdP4lukY0mE5c2ivFJtvpsR/VEHSzTKnnd/qzNon/3fIqKPrIUidFrl6wow4oEIrZpfncsNKjPEIha4+Yz5A3/ol1GIm9fuJnl3BA0RvQvMpqPnEl3OEEs5B8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208418; c=relaxed/simple;
	bh=5VsRk0Ia04Ozcptj9MDElUmZeXj5McZif5cJAMhyKiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XN5tLLIhA41P0h6zxvrLz6AZIsakzeYwNTEx9BJSfNRgL2OTIYXoCoKCqx2OBLrqMDpBGz22Sckjjd6p7Xsy+5G9JVosLyM+C+qP6JmKweVUyTtu6aMRdLeBTR8dbNjGuPcmXqfBin2T9kOp0/cjYXdhasGkBH+qMApYPLkX8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIH0qN1X; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de5a853090so4968652a12.3
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739208415; x=1739813215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOu5y0HZxfwkkOMar6QrCcN8oVo/eCbg0mvMdOG906I=;
        b=MIH0qN1X4/tY+/pbszB+s+RjI48ezISru+7OApfPemdT7STcUM28o7JignKoAGd5e7
         rbgybBeHDs0pibgGOIPmZyPRFw8Xl1nuHKAnRPJCPV/fAMrZKfxs9UWKDr6N6pyodeqc
         R2YXgO2kDHZd1vdClEGxXYaNfi883wcMxK42DSaVUuXLwvi+CPeQJiNd2XZkiM64Z2sZ
         jlbFZivQ5Zy1UGpX7o9UGdw0dj79ikABu6DwXjgFUuoHFvFWIfoG7oByii+TObqiDLcB
         D+W55Ed2J+GNJlYeG7VqrCFp4OeBvIA4d2tw///k1QgaPBUI27jLQLijBzg9GbEJ79uN
         BMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208415; x=1739813215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOu5y0HZxfwkkOMar6QrCcN8oVo/eCbg0mvMdOG906I=;
        b=w/qv9tu90VhP197nHro8sIiNEv7+E78BmN6jb+GwCduYOGj5mlZwy8j5ro5W4W/r/a
         I40sVHG/hVRxzVylZ8uT26QOA9EogpovNsc4teYzNp56Gjs9Dqq2LybY10f/XX5menbI
         xsHnj8q6eO70zzIT1NiP+CZrUh9J5ePek6E6BkKbmvIb5Tlxw2bw4UIl36kHDPmFVcpU
         nx7MrYOPQjkFMQQ0KUcBUrqBY4GpZKM/M9F8QnGCIX6i9+5CqTirOJUW23vMjlDn2MAL
         Gx4x2XLcI65N7AyIg1r+y/SK/C4Dpz7MLDV+AAZ1urz/JcYaZw+kb9w/3mM1SfjHtaRT
         tiYw==
X-Gm-Message-State: AOJu0YxhLD6G1ZWpQ90EfntZYS5XDaDdAglBTvqmuYe5iFy5sQPk1gjk
	CJ1UmM0CJtkJnA+uI90hPgbd9HfU9CbBXL8jtzShsoP8BC5OXEKw91jvkw==
X-Gm-Gg: ASbGncsBRL2EKib+2b67OTiqv1UwmFqmdvwd2U91vK3T6uHC1LMGy3YOFi4UelIN9Ui
	OOhdD896ockdJREx/7L0Z0g5633sIjdIQN0yJIXKl/WDxadkeeCwYERYWbv1paAtfXeAK9KVGr3
	vEMIl98afHRjUWt1MwMJpzHioMei9Ahd/SrpBZWRdZFoZiJk566TbRb4OBWCm88feQqu4yeyHSo
	fvW5gh1NViysb8FsJ97FnVId4424dmpDJW4mjjkX403SboMhnvDXiCYXX45oEDSvM2VSQYroWg=
X-Google-Smtp-Source: AGHT+IFFqEcf7Pp/0KSpoDhfJKdk37U0jUc0voaAn2TokmdyCL3+k9pTdo8Xi3kSzed1CRHRNBIgNA==
X-Received: by 2002:a05:6402:1948:b0:5d2:7199:ae6 with SMTP id 4fb4d7f45d1cf-5de45047a28mr13737219a12.9.1739208414674;
        Mon, 10 Feb 2025 09:26:54 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:cac5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4ba95a32sm6931723a12.40.2025.02.10.09.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:26:53 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH stable-6.1 0/3] provided buffer recycling fixes
Date: Mon, 10 Feb 2025 17:27:53 +0000
Message-ID: <cover.1739208415.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes for the provided buffers for not allowing kbufs to cross a single
execution section. Upstream had most of it already fixed by chance,
which is why all 3 patches refer to a single upstream commit.

Pavel Begunkov (3):
  io_uring: fix multishots with selected buffers
  io_uring: fix io_req_prep_async with provided buffers
  io_uring/rw: commit provided buffer state on async

 io_uring/io_uring.c |  5 ++++-
 io_uring/poll.c     |  2 ++
 io_uring/rw.c       | 10 ++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.48.1


