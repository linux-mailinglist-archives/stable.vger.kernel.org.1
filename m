Return-Path: <stable+bounces-61435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B649993C438
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AC51C20CF4
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AA819D891;
	Thu, 25 Jul 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk+Y5a01"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A08319D887
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917883; cv=none; b=pIylKxXWb9qjFurU0dlQgTA1uQlO5Uziwr0T2vt3PqrenWj9OktGf3BE9+7HCrUaovPIj7Ll1rPPvQpIIbCrVeo7x7BP0SGjbjx1ZCz20YnlZKfGIevLN32h8ZpS8dul1T6Ul5A46t3w+zXqUpq22cpv+GU8PrS3n+wNfj43YNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917883; c=relaxed/simple;
	bh=JGxU3zYS2VAatIWFlak0GhwLH1YG3baZvMJ6/Ky3+OE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f9j+aEonnBGNSm8ELXtN11jAxTmiQ4jp4kMGApu5UfUzBL5EZRyJSADb/EbzUUF80oAhU3iuCPhOFcAQ8HncG/4jDqWqdyGrXuth4ghM0YSP6ajah1K3KPGBlmDo5kwGuBaYyUXlmxkUGpfQEJI048WfLFyQdCGvO2hrfYznMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk+Y5a01; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427d8f1f363so7576145e9.2
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721917880; x=1722522680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7AIVGS6bVIlfSdLvm/x/5ywZaxTAuJPsXGGOUWU4no=;
        b=kk+Y5a01kbgmaz+/RFtt6lAck8eV/vbx0P6KfZ38+5HvOaoKN/81Y9ghVVfkQgoqmq
         6f6Gqg2rssT1MrkUKJjmmXzawr68a46pEBodWeYSYjp/o9pEbKcav4rTq2r5GbB850pl
         iypDlVOBN40jgYvRIiItlPew2LQYCjS5HRqZzB2hIPOlgKMyfAZPDtaAdeqehhatrAgd
         8rm46rjVVuSEOqnVG7cfAp8Yau8auXaM70lMrPs0f48O3ar+uzEmFQvc9537Nwv6XaeN
         VSqRvAqo5j5wcLLPj4usG6HDlptnXLHfa70pNc1k6JJn0zalmXjmzCcjAAfUQZVwuVYn
         3GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917880; x=1722522680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7AIVGS6bVIlfSdLvm/x/5ywZaxTAuJPsXGGOUWU4no=;
        b=Ni1cooXMVSLZy7FPXTnJVX6DD9wP9SxezuB9knB617vdn/5uHBf7ngSd7OrollVHsc
         nLd1Fv7LFCLicC4apQ41vgn/Ub04qH1QDoypvQRLhG1YVWE5qgykd3GUtbhIvb9rpFWn
         +0Csnra+1hWb2uK3Xbmh/30mkHWmtjPHN9eJVnOtKoWv4/yeIZYB6sRg4o8daTS2i7o/
         9tLXFPnmhBLEHPDz8vq7Ptnq7ktgy7QK/4anxudBbHu1QK5sdmllLM0aAGvOlMmhhU5a
         vcSNZ2A5amLmclMIaIkzef3lBZMY3Eu+R4dGWkv7pyGjQcZjWpMZQ1P5J8qE5yCq0a8k
         +QJw==
X-Gm-Message-State: AOJu0Yw6Raiy+lEkjpOrGhAUclzyCn+mvS2RCYX2UW9o3E9DEc7os/Az
	vH7woqTtArI7TG65Aj1elDEROXw/FQzxm0x0RA916EXiYi13EPJE39yubt4N
X-Google-Smtp-Source: AGHT+IEDpJ0o+L7Ka8jWtriRCeoBC1hhU9DFKm2E/d4+YYZU1ZYlk9eKCD27D+UE45PC2l+nOi515A==
X-Received: by 2002:a05:600c:5487:b0:426:5fe1:ec7a with SMTP id 5b1f17b1804b1-42806be7443mr16696735e9.31.1721917879517;
        Thu, 25 Jul 2024 07:31:19 -0700 (PDT)
Received: from laptop.home (83.50.134.37.dynamic.jazztel.es. [37.134.50.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42803c593aasm44004705e9.23.2024.07.25.07.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 07:31:19 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Jiri Olsa <jolsa@kernel.org>,
	Hao Sun <sunhao.th@gmail.com>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	syzbot+08ba1e474d350b613604@syzkaller.appspotmail.com
Subject: [PATCH 6.1.y] bpf: Synchronize dispatcher update with bpf_dispatcher_xdp_func
Date: Thu, 25 Jul 2024 16:31:11 +0200
Message-Id: <20240725143111.222429-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 4121d4481b72501aa4d22680be4ea1096d69d133 ]

Hao Sun reported crash in dispatcher image [1].

Currently we don't have any sync between bpf_dispatcher_update and
bpf_dispatcher_xdp_func, so following race is possible:

 cpu 0:                               cpu 1:

 bpf_prog_run_xdp
   ...
   bpf_dispatcher_xdp_func
     in image at offset 0x0

                                      bpf_dispatcher_update
                                        update image at offset 0x800
                                      bpf_dispatcher_update
                                        update image at offset 0x0

     in image at offset 0x0 -> crash

Fixing this by synchronizing dispatcher image update (which is done
in bpf_dispatcher_update function) with bpf_dispatcher_xdp_func that
reads and execute the dispatcher image.

Calling synchronize_rcu after updating and installing new image ensures
that readers leave old image before it's changed in the next dispatcher
update. The update itself is locked with dispatcher's mutex.

The bpf_prog_run_xdp is called under local_bh_disable and synchronize_rcu
will wait for it to leave [2].

[1] https://lore.kernel.org/bpf/Y5SFho7ZYXr9ifRn@krava/T/#m00c29ece654bc9f332a17df493bbca33e702896c
[2] https://lore.kernel.org/bpf/0B62D35A-E695-4B7A-A0D4-774767544C1A@gmail.com/T/#mff43e2c003ae99f4a38f353c7969be4c7162e877

Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20221214123542.1389719-1-jolsa@kernel.org
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
(cherry picked from commit 4121d4481b72501aa4d22680be4ea1096d69d133)
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Reported-by: syzbot+08ba1e474d350b613604@syzkaller.appspotmail.com
---
 kernel/bpf/dispatcher.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index c19719f48ce0..fa3e9225aedc 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -125,6 +125,11 @@ static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
 
 	__BPF_DISPATCHER_UPDATE(d, new ?: (void *)&bpf_dispatcher_nop_func);
 
+	/* Make sure all the callers executing the previous/old half of the
+	 * image leave it, so following update call can modify it safely.
+	 */
+	synchronize_rcu();
+
 	if (new)
 		d->image_off = noff;
 }
-- 
2.39.2


