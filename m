Return-Path: <stable+bounces-105121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9929F5F01
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 08:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD477164EDE
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78641531F2;
	Wed, 18 Dec 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZxrLO/9a"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0642572
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734505301; cv=none; b=dPJqbp1ALRWiiYD3Nyd5ZPmwk4kFSCd+rCiJPc7hTN4QJxVyFsSn8Mq4cHfAug0cHukZzMn2qSvtDmdbzLZWiNV9o9SHHD5h+kf/RYcvZ+9MqrIb0S+WcNGAeT1G4iqeS9suqj+1Ei9h664WT3upCkuS++oySHGp24KvrLpMhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734505301; c=relaxed/simple;
	bh=YDmzCKjr6O8s65+830em0u7uAm9NTgCzBLy0LbUNc4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fuk2rOg794a2PVFwNrx0nrQufZITllMrTzPLvvajUZrRICgdnEqvWuj3TlMqz+pw6aZmdq/ztSsE5eSV5SSicemfUrrNtzK74hnDAeqWSdK/bVm+0DrU/IZ6l8MCDBkZ9Sk32timsvJpbZWAtyijz9lLBi+OQBiEoE5B4bzRMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZxrLO/9a; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso6524022f8f.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 23:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734505297; x=1735110097; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxlZmL+4Rzxr4WefzwrlIWK9XU6TvkLCwEns7cD8g9A=;
        b=ZxrLO/9alVAjTZPIsStQv0s0oZXo7OcQSRmscKT7cpVw4FUWB9e+O1xkMF9xX9z0+9
         kCUI5vLEZvvfOzuhpT7fxsEHiQPd1IQzdzTsBYsa0vSYxLfqKvI4siQIHUT9az/jJQvJ
         mBvDgYZxyMM8VnZjQW2+nlKg79C4OGHao8Paky5Aj5WlTBceWrnlY+AVx7VYQBWPtles
         mbuLGbMcH9uibjvOa5bl7yIhXGWJpwz9HaNmzitrnNR3X85XJj+8WtHystAlshmTcv5r
         AsDBwTd6wnC0nOVn6aIWpiu4TVD7oxuImATyqtZSaW99MmEdsoJXRsqLRchOH1RzlTbV
         +6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734505297; x=1735110097;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxlZmL+4Rzxr4WefzwrlIWK9XU6TvkLCwEns7cD8g9A=;
        b=If45N5/myse8jGQMZ0khne3yfdlrRivFEHvbYCyV0yeOE6TgI5OQXUVBAfwBEUZ07m
         bnee1stORHEK5WKzdDhjX/CAcKPEoOFMkm6cPkC9IWcPIE4iAzitBmAQKrd3Ax5PVtMG
         bNNS19rjTkdPCbUxOkqzxeUMH+Y0ho4DJJ79QvZPzlDCuHOTnzrgC50lDEjAAFlLyPRT
         03ScBIVYsav2HLFC53l27zrR69oGX3JZnLb3nYKqE/U19nj1BS0dAevdHbfj2G6nQ1fC
         qLcbiwudqMBzPLFVhWCimuRHHxRIichlOccqlqSmTNipevg681XFwb6JpokgmMit00iP
         2bPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXr4XrDb4aTAPzLZLer10PEg0FPgu/zh2oDcIQqcahcWqQLZ9s6VjX79vuyMtbunOOO3HhnyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcecoA1d0nhcz1Uwa6W5wr8WGUWeDDsVNP4/sbAmcc3ZzAenfa
	JgQl45uy9BJgwOHBVb/oaQ7E5r2KZQR3+Miqa1xpsU1ZSidUVjvzzv61oOk2pX8=
X-Gm-Gg: ASbGncsKvuQw3uRpLt0FnN+Wll+Gho9lfDpqeZh/adDqb8bZHsuVNf5MtqB6Pq9munS
	I+GGs5oewfYJu5EAqpZK9NWhPw5T41uv0tQdt+oQTB0tbMxFsDcUk82axT23KFosVADWwkuITV8
	+8TOn3J7WO+vXYQHOqkthLl7GYAEbi+bPTqq7/1d/X4t+gdoadEuG+RFM661Hh7B2Le6+Xm4E3C
	DfyWdo6W1FFen47CyIrjPHlIImiVQwanO+wld9SMUfcPv2/2C/Y
X-Google-Smtp-Source: AGHT+IH7PZMByS4NO4/EFyBOj4SJpzYoYtcsq6U4AGcgPppvriv4goRZc5bINo/Uy4LHQIcmzsmePA==
X-Received: by 2002:a05:6000:2a4:b0:385:f66a:4271 with SMTP id ffacd0b85a97d-388e4d6a338mr1160407f8f.4.1734505297359;
        Tue, 17 Dec 2024 23:01:37 -0800 (PST)
Received: from u94a ([2401:e180:8863:7234:db39:d989:bb90:49df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e72469sm69487075ad.274.2024.12.17.23.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 23:01:14 -0800 (PST)
Date: Wed, 18 Dec 2024 15:00:46 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org, stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Subject: [BUG stable 6.6] kernel crash in BPF selftests dummy_st_ops
Message-ID: <ffsmmoqcc7yru7yc6sykdwfnad5phgddl5wysq4bw3mwdaiixx@znzt4ucmf37g>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(Maybe a good first-timer bug if anyone wants to try contributing during
the holiday seasons)

The stable v6.6 kernel currently runs into kernel panic when running the
test_progs tests from BPF selftests. Judging by the log it is failing in
one of the dummy_st_ops tests (which comes after deny_namespace tests if
you look at the output of `test_progs -l`). My guess is that it is
related to "check bpf_dummy_struct_ops program params for test runs"[1],
perhaps we're missing a commit or two.

Some notes for anyone tackling this for the first time:
1. You'll need to use the stable/linux-6.6.y branch from
   https://github.com/shunghsiyu/bpf. The current v6.6.66 one fails at
   compiling of BPF selftests[2]
2. The easiest way to run BPF selftests is to got relevant
   dependencies[3] installed, and run
   tools/testing/selftests/bpf/vmtest.sh (need to give it `-i` to
   download the root image first, and also might need to specify clang
   and llvm-strip by setting environmental variable CLANG=clang-17 and
   LLVM_STRIP=llvm-strip-17, respectively). For a more solid setup, see
   materials[4][5] from Manu Bretelle
3. Patch(es) should be send to stable@vger.kernel.org, following the
   stable process[6], see [2] as an example

Below is the output from vmtest.sh:

    #68/1    deny_namespace/unpriv_userns_create_no_bpf:OK
    #68/2    deny_namespace/userns_create_bpf:OK
    #68      deny_namespace:OK
    [   26.829153] BUG: kernel NULL pointer dereference, address: 0000000000000000
    [   26.831136] #PF: supervisor read access in kernel mode
    [   26.832635] #PF: error_code(0x0000) - not-present page
    [   26.833999] PGD 0 P4D 0
    [   26.834771] Oops: 0000 [#1] PREEMPT SMP PTI
    [   26.835997] CPU: 2 PID: 119 Comm: test_progs Tainted: G           OE      6.6.66-00003-gd80551078e71 #3
    [   26.838774] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
    [   26.841152] RIP: 0010:bpf_prog_8ee9cbe7c9b5a50f_test_1+0x17/0x24
    [   26.842877] Code: 00 00 00 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 8b 7f 00 <8b> 47 00 be 5a 00 00 00 89 77 00 c9 c3 cc cc cc cc cc cc cc cc c0
    [   26.847953] RSP: 0018:ffff9e6b803b7d88 EFLAGS: 00010202
    [   26.849425] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 2845e103d7dffb60
    [   26.851483] RDX: 0000000000000000 RSI: 0000000084d09025 RDI: 0000000000000000
    [   26.853508] RBP: ffff9e6b803b7d88 R08: 0000000000000001 R09: 0000000000000000
    [   26.855670] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9754c0b5f700
    [   26.857824] R13: ffff9754c09cc800 R14: ffff9754c0b5f680 R15: ffff9754c0b5f760
    [   26.859741] FS:  00007f77dee12740(0000) GS:ffff9754fbc80000(0000) knlGS:0000000000000000
    [   26.862087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   26.863705] CR2: 0000000000000000 CR3: 00000001020e6003 CR4: 0000000000170ee0
    [   26.865689] Call Trace:
    [   26.866407]  <TASK>
    [   26.866982]  ? __die+0x24/0x70
    [   26.867774]  ? page_fault_oops+0x15b/0x450
    [   26.868882]  ? search_bpf_extables+0xb0/0x160
    [   26.870076]  ? fixup_exception+0x26/0x330
    [   26.871214]  ? exc_page_fault+0x64/0x190
    [   26.872293]  ? asm_exc_page_fault+0x26/0x30
    [   26.873352]  ? bpf_prog_8ee9cbe7c9b5a50f_test_1+0x17/0x24
    [   26.874705]  ? __bpf_prog_enter+0x3f/0xc0
    [   26.875718]  ? bpf_struct_ops_test_run+0x1b8/0x2c0
    [   26.876942]  ? __sys_bpf+0xc4e/0x2c30
    [   26.877898]  ? __x64_sys_bpf+0x20/0x30
    [   26.878812]  ? do_syscall_64+0x37/0x90
    [   26.879704]  ? entry_SYSCALL_64_after_hwframe+0x78/0xe2
    [   26.880918]  </TASK>
    [   26.881409] Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)]
    [   26.883095] CR2: 0000000000000000
    [   26.883934] ---[ end trace 0000000000000000 ]---
    [   26.885099] RIP: 0010:bpf_prog_8ee9cbe7c9b5a50f_test_1+0x17/0x24
    [   26.886452] Code: 00 00 00 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 8b 7f 00 <8b> 47 00 be 5a 00 00 00 89 77 00 c9 c3 cc cc cc cc cc cc cc cc c0
    [   26.890379] RSP: 0018:ffff9e6b803b7d88 EFLAGS: 00010202
    [   26.891450] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 2845e103d7dffb60
    [   26.892779] RDX: 0000000000000000 RSI: 0000000084d09025 RDI: 0000000000000000
    [   26.894254] RBP: ffff9e6b803b7d88 R08: 0000000000000001 R09: 0000000000000000
    [   26.895630] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9754c0b5f700
    [   26.897008] R13: ffff9754c09cc800 R14: ffff9754c0b5f680 R15: ffff9754c0b5f760
    [   26.898337] FS:  00007f77dee12740(0000) GS:ffff9754fbc80000(0000) knlGS:0000000000000000
    [   26.899972] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   26.901076] CR2: 0000000000000000 CR3: 00000001020e6003 CR4: 0000000000170ee0
    [   26.902336] Kernel panic - not syncing: Fatal exception
    [   26.903639] Kernel Offset: 0x36000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
    [   26.905693] ---[ end Kernel panic - not syncing: Fatal exception ]---


1: https://lore.kernel.org/all/20240424012821.595216-1-eddyz87@gmail.com/t/#u
2: https://lore.kernel.org/all/20241217080240.46699-1-shung-hsi.yu@suse.com/t/#u
3: https://gist.github.com/shunghsiyu/1bd4189654cce5b3e55c2ab8da7dd33d#file-vmtest-containerfile-L14-L39
4: https://chantra.github.io/bpfcitools/bpf-local-development.html
5: http://oldvger.kernel.org/bpfconf2024_material/BPF-dev-hacks.pdf
6: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

