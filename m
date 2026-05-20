Return-Path: <stable+bounces-253400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEyiKOc2DmpN8QUAu9opvQ
	(envelope-from <stable+bounces-253400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:34:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9832A59C1A1
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD619310CA2F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8E3C7DE8;
	Wed, 20 May 2026 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWtV5z2r"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA73B9D96
	for <stable@vger.kernel.org>; Wed, 20 May 2026 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314514; cv=none; b=FZcP7l8cqYOJ64I+7zJQIsCgV/DZSNi16zDFGTzPyRtQRtTkEGZAN56C43R+IDicBXXSac2pEt4FtLSZsXOdtI6PFKClzIVzlydAQsmR7ZeQYPZ80b07Gdsk7XQtvKWp1/B2/reYAAKQVJEcdmp/E2aSRLJw+1tqU1/tuh/uGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314514; c=relaxed/simple;
	bh=XUsZplKzqK8gAQebRInCSlTKmWr/ICMuMJAwgalEV90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4pkIUf3zbjZ0u9wbkkixP1qVbF5Pruw0s1YkLyH6JlZ6HEzpgjIxxiveWI4O0bJxXjaVKrOUDcfqcpEEcj1Frpg0EVexoeC0u2MrDP2zxxCJLVtqAKkdjgVQXsYAYA7jDfn+m4wZlX8GNi0pT/cmQ2qtJ34YrtmXlZxLTEkjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWtV5z2r; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso27983095e9.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 15:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779314508; x=1779919308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJTamhefML82kg15lhvjPFQFbeI1fp3z405qfk0p2nY=;
        b=SWtV5z2rzCs/3iJPuB9tUqJhmAmxZfOy8SlFCccadyaRmg4H2a+vUIU2gEjbpnjHDi
         qDki45gsDO2u5AD3XxY4FDBzW0Yf/pJE8vcMdN5Y/eDe4bYoPb3YjFduXTXvIVRm3vKJ
         JsAKWSfdWfztMK8BbH1yy4335Tmdk7R9ZEhJiTmvLw+sp+bBVpuS3A0LgA75FCdDu3oK
         YliW+oViLhug3j2MyrY02FHqWxQXjjmh0+IFqAmEwgtSro0iF+ob3Tus9EPyngSWoJI3
         85gKO8hwVrMBnASAbhuQN6j+3xw14Pb3LiWlpCi8xX+mSkjGjjgxmDH8QyOgO6O1nVFG
         hjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779314508; x=1779919308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJTamhefML82kg15lhvjPFQFbeI1fp3z405qfk0p2nY=;
        b=J4XgdyGQyMLzEKyCRRZlicwUHIpCHyD8JhpJIIfsNTkz+hdvapdwdVgt/WmDVm/m60
         zKJmr88p6uXxvrJXwkT7qQriP1E+Pi3KiyZtXNDQVBvA4BQhnw27mP6derp13nTp/IeP
         Z7L2ga9VAsANQ77NezTCe7fXsQ685tGDxIT68BKleCb5o9Q45g5Mrtk72epOt5lswqcH
         dy3sx0xdxZSVrhcDyPFyInqHId6aGlf/QTKYLdcgN9LSgv6pEZJQ8oHOva6718Pe8e/+
         PCzTuQR6FjYZbFVCrCWmgy3U3SMr9xKPADY8pr3uMYyE2MPvp/0mLhV8C11ebKXwyDry
         r14g==
X-Gm-Message-State: AOJu0YyHQdefNIsahAx1ZJKdMM7D5hJ80W5r4NJOTmLLBXwkVDELjDmK
	jzzl5wRoon4pyYlYQOiYyMxyN+lY8S1jtXRV+6W2Srack3MZ6fMuyfR9
X-Gm-Gg: Acq92OE2qxj9M1hlOToAXDRT2lbbaJmBYmmmX8cISq95tNSyh7Mm91zs6qWiekl2P0A
	LnBxYTuLEIRrJodMKUHoumVqppXge5oB3s9QALwWip/gyXfiYYu85bp/ZdvOUUU8vr0wWPMyzOD
	hSiEWq2Y/Cjqa8MIxU64eAm6CYo4pSTVRes4BsGxh6t0MFT2MZfV6QelRSvlshSUb7JecmUJ1/d
	y+RJwInl9U+eEU8dGlPSQRJnzRdxbwb13Z60vtzNsuxNNOuVuviDoW640R2lY29W6jQx5YKccYi
	Tjq04VygqObDLcMdoFrV9v/tJw4Yz9uHk3IvMJD1gdD4LP4w6RjYrKpEic/Suljh5Qy3DmV3YaA
	4fId9Xx7RjuKRF6vMR0Ya7LRPHMdKtqeKzAq2UDEKTkZmHPNYYz7N03KI6IIL9FsDcy10yD6WwM
	qNy3N1ddw+InOiw9UomIBTbkXzMqzSx1niusiUmhIE3OcfYsks6GH2iMMF5JjANNQFraKg6juPP
	hWID5dG
X-Received: by 2002:a05:600c:2d85:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-490360b142fmr1009575e9.21.1779314507349;
        Wed, 20 May 2026 15:01:47 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d60247sm20238425e9.14.2026.05.20.15.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:01:46 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8093BBE2EE7; Thu, 21 May 2026 00:01:45 +0200 (CEST)
Date: Thu, 21 May 2026 00:01:45 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 354/666] libbpf: Stringify errno in log messages in
 libbpf.c
Message-ID: <ag4vSWzIUCsRlpKv@eldamar.lan>
References: <20260520162111.222830634@linuxfoundation.org>
 <20260520162118.906982302@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520162118.906982302@linuxfoundation.org>
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253400-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,eldamar.lan:mid]
X-Rspamd-Queue-Id: 9832A59C1A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Wed, May 20, 2026 at 06:19:25PM +0200, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> [ Upstream commit 271abf041cb354ce99df33ce1f99db79faf90477 ]
> 
> Convert numeric error codes into the string representations in log
> messages in libbpf.c.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/bpf/20241111212919.368971-3-mykyta.yatsenko5@gmail.com
> Stable-dep-of: 380044c40b16 ("libbpf: Prevent double close and leak of btf objects")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

This commit caused a build failure while testing 6.12.91-rc1 to
prepare it for Debian:

make -f /home/build/linux-stable-rc/tools/build/Makefile.build dir=./arch/x86 obj=objtool
In file included from libbpf.c:54:
libbpf.c: In function ‘bpf_object__elf_init’:
libbpf.c:1538:76: error: implicit declaration of function ‘errstr’; did you mean ‘strstr’? [-Werror=implicit-function-declaration]
 1538 |                         pr_warn("elf: failed to open %s: %s\n", obj->path, errstr(err));
      |                                                                            ^~~~~~
libbpf_internal.h:167:47: note: in definition of macro ‘__pr’
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                                               ^~~~~~~~~~~
libbpf.c:1538:25: note: in expansion of macro ‘pr_warn’
 1538 |                         pr_warn("elf: failed to open %s: %s\n", obj->path, errstr(err));
      |                         ^~~~~~~
libbpf.c:1538:76: error: nested extern declaration of ‘errstr’ [-Werror=nested-externs]
 1538 |                         pr_warn("elf: failed to open %s: %s\n", obj->path, errstr(err));
      |                                                                            ^~~~~~
libbpf_internal.h:167:47: note: in definition of macro ‘__pr’
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                                               ^~~~~~~~~~~
libbpf.c:1538:25: note: in expansion of macro ‘pr_warn’
 1538 |                         pr_warn("elf: failed to open %s: %s\n", obj->path, errstr(err));
      |                         ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:1538:25: note: in expansion of macro ‘pr_warn’
 1538 |                         pr_warn("elf: failed to open %s: %s\n", obj->path, errstr(err));
      |                         ^~~~~~~
libbpf.c: In function ‘bpf_object__init_internal_map’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:1938:17: note: in expansion of macro ‘pr_warn’
 1938 |                 pr_warn("failed to alloc map '%s' content buffer: %s\n", map->name, errstr(err));
      |                 ^~~~~~~
libbpf.c: In function ‘parse_u64’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:2102:17: note: in expansion of macro ‘pr_warn’
 2102 |                 pr_warn("failed to parse '%s': %s\n", value, errstr(err));
      |                 ^~~~~~~
libbpf.c: In function ‘bpf_object__read_kconfig_file’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:2268:25: note: in expansion of macro ‘pr_warn’
 2268 |                         pr_warn("error parsing system Kconfig line '%s': %s\n",
      |                         ^~~~~~~
libbpf.c: In function ‘bpf_object__read_kconfig_mem’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:2289:17: note: in expansion of macro ‘pr_warn’
 2289 |                 pr_warn("failed to open in-memory Kconfig: %s\n", errstr(err));
      |                 ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:2296:25: note: in expansion of macro ‘pr_warn’
 2296 |                         pr_warn("error parsing in-memory Kconfig line '%s': %s\n",
      |                         ^~~~~~~
libbpf.c: In function ‘bpf_object__init_btf’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:3212:25: note: in expansion of macro ‘pr_warn’
 3212 |                         pr_warn("Error loading ELF section %s: %s.\n", BTF_ELF_SEC, errstr(err));
      |                         ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:3230:25: note: in expansion of macro ‘pr_warn’
 3230 |                         pr_warn("Error loading ELF section %s: %s. Ignored and continue.\n",
      |                         ^~~~~~~
libbpf.c: In function ‘btf_fixup_datasec’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 5 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:172:33: note: in expansion of macro ‘__pr’
  172 | #define pr_debug(fmt, ...)      __pr(LIBBPF_DEBUG, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:3323:25: note: in expansion of macro ‘pr_debug’
 3323 |                         pr_debug("sec '%s': failed to determine size from ELF: size %u, err %s\n",
      |                         ^~~~~~~~
libbpf.c: In function ‘bpf_object__load_vmlinux_btf’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:3478:17: note: in expansion of macro ‘pr_warn’
 3478 |                 pr_warn("Error loading vmlinux BTF: %s\n", errstr(err));
      |                 ^~~~~~~
libbpf.c: In function ‘bpf_object__sanitize_and_load_btf’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:3582:25: note: in expansion of macro ‘pr_warn’
 3582 |                         pr_warn("Error loading .BTF into kernel: %s. BTF is mandatory, can't proceed.\n",
      |                         ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:171:33: note: in expansion of macro ‘__pr’
  171 | #define pr_info(fmt, ...)       __pr(LIBBPF_INFO, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:3585:25: note: in expansion of macro ‘pr_info’
 3585 |                         pr_info("Error loading .BTF into kernel: %s. BTF is optional, ignoring.\n",
      |                         ^~~~~~~
libbpf.c: In function ‘bpf_get_map_info_from_fdinfo’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:4798:17: note: in expansion of macro ‘pr_warn’
 4798 |                 pr_warn("failed to open %s: %s. No procfs support?\n", file,
      |                 ^~~~~~~
libbpf.c: In function ‘bpf_object_prepare_token’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf.c:4954:17: note: in expansion of macro ‘__pr’
 4954 |                 __pr(level, "object '%s': failed (%s) to open BPF FS mount at '%s'%s\n",
      |                 ^~~~
libbpf.c: In function ‘bpf_object__probe_loading’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5004:17: note: in expansion of macro ‘pr_warn’
 5004 |                 pr_warn("Failed to bump RLIMIT_MEMLOCK (err = %s), you might need to do it explicitly!\n",
      |                 ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5013:17: note: in expansion of macro ‘pr_warn’
 5013 |                 pr_warn("Error in %s(): %s. Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.\n",
      |                 ^~~~~~~
libbpf.c: In function ‘map_is_reuse_compat’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5047:17: note: in expansion of macro ‘pr_warn’
 5047 |                 pr_warn("failed to get map info for map FD %d: %s\n", map_fd,
      |                 ^~~~~~~
libbpf.c: In function ‘bpf_object__reuse_map’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5084:17: note: in expansion of macro ‘pr_warn’
 5084 |                 pr_warn("couldn't retrieve pinned map '%s': %s\n",
      |                 ^~~~~~~
libbpf.c: In function ‘bpf_object__populate_internal_map’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5125:17: note: in expansion of macro ‘pr_warn’
 5125 |                 pr_warn("map '%s': failed to set initial contents: %s\n",
      |                 ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5135:25: note: in expansion of macro ‘pr_warn’
 5135 |                         pr_warn("map '%s': failed to freeze as read-only: %s\n",
      |                         ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5162:25: note: in expansion of macro ‘pr_warn’
 5162 |                         pr_warn("map '%s': failed to re-mmap() contents: %s\n",
      |                         ^~~~~~~
libbpf.c: In function ‘bpf_object__create_map’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5220:33: note: in expansion of macro ‘pr_warn’
 5220 |                                 pr_warn("map '%s': failed to create inner map: %s\n",
      |                                 ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5276:17: note: in expansion of macro ‘pr_warn’
 5276 |                 pr_warn("Error in bpf_create_map_xattr(%s): %s. Retrying without BTF.\n",
      |                 ^~~~~~~
libbpf.c: In function ‘init_map_in_map_slots’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 7 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5332:25: note: in expansion of macro ‘pr_warn’
 5332 |                         pr_warn("map '%s': failed to initialize slot [%d] to map '%s' fd=%d: %s\n",
      |                         ^~~~~~~
libbpf.c: In function ‘init_prog_array_slots’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 7 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5365:25: note: in expansion of macro ‘pr_warn’
 5365 |                         pr_warn("map '%s': failed to initialize slot [%d] to prog '%s' fd=%d: %s\n",
      |                         ^~~~~~~
libbpf.c: In function ‘bpf_object__create_maps’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5492:41: note: in expansion of macro ‘pr_warn’
 5492 |                                         pr_warn("map '%s': failed to mmap arena: %s\n",
      |                                         ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 5 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5515:33: note: in expansion of macro ‘pr_warn’
 5515 |                                 pr_warn("map '%s': failed to auto-pin at '%s': %s\n",
      |                                 ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5525:9: note: in expansion of macro ‘pr_warn’
 5525 |         pr_warn("map '%s': failed to create: %s\n", map->name, errstr(err));
      |         ^~~~~~~
libbpf.c: In function ‘load_module_btfs’:
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5649:25: note: in expansion of macro ‘pr_warn’
 5649 |                         pr_warn("failed to iterate BTF objects: %s\n", errstr(err));
      |                         ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
      |                                 ^~~~
libbpf.c:5658:25: note: in expansion of macro ‘pr_warn’
 5658 |                         pr_warn("failed to get BTF object #%d FD: %s\n", id, errstr(err));
      |                         ^~~~~~~
libbpf_internal.h:167:29: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
  167 |         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__);     \
      |                             ^~~~~~~~~~
libbpf_internal.h:170:33: note: in expansion of macro ‘__pr’
  170 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
[...]
libbpf.c:13965:25: note: in expansion of macro ‘pr_warn’
13965 |                         pr_warn("map '%s': failed to auto-attach: %s\n",
      |                         ^~~~~~~
cc1: all warnings being treated as errors
make[8]: *** [/home/build/linux-stable-rc/tools/build/Makefile.build:105: /home/build/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o] Error 1
make[7]: *** [Makefile:165: /home/build/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2
make[6]: *** [Makefile:63: /home/build/linux-stable-rc/tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2
make[5]: *** [Makefile:76: bpf/resolve_btfids] Error 2
make[4]: *** [Makefile:1391: tools/bpf/resolve_btfids] Error 2

Regards,
Salvatore

