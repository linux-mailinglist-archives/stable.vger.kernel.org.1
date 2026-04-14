Return-Path: <stable+bounces-237896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ECeH9pR3mlIqQkAu9opvQ
	(envelope-from <stable+bounces-237896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:40:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F19003FB6A1
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C733F30E0F6A
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56A23E325;
	Tue, 14 Apr 2026 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blisvXN5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759F3E8693
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177129; cv=none; b=nl3f0pqY83bfSd0UNz7ThEuwYrYd7CCvM0GNBzPv3eUMprv4kw9Q+Ygavp2jN4i6RJ2kNrDn4bkuERgKPrwONXgOtIdnYJ6lNMl2+bI+8swwP9ImTgLMqgm8AAWSciP0jcQciWFStpzdmBcZ6TW1TNHUnzHGmSYLq1D7r+vMCHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177129; c=relaxed/simple;
	bh=OCBOxvUVA3iZFQHMnJZxr7ME+CJH9N1riYhfgi5OFaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PO2ijFQaVsIlUaEjmQWEMDCQR85kgGDvUDuNCXbAL+FfaxD80J96WOfHn7UHL6Zz2s9EBzQ7gqrhQOtrnjv3opqnIhAOOIXv8HCjTwFsRGJIRQjl3sU5xTjGOJbNGs1Mb9l8V8sUQTT3+XZBvXR5QwqpMa9sG9aPJvq8yvCL8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blisvXN5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3597822d6d8so1045277a91.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177126; x=1776781926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fj8xK0V4hyBK8W+g1KV8tKcvSDeKIl5UTUXp9K1uZbo=;
        b=blisvXN56iPqkyBgL27drBEjGP93vwjpEK8vEmEavpU7FpzgW5505HMtgu3ZAe0Slw
         uuEzmG3JRrGAFz0lZs8TRLrDD8Vd7oq0zVDy0jRMQ4nUAxx2KjZcq7Mpcc67ljO4W0Sq
         lCksgZI3Oyav/usvd1i6NqHHa2rauy5yYuHjMt0cPS2nhfmUrw3/Jxgy2eYVZ9Ix6m4k
         Dx8eu41VoiLM4iyt7IYyr/OxJXEEwpOFKy9ckHkPFP/LSR7sRMc08R2tKM+ki+RLfYQL
         WCwmAthqU9I41CoZOlrGtR7lYp2hAuCqbQhVJonGs82gAz9OA19JeEvjolcMRC8MOm2P
         2HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177126; x=1776781926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj8xK0V4hyBK8W+g1KV8tKcvSDeKIl5UTUXp9K1uZbo=;
        b=B1Sd9e0qGfiOi8fOIuiVs2Cqtshv5YQC4wRFzfCw/KmDmn61e32eCS/LPXfdi7uS8J
         IJaLE/dQZ38WxDjwKHwGHRmTds6y0IzgqoIhmeI2ILD626qT9U4zomE4m7flx1/bN76J
         Gx/yTh/ui2CGNht7tHsa7KkYKdkRitGyBlHRD5mBM5qmJSL5hUS/SMiroQSKtzHLBP6b
         LYpePVxfdVCixxFYBn/4GBjR7lVrV8d22/TiDND/Zm7D2CLn6F7HEUKjeqtWimsdTki6
         QueyAWk95GcApCIxMvKM7ZBSgvmG6agWtPdwBC3ywAW/qgeJwBniac/gP8erSk4kVPOU
         U1aA==
X-Forwarded-Encrypted: i=1; AFNElJ9T0IYPtinEOKHin+w0aEsUZa7wxgnSmp5dAZ7LczlTkoot0pgDk1RHIAlF8Zu7ebTUKl4HmAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHd3IXml65WXgf2np5x5iUuXvFWARl/zgNyBW+cDtzycslIRe5
	Ks5sG0iEDi09UuuPBP3qKHx/f+QHiwrVgnYYSdbwBo1mGdtjFZjnomf3
X-Gm-Gg: AeBDieseSacswYw9EAE4fg59JhjgK4gxM5dThNI7qQgT8e3wXmSCsVLbRD0Iyd1P7aT
	4a1xd1b/szhdPH79yOQBDoshYbHdxdGOv9Xrg4lA3bmMMtuLAMm0ZxhuIwBoFIUI5x+KJ8cFbXu
	Z6Gd9XIOBp6aXJP6aoWUAB9N8S0YwSIVhLFjx1Q+tprmQZgxq2k1bPUERqAsJa3AL7BE4cdmXPM
	8QlvD2k07uYcUxKnL57UCZ5SxMRImQSh/RMolLA4CqUf/ObIYrpknEdSZd5QuBq+GZUhS9jAnwf
	OPEAI8IbnTGv0BzfkX1ZRD2XqL7NUHQXpd6r1OIy1nriQ3fc/1no3l7ZRQk0K11MNf3ZQywkYV/
	7eQ2HQGgATWK9VjxVgOQBAzQnWeGc5vHI+IopYwHRlzOHZHSg3iBbQ1B7Vrm4cVpYZk3XsCh+O7
	IxOnRVBFjvggOEZEYi
X-Received: by 2002:a17:90b:1b4f:b0:35b:e69f:847 with SMTP id 98e67ed59e1d1-35e4430d82bmr10392670a91.8.1776177126212;
        Tue, 14 Apr 2026 07:32:06 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e75c38sm2272164a91.11.2026.04.14.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:32:05 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Youngjun Park <youngjun.park@lge.com>,
	Kairui Song <kasong@tencent.com>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] PM: hibernate: preserve uswsusp swap pin across SNAPSHOT_SET_SWAP_AREA re-set failures
Date: Tue, 14 Apr 2026 23:32:00 +0900
Message-ID: <20260414143200.1267932-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lge.com,tencent.com,kernel.org,huaweicloud.com,gmail.com,redhat.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-237896-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F19003FB6A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 5b2b0c6e4577 ("mm/swap, PM: hibernate: fix swapoff race in uswsusp
by pinning swap device") introduced SWP_HIBERNATION so that the swap
device chosen via /dev/snapshot is held against swapoff for the entire
uswsusp session. The intended invariant is: from the first successful
SNAPSHOT_SET_SWAP_AREA until the /dev/snapshot fd is closed, exactly one
swap device is pinned.

snapshot_set_swap_area() breaks that invariant on the re-set path:

	unpin_hibernation_swap_type(data->swap);
	data->swap = pin_hibernation_swap_type(swdev, offset);
	if (data->swap < 0)
		return swdev ? -ENODEV : -EINVAL;

The unpin happens unconditionally before the new pin is attempted. If
the new pin fails (e.g. user space supplies an offset/device that is not
an active swap area), the session continues with no swap device pinned,
reopening exactly the swapoff race the original commit was meant to
close. A subsequent swapoff on the previously selected device now
succeeds where it would have been blocked with EBUSY.

As a secondary consequence, data->swap is overwritten with the negative
error return from pin_hibernation_swap_type(). The value is harmless at
close time (swap_type_to_info() on the invalid type returns NULL, so the
release-side unpin is a no-op and there is no pin to leak), but leaving
a negative sentinel in data->swap for the rest of the session is still
a state-hygiene defect: any future reader of data->swap cannot
distinguish it from a never-set session.

The bug is observable with ioctls alone; it does not require an actual
hibernation cycle. A user-space caller that supplies one valid and then
one invalid resume_swap_area is enough to strand the session without a
pin.

Reordering pin/unpin in the caller cannot fix this cleanly. Each of
pin_hibernation_swap_type() / unpin_hibernation_swap_type() acquires
swap_lock independently, so any two-call sequence leaves a window in
which swapoff can observe an inconsistent pin state. The same-area
re-set case (type == old_type) also cannot be expressed with pin+unpin
without either toggling the bit (racy) or returning EBUSY (a false
error).

Introduce repin_hibernation_swap_type(), which performs the transition
atomically under a single swap_lock acquisition:

  - verify that old_type, if held, still carries SWP_HIBERNATION;
  - look up the new swap area;
  - if it is the same as old_type, return without touching any flags;
  - otherwise clear SWP_HIBERNATION on the old si and set it on the
    new si within the same critical section;
  - on any failure, return without modifying either si's flags, so the
    previous pin is preserved.

Update snapshot_set_swap_area() to use the new helper and to stage the
result in a local variable, committing to data->swap only on success.
This closes the protection-loss window and also avoids the data->swap
corruption on failure.

Fixes: 5b2b0c6e4577 ("mm/swap, PM: hibernate: fix swapoff race in uswsusp by pinning swap device")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
Notes (not part of the commit, stripped by git am):

Baseline
--------
This patch is generated against linux-next at commit 5b2b0c6e4577
("mm/swap, PM: hibernate: fix swapoff race in uswsusp by pinning swap
device"). Mainline does not yet carry that commit, and neither the
helpers it introduces (pin/unpin_hibernation_swap_type) nor the code
site this patch modifies exist there. The base-commit trailer at the
bottom of the mbox records the exact commit.

Testing
-------
The bug does not require an actual hibernation cycle. The ioctl path
alone is enough to re-open the swapoff race. A targeted reproducer is
included below; run it as root in a throwaway VM with two active swap
block devices and one non-swap block device (three arguments).

Run inside a VM on linux-next at 5b2b0c6e4577 with this patch applied:

  step1: pinned active swap /dev/vda
  step2: swapoff blocked with EBUSY while pin is held
  step3: repinned active swap to /dev/vdb
  step4: swapoff(/dev/vda) succeeded after repinning away
  step5: repinned swap is blocked with EBUSY
  step6: bogus SNAPSHOT_SET_SWAP_AREA failed as expected: No such device
  step7: swapoff(/dev/vdb) is still blocked with EBUSY
  result: FIXED kernel, hibernation pin was preserved
  step8: swapoff succeeded after closing /dev/snapshot

Run on the same tree without this patch applied: step7 instead reports
"swapoff(/dev/vdb) succeeded after failed re-set" and the program exits
with status 1 ("BUGGY kernel, hibernation pin was dropped").

What the reproducer covers:
  - SWP_HIBERNATION is actually enforced against swapoff (step2, step5);
  - the success path of repin_hibernation_swap_type() atomically moves
    the pin from one active swap to another (step3, step4, step5);
  - the failure path of repin_hibernation_swap_type() preserves the
    existing pin (step6, step7);
  - the pin lifetime ends on /dev/snapshot close (step8).

What it does not cover:
  - snapshot_open(O_RDONLY) initial resume-device pin path;
  - the full suspend-to-disk image create/restore flow;
  - concurrent swapoff racing against SNAPSHOT_SET_SWAP_AREA;
  - the type == old_type idempotent branch (not externally observable).

A normal sysfs-based suspend-to-disk cycle continues to work; the
find_hibernation_swap_type() path is unchanged. Build tested with
allmodconfig and run-tested with CONFIG_PROVE_LOCKING=y and
CONFIG_KASAN=y. The VM was booted with oops=panic panic=-1 so any
WARN/Oops/BUG would have halted the run; the full test completed
cleanly with no kernel log diagnostics, including the three
WARN_ON_ONCE() invariant checks inside repin_hibernation_swap_type().

Reproducer (C source, for reference only -- not added to the tree):

 // SPDX-License-Identifier: GPL-2.0
 /*
  * Reproduce the uswsusp SNAPSHOT_SET_SWAP_AREA pin lifetime regression.
  *
  * This targets the bug introduced after hibernation swap pinning was added:
  * a failed SNAPSHOT_SET_SWAP_AREA() could drop the existing pin, letting a
  * subsequent swapoff() succeed while /dev/snapshot was still open.
  *
  * Run only inside a throwaway VM. The test manipulates swap state and leaves
  * the target swap area disabled on success.
  */
 
 #define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/types.h>
 #include <linux/suspend_ioctls.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/swap.h>
 #include <sys/sysmacros.h>
 #include <unistd.h>
 
 static void print_usage(const char *prog)
 {
 	fprintf(stderr,
 		"usage: %s <active-swap-dev-1> <active-swap-dev-2> <bogus-block-dev>\n"
 		"  <active-swap-dev-1> must be an active swap block device.\n"
 		"  <active-swap-dev-2> must be a second active swap block device.\n"
 		"  <bogus-block-dev> must be a block device that is not a swap area.\n",
 		prog);
 }
 
 static int encode_dev(dev_t dev)
 {
 	unsigned int major_num = major(dev);
 	unsigned int minor_num = minor(dev);
 
 	/*
 	 * Match the kernel's new_encode_dev() layout; SNAPSHOT_SET_SWAP_AREA
 	 * decodes this with new_decode_dev() on the kernel side.
 	 */
 	return (major_num & 0xfff) << 8 |
 	       (minor_num & 0xff) |
 	       ((minor_num & ~0xff) << 12);
 }
 
 static int get_block_dev(const char *path, dev_t *dev)
 {
 	struct stat st;
 
 	if (stat(path, &st) < 0) {
 		fprintf(stderr, "stat(%s): %s\n", path, strerror(errno));
 		return -errno;
 	}
 
 	if (!S_ISBLK(st.st_mode)) {
 		fprintf(stderr, "%s is not a block device\n", path);
 		return -EINVAL;
 	}
 
 	*dev = st.st_rdev;
 	return 0;
 }
 
 static int snapshot_set_swap_area(int fd, dev_t dev, long long offset)
 {
 	struct resume_swap_area area = {
 		.offset = offset,
 		.dev = encode_dev(dev),
 	};
 
 	if (ioctl(fd, SNAPSHOT_SET_SWAP_AREA, &area) < 0)
 		return -errno;
 	return 0;
 }
 
 int main(int argc, char **argv)
 {
 	const char *swap_path_1, *swap_path_2, *bogus_path;
 	dev_t swap_dev_1, swap_dev_2, bogus_dev;
 	int fd, ret;
 	bool buggy = false;
 
 	if (argc != 4) {
 		print_usage(argv[0]);
 		return 2;
 	}
 
 	if (geteuid() != 0) {
 		fprintf(stderr, "must run as root\n");
 		return 2;
 	}
 
 	swap_path_1 = argv[1];
 	swap_path_2 = argv[2];
 	bogus_path = argv[3];
 
 	ret = get_block_dev(swap_path_1, &swap_dev_1);
 	if (ret < 0)
 		return 2;
 
 	ret = get_block_dev(swap_path_2, &swap_dev_2);
 	if (ret < 0)
 		return 2;
 
 	ret = get_block_dev(bogus_path, &bogus_dev);
 	if (ret < 0)
 		return 2;
 
 	fd = open("/dev/snapshot", O_WRONLY);
 	if (fd < 0) {
 		fprintf(stderr, "open(/dev/snapshot): %s\n", strerror(errno));
 		return 2;
 	}
 
 	ret = snapshot_set_swap_area(fd, swap_dev_1, 0);
 	if (ret < 0) {
 		fprintf(stderr, "step1: valid SNAPSHOT_SET_SWAP_AREA failed: %s\n",
 			strerror(-ret));
 		close(fd);
 		return 2;
 	}
 	printf("step1: pinned active swap %s\n", swap_path_1);
 
 	if (swapoff(swap_path_1) == 0) {
 		fprintf(stderr,
 			"step2: swapoff(%s) unexpectedly succeeded while pinned\n",
 			swap_path_1);
 		close(fd);
 		return 1;
 	}
 	if (errno != EBUSY) {
 		fprintf(stderr,
 			"step2: swapoff(%s) failed with %s, expected EBUSY\n",
 			swap_path_1, strerror(errno));
 		close(fd);
 		return 2;
 	}
 	printf("step2: swapoff blocked with EBUSY while pin is held\n");
 
 	ret = snapshot_set_swap_area(fd, swap_dev_2, 0);
 	if (ret < 0) {
 		fprintf(stderr,
 			"step3: second valid SNAPSHOT_SET_SWAP_AREA failed: %s\n",
 			strerror(-ret));
 		close(fd);
 		return 2;
 	}
 	printf("step3: repinned active swap to %s\n", swap_path_2);
 
 	if (swapoff(swap_path_1) < 0) {
 		fprintf(stderr,
 			"step4: swapoff(%s) failed after repin: %s\n",
 			swap_path_1, strerror(errno));
 		close(fd);
 		return 2;
 	}
 	printf("step4: swapoff(%s) succeeded after repinning away\n",
 	       swap_path_1);
 
 	if (swapoff(swap_path_2) == 0) {
 		fprintf(stderr,
 			"step5: swapoff(%s) unexpectedly succeeded while pinned\n",
 			swap_path_2);
 		close(fd);
 		return 1;
 	}
 	if (errno != EBUSY) {
 		fprintf(stderr,
 			"step5: swapoff(%s) failed with %s, expected EBUSY\n",
 			swap_path_2, strerror(errno));
 		close(fd);
 		return 2;
 	}
 	printf("step5: repinned swap is blocked with EBUSY\n");
 
 	ret = snapshot_set_swap_area(fd, bogus_dev, 0);
 	if (!ret) {
 		fprintf(stderr,
 			"step6: bogus SNAPSHOT_SET_SWAP_AREA unexpectedly succeeded\n");
 		close(fd);
 		return 2;
 	}
 	printf("step6: bogus SNAPSHOT_SET_SWAP_AREA failed as expected: %s\n",
 	       strerror(-ret));
 
 	if (swapoff(swap_path_2) == 0) {
 		printf("step7: swapoff(%s) succeeded after failed re-set\n",
 		       swap_path_2);
 		printf("result: BUGGY kernel, hibernation pin was dropped\n");
 		buggy = true;
 	} else if (errno == EBUSY) {
 		printf("step7: swapoff(%s) is still blocked with EBUSY\n",
 		       swap_path_2);
 		printf("result: FIXED kernel, hibernation pin was preserved\n");
 	} else {
 		fprintf(stderr, "step7: unexpected swapoff(%s) error: %s\n",
 			swap_path_2, strerror(errno));
 		close(fd);
 		return 2;
 	}
 
 	close(fd);
 
 	if (!buggy) {
 		if (swapoff(swap_path_2) < 0) {
 			fprintf(stderr,
 				"step8: swapoff(%s) after close failed: %s\n",
 				swap_path_2, strerror(errno));
 			return 2;
 		}
 		printf("step8: swapoff succeeded after closing /dev/snapshot\n");
 	}
 
 	printf("note: re-enable swap with `swapon %s` and `swapon %s`\n",
 	       swap_path_1, swap_path_2);
 	return buggy ? 1 : 0;
 }


 include/linux/swap.h |  1 +
 kernel/power/user.c  | 12 +++------
 mm/swapfile.c        | 61 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1930f81e6be4..720347ae8ce1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -435,6 +435,7 @@ static inline long get_nr_swap_pages(void)
 
 extern void si_swapinfo(struct sysinfo *);
 extern int pin_hibernation_swap_type(dev_t device, sector_t offset);
+extern int repin_hibernation_swap_type(int old_type, dev_t device, sector_t offset);
 extern void unpin_hibernation_swap_type(int type);
 extern int find_hibernation_swap_type(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 4406f5644a56..869371ad4a5f 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -218,6 +218,7 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 {
 	sector_t offset;
 	dev_t swdev;
+	int swap;
 
 	if (swsusp_swap_in_use())
 		return -EPERM;
@@ -238,19 +239,14 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 		offset = swap_area.offset;
 	}
 
-	/*
-	 * Unpin the swap device if a swap area was already
-	 * set by SNAPSHOT_SET_SWAP_AREA.
-	 */
-	unpin_hibernation_swap_type(data->swap);
-
 	/*
 	 * User space encodes device types as two-byte values,
 	 * so we need to recode them
 	 */
-	data->swap = pin_hibernation_swap_type(swdev, offset);
-	if (data->swap < 0)
+	swap = repin_hibernation_swap_type(data->swap, swdev, offset);
+	if (swap < 0)
 		return swdev ? -ENODEV : -EINVAL;
+	data->swap = swap;
 	data->dev = swdev;
 	return 0;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c5b459a18f43..4d3b41125e6a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2215,6 +2215,67 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
 	return type;
 }
 
+/**
+ * repin_hibernation_swap_type - Retarget a hibernation pin without dropping it
+ * @old_type: Currently pinned swap type, or a negative value if none is pinned
+ * @device: Block device containing the resume image
+ * @offset: Offset identifying the swap area
+ *
+ * Locate the swap device for @device/@offset and make it the hibernation-pinned
+ * device. If @old_type already refers to the same swap area, the existing pin
+ * is kept. On failure, the previous pin is preserved.
+ *
+ * Return:
+ * >= 0 on success (new swap type).
+ * -EINVAL if @device is invalid.
+ * -ENODEV if the swap device is not found.
+ * -EBUSY if another device is already pinned for hibernation.
+ */
+int repin_hibernation_swap_type(int old_type, dev_t device, sector_t offset)
+{
+	int type;
+	struct swap_info_struct *old_si = NULL, *new_si;
+
+	spin_lock(&swap_lock);
+
+	if (old_type >= 0) {
+		old_si = swap_type_to_info(old_type);
+		if (WARN_ON_ONCE(!old_si || !(old_si->flags & SWP_HIBERNATION))) {
+			spin_unlock(&swap_lock);
+			return -EINVAL;
+		}
+	}
+
+	type = __find_hibernation_swap_type(device, offset);
+	if (type < 0) {
+		spin_unlock(&swap_lock);
+		return type;
+	}
+
+	if (type == old_type) {
+		spin_unlock(&swap_lock);
+		return type;
+	}
+
+	new_si = swap_type_to_info(type);
+	if (WARN_ON_ONCE(!new_si)) {
+		spin_unlock(&swap_lock);
+		return -ENODEV;
+	}
+
+	if (WARN_ON_ONCE(new_si->flags & SWP_HIBERNATION)) {
+		spin_unlock(&swap_lock);
+		return -EBUSY;
+	}
+
+	if (old_si)
+		old_si->flags &= ~SWP_HIBERNATION;
+	new_si->flags |= SWP_HIBERNATION;
+
+	spin_unlock(&swap_lock);
+	return type;
+}
+
 /**
  * unpin_hibernation_swap_type - Unpin the swap device for hibernation
  * @type: Swap type previously returned by pin_hibernation_swap_type()

base-commit: 5b2b0c6e457765adbe96fb2d464ff1bcd3d72158
-- 
2.43.0


