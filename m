Return-Path: <stable+bounces-136667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DF2A9C090
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A8D17FA46
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113C2233158;
	Fri, 25 Apr 2025 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eiV0UKJj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F50233136
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568771; cv=none; b=aI4Cg+Kek8/HbWAolzrzjiv8bGcu/oLmMJAdz7zeHxPBhU1B6EbMOQBqyMsPkkqLwVDqMByscGQKDOrk55DXPu/y+h0N4zr76CW7k0PrJmt24DFSxaKdGL1Ihy2FaRaWXbBpJx8nDkwWREZuWkIdjoYpaAagp0rAkdp3T/VMcp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568771; c=relaxed/simple;
	bh=1oRE9Lc8n4+aYsrgBcYNNBnnGSFCleYBuVGVdm1Lh0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=neiaNDVg8rWdGGtGZ6+Bynlpidh/X6oQLOMnLc14Isb7qCC0TNsRbcOlzwmAGEhQT5xBIFsuWhFu96Wr6DMZKGil80+Tm3bmYp+qzpZBwxNSQAQnBJglBuUPJC65z1FWnbY8w9E5zuLmpYrqHGoZQKAPRh2FfeElssLE2qNHKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eiV0UKJj; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso1569363f8f.2
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745568768; x=1746173568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cYyQyZEYdwuZP7Ntn12ILNop2FgGUL4dLpkOOPYjiZw=;
        b=eiV0UKJjYHxlsYvMGEh0vTw34dAyl7GFrkZ104o3MT6JJ+om3Jv+CB3KJCB49JQiLt
         NAPJcDhfBcGg/paNtpG8VNjFNJe5d6Z8IyQGiYYeVaedMGa2zqStP2g3B1Ies4QgCWOy
         dOpK68m1xAemjMHWqPXhlkEP7ySAbhXqAJqrEP8riQ5OTcQiNp7hyKC9yr0VoCae3cYm
         F5pB0Pwa4HLJs45JoaOKynKNF8zpTClZlxOMVje6GmY78VdrPzVTx5ZH+4D3gzPcuumy
         C4WrVK9TTrSAjGnMttA4nzlKXsA+OZVG/wJ1F271awKJT4aCelzo5yUFwcIWRkNyaJuT
         AbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568768; x=1746173568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYyQyZEYdwuZP7Ntn12ILNop2FgGUL4dLpkOOPYjiZw=;
        b=Ldoor0DS6M59aIg0H3YGyT9rcG4ExfUpJ+tDzCLegBm++bqjCPH8gQvw5WOEtwtffL
         m4NIk1E2F9R23Zmc3BRRh15v+8EMxp1uSTLqYU4EODBSAEta7iQZjmZqPQ2P0yf6rEn6
         ytt2v8vPY2H+XzDHQSh4R56c0MvVooFNetDwpq0RN6cHV6/I91dbaNLWHMClDQhxBTEe
         vN1CjFfeCjU+/w9JC/HOOTGY8ZZeaRX/pywkWuJpny0b/wnADqWuv2Zh0Uy1x1B6S2gL
         2nhrGfTyFfOGPKb0caWRe5BsxijvQ7savXvXJeGI1ZiwGt6Z+8yJoUpo7bbRX6II8SnP
         77Rw==
X-Gm-Message-State: AOJu0YyfDM4xUAoFpAFL/y7Ssh+jcJPWM3YBiYncDmZoFrjgzIfQVk2e
	o+vk+SsRtNOidO91zZ8gS6ZbRhd7baDlVm3mEGyojsBTGFP2qDYxHYyjepun1Bjg4Qfu0j4ec7g
	PKA63eA==
X-Gm-Gg: ASbGncsx97b4mc65E1eRvAhzTBPbwCU9K34huLzL5rO13TTvcS6km8+pmBGbq4C8O3N
	ylNndF8PTXq7hdeEJ6jMqjJ5Hp/5HjvsjtmJoEgQgEF2WyI17ZLBpfxOx4d0OQedhppMB1N7VXB
	2+JufSMgVr76UXrI+Z44MUbDRVItA7tAv7o26IjEeix1i7JY+D+FnD4urm8fi+qes0Z36YbROcF
	uzCsfRJeE1KR98ux0XSoVunj/kKTwhIxCUBzEniwiZMz+F0Gx31MvDwVUPeVeJ7hMP3JfrK006T
	9EDe1FnyJruq3oXNb5waW3kp7FhRsjbHvov/6s2L+0I=
X-Google-Smtp-Source: AGHT+IE5Lr+xmDk0du/a1ru3xw/UihbzmHcPRIGoY4aujfDYGyrGpCJRX5WfaO4HYD4CyfPK7Em/Pg==
X-Received: by 2002:a5d:5f44:0:b0:39c:1f0e:95af with SMTP id ffacd0b85a97d-3a074e1431amr980021f8f.3.1745568767589;
        Fri, 25 Apr 2025 01:12:47 -0700 (PDT)
Received: from localhost ([2401:e180:8d6c:c147:7e8d:44fa:c193:53fc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22db50e7cf2sm26406265ad.154.2025.04.25.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:12:47 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 0/4] Fix xdp_devmap_attach failure in BPF selftests
Date: Fri, 25 Apr 2025 16:12:33 +0800
Message-ID: <20250425081238.60710-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset backport commit to fix BPF selftests failure in stable
6.12 since commit 972bafed67ca ("bpf, test_run: Fix use-after-free issue
in eth_skb_pkt_type()"), which is backport of upstream commit
6b3d638ca897.

The fix needed is upstream commit c7f2188d68c1 ("selftests/bpf: Adjust
data size to have ETH_HLEN"), which in turn depends on upstream commit
d5fbcf46ee82 "selftests/bpf: make xdp_cpumap_attach keep redirect prog
attached". Latter is part of "selftests/bpf: add coverage for
xdp_features in test_progs"[1], and I opt to backport the series entirely
since it adds coverage. With these patches the xdp_devmap_attach no
longer fails[2].

BPF selftests failure log below for completeness. See [3] for the
raw log.

  Error: #566 xdp_devmap_attach
  Error: #566/1 xdp_devmap_attach/DEVMAP with programs in entries
  test_xdp_with_devmap_helpers:PASS:ip netns add devmap_attach_ns 0 nsec
  test_xdp_with_devmap_helpers:PASS:open_netns 0 nsec
  test_xdp_with_devmap_helpers:PASS:ip link set dev lo up 0 nsec
  test_xdp_with_devmap_helpers:PASS:test_xdp_with_devmap_helpers__open_and_load 0 nsec
  test_xdp_with_devmap_helpers:PASS:Generic attach of program with 8-byte devmap 0 nsec
  test_xdp_with_devmap_helpers:PASS:bpf_prog_get_info_by_fd 0 nsec
  test_xdp_with_devmap_helpers:PASS:Add program to devmap entry 0 nsec
  test_xdp_with_devmap_helpers:PASS:Read devmap entry 0 nsec
  test_xdp_with_devmap_helpers:PASS:Match program id to devmap entry prog_id 0 nsec
  test_xdp_with_devmap_helpers:FAIL:XDP test run unexpected error: -22 (errno 22)
  test_xdp_with_devmap_helpers:PASS:XDP program detach 0 nsec
  libbpf: Kernel error message: BPF_XDP_DEVMAP programs can not be attached to a device
  test_xdp_with_devmap_helpers:PASS:Attach of BPF_XDP_DEVMAP program 0 nsec
  test_xdp_with_devmap_helpers:PASS:Add non-BPF_XDP_DEVMAP program to devmap entry 0 nsec
  test_xdp_with_devmap_helpers:PASS:Add BPF_XDP program with frags to devmap entry 0 nsec
  Error: #566/4 xdp_devmap_attach/DEVMAP with programs in entries on veth
  test_xdp_with_devmap_helpers_veth:PASS:ip netns add devmap_attach_ns 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:open_netns 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:ip link add veth_src type veth peer name veth_dst 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:ip link set dev veth_src up 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:ip link set dev veth_dst up 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:val.ifindex 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:ifindex_dst 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:test_xdp_with_devmap_helpers__open_and_load 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:Attach of program with 8-byte devmap 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:bpf_prog_get_info_by_fd 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:Add program to devmap entry 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:Read devmap entry 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:Match program id to devmap entry prog_id 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:Attach of dummy XDP 0 nsec
  test_xdp_with_devmap_helpers_veth:FAIL:XDP test run unexpected error: -22 (errno 22)
  test_xdp_with_devmap_helpers_veth:PASS:XDP program detach 0 nsec
  test_xdp_with_devmap_helpers_veth:PASS:XDP program detach 0 nsec

1: https://lore.kernel.org/all/20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com/
2: https://github.com/shunghsiyu/libbpf/actions/runs/14569651139/job/40864428776
3: https://github.com/shunghsiyu/libbpf/actions/runs/14562221313/job/40846927566

Alexis Lothoré (eBPF Foundation) (3):
  selftests/bpf: fix bpf_map_redirect call for cpu map test
  selftests/bpf: make xdp_cpumap_attach keep redirect prog attached
  selftests/bpf: check program redirect in xdp_cpumap_attach

Shigeru Yoshida (1):
  selftests/bpf: Adjust data size to have ETH_HLEN

 .../bpf/prog_tests/xdp_cpumap_attach.c        | 44 +++++++++++++++----
 .../bpf/prog_tests/xdp_devmap_attach.c        |  8 ++--
 .../bpf/progs/test_xdp_with_cpumap_helpers.c  |  7 ++-
 3 files changed, 46 insertions(+), 13 deletions(-)

-- 
2.49.0


