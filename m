Return-Path: <stable+bounces-111826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2114A23F51
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876C83A3DD4
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659441C5F1E;
	Fri, 31 Jan 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="osGqXY5Y"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F31C4A16
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738335542; cv=none; b=fGLVZmq41LW5FsD1YWg92Q/ep+tXC6wmKMk96k9+1Lr1aTfi7bJGSZriOs05kcJgtMWg4CplORE46xQeF46Ue9YDuIDW618V/3WZAgXJR3mVHztMCVRh+pyhkChAa/rTc42lDqEmnWWQZ7VKKoaZwhaNrsSM5gGyymCpQTgYHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738335542; c=relaxed/simple;
	bh=XBNNuBszWPZRuBRnhjhNXFM71rGXO2E6hrl38UKQQzs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Ff+80mU+Z2Wtm/mCAt6QN7k88Ofl72Xjllsvg/ceX3YQfG6zFYIPaN4UKvDB8NQAal6IB9FXqANWyAAhVLnnXWGSBSPBOQp6CSKAhoPJJ1wjQaLlJYyCypukIUCnZps0mmhhMtkYKugb1lkRf3xWycK9pRNgtnGVan9QBj+mC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=osGqXY5Y; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:In-Reply-To:Subject:
	Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zwu5Hitv4/1a67lggN6GEML6nle7odGui4zBbtRSaLw=; b=osGqXY5Yhp/3betjjQN3iGpsKK
	+BsShqKY1BFhdk7dAKvK3MaS6MnyJbxgg/nBDMmQABeBpztuZahifhG6AMCMxcvqJGnm+/YZGYNTd
	LC0T64ebtuusrtKoXlcP15qgcoJM81W3suyvyEBR/n8N/goQ2XqSKi0PHvuycbp0XkE81BitWU60v
	OEmYoQO2den62GFoXca39stFfhZnyf6LawyrWj4Oo2cZWvpf3R3InGh0XraiT+l52L82wyhf2UVej
	GXA4desNZ9E/+lWm2RLFJI7fb1+/mBN0McNxTbmYx6uj78Sv3tsMLlT0k3+f4OzwdrmlQ1EAWFhdi
	KZz95xmA==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tdsTi-001WLc-67; Fri, 31 Jan 2025 15:58:48 +0100
From: =?utf-8?Q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
Cc: akpm@linux-foundation.org,
	riel@surriel.com, linux-mm@kvack.org,
	stable@vger.kernel.org,
	kernel-dev@igalia.com,
	revest@google.com
Subject: Re: [PATCH] mm,madvise,hugetlb: check for 0-length range after end
 address adjustment
In-Reply-To: <20250131143749.1435006-1-rcn@igalia.com> (message from Ricardo
 =?utf-8?Q?Ca=C3=B1uelo?= Navarro on Fri, 31 Jan 2025 15:37:49 +0100)
Date: Fri, 31 Jan 2025 15:58:41 +0100
Message-ID: <87plk3xc66.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi all,

Some more context about the patch. The issue (WARNING in
madvise_vma_behavior) was found by a private syzbot instance, so I can't
share the link, but it can be triggered by an unprivileged user with
this reproducer:

--8<------------------------------------------------------------------

#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>

#ifndef __NR_userfaultfd
#define __NR_userfaultfd 323
#endif

static void sleep_ms(uint64_t ms)
{
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg)
{
  pthread_t th;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setstacksize(&attr, 128 << 10);
  int i = 0;
  for (; i < 100; i++) {
    if (pthread_create(&th, &attr, fn, arg) == 0) {
      pthread_attr_destroy(&attr);
      return;
    }
    if (errno == EAGAIN) {
      usleep(50);
      continue;
    }
    break;
  }
  exit(1);
}

typedef struct {
  int state;
} event_t;

static void event_init(event_t* ev)
{
  ev->state = 0;
}

static void event_reset(event_t* ev)
{
  ev->state = 0;
}

static void event_set(event_t* ev)
{
  if (ev->state)
    exit(1);
  __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
  syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev)
{
  while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev)
{
  return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
  uint64_t start = current_time_ms();
  uint64_t now = start;
  for (;;) {
    uint64_t remain = timeout - (now - start);
    struct timespec ts;
    ts.tv_sec = remain / 1000;
    ts.tv_nsec = (remain % 1000) * 1000 * 1000;
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
    if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
      return 1;
    now = current_time_ms();
    if (now - start > timeout)
      return 0;
  }
}

struct thread_t {
  int created, call;
  event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
  struct thread_t* th = (struct thread_t*)arg;
  for (;;) {
    event_wait(&th->ready);
    event_reset(&th->ready);
    execute_call(th->call);
    __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
    event_set(&th->done);
  }
  return 0;
}

static void loop(void)
{
  if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {
  }
  int i, call, thread;
  for (call = 0; call < 8; call++) {
	  for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
	       thread++) {
		  struct thread_t* th = &threads[thread];
		  if (!th->created) {
			  th->created = 1;
			  event_init(&th->ready);
			  event_init(&th->done);
			  event_set(&th->done);
			  thread_start(thr, th);
		  }
		  if (!event_isset(&th->done))
			  continue;
		  event_reset(&th->done);
		  th->call = call;
		  __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
		  event_set(&th->ready);
		  event_timedwait(&th->done, 50);
		  break;
	  }
  }
  for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
    sleep_ms(1);
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_call(int call)
{
  intptr_t res = 0;
  switch (call) {
  case 0:
    *(uint64_t*)0x20000040 = 0x20000004;
    *(uint32_t*)0x20000048 = 4;
    *(uint32_t*)0x2000004c = 2;
    *(uint32_t*)0x20000050 = 0;
    syscall(__NR_mq_notify, /*mqd=*/-1, /*notif=*/0x20000040ul);
    break;
  case 1:
    syscall(__NR_mremap, /*addr=*/0x20002000ul, /*len=*/0x3000ul,
            /*newlen=*/0x4000ul, /*flags=MREMAP_FIXED|MREMAP_MAYMOVE*/ 3ul,
            /*newaddr=*/0x20422000ul);
    break;
  case 2:
    res = syscall(__NR_userfaultfd,
                  /*flags=UFFD_USER_MODE_ONLY|O_CLOEXEC*/ 0x80001ul);
    if (res != -1)
      r[0] = res;
    break;
  case 3:
    *(uint64_t*)0x200000c0 = 0xaa;
    *(uint64_t*)0x200000c8 = 0xc;
    *(uint64_t*)0x200000d0 = 0;
    syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0xc018aa3f, /*arg=*/0x200000c0ul);
    break;
  case 4:
    *(uint64_t*)0x20000140 = 0x200e2000;
    *(uint64_t*)0x20000148 = 0xc00000;
    *(uint64_t*)0x20000150 = 1;
    *(uint64_t*)0x20000158 = 0;
    syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0xc020aa00, /*arg=*/0x20000140ul);
    break;
  case 5:
    syscall(
        __NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x400000ul,
        /*prot=PROT_GROWSUP|PROT_SEM|PROT_WRITE|PROT_READ|PROT_EXEC*/
        0x200000ful,
        /*flags=MAP_SYNC|MAP_NONBLOCK|MAP_HUGETLB|MAP_FIXED|MAP_ANONYMOUS|0x2*/
        0xd0032ul, /*fd=*/-1, /*offset=*/0ul);
    break;
  case 6:
    syscall(__NR_madvise, /*addr=*/0x20000000ul, /*len=*/0x600003ul,
            /*advice=MADV_DONTNEED*/ 4ul);
    break;
  case 7:
    syscall(
        __NR_mmap, /*addr=*/0x20000000ul, /*len=*/0xff5000ul, /*prot=*/0ul,
        /*flags=MAP_POPULATE|MAP_NORESERVE|MAP_NONBLOCK|MAP_HUGETLB|MAP_FIXED|0x2000000000821*/
        0x200000005c831ul, /*fd=*/-1, /*offset=*/0ul);
    break;
  }
}
int main(void)
{
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
          /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  loop();
  return 0;
}

--8<------------------------------------------------------------------

Cheers,
Ricardo

