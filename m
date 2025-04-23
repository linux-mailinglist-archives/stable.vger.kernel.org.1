Return-Path: <stable+bounces-135226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF76AA97E5D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E477A2300
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 05:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FC9265619;
	Wed, 23 Apr 2025 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z6PNHKQS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BDEAFA
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387633; cv=none; b=UhFxMOFCa9gsaIj9zRVQRcipyLLyOPtwOxWC6pa4rj9SmdfIILyFC5vOB0MK5G6wO9856j/I3KR3si8JSlZf+9MHrdHyfJG69/0o9MNGHyViDfIIxseMb858Jo3nCDvrIlIYrzM3I1vR+BCN6ukOpJmFjeSKSmu5VwxVVaAtSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387633; c=relaxed/simple;
	bh=cBLnR2e9p6MbPR/VLFn+fkB+WbH36ne5ggQCcMCexOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZET7Oqi6JAs8HUJOlKzzvD80rOU8+bQWEniobCb0vsu6Xaot2XEPYn12nj9th9q5BJge1avTfaknmsjJG5YgVzEHzUJknOLAVINKrykn6wiJkTK1SRBX+aFUoK1f5G0Fmry+5VAr3w9rWl9TtFp17UrEq7vbEm3Ual+j6ZV81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z6PNHKQS; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso4274129f8f.2
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745387629; x=1745992429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMEWJ5urtpMVWG9uRW+hxPJ8zGK0oWlvxK9zdQTz/WQ=;
        b=Z6PNHKQSiKwVLSy5agd7Pinl7r945m5C34G6I74IDsseqmwYb+wlRDSPCRNm5yoyoI
         00ku8mk7eyse08HAN6BrpAEWb2BEwI0J9Y/Yz2kXDm2EZNMYaBPw8SUP+f1oRUv3G9HL
         uLk1RZeMOlnk1x6F8ZVS+3ZIAqzR9293Wl+jgC3iLR03FpHzFTJneswT/zdMb1H9taf5
         HxXKzRBX9s/QfcuaE9JSydn+Oxg88Rt33u5WhJgcap/466uxkSjlpJ8AwkyiTwK4xqPw
         cKQb10iQ9p55J4BsSihXLa0p0kQj7jeYxiSNUT+89G8xsOG0YxNpcolLMpDWu8uTizXK
         ONgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745387629; x=1745992429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMEWJ5urtpMVWG9uRW+hxPJ8zGK0oWlvxK9zdQTz/WQ=;
        b=IiXW1UuRN/Yal2n+E4QP+zWVs6m3EOurvI2uaoeikl5RmTbNnAO52WGwRni8frG5NB
         n8mV09QKv7RrV+v5xjo1T2nSjKagxhDtnb55I2CF2lZOl/M/fv26y1R+YKv9rzEgI03E
         EzN5i5zQGHefSRvSDlDTgfFtz2yKJKZizE1fE/biKxLvld+Wm3c0eq241BcYNaJ9PF7c
         Nd6wXrLzkVwhDJDdqlOhU0Wt5+S0Rc2G23lUT0De8Kgumssi4gVspDNHrsBC8V05VKij
         w+V/mVuXML4vQpHUZoyQ9LpFjiXoVtpaqAB2RIBY43Ch5FrtgdYNo5MFIDn2kfToePen
         qB0g==
X-Gm-Message-State: AOJu0YzryI1QirdDPIA4Drl6ANj/7UPl5lScIotNkv8bwjxtNCduJeq4
	400n5x2LCf+BGouphWrFQTX1vCAh+vbc0DeFUMG5uI5lr6T6yBNTZnBnuG1x1AQ6HLCA8icwcWo
	RntiQTg==
X-Gm-Gg: ASbGncscy2I6U5uNQt7oYQj8Q2hdyZrJdQduTMA3JIKRvsdZVpFnWd/a2hODygHSULd
	aZK3OgT5fJ98njLZy3xulfJOZoDFPFJs+Gj5nG366C0krYz4hBlcdFjc3aGM/h02nUcmJbapqy7
	d7Qlg2EYTMeWug4km3uksD6jbip8fcigL3ogJ79b8qkPZXsBjoiM7UJpeV6fEXtXbBGV5ZXdxnN
	OuX007NGpU0XRvKrClqCAz3Pp1CfZQl4UbVeNwWt7u5KPlnziNXrN2rueZpFNnjra9qn/r6cA8f
	sfmZ6ATGUlPMbpT8pc1XG8uS4fZlr8ma9viJnP+HKqZ0a2nm034OBVoGz3ub3QQ4pOK0Bg==
X-Google-Smtp-Source: AGHT+IEvyOZqvDXHNRAE9s1IJ8j+E7st3nSH9wLt9mMX0kFRJrUVlTVnd+pHK6OGWz0+acEqp2EKjA==
X-Received: by 2002:a5d:64cf:0:b0:39c:30f7:ac88 with SMTP id ffacd0b85a97d-39efba4e29cmr13569741f8f.20.1745387629309;
        Tue, 22 Apr 2025 22:53:49 -0700 (PDT)
Received: from localhost (27-240-233-37.adsl.fetnet.net. [27.240.233.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50bd993dsm96392215ad.37.2025.04.22.22.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 22:53:48 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 0/8] bpf: track changes_pkt_data property for global functions
Date: Wed, 23 Apr 2025 13:53:21 +0800
Message-ID: <20250423055334.52791-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While stable 6.12 has commit 1a4607ffba35 ("bpf: consider that tail
calls invalidate packet pointers") backported, that alone is not enough
to fix the issue reported by Nick Zavaritsky[1]. This is evident when
running the verifier_sock/invalidate_pkt_pointers_from_global_func and
verifier_sock/invalidate_pkt_pointers_by_tail_call BPF selftests[2].

  Error: #529 verifier_sock
  Error: #529/57 verifier_sock/invalidate_pkt_pointers_from_global_func
  run_subtest:PASS:obj_open_mem 0 nsec
  run_subtest:FAIL:unexpected_load_success unexpected success: 0
  Error: #529/58 verifier_sock/invalidate_pkt_pointers_by_tail_call
  run_subtest:PASS:obj_open_mem 0 nsec
  run_subtest:FAIL:unexpected_load_success unexpected success: 0

Fix the issue by backporting the entire "bpf: track changes_pkt_data property
for global functions" series[3], along with the follow up, "bpf: fix NPE when
computing changes_pkt_data of program w/o subprograms" series[4]; both from
Eduard. With this series applied the test above no longer fails[5].

1: https://lore.kernel.org/bpf/0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com/
2: https://github.com/shunghsiyu/libbpf/actions/runs/14591085098/job/40926303169
3: https://lore.kernel.org/all/20241210041100.1898468-1-eddyz87@gmail.com/
4: https://lore.kernel.org/all/20241212070711.427443-1-eddyz87@gmail.com/
5: https://github.com/shunghsiyu/libbpf/actions/runs/14609494070/job/40984756980

Eduard Zingerman (8):
  bpf: add find_containing_subprog() utility function
  bpf: track changes_pkt_data property for global functions
  selftests/bpf: test for changing packet data from global functions
  bpf: check changes_pkt_data property for extension programs
  selftests/bpf: freplace tests for tracking of changes_packet_data
  selftests/bpf: validate that tail call invalidates packet pointers
  bpf: fix null dereference when computing changes_pkt_data of prog w/o
    subprogs
  selftests/bpf: extend changes_pkt_data with cases w/o subprograms

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/verifier.c                         |  79 +++++++++++--
 .../bpf/prog_tests/changes_pkt_data.c         | 107 ++++++++++++++++++
 .../selftests/bpf/progs/changes_pkt_data.c    |  39 +++++++
 .../bpf/progs/changes_pkt_data_freplace.c     |  18 +++
 .../selftests/bpf/progs/verifier_sock.c       |  56 +++++++++
 7 files changed, 292 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c

-- 
2.49.0


