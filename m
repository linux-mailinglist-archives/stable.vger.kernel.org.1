Return-Path: <stable+bounces-203135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B890ACD2DA6
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 12:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCA9D300E818
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 11:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBBA30AACF;
	Sat, 20 Dec 2025 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBXcdwyY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BE3081BE
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228590; cv=none; b=muryNM/+1ZSxNFJnPlvWySZk4NuITIUCoH8nO5+1zioy283wn9FzRFygOFCBthX5OcOXokhwBxMP5IcLfC3VjgD+glKEE3rqvtEV1MWxwLEhrZcjx8/HOuTJ7iSDSFJBjdOnLBYk4cXHGzai88lSF9+Yz59E7Z2TMN/pYZIIXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228590; c=relaxed/simple;
	bh=X63UHz0qWW55kaT+C6+HLfCvDytNqyZnVYp33HW2dWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxd7PkPxYtgasU/GmWIi8nkm/V8jvRQYbMFRtto+hqHSt9SbfR37aAt3Z2BBDloO34Qp4tIL0oqJ2K+niyjd0qMK2/XRpyFhe9qElid06FJnMBsxX+92SbH+kDSLxPP5qemZs54V1oHWL4VyZBT3a6t1Yk/GqgM7zG4BQPJdquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBXcdwyY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7fc0c1d45a4so2405570b3a.0
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 03:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766228588; x=1766833388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdk30fl3+WxdOLA0QiGygI7T24j/N41MKw7RxS8QmMs=;
        b=lBXcdwyYCwKcK75i24inBsK5xsndNpiDEHKRjHNpudH+6rhqntRPEaJuEYBRBAXu/T
         2egFWXdXPoC41WKYYf3zLyko40oMNjEj4rwWMHfiG3qwofVXQHZbRVzBOEcqL7KfXZ/4
         1pws1XLs7GQ2UpS3lYKDyoGGcc5WaDY2uCPpiNBz535OFi/dU0JxtLXx3D/gA0BgSvkf
         ZuDxDn3l1Al5uNrH9P30Gls+SzKo7ezqU3qIlLk8KZlVTAgDBUYeY+RJp9u9c2TpX2wK
         FwYTymeaZMWFXJnOyU6RfidnD5vved5elcVNWTM+Gq47zncrDGDr/FFKUW2iR2NSrfn3
         9/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766228588; x=1766833388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tdk30fl3+WxdOLA0QiGygI7T24j/N41MKw7RxS8QmMs=;
        b=sSZ+69dsEqg//zfHTQ7qxLOK4q/9Lh+uTnUnRx6cg0MV+c3VsbYFi5hq8EPbg6STZP
         34o6gT0mUIRMgNhOaAgauAc908668Lc8zubpp5xWxgO55yaZ0NqqUgj/6bLCVqpCm0wZ
         Wrwxhwgp0uLfKEkyMFnWuwa8Qc5b+j5orRzUkpL4J4M0s5Ahq4cm4LsNDwG5kjFR4ES0
         YmrBo2WXmotX9iZPFRcjpDUHebaCYhWcweIcjtgSkgAec0Jzy3zg3/d/zyHPcr4bLIX/
         5VP1VZsUjo7sjSWXyUJqVLJUGKoj2jc3y5DTi8ctN+tKOlvq3vl39sr6AWH2DHp8QoiR
         kFEw==
X-Forwarded-Encrypted: i=1; AJvYcCWH+4REHoehwR10zKTaQwRryIlgXNJ0JDhCft21Rw9mzh1DhgltIuCceIsF4L39GAlAPVayHP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtff9o/mB726gCKI8C26/7NN7xpzsE1GAfZXRZLUnggO8v39x7
	WA6a0/QJEsPm9mE0Pxf1yjIPTjSWWlv2orSJXVM24LmiJLTprQN+4kfM
X-Gm-Gg: AY/fxX4YyFMwF77gx0uDVwz9WcFXncDB2a9TJQW7lbjmBXjYSE5lOhydmYEbZY2jGTR
	lfVcBNjaNHot5ts0fgXcpQNqb/p1QDcWZfUnddjBYiQ99aUh/640ThBVqX2YeB/vjtG1iiD05Er
	411cqlBJT0AHdB+wIeaL7c63nhHk33RRpP7uOAzKzg9vdlSS/e6wmCWXA323bztvL2Okvuhzlgq
	5gtDER3e8BDN+2eyByeRB1a2SvXfO1tWmxQLAy73TCaYAKSDl1dLaUtYC4BJF/7Va7cvgp3/TLJ
	3I2zXpZwFyaNG6nwkJkNtexh0GfLaqCIWenHf7Cxgl+jKMMSkIDTwEAEcR0cGYgTSDan/YDO8xH
	bbcv/KeSgchGKGUaLIHbIL8NSboGXg9VeowL/m41NHpRyfXKZeJ3jAvdmyK+eMosbi/5UwRCVUG
	9uUY+U9OCyXivybrgd+iq0KaWOyaqb1bwd3VEUqiInCEa4362m/zE=
X-Google-Smtp-Source: AGHT+IHEZA0PlL34m7yNPdJr3Fq6Se8nfkRk1RvfpC41M1UWR1oVofl4k9hWmNXMFRfN5WzwylRClA==
X-Received: by 2002:a05:6a00:4512:b0:7e8:450c:61c8 with SMTP id d2e1a72fcca58-7ff6667c5a7mr5734984b3a.56.1766228588397;
        Sat, 20 Dec 2025 03:03:08 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f0e:c406:a500:4e4:f8f7:202b:9c23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a84368dsm5015547b3a.2.2025.12.20.03.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 03:03:07 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: gregkh@linuxfoundation.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 0/2] block/blk-mq: fix RT kernel performance regressions
Date: Sat, 20 Dec 2025 13:02:39 +0200
Message-ID: <20251220110241.8435-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

This series addresses two critical performance regressions in the block
layer multiqueue (blk-mq) subsystem when running on PREEMPT_RT kernels.

On RT kernels, regular spinlocks are converted to sleeping rt_mutex locks,
which can cause severe performance degradation in the I/O hot path. This
series converts two problematic locking patterns to prevent IRQ threads
from sleeping during I/O operations.

Testing on MegaRAID 12GSAS controller with 8 MSI-X vectors shows:
- v6.6.52-rt (before regression): 640 MB/s sequential read
- v6.6.64-rt (regression introduced): 153 MB/s (-76% regression)
- v6.6.68-rt with queue_lock fix only: 640 MB/s (performance restored)
- v6.6.69-rt with both fixes: expected similar or better performance

The first patch replaces queue_lock with memory barriers in the I/O
completion hot path, eliminating the contention that caused IRQ threads
to sleep. The second patch converts the global blk_mq_cpuhp_lock from
mutex to raw_spinlock to prevent sleeping during CPU hotplug operations.

Both conversions are safe because the protected code paths only perform
fast, non-blocking operations (memory barriers, list/hlist manipulation,
flag checks).

Ionut Nechita (2):
  block/blk-mq: fix RT kernel regression with queue_lock in hot path
  block/blk-mq: convert blk_mq_cpuhp_lock to raw_spinlock for RT

 block/blk-mq.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

--
2.52.0

