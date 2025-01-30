Return-Path: <stable+bounces-111243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A59A2272E
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 01:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736D63A51AD
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 00:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DDF8BEC;
	Thu, 30 Jan 2025 00:28:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522C11EA73
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738196893; cv=none; b=H/d+Zundbgz+9xRzdG4RwI8lziHTkHNWIGHezm4MsfJQWxk0J0Y00p+UdAAbQQDh+CkEpAQy0SdFHaZQv38PUIqOuxF2v/5b+a8R2ZLeyEUyUyjqe3GSIiaRvpEqu+0GMRTTTeVPLVzypKaKrQN06x1YPXSxoUcMjqwLm4ygIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738196893; c=relaxed/simple;
	bh=jXZaJNrktFBir5KidGgxYH4Q1irgKpjCs9vRVTiYlCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d+LZ63STXPBBelYzJiTzrz8E4514GpaX1GcyNdQNbTlOy7JYNIY942aRhna8EyK2mc8M4pcumxLAgG/wRAXP5Rmhd63x6cVVggnTMXxKvcmX2013DNsBL++liCZQycAnD0yR5beM7UqpQosjelmFwoCobpXC+pRV9i7n5L242XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id B1EBC233AA;
	Thu, 30 Jan 2025 03:27:59 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH v2 5.10/5.15/6.1 0/5] x86/mm: backport fixes for CVE-2023-0597 and CVE-2023-3640
Date: Thu, 30 Jan 2025 03:27:36 +0300
Message-Id: <20250130002741.66796-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://www.cve.org/CVERecord/?id=CVE-2023-0597
Link: https://www.cve.org/CVERecord/?id=CVE-2023-3640

v1: https://lore.kernel.org/all/20241112224201.289285-1-kovalev@altlinux.org/

v2: fix the regression causing kernel boot failures when both
CONFIG_RANDOMIZE_BASE=y and CONFIG_KASAN=y are enabled, instead of backporting
commit d4150779e60f ("random32: use real rng for non-deterministic randomness"),
which would bring in additional fixing commits:

4051a81774d6 ("locking/lockdep: Use sched_clock() for random numbers")
327b18b7aaed ("mm/kfence: select random number before taking raw lock")
f05ccf6a6ac6 ("crypto: testmgr - fix RNG performance in fuzz tests")

replaced the random number generator function (prandom -> random) with in
commit dcd5ba760e89 ("x86/mm: Randomize per-cpu entry area"):

- cea = prandom_u32_max(max_cea);
+ cea = (u32)(((u64) get_random_u32() * max_cea) >> 32);

This change will replicate the behavior as if the fixing
commit d4150779e60f ("random32: use real rng for non-deterministic randomness")
had been applied.

[PATCH v2 5.10/5.15/6.1 1/5] x86/kasan: Map shadow for percpu pages on demand
[PATCH v2 5.10/5.15/6.1 2/5] x86/mm: Recompute physical address for every page of
[PATCH v2 5.10/5.15/6.1 3/5] x86/mm: Populate KASAN shadow for entire per-CPU range of
[PATCH v2 5.10/5.15/6.1 4/5] x86/mm: Randomize per-cpu entry area
[PATCH v2 5.10/5.15/6.1 5/5] x86/mm: Do not shuffle CPU entry areas without KASLR


