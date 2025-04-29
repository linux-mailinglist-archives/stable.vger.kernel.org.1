Return-Path: <stable+bounces-136986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65287AA0017
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 04:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F58481402
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 02:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EACE29CB4A;
	Tue, 29 Apr 2025 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lx8T1+3S"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423A29B76F
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745895160; cv=none; b=CriSCRtf4G7owZ0vk9vLZETUAdRdCaLkMP63ynVFWtSK2eH+/TOZD4kc7Cz4FPEdjufJxFXPCUKJgmiGn8+Yj+dAgTHnQ6YjGG2TOI2cNgWg76Oa6Epx25J841NkUdMM44kET+RfDeR0B4QRkMqi0NPcuGHt3/XNWzQYWAt17bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745895160; c=relaxed/simple;
	bh=6zGrKlI+vbW0EgLtBiqyo7XkmvVAT/TtIQwncT58chg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RDvOXQkDRtkJDLhYuuvI8tsWLXPAnEFF7YP1b92Xh7JNulzdfH6DBYSBiih0D3UKPPkdEHIzyOtB3bwmd6FjBrjvi9TfaBVjyuA0afBKz4Qzamq66VNV2aXF6xUobQ7oUletbQfzvXICDYxXuKAs4vH9x1SVzrnvW5HR/TDi4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lx8T1+3S; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ace3b03c043so846427566b.2
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 19:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745895156; x=1746499956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RToo9FXxqt+8t5BJ+XtqZXyvJwGCNqAp+NYpglN/jCA=;
        b=Lx8T1+3Sx4YNdPBvyjWqDWOkrdL9qH42xq2XpiNMwBdkAKjccfmy9Wp3/qiXyJdnto
         qRfT3epcBfXEMCzGy9Q3UWabi6tKfjfw6HhttX3MjsUSXTo6BmsAqjvU2bPzPXVVR8rh
         6iJg20mnI2sK/7kjCL5tAbExtiZkGkv6h5Kp2MZ6X4YFNadFgfj3rGznxjYcSnxiIUQt
         DL5bpcvLt6CWbC8AP7rNdN5tVruEacpDnZjO2Ic4Hu7p+yBK5sIL6IuAqVIALZ0i/xbK
         U7BSUodgSHTcY7HjMIO0zQUbEf1j46SPBfDUW9t5mFN2CdfLSMIzuwXE9/nvUQYmqmrG
         p2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745895156; x=1746499956;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RToo9FXxqt+8t5BJ+XtqZXyvJwGCNqAp+NYpglN/jCA=;
        b=k9kzlDn2Y090KjLwWw5TzVw+FcE6LtuDN03QFkIQgzLc0jEwwgF9LJRC1A4e+d2YTL
         b8XaEs+hlUN6qkE1pkjLJ7tlClVJxuGQffjIpb1Y0xthReBcoPsxvT3plcPktxrqzVXT
         r2slthAuOZaAM6fOYa3yvQ/ji3le0PnWnFFURMH0jycjyCJNwuOMH057oJUx+xixi1QE
         17GpVN5mGKn0WIoDzvetCU5zao6ERSIKsNQWImltSPKpqKVGBsJviinyrYepLndYxXYE
         3zaq82PxxjBLmUFuvi+R858XMHHLU+CIOaF05aC3+3BJzwE7ieR0luHjH/syrxz0UQJY
         ymig==
X-Gm-Message-State: AOJu0Ywx1K+0ODorYjBmvwRdIWeg1rKVBvlIpr0+wMk+Yt7kntv9gd6D
	adH70vr7RH14W1v6s0Tpx9kA3BL6TcyTHyzMmLOwzjstqZWJn7KO0iQeTNW4Szn1EGjlK1JIWWW
	QKcQ=
X-Gm-Gg: ASbGnctR2u/DmUwBDTYgZOkAZPRJoIzOFm6j+n5aIpqTgSnQImul374KEzuw04OGSME
	P0eXGD5qv0L96CS0DTlmSbrtEg1nFZHtG15aLAu9uw8cOQVFRWqgT9vMeJ7tthRWsgsoZCalwsG
	73LcPLJZ6Q0a0o1FoFT216Xi/bkl4dOXRUlPcSGZWBkpcWMLG9YQBe0E5zEmt7amPv6wdTE9Klf
	HKevkLvlIei769F9WbG2ncjT7zAhy+vluWpKLbIwBK4+FcadPPQFTO/RUIgLmQqO84fLu/Bm78r
	EgNimq+/DYVkOiE5PH6fWBnJf68rViAuaIsUJFyZW07x3Ygqs3E+foxd15VFnfDv9w==
X-Google-Smtp-Source: AGHT+IHsSUcfAeh2/f3Lw756LCNJtkRJ8BtO/vPKHWTVSmzUxKL37V+R7Wh8qp7S8HS1Vb9B098ciw==
X-Received: by 2002:a17:907:94c8:b0:acb:86f0:feda with SMTP id a640c23a62f3a-acec84f5d8cmr78831966b.14.1745895155619;
        Mon, 28 Apr 2025 19:52:35 -0700 (PDT)
Received: from u94a (114-140-113-76.adsl.fetnet.net. [114.140.113.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf8f3dsm695375366b.110.2025.04.28.19.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 19:52:35 -0700 (PDT)
Date: Tue, 29 Apr 2025 10:52:28 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Build failure due to backport of "bpf: Add namespace to BPF internal
 symbols"
Message-ID: <d5qsidvulna547jx6tyrjnocvqlddfpsmy6nqlbjss6dt3xbg5@zeqfjvfng25a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Sasha,

bpf-add-namespace-to-bpf-internal-symbols.patch is stable-queue.git
seems like the culprit responsible for build failure in stable 6.12 and
earlier (log below). The reason is likely due to the lack of commit
cdd30ebb1b9f ("module: Convert symbol namespace to string literal")
before v6.13. Getting rid of the quotes s/"BPF_INTERNAL"/BPF_INTERNAL/
probably would be enough to fix it.

  In file included from .vmlinux.export.c:1:
  .vmlinux.export.c:1697:33: error: expected ‘)’ before ‘BPF_INTERNAL’
   1697 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
        |                                 ^~~~~~~~~~~~
  ./include/linux/export-internal.h:45:28: note: in definition of macro ‘__KSYMTAB’
     45 |             "   .asciz \"" ns "\""                                      "\n"    \
        |                            ^~
  .vmlinux.export.c:1697:1: note: in expansion of macro ‘KSYMTAB_FUNC’
   1697 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
        | ^~~~~~~~~~~~
  ./include/linux/export-internal.h:41:12: note: to match this ‘(’
     41 |         asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
        |            ^
  ./include/linux/export-internal.h:62:41: note: in expansion of macro ‘__KSYMTAB’
     62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name, KSYM_FUNC(name), sec, ns)
        |                                         ^~~~~~~~~
  .vmlinux.export.c:1697:1: note: in expansion of macro ‘KSYMTAB_FUNC’
   1697 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
        | ^~~~~~~~~~~~
  .vmlinux.export.c:1706:42: error: expected ‘)’ before ‘BPF_INTERNAL’
   1706 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
        |                                          ^~~~~~~~~~~~
  ./include/linux/export-internal.h:45:28: note: in definition of macro ‘__KSYMTAB’
     45 |             "   .asciz \"" ns "\""                                      "\n"    \
        |                            ^~
  .vmlinux.export.c:1706:1: note: in expansion of macro ‘KSYMTAB_FUNC’
   1706 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
        | ^~~~~~~~~~~~
  ./include/linux/export-internal.h:41:12: note: to match this ‘(’
     41 |         asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
        |            ^
  ./include/linux/export-internal.h:62:41: note: in expansion of macro ‘__KSYMTAB’
     62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name, KSYM_FUNC(name), sec, ns)
        |                                         ^~~~~~~~~
  .vmlinux.export.c:1706:1: note: in expansion of macro ‘KSYMTAB_FUNC’
   1706 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
        | ^~~~~~~~~~~~
  .vmlinux.export.c:1708:34: error: expected ‘)’ before ‘BPF_INTERNAL’
   1708 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
        |                                  ^~~~~~~~~~~~
  ./include/linux/export-internal.h:45:28: note: in definition of macro ‘__KSYMTAB’
     45 |             "   .asciz \"" ns "\""                                      "\n"    \
        |                            ^~
  .vmlinux.export.c:1708:1: note: in expansion of macro ‘KSYMTAB_FUNC’
   1708 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
        | ^~~~~~~~~~~~
  ./include/linux/export-internal.h:41:12: note: to match this ‘(’
     41 |         asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
        |            ^
  ./include/linux/export-internal.h:62:41: note: in expansion of macro ‘__KSYMTAB’
     62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name, KSYM_FUNC(name), sec, ns)
        |                                         ^~~~~~~~~
  .vmlinux.export.c:1708:1: note: in expansion of macro ‘KSYMTAB_FUNC’
   1708 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
        | ^~~~~~~~~~~~
  make[2]: *** [scripts/Makefile.vmlinux:18: .vmlinux.export.o] Error 1
  make[1]: *** [/home/runner/work/libbpf/libbpf/.kernel/Makefile:1184: vmlinux] Error 2
  make: *** [Makefile:224: __sub-make] Error 2


Shung-Hsi Yu

