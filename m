Return-Path: <stable+bounces-150745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEDFACCCC6
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52191170488
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B0A288C20;
	Tue,  3 Jun 2025 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="la3G76Ji"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA31D63DD
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974877; cv=none; b=JbRlT777UyP4C4f2Eqm9BHkLUGhP2/2HH0dB8yZxgFbbHt3MS4BrqsX+rHY/DG336Fmqdo8ULNbS153+gkp8gJjX40yIsKtUv13/Fc8fdQ3ivDs5saVv3gWJvB7MSi86q2tiFqrx4awHsKIp7nKFbShn2zNxJUvCTbWPEkg2gd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974877; c=relaxed/simple;
	bh=NbsRwYQsU0CO1ZXV6KbvBQ+Yr8Kwk1GnONKaodwEyNw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=olmCbCrF3JUIbXJOXgawgahalyFrWmWze/MfkoWeCl3ZN5+HfsOIZQ8VEFBWDUNkEf3ILlnMOcnUuSdn3Yg75gpz1x9ny4pME0lUxKoVcnFD1hwiZ5sUc0G7IkjoaNnAcOLF2NEs2T1BMqGCKEU3kRrgws4ajfu1FhCw85TsyjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=la3G76Ji; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450d726f61aso9185e9.1
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748974874; x=1749579674; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYuYabL4uCVwF/1h/26iRiOfzm4Zqn6YpsGjqJSyXvU=;
        b=la3G76JiWYsMQTeLGs8A02FT2OT39GbDKyxZke5SegzdXFbb2pce94VWqhLrIhcYp8
         L2Wsba3oQHfv3cqlQg+6VMs9Nv1VQZFSWIF8yxCz22PzWxsJjXaFge0PpJeNvBr4A3Wh
         cME99zFbvGjF13GZEkiLPrFMiKMMoRJ3kq4n0PNJqlyFpUnWQDngmqnKmr2W0rYysWKt
         Z0eVGf0AKSiE6BE0lRwQWMa6EehTRXvpDF+hws0tBEHzzwN3x2pt0gQDyA0A1h9+YGZz
         CNXRnKgrCuj3mmjSPDmm/nBNWoA9FpSrQ1ZkbKbrM8uAjoTpN11hFCkI3U5M3QISaSlt
         a39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748974874; x=1749579674;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYuYabL4uCVwF/1h/26iRiOfzm4Zqn6YpsGjqJSyXvU=;
        b=dDnXBCXbk7KDAOWVxBMc6xs1zj1nhG96Tm7GlK+PHgxByCN/Vb0vXwagksG6MrjWvs
         qIjiPK/S2/J39TLnXMFLVAP5waIBcQFLK60sGCXE8YYqsAWBWVmDS/eQYW6Dmz80n7ab
         kFdGYpmWrCKCtDU87zPKpLvrxHg+lqu2H34ny+xkuWZgBFtmEu21EI3SHe6UZKB1mHw0
         nrz0R5XBxck+1EPCcn8JwjKm/O8V3JF4MplngRUQKS8vx+oiN+FVm9yZZa31qTa2zKhz
         r3uGst5FVlqei+9dT/BSS7UrGMuVe74DjVmwxWrqTIfIF7lxFhY07hMXOQdEgYxzCHvY
         sEFA==
X-Forwarded-Encrypted: i=1; AJvYcCVkowdxqYT69ciOoXWi0kjZaTUu5/AzkQoVaEGlyN4bb2i9hIroac9XhMCSVKIuyQBIR0mliJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVPVcg/F4PMc7qekDDu1EFqhh049OzmyHVkAFsJRcNTKZb+dc
	gOS9iFBx+9huY0pbeir5LXxcSaP2sUREJzqJxqLzNujRkM2Fhxl93fu15hQyRP0qTw==
X-Gm-Gg: ASbGncsGJClrM9OolOk5Jq0eZvVPFBIZFFyL+3WS1VCyM6B9azysf3ks0/yyNUnK7mZ
	xVJa7sBfer7MMiKlzgDJl0MIoEwJbaPP5Wc8hAN8N5TUHIYEyrd0LhNTgcKzlmQO7h5+4jxzSOa
	8PgVs5BZwhmiRxAfCSUZvgtWk1vDUZgS7+8T5CeDT3VHTPdCvOWJfWWqmOgk+Qkj71/WXeS37+p
	9+25YlMa5YUCf4dk6cTSHl5497m+vhyKvBqJCuhsWz8MtrT4mxCE31IaS6qLKBVrmDk/7cNlwWK
	jB8ipzMZHmFCeVdadnBNddRGLwpAHE6CfzG6k1gCo/NbUQqHrQ==
X-Google-Smtp-Source: AGHT+IG9QBvMlzUUOGyuqXUZorlJfOhUQuguzF3v93oEKgimDs5OZohrwpuPd+bRSqntMdeynS2QHA==
X-Received: by 2002:a05:600c:1ca8:b0:43b:b106:bb1c with SMTP id 5b1f17b1804b1-451ef7e9a53mr91075e9.0.1748974873164;
        Tue, 03 Jun 2025 11:21:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:796:935b:268f:1be4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4efe73eadsm18772731f8f.41.2025.06.03.11.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 11:21:12 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/2] mm/memory: fix memory tearing on threaded fork
Date: Tue, 03 Jun 2025 20:21:01 +0200
Message-Id: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA09P2gC/x3MQQqAIBBA0avIrBPUkKCrRAvR0YZAY4wIxLsnL
 d/i/wYVmbDCKhowPlSp5AE9CfCHywklhWEwylhlZyVj4VPe6JhykosOzmjtrPIRRnIxRnr/3bb
 3/gGPwrtFXgAAAA==
X-Change-ID: 20250530-fork-tearing-71da211a50cf
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 linux-mm@kvack.org
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748974869; l=3953;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=NbsRwYQsU0CO1ZXV6KbvBQ+Yr8Kwk1GnONKaodwEyNw=;
 b=CEriTtRE9yncVYoRCEU/fpeoyPzoqk9fL+0QVRI2F8lYHb21cJQeJv92F4uUlLp55s/mlmvKu
 ilhnIkFMxMQBC3pYEy2fMblw+YD+gjExNxykStTn24IHo4n/TsnP5tX
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The first patch is a fix with an explanation of the issue, you should
read that first.
The second patch adds a comment to document the rules because figuring
this out from scratch causes brain pain.

Accidentally hitting this issue and getting negative consequences from
it would require several stars to line up just right; but if someone out
there is using a malloc() implementation that uses lockless data
structures across threads or such, this could actually be a problem.

In case someone wants a testcase, here's a very artificial one:

```
 #include <pthread.h>
 #include <err.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/uio.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <linux/io_uring.h>

 #define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

 #define NUM_SQ_PAGES 4
static int uring_init(struct io_uring_sqe **sqesp, void **cqesp) {
  struct io_uring_sqe *sqes = SYSCHK(mmap(NULL, NUM_SQ_PAGES*0x1000, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0));
  void *cqes = SYSCHK(mmap(NULL, NUM_SQ_PAGES*0x1000, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0));
  *(volatile unsigned int *)(cqes+4) = 64 * NUM_SQ_PAGES;
  struct io_uring_params params = {
    .flags = IORING_SETUP_NO_MMAP|IORING_SETUP_NO_SQARRAY,
    .sq_off = { .user_addr = (unsigned long)sqes },
    .cq_off = { .user_addr = (unsigned long)cqes }
  };
  int uring_fd = SYSCHK(syscall(__NR_io_uring_setup, /*entries=*/10, &params));
  if (sqesp)
    *sqesp = sqes;
  if (cqesp)
    *cqesp = cqes;
  return uring_fd;
}

static char *bufmem[0x3000] __attribute__((aligned(0x1000)));

static void *thread_fn(void *dummy) {
  unsigned long i = 0;
  while (1) {
    *(volatile unsigned long *)(bufmem + 0x0000) = i;
    *(volatile unsigned long *)(bufmem + 0x0f00) = i;
    *(volatile unsigned long *)(bufmem + 0x1000) = i;
    *(volatile unsigned long *)(bufmem + 0x1f00) = i;
    *(volatile unsigned long *)(bufmem + 0x2000) = i;
    *(volatile unsigned long *)(bufmem + 0x2f00) = i;
    i++;
  }
}

int main(void) {
 #if 1
  int uring_fd = uring_init(NULL, NULL);
  struct iovec reg_iov = { .iov_base = bufmem, .iov_len = 0x2000 };
  SYSCHK(syscall(__NR_io_uring_register, uring_fd, IORING_REGISTER_BUFFERS, &reg_iov, 1));
 #endif

  pthread_t thread;
  if (pthread_create(&thread, NULL, thread_fn, NULL))
    errx(1, "pthread_create");

  sleep(1);
  int child = SYSCHK(fork());
  if (child == 0) {
    printf("bufmem values:\n");
    printf("  0x0000: 0x%lx\n", *(volatile unsigned long *)(bufmem + 0x0000));
    printf("  0x0f00: 0x%lx\n", *(volatile unsigned long *)(bufmem + 0x0f00));
    printf("  0x1000: 0x%lx\n", *(volatile unsigned long *)(bufmem + 0x1000));
    printf("  0x1f00: 0x%lx\n", *(volatile unsigned long *)(bufmem + 0x1f00));
    printf("  0x2000: 0x%lx\n", *(volatile unsigned long *)(bufmem + 0x2000));
    printf("  0x2f00: 0x%lx\n", *(volatile unsigned long *)(bufmem + 0x2f00));
    return 0;
  }
  int wstatus;
  SYSCHK(wait(&wstatus));
  return 0;
}
```

Without this series, the child will usually print results that are
apart by more than 1, which is not a state that ever occurred in
the parent; in my opinion, that counts as a bug.
If you change the "#if 1" to "#if 0", the bug won't manifest.

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (2):
      mm/memory: ensure fork child sees coherent memory snapshot
      mm/memory: Document how we make a coherent memory snapshot

 kernel/fork.c | 34 ++++++++++++++++++++++++++++++++++
 mm/memory.c   | 18 ++++++++++++++++++
 2 files changed, 52 insertions(+)
---
base-commit: 8477ab143069c6b05d6da4a8184ded8b969240f5
change-id: 20250530-fork-tearing-71da211a50cf

-- 
Jann Horn <jannh@google.com>


