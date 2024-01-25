Return-Path: <stable+bounces-15740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B7683B5EF
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E132890A2
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B8C197;
	Thu, 25 Jan 2024 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgSTn7Y1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C3C7F
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141780; cv=none; b=syvHbbZ+nW38WjgwXII/z176HqGzQgTSnRFNZHQ/AhSVYvz0HVQVcQOjFD6binEXj+332EBmFWVoatcshxOYy0SW12FF5axuXEwpLzczABQc4ZMDSuURuL8d8eXJ6dTO7TIdCnvtM4ryEEwddHOX5wXjbzLX+hAwidv3Re0d/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141780; c=relaxed/simple;
	bh=4lhSQOaGGAtm2mILgq/OtxB6iVBb4xFPxwpoom8sef0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPCun4XWDT4pxQWsRE61a1c3t4ilPCuMyI97Ui7Q+b0gele1Fot/IFIImr9LV+zIVRtTnBF2yuwm+jDqLDsW6OeYb7sL+6MgAVzEgifi3WvhYx56CMK496OgkvVmVUeakTaeVxhRGYUhQkEj7VgBi833BkcWqpJcUevB/UVzI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgSTn7Y1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3106f5aac8so174174466b.0
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141777; x=1706746577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aagj/itV+8X7Aw0GTPZ5q+bpVR+SKDuLD3hYdxAXPzU=;
        b=LgSTn7Y1tbbHBXq0Mb8UvjkWhW4t4cyMmNypzU1xuD6sntdKtSvLSgOZXsIIAC6Grj
         YodzEeyD+0kYlvVPyZlKBbuaoP1p7Omvh4rymgGFsiXbCzYcZx7pY89LZLkq4soXPBxq
         kQ0SBuauUXsNIzLy4nEdjWbhQgbWe8h90fI5AdaC3E3WezkhQ9V7iwXsh2ocUCancQ0Z
         wN5mzl7TVEXFA4UjwTazCfK3vzlcnboSBvlJKFo4Cyb4uGvndX2XI9dasaIWGHS6UH50
         oe7zgPco+BCAyhIhfKcr1rptIjNNImFmpnBjDwGuYdr5780EYMmqZ5KZBj62fVq+pWI0
         dAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141777; x=1706746577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aagj/itV+8X7Aw0GTPZ5q+bpVR+SKDuLD3hYdxAXPzU=;
        b=pRkeaKrvSGwo+vA00lIOSaJ0kN6eg9yeOe64pJN7cQT3kwlJ70EBNb0Rx0uBsp9qKw
         My/eFSTRpbCvKlgUVwasFPreEn9fzcv5KI1V/81phee4XpRi9uFOAq5jzNp88yNdqXdK
         kGXhvioRaJId6w+13hSSM+jd7PRYlOv2boJBRGOCgJwb8og3qwrpZWro+WNmmIglvruf
         i3N5qto34c//QsARj+p9WddB6f4tbX/zw//E7HW4gbNF5lBJ8MoWwIF1/rYcYh+lQRe4
         cUlBuZsBvB1cujGFqrdY3/q5Wy01NpHK77xtJSNn3hhQE7ukQwTabVYl3JMfunDDXpuc
         32RA==
X-Gm-Message-State: AOJu0YwQo+oFXSWuJbUllDKUOHRiNYdTO5Qd9alMc3feNYRzt1mVCGKk
	toSaBTFDr59n4caSef0cubhIjE1YYwe2pnq9a5yuCV5sVfCMj2uqA/5rogtz
X-Google-Smtp-Source: AGHT+IF3Yn2Z4pJQ9B3fqeahNBMdQFpH2K3sZUlCtGgm/LeeiLnDaDndFiHKVncok75/Gzkj/HPLqw==
X-Received: by 2002:a17:906:3b93:b0:a30:9cd5:232d with SMTP id u19-20020a1709063b9300b00a309cd5232dmr35337ejf.80.1706141776652;
        Wed, 24 Jan 2024 16:16:16 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:16 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: stable@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	mykolal@fb.com,
	gregkh@linuxfoundation.org,
	mat.gienieczko@tum.de,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.6.y 00/17] bpf: backport of iterator and callback handling fixes
Date: Thu, 25 Jan 2024 02:15:37 +0200
Message-ID: <20240125001554.25287-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a backport of two upstream patch-sets:
1. "exact states comparison for iterator convergence checks"
   https://lore.kernel.org/all/20231024000917.12153-1-eddyz87@gmail.com/
2. "verify callbacks as if they are called unknown number of times"
   https://lore.kernel.org/all/20231121020701.26440-1-eddyz87@gmail.com/
  
Both patch-sets fix BPF verifier logic related to handling loops:
for bpf iterators, and for helper functions that accept callback
functions.

The backport of (2) was requested as a response to bug report by
Mateusz Gienieczko <mat.gienieczko@tum.de>.
The (1) is a dependency of (2).

The patch-set was tested by running BPF verifier selftests on my local
qemu-based setup.

Most of the commits could be cherry-picked but three required merging:

| Action | Upstream commit                                                                                 |
|--------+-------------------------------------------------------------------------------------------------|
| pick   | 3c4e420cb653 ("bpf: move explored_state() closer to the beginning of verifier.c ")              |
| pick   | 4c97259abc9b ("bpf: extract same_callsites() as utility function ")                             |
| merge  | 2793a8b015f7 ("bpf: exact states comparison for iterator convergence checks ")                  |
| pick   | 389ede06c297 ("selftests/bpf: tests with delayed read/precision makrs in loop body ")           |
| pick   | 2a0992829ea3 ("bpf: correct loop detection for iterators convergence ")                         |
| pick   | 64870feebecb ("selftests/bpf: test if state loops are detected in a tricky case ")              |
| pick   | b4d8239534fd ("bpf: print full verifier states on infinite loop detection ")                    |
| drop   | dedd6c894110 ("Merge branch 'exact-states-comparison-for-iterator-convergence-checks' ")        |
|--------+-------------------------------------------------------------------------------------------------|
| pick   | 977bc146d4eb ("selftests/bpf: track tcp payload offset as scalar in xdp_synproxy ")             |
| pick   | 87eb0152bcc1 ("selftests/bpf: track string payload offset as scalar in strobemeta ")            |
| pick   | 683b96f9606a ("bpf: extract __check_reg_arg() utility function ")                               |
| pick   | 58124a98cb8e ("bpf: extract setup_func_entry() utility function ")                              |
| merge  | ab5cfac139ab ("bpf: verify callbacks as if they are called unknown number of times ")           |
| pick   | 958465e217db ("selftests/bpf: tests for iterating callbacks ")                                  |
| pick   | cafe2c21508a ("bpf: widening for callback iterators ")                                          |
| pick   | 9f3330aa644d ("selftests/bpf: test widening for iterating callbacks ")                          |
| merge  | bb124da69c47 ("bpf: keep track of max number of bpf_loop callback iterations ")                 |
| pick   | 57e2a52deeb1 ("selftests/bpf: check if max number of bpf_loop iterations is tracked ")          |
| drop   | acb12c859ac7 ("Merge branch 'verify-callbacks-as-if-they-are-called-unknown-number-of-times' ") |

Note:
I don't know how deal with merge commits, so I just dropped those.
These commits are empty but contain cover letters for both series,
so it might be useful to pick those (how?).

Eduard Zingerman (17):
  bpf: move explored_state() closer to the beginning of verifier.c
  bpf: extract same_callsites() as utility function
  bpf: exact states comparison for iterator convergence checks
  selftests/bpf: tests with delayed read/precision makrs in loop body
  bpf: correct loop detection for iterators convergence
  selftests/bpf: test if state loops are detected in a tricky case
  bpf: print full verifier states on infinite loop detection
  selftests/bpf: track tcp payload offset as scalar in xdp_synproxy
  selftests/bpf: track string payload offset as scalar in strobemeta
  bpf: extract __check_reg_arg() utility function
  bpf: extract setup_func_entry() utility function
  bpf: verify callbacks as if they are called unknown number of times
  selftests/bpf: tests for iterating callbacks
  bpf: widening for callback iterators
  selftests/bpf: test widening for iterating callbacks
  bpf: keep track of max number of bpf_loop callback iterations
  selftests/bpf: check if max number of bpf_loop iterations is tracked

 include/linux/bpf_verifier.h                  |  32 +
 kernel/bpf/verifier.c                         | 875 ++++++++++++++----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/cb_refs.c   |   1 +
 tools/testing/selftests/bpf/progs/iters.c     | 695 ++++++++++++++
 .../testing/selftests/bpf/progs/strobemeta.h  |  78 +-
 .../bpf/progs/verifier_iterating_callbacks.c  | 242 +++++
 .../bpf/progs/verifier_subprog_precision.c    |  86 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |  84 +-
 9 files changed, 1830 insertions(+), 265 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

-- 
2.43.0


