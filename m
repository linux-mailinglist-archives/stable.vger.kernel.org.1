Return-Path: <stable+bounces-153270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1DFADD3AF
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F7189E58B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3438D2ECE99;
	Tue, 17 Jun 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I0oHP2ki"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C452F2C55;
	Tue, 17 Jun 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175420; cv=none; b=TL/zcdLC+5pePOMyxlPV3gvDFC2lGjZrBYqIyxrceAXlDNRSyk/wXLA530IZv4hsyTJlTCmKXZKOvbt5jWMKAmu+WltmrFZIuhXpmva0PyS+y69ldePXfkJWieDy/vHe4lKoeqPLvewI/b9F9ZJbbY0UCk8odn4xPqE/KluV8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175420; c=relaxed/simple;
	bh=M202Es4hzm4xT4dK+acrZRgcACAjGgD9Er5HkE8AVcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7dxFqaz/Szj87MKRzvdHEvF0BIu3ALb4i1RnVHngwm0n0C421Z9+TvWUxw7Jl5jhiDkx7Pt5iUdOO65zgTNhGQiyQEeUDKATBjvtT5CudpFoGphkzkg3T6qM6t36c9MekCjrA5mPIINpErW3wc4vX8NGlcYq2d4EFmnOZhjud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I0oHP2ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FF4C4CEF1;
	Tue, 17 Jun 2025 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175419;
	bh=M202Es4hzm4xT4dK+acrZRgcACAjGgD9Er5HkE8AVcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0oHP2ki1qCeDfFXhbz5IxM0CCJAQkNFDWW6z9KYSLcHL2bn3aWwk7acgVGsLpipx
	 yRWdmXerXNe79YFnNIH+tr0fvfW3Zge673z+3bu0WrHt7tu10+I+6Vqg3JUfEbNXT3
	 W14pJeqebkCg0BNTZcGR+ucUXb+tLvqUi1Rm8lY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	lmarch2 <2524158037@qq.com>,
	Viktor Malik <vmalik@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 124/512] libbpf: Fix buffer overflow in bpf_object__init_prog
Date: Tue, 17 Jun 2025 17:21:30 +0200
Message-ID: <20250617152424.618110074@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viktor Malik <vmalik@redhat.com>

[ Upstream commit ee684de5c1b0ac01821320826baec7da93f3615b ]

As shown in [1], it is possible to corrupt a BPF ELF file such that
arbitrary BPF instructions are loaded by libbpf. This can be done by
setting a symbol (BPF program) section offset to a large (unsigned)
number such that <section start + symbol offset> overflows and points
before the section data in the memory.

Consider the situation below where:
- prog_start = sec_start + symbol_offset    <-- size_t overflow here
- prog_end   = prog_start + prog_size

    prog_start        sec_start        prog_end        sec_end
        |                |                 |              |
        v                v                 v              v
    .....................|################################|............

The report in [1] also provides a corrupted BPF ELF which can be used as
a reproducer:

    $ readelf -S crash
    Section Headers:
      [Nr] Name              Type             Address           Offset
           Size              EntSize          Flags  Link  Info  Align
    ...
      [ 2] uretprobe.mu[...] PROGBITS         0000000000000000  00000040
           0000000000000068  0000000000000000  AX       0     0     8

    $ readelf -s crash
    Symbol table '.symtab' contains 8 entries:
       Num:    Value          Size Type    Bind   Vis      Ndx Name
    ...
         6: ffffffffffffffb8   104 FUNC    GLOBAL DEFAULT    2 handle_tp

Here, the handle_tp prog has section offset ffffffffffffffb8, i.e. will
point before the actual memory where section 2 is allocated.

This is also reported by AddressSanitizer:

    =================================================================
    ==1232==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c7302fe0000 at pc 0x7fc3046e4b77 bp 0x7ffe64677cd0 sp 0x7ffe64677490
    READ of size 104 at 0x7c7302fe0000 thread T0
        #0 0x7fc3046e4b76 in memcpy (/lib64/libasan.so.8+0xe4b76)
        #1 0x00000040df3e in bpf_object__init_prog /src/libbpf/src/libbpf.c:856
        #2 0x00000040df3e in bpf_object__add_programs /src/libbpf/src/libbpf.c:928
        #3 0x00000040df3e in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3930
        #4 0x00000040df3e in bpf_object_open /src/libbpf/src/libbpf.c:8067
        #5 0x00000040f176 in bpf_object__open_file /src/libbpf/src/libbpf.c:8090
        #6 0x000000400c16 in main /poc/poc.c:8
        #7 0x7fc3043d25b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4)
        #8 0x7fc3043d2667 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x3667)
        #9 0x000000400b34 in _start (/poc/poc+0x400b34)

    0x7c7302fe0000 is located 64 bytes before 104-byte region [0x7c7302fe0040,0x7c7302fe00a8)
    allocated by thread T0 here:
        #0 0x7fc3046e716b in malloc (/lib64/libasan.so.8+0xe716b)
        #1 0x7fc3045ee600 in __libelf_set_rawdata_wrlock (/lib64/libelf.so.1+0xb600)
        #2 0x7fc3045ef018 in __elf_getdata_rdlock (/lib64/libelf.so.1+0xc018)
        #3 0x00000040642f in elf_sec_data /src/libbpf/src/libbpf.c:3740

The problem here is that currently, libbpf only checks that the program
end is within the section bounds. There used to be a check
`while (sec_off < sec_sz)` in bpf_object__add_programs, however, it was
removed by commit 6245947c1b3c ("libbpf: Allow gaps in BPF program
sections to support overriden weak functions").

Add a check for detecting the overflow of `sec_off + prog_sz` to
bpf_object__init_prog to fix this issue.

[1] https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md

Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
Reported-by: lmarch2 <2524158037@qq.com>
Signed-off-by: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
Link: https://lore.kernel.org/bpf/20250415155014.397603-1-vmalik@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6e4d417604fa0..069ffe5da96e5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -887,7 +887,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
-		if (sec_off + prog_sz > sec_sz) {
+		if (sec_off + prog_sz > sec_sz || sec_off + prog_sz < sec_off) {
 			pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
 				sec_name, sec_off);
 			return -LIBBPF_ERRNO__FORMAT;
-- 
2.39.5




