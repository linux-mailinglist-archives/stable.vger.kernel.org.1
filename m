Return-Path: <stable+bounces-203150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AD8CD373B
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 21:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49A993007697
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D513128D9;
	Sat, 20 Dec 2025 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQwKBhzS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDD31282E
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766264331; cv=none; b=KMXp3qp/+VWPO4aL3gjtMI3ecpTlLKsYj9GpgmeBL7Xul3KcDD1EYc/Fn97PlYQN2P8tEsNND8mDmAWCxc5j1AxBwA/GKWwRgkekG7Rrc5OaDfDS8zzlpw/t1PoYzaJy3BM9eaPuSaPlsiZuShEsIfjHgH73M/FeOpykuuS1RUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766264331; c=relaxed/simple;
	bh=FuxQS6E0Qzft914wYAlyaZ47/nuyIPysXDjhmxdisGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiJRxUnI0lseoQ+Ete5GevqCThIJNQT/Ne2h1SbFt7D7DUe3BZax8gx1lMjZ/OMYFTMgdkOxYpk/Ee9ooPDKOLMdfvr/bkH+TfHKGcf9a6OvK1v3XOgiMT7VF3cd3ZjIMyfYL9gApzmDwltHSTCoVPq/ttdvkqjUsIF/jk8lSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQwKBhzS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so1884184b3a.2
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 12:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766264330; x=1766869130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv3JIVjNgbdyh2io0L3fN/o5T0HuY7Hr8INRNlkFSBM=;
        b=KQwKBhzS38L7C1XjKOMITCOVb10V5s2hWbV74yWEoGipcsBPaOOYo1nG5y3myvmf+M
         CvOgc7RHd0ZKlAoIMPAnUjoJ2o1viIHjwko45lGIvH0QOeyorQSQOmgmmUnrbB3Ez21p
         S/1sYCSnG9tJYd3Wa0efqu7Qz83oH7QFkj/IZeaiMq2qpb60Ee7ARUTo5e3qOrCi37LF
         ks6DYJzCwj9nFiZYUiTOfJPrDIJUZ+JJGo0rYJJZYFtDdL+iKHso04nKlzMnB13fGHIF
         jpx/wFfawWC7hHMK8NRTwb/sI74tSRexmSRzVk8plZZSSC0YYUF8Jzdl2Om3oC0i4eZ8
         Ub7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766264330; x=1766869130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rv3JIVjNgbdyh2io0L3fN/o5T0HuY7Hr8INRNlkFSBM=;
        b=lHGdkB1mPfH+qGV0DIosgmfo6qvVZkJrKUV0yTBrPYHfUeZw0Mfg9kClu0VzVQXBo9
         hAyyf/D6KBQUwTtiJhzqfJirW2unj660gvcnmWmc0Aq2DtUtT+gis3lzo36EjFe/KIsg
         1pcn9G2ipDvViKSfQmrHgrSvIcVB56oPl3jTo0BZsVV0DzAgGOk31btHdQxsql6gBqHy
         t3yd8KEH0T8INLBsO2H83qk7O+lfz5cGqpVSKNw9zGWjHYnALXAogfRTNrWgrFWLe3hh
         W+MDFKy90S14bU37H5S+q0SvQO+b3IYyJoHtb28dVBp0k6FFMJ63qm6vUCd8TPRm82a8
         WJFw==
X-Forwarded-Encrypted: i=1; AJvYcCUz4q1patwi/8/22Xt0ZZCnZpWY6/WNUi9jpn4hjnxLVzr6h3kkvvghaH6gLFUqhodFaov73eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyahqdYTluTtUJZpwHPTH0txFOoZyEowfp26P8MjwV73C3/+iI0
	5zia2LpmTGyOUfkpNO3JsyWwFQwXeAdM7W2gUe/ybXoQPMYfCKYYOZnY
X-Gm-Gg: AY/fxX41J6mkbBy/+PKmzPq1bO0EhQG1ZiSwgI7myGWvcZYztSG6vPsAPzYO/qAEitS
	EcpE81GP/5qLvjCqcXWMdz9EUlNR/YeVKrlctwQNYj+2HKdlqC2W6w9mM+7fbzvpFBe8oQSk4mC
	iZK52KoyXnQ9jgG6Gxkhe/MxU5qC9AmCj9hfrRLs65bMSpNBW0MgNkmsBTDqVcZLse4byMCvUHM
	rLHQhQvJcPdWbHGgYY0GervirY8OC0VXc9SxcjQy469sPpPXL96SoAgYkTE81DsbJhWjEdEwUM5
	KAPX7jGB76QiHv0pJ5VSbne5lItHEKBF4+YeD9QzGFJYGjrzFGziTP16FG+Tb4cq1ieppVExI2w
	i3U2synGs/b11o2jEcSYTMcOTwDi+b21cuIQKTyc201THqjEoCmYNckgazAY0gg67ZfAnpoJNDf
	gUpfWd5K/6CXREzo/6UXB4hlJssLfXnJuXbPUE98jTcJ4=
X-Google-Smtp-Source: AGHT+IHvwuYKMUU22bSDiWhgDhgPtQNkVn7dYPOpwL8nxp+q364FIMqTcJxyMX2lBMhJzgA6rw2kyw==
X-Received: by 2002:a05:6a20:3946:b0:35d:53dc:cb57 with SMTP id adf61e73a8af0-376a96b9113mr7150196637.49.1766264329534;
        Sat, 20 Dec 2025 12:58:49 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:c406:a500:11f0:cf32:1f0:98ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93b441sm5878717b3a.9.2025.12.20.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 12:58:49 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk,
	djiony2011@gmail.com,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] block/blk-mq: fix RT kernel performance regressions
Date: Sat, 20 Dec 2025 22:58:22 +0200
Message-ID: <20251220205822.27539-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aUaa7IbGko82Dn8Z@fedora>
References: <aUaa7IbGko82Dn8Z@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Ming,

Thank you for the feedback!

You're absolutely right - blk_mq_cpuhp_lock is only acquired in the slow
path (setup/cleanup operations during queue initialization/teardown), not
in the fast I/O path.

Looking at my testing results more carefully:
- The queue_lock patch (PATCH 1/2) alone restores performance to 640 MB/s
- The cpuhp_lock conversion (PATCH 2/2) doesn't contribute to fixing the
  I/O regression

The cpuhp_lock is used in:
- blk_mq_remove_cpuhp() - queue cleanup
- blk_mq_add_hw_queues_cpuhp() - queue setup
- blk_mq_remove_hw_queues_cpuhp() - queue cleanup

These are indeed slow path operations with no contention in the I/O hot
path.

I'll drop the second patch (cpuhp_lock conversion) and send v2 with only
the queue_lock fix, which addresses the actual bottleneck: removing the
sleeping lock from blk_mq_run_hw_queue() that was causing IRQ threads to
serialize and enter D-state during I/O completion.

Best regards,
Ionut

