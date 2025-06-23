Return-Path: <stable+bounces-156185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC45DAE4E83
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE31189F204
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98885202983;
	Mon, 23 Jun 2025 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CU9erjEP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB3219E0;
	Mon, 23 Jun 2025 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712787; cv=none; b=cvdHq2aa+iCh+4oW/90JwQ+kVQbMJWfR/DKmEMuHSqzZ8AvBO8UF9EOuG2nUczta4CFN5cIwWBI7CW7BZyJhSa+mYe7o7LbZtBx0yEVmuEjSuvzb7uTjoBysiH9gMqTMWNQpbonAEkTvvLxxv55LqMyTVsF4PmxXeSw4rpUU3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712787; c=relaxed/simple;
	bh=D9W9C2IQ8Al9J65TvI4xNWK6RvlCo5vNq76ynypn+Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVKZwcrmXJCAC3FNHIiAByBBBDY2rvs1sI9K1O8IdduBljF4UIGRbMi4fLYSZb8GhFB22fT40PQQH6A3tU8YirYsEctud7nk7c1U+kOm0dRSUcLovvkcPg/RI7kNKfxoGoRaDHQ35dtgfLhky80MSd5HK5Fu1aIIHXZ9z/ARaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CU9erjEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A70C4CEEA;
	Mon, 23 Jun 2025 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712787;
	bh=D9W9C2IQ8Al9J65TvI4xNWK6RvlCo5vNq76ynypn+Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CU9erjEPMdzHJcWC1Pts2q08lpNHkoVWjb6XwRtmpksiVRo9IXQg8lFBJrXUAXtY+
	 VNk/R+Qhie9LxGP1LIiPLITzXXbL170NY3NvQDfDWBkfoF4hgtNc2C5OJKaVCwkED3
	 3i7Ey2UuY5IJsM2rRDEwB7yliwOuafB738ZGNn9E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	lmarch2 <2524158037@qq.com>,
	Viktor Malik <vmalik@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 060/508] libbpf: Fix buffer overflow in bpf_object__init_prog
Date: Mon, 23 Jun 2025 15:01:45 +0200
Message-ID: <20250623130646.718269478@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 98d5e566e0582..2fb66ca0f50a5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -818,7 +818,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
-		if (sec_off + prog_sz > sec_sz) {
+		if (sec_off + prog_sz > sec_sz || sec_off + prog_sz < sec_off) {
 			pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
 				sec_name, sec_off);
 			return -LIBBPF_ERRNO__FORMAT;
-- 
2.39.5




