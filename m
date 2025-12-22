Return-Path: <stable+bounces-203234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3808ECD70C8
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 21:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC7F3016CD1
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 20:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C77263F4A;
	Mon, 22 Dec 2025 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYUnIsdq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3C1DF261
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766434565; cv=none; b=KgI7E+VDY9pDt3PxhW/fCy3Hp5N/B/lsKbfZtqriOTKgr20+jyjNc9bzrHmMu8gyyJopkiE5VSHzt3BvhQZF6FiVjnlC2Ipli47Z4TdJaZG/rEdQH9+uVMYQlEpHsWWWqWtcegyCy3drFrA0+QMpZsHBkXrEiNO5VGxpMm7I6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766434565; c=relaxed/simple;
	bh=Sr3KKY5gdg4covXdAxmynr9WNo37NEEPQufX1R1+kpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oTubwgJFzwzzVB4MLhijfAI+oGSzlOU9xL3IHt3bxLEI2W4x1ADXY9wb0C39trw8B0+trpvAGm3k7xXqZUDzHRULTlw9ShyRETGky8uUC311VKmki+Y5ae7a/ntqAX2xH+GhxinftY50u7vN2bcrd83iTPash9OQ+wp+sVzsiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYUnIsdq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d6f647e2so69970675ad.1
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 12:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766434564; x=1767039364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAVD7pQJt8pMzyS2qTPwLIicoj5lRR1SZQUgrj3JBGw=;
        b=UYUnIsdqca6W5EK9IRZsyTjinmGI7yU057N2001gmCM//pxLU1QXBPX9Lh5RhfsjWc
         50lw7c4po/zDsVfLhncxCuoRZpVcTDb02XzW/Zwba0uNay6CqSqB/CMqRQwdPW5GfRx7
         0V3UQ23zEGCGT0axOhNwxxM52lfQBDh05l1ODYYUv6K8xOTWh5sCKAe8bY9gwp2CVS4O
         nleSAyH1BZiP5FDX2qoE9XoVQ5w2noKlpytWodVaGLnZbKHC25gpU5vMgQ7xg+hxrMOZ
         dSAV63XxrUcqVgeazjoZ2rSt4PZ4gn47Ko0QrZQK4XEEunaRwqshf+rhRol6v4QHsYhd
         aYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766434564; x=1767039364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAVD7pQJt8pMzyS2qTPwLIicoj5lRR1SZQUgrj3JBGw=;
        b=awUMDYHvk/UFJ58yfxmoKCu8az5/oQ9JhKrzls+u9Zk8Y/MqpXHSGtjSWR4SPr/m1S
         9XcWxjZ7QyHuGi0+qh+rHKwvqVUZgJepCN0099JIsIZG6EZ7ZzOhHjr20V/yHbHvnUfh
         1Q7ozYPb/B3NeyMYVqJ0MD0+UIXQdLgsirRQEw4uZPXVupju7YMnwgH1M7ojx78vVExZ
         BYEkQahNKVJDKBrukevxhcC43qBYgoji/P1N8SsFmiNXAVfF70bs6bHSTvFSWNGeylhd
         p4jU/4qaOqf2V/lWsY6cg0JH83WFg5S2Q/h6BWHyiCAyr3najRzaaiCV7XnnldHNVZFD
         8kww==
X-Forwarded-Encrypted: i=1; AJvYcCWxc0R/BwcRgGSoA+TjWMK2v7KXKy78FoOTwt5FKZLN62cvhyHUiRoWPeVmOrECmVZz3jypF1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMUhoUoDKYlke0F3meVP2XtJ6HrgBYuU8S8NmYhouTciOFH5A
	xTvGY5OYfLT30vxCbqvgD/pVS5XS0lLIZrO2X+QFH28wgym87kkmR8Od
X-Gm-Gg: AY/fxX4sc6tRkvKz0VO4ufmJL1Z+G2QwKaT9Ih7AythQ6qfeF33L0UgN94DoQI+Z6+u
	tYboGhtHsvw5e3njqHQ+akxtoJPpIUtsj1dz1MIy0dFqVMmQgfTb5mi6FFbBYnv2xe5wLWAb489
	y/pW0PQXG+gD0ZfQWu1ikh02IY6YrrUE2Yyl2YhRXTqxJLjcZMzZNjGIQWIZ6L6t3I11dlkaEEO
	I3GBSI4Hpl4nSIvQfsO70IqxX/VokhIStC/nHYWcSJIH+Zsjelpgju+KRe1somvX2938R1diExO
	Fxy9l13+Il/r3UXz+m0kPg6F0YJRwp2+/uG7RfRjEFyl2LdTm8C84IdBPOm+6KerYEYG73B//rr
	mETpv5o07FrqvZ9clX8lRZ8zjBSnDfd8iWO5snI1rXsH+sS2AqsJYtTAy78x0Kz+2om1xtZXzFI
	9vVTI981Qh+hxwk2Dmhkg4v4HZLOZJRP0GGRNUTkQeYtu/
X-Google-Smtp-Source: AGHT+IGoKDbgLO06d1N/xUAWix3bqvDx5d2bd7CemzO0C9eAGrNH3gikQJk/ZoCDYWgpNXOngJAKkA==
X-Received: by 2002:a17:903:ac4:b0:298:2afa:796d with SMTP id d9443c01a7336-2a2f2a56707mr111799725ad.61.1766434563728;
        Mon, 22 Dec 2025 12:16:03 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f07:6016:fa00:48f6:1551:3b44:fd83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f330d25esm104358905ad.0.2025.12.22.12.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 12:16:03 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] block/blk-mq: fix RT kernel issues and interrupt context warnings
Date: Mon, 22 Dec 2025 22:15:39 +0200
Message-ID: <20251222201541.11961-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

This series addresses two critical issues in the block layer multiqueue
(blk-mq) subsystem when running on PREEMPT_RT kernels.

The first patch fixes a severe performance regression where queue_lock
contention in the I/O hot path causes IRQ threads to sleep on RT kernels.
Testing on MegaRAID 12GSAS controller showed a 76% performance drop
(640 MB/s -> 153 MB/s). The fix replaces spinlock with memory barriers
to maintain ordering without sleeping.

The second patch fixes a WARN_ON that triggers during SCSI device scanning
when blk_freeze_queue_start() calls blk_mq_run_hw_queues() synchronously
from interrupt context. The warning "WARN_ON_ONCE(!async && in_interrupt())"
is resolved by switching to asynchronous execution.

Changes in v2:
- Removed the blk_mq_cpuhp_lock patch (needs more investigation)
- Added fix for WARN_ON in interrupt context during queue freezing
- Updated commit messages for clarity

Ionut Nechita (2):
  block/blk-mq: fix RT kernel regression with queue_lock in hot path
  block: Fix WARN_ON in blk_mq_run_hw_queue when called from interrupt
    context

 block/blk-mq.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

-- 
2.52.0


