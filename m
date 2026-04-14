Return-Path: <stable+bounces-237894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLsyFLFR3mlUqQkAu9opvQ
	(envelope-from <stable+bounces-237894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:39:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D13FB65B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AAB8300EA84
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DF23E8C5E;
	Tue, 14 Apr 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFRkbMhZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE53E5ECA
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177091; cv=none; b=qmZAFuyRIOjiofR4NOC+MghUNyuI+tURNGUcLnFFto34rGAlXun8Ch4VT7gJ09FmZ727IlF4ESHq9h9T0N3Ghiejy/z8ohE4IbxqmdZKdVPXb8VyzG+AzBJegz8OKsR8Ete3Ry9BTgpt+3HdT8GbG1W33nEbXJHGjc/mwo8uc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177091; c=relaxed/simple;
	bh=OCBOxvUVA3iZFQHMnJZxr7ME+CJH9N1riYhfgi5OFaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iOvKa9NFJTJD36kHsCSgQJ0TD5b2ozzkWonwg9ODdddvoP/dnkyP8pPZYXXGWFLsLUtYbcPqtDpcS34NKGQcQz+N6UIJ+3Za/YQWFDHtiSF4SngKAzJaSUmfw6HaCyzj1D8aBcJ2XI/e2+3wGDoVI0Y6bBRB/G0jgtsQIo8rppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFRkbMhZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a3e79fe2b8so3696765ad.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177089; x=1776781889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fj8xK0V4hyBK8W+g1KV8tKcvSDeKIl5UTUXp9K1uZbo=;
        b=EFRkbMhZuUg54+86UZ/RnVGoz3oWnr0Y9q6L7wOyNW6FpEoG/FmfrEOWFKq4YGM+6b
         PhkRPyXw65q701xnmH80EYYlkOrvufm5AjntnMmLe6RxE0duVUXjNoN5dT3r5nQOQGcP
         y/khIZCrueDCqyamrhSrLxPACoO9tWvaZsNb9TqCDxblkzgFIXt49UGfH1pPXLheoslM
         CUP29DdyRpF+3Eig3AXB80+jAvWi6akv1x9eT9kmrgd5Ng9AHjvi+1eaUfnCheCF1Ycg
         anaoqOzAEVoWLu1/xFumoBy+2JPuuBmo6wRMXhJVp+MGyFH+ieLgCcAKJ8s0sQAiOWFR
         w7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177089; x=1776781889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj8xK0V4hyBK8W+g1KV8tKcvSDeKIl5UTUXp9K1uZbo=;
        b=RdGWUIe6kWIbNFCMiAuyotbWEr4hZ8C0UhLXCn8vKrVGcasqsJV2uzIrFEvb9O+vky
         kqo/aDS7P5uGfkyzaKTF42jMbqgap5H/8/7T4nlfUWVfdgIguZzaFqgp6zevi0t2xIX6
         2e0oJo1v4q6Nlv1qeW0ZhXQf/0wIBqn0afxfxsUipUgAJ3ceniomJeFYFw7KuMiSoWB2
         5J5HoebdaXBL1skBNJ9GqMTnoXtF902FYdMMIatP0fJkiZJW3jIev0Ltsj2MncQAm/F+
         RkjjqItzsgqigewWeVjsvgYYFdcq1Yy3TBXDuL6y+Q7U4zKZwlG7lLBwsJODFPNDa50P
         EOMw==
X-Gm-Message-State: AOJu0YzXgNfUSIAFQNKDfIVBne58qY1tcWkbuqcz26pgSRwi8Sk6opb2
	lygH7jm5oD5gVUyYb2AC5lXThb20xer896JzM7rI3QbaB7XzZTt79pti
X-Gm-Gg: AeBDievKjDZK9zrVNRBvyzAk7o80FH0fzqXRrlD6IA6aV23FMUhlVv0tVQA8TjL05lo
	ZMtaCtfH/VC3xvMKLMqOT7H/cOkcJgZ567ndHdaufemqpRpj02vryFh9CIB6lACaLsmpx4B5c0k
	uWmNi0v4E4nHeHJmYMalcCZf7gdru68RnxDhdXN8gpdLdr52dq9ifx9+oC2rDJglSWaIIAnN20b
	OFmmYT2Qcky46c816VAK31JuSf/G2RlVOswVcCDPMs/7uN0yajbS/4HNnMbCYTzylEdeCg/I1EA
	JIC6yT40xwIaD7pJGDfm3itYToIf8PdGSpKZd1TK1CMM/beB0fGndwdTCkOCu0hfPVzGQ9Q5yIS
	ZtkfA08khGW7RWVP5NZhHWwCxLSwm/XLAh7xw/X2KbJ0AJShAl6CcgkOoVt30M5wae9GRcRudjA
	0Oz9akpvn81rVNCNtb
X-Received: by 2002:a17:903:1108:b0:2ae:54b2:27d9 with SMTP id d9443c01a7336-2b2d5a8f595mr107625495ad.7.1776177087911;
        Tue, 14 Apr 2026 07:31:27 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm143136075ad.79.2026.04.14.07.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:31:27 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: charsyam@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] PM: hibernate: preserve uswsusp swap pin across SNAPSHOT_SET_SWAP_AREA re-set failures
Date: Tue, 14 Apr 2026 23:31:21 +0900
Message-ID: <20260414143121.1267803-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-237894-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F0D13FB65B
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


