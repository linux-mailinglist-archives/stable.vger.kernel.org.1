Return-Path: <stable+bounces-227229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HVoODiyu2k8mgIAu9opvQ
	(envelope-from <stable+bounces-227229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:22:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6684E2C7CC4
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DD063028F53
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3A3A784B;
	Thu, 19 Mar 2026 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDVUx6F4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8318368972
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908530; cv=pass; b=unUqm1wOQTsERb19jQLdKPlvy/ShwhyrWeyvoOePZJ7V8S2GB2VbgOxv67hWtlHkTQxQslxmIFYtgOxFhHb4LVu08as0pRGPiww7zReMsmG4oqjQ0rmS6t+7QocKLyVcZekdKdgLFqTqqkjY0pzcxueJTXBbdpDc01cJrYmL6PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908530; c=relaxed/simple;
	bh=01DMyjb/HZSvI6O8znLL6RPAI6YtqeAqhwj7l50SI/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiIuuVbbLzyjFggzpoda+a8VJGJGqWwlHPX/A8oadet7E006bDNp3tSxSOU9zx4cS+WFrOYB1L0JIfRXAy4943Tg79Z4ft/6fqFCj6pkBpm461Kmn8CtrduNBgTBYnLp1IA1LtcYn9eUDbKeqdg3ZyB+2jKtMN5b3+N7R9fKkB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDVUx6F4; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aeab6ff148so48535ad.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 01:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773908529; cv=none;
        d=google.com; s=arc-20240605;
        b=LTl9ilWEee6rf27UylJOVDdGYgrxVUZrBWbYcNcqw2RnLEhLJV7OjzU2W6P47x2yz7
         LYP8DiXM+3tam3INHkXS2NjzIJG0T+bCgQyuWaCHgTXqydeyn1dkCp7mujit/bcpMb7N
         auFwN0OZBFZBoDjxrcGh8PxMi8SVLyzgKJMsSbBy4a+CxfwU3bhsBKcCiAtmcxsDEPTL
         ME5GlReO+9WT1v6Dq2r2PVdYH60JzaJbcip0++o28SwysnIgB1JGHfiKIMy2Tqz0O3hX
         66ansJzZ32zJK83Xq8BnRV5koqf327VBD6tVv7cEJyk5HlLXA3VX5ciD+kFBH1QfaT+n
         NP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IHfTqB5YPEraYU2kXL8nscbmS2lKLIijP1hKdy0xaBM=;
        fh=nCvO59nBme5OCTvb5FJQLR1INBiTPDGN/mfzOW6PHfY=;
        b=Ta4Mo7+mwJrfkn9IMeMbsacb2ERRvoSjhAu51dURCFjvkJmXvfPG8EZmKP6CzX2Ysp
         MV883fpfWkK4i1z36VcRHAjtE+E9fUsOs3LpFh9qX1e2QefGgpVBO0gAnkBUN2e8mKiv
         Qu7N51DkphE4ostjcJH4aA/HvMXNQFDrAbw0vc9a75/+TSF4JCDBE5S6xqNcBNUomei/
         ofUZX1eiM519cUF4DrVy2LFPy6JjGa4dZ0FpCK/bQImYZYaYO44H4cYNXa2uIBMO30Me
         rb+Ot6ODxE8nxxCkH7A0ucbgPh+gpzW/JEYPbPP9lEbfiSfN2zOxQ9XGZdKAvEg3Pf09
         t3Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773908529; x=1774513329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHfTqB5YPEraYU2kXL8nscbmS2lKLIijP1hKdy0xaBM=;
        b=LDVUx6F4cv1JCa5g41Yai2tWjycFahZm0tz7+oiLGIFhJZbbsOOsm9v9sDkJmKdKFU
         HBEKF45AFN7rxcn4EcbUslLb141GuYBbQDOVbTnR0HgQmzum343aKhAY4aP8k5G0KS9M
         EB/UCHTapElmL86+/XDIJJ/ZINFF/kWpsTK1q/w8AkgAR1k5an6I1V4GXB2OEuBuLb1u
         fD+W5lk5ZyVgE8nOTPd0H4pAflTGv5xtgQEjsvjBmcF8ipBzec8s/aynqG4T091og1+J
         KcXUl9prYV82PiUoadi+MlNzB9na+XktFsjD4RdmKP6YB2WyPIvov4RZZw4bCEi7Imah
         HjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773908529; x=1774513329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IHfTqB5YPEraYU2kXL8nscbmS2lKLIijP1hKdy0xaBM=;
        b=Gyy/MEtOUo8lyni+Fkj2Ar8gGAxlVHXPdb74riQHa4tKmZCKCvunUupvu7nvseoQXP
         WPoxNV53ATwf6t1qts/cj1kNUS5158p33YP4h3uYOJ975/FRC0l5vNCVfxVc/gB9JTsT
         dUPZLbcbRnLsK2Y5y5ApsqvFbZh9YB4s0s32GVqlo8oD0s04p39m5GX2Kkf5sWK5Zx9w
         UStLoR9SyBW67GtPevRkodnIdMxfbS99yNI/sbbN52PQZ803REtFQxv1R+UhOq3XCQRI
         0aJLQczcABsQDFkPY3U1CDir6UW1nRcamzSRq2O5EykO5UedA8u0zd6xwvRdkZWjVoTs
         /zMA==
X-Forwarded-Encrypted: i=1; AJvYcCWlIrwXpacvQyHb8cAT+RU4ymFcBLKzMdDaH+vaqK7KqEg3EjMMSiML+iiBzzA+s45vOjX9XR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/s/sx2oU+2t8DS+46E0dfuvbAmq3N9WOOkVw/3w8KSeaF5dR
	g5qnO/Hk0mMGjk4CnP4Fl3J6H3aFarpYMuIScbluVgnLbR9YAdA2AMKW8zSRlW3YSusy3Lh7eKc
	EYTk+qZ4iYCo2oCvKiEHi2dIjO5zLVrQO3gd/1O/k
X-Gm-Gg: ATEYQzwCm1qVXYNrjX5P49rzQcE4PJm89mkX32iBF2Zk0gj0FIK2c2tLL0lGj6/fI74
	tm/SE2eMuGdpNhsOuNraTFIcIQnDUAtNb2a7QMPqpIX9AucM5MyPV5j6Yd5avrvm+pORFuLYTe6
	K2m8QqZv47PmzOSGUyyV+EQdW4syRAHo9m7pnCP2Z+UpB6R61ch+5hxk86Jd5hwKAGXhW/pb2fm
	jYbzFIQhomCgHPA9vxh5xqxi9e8jpK3OBxT1takR0A9mysCqHDk762XpFMUo2ZbBXDvFYVZMmI7
	49r8KcsQ
X-Received: by 2002:a17:902:ccc4:b0:2a7:d266:d84a with SMTP id
 d9443c01a7336-2b079fbb39emr1497765ad.17.1773908528384; Thu, 19 Mar 2026
 01:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <813bc5fd-0c35-46af-aea2-90798154daaa@windriver.com>
In-Reply-To: <813bc5fd-0c35-46af-aea2-90798154daaa@windriver.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 19 Mar 2026 01:21:57 -0700
X-Gm-Features: AaiRm52YAXaNrkUnKO5zFLhl-iDdZJWeEPshCImbwceVdhaH6rxOGvGt1lbz9ew
Message-ID: <CAP-5=fW_O_sm9JzfCf=qDXyaffoLLRH3mob1zckESUHsG2rp-g@mail.gmail.com>
Subject: Re: [REGRESSION] perf build failed after 5cf6e76e4f4f ("libperf:
 Don't remove -g when EXTRA_CFLAGS are used") on riscv64 with gcc 13
To: Haixiao Yan <haixiao.yan.cn@windriver.com>, Chingbin Li <liqb365@163.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[windriver.com,163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227229-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gnu.org:url,yoctoproject.org:url]
X-Rspamd-Queue-Id: 6684E2C7CC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 6:57=E2=80=AFPM Haixiao Yan
<haixiao.yan.cn@windriver.com> wrote:
>
> Hi,
>
> Commit[5cf6e76e4f4f](https://git.kernel.org/pub/scm/linux/kernel/git/stab=
le/linux.git/commit/tools/lib/perf/Makefile?h=3Dlinux-6.6.y&id=3D5cf6e76e4f=
4fee54c0056758b639cf4919cffba9)
> changed the libperf Makefile to preserve external CFLAGS instead of overr=
iding them. As a result, the -O6 optimization flags from perf's
> build system are now inherited by libperf during compilation. This trigge=
rs a false positive -Walloc-size-larger-than=3D warning in GCC 13 on
> riscv64, causing the build to fail with -Werror.
>
> | cpumap.c: In function 'perf_cpu_map__merge':
> | cpumap.c:422:20: error: argument 1 range [18446744065119617024, 1844674=
4073709551612] exceeds maximum objec
> t size 9223372036854775807 [-Werror=3Dalloc-size-larger-than=3D]
> |   422 |         tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
> |       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | In file included from cpumap.c:3:
> | /buildarea5/hyan-cn/project_yocto/poky/build-riscv64/tmp/work/qemuriscv=
64-poky-linux/perf/1.0/recipe-sysroo
> t/usr/include/stdlib.h:672:14: note: in a call to allocation function 'ma=
lloc' declared here
> |   672 | extern void *malloc (size_t __size) __THROW __attribute_malloc_=
_
> |       |              ^~~~~~
> | rm -f /buildarea5/hyan-cn/project_yocto/poky/build-riscv64/tmp/work/qem=
uriscv64-poky-linux/perf/1.0/perf-1.
> 0/libapi/libapi.a && riscv64-poky-linux-gcc-ar rcs /buildarea5/hyan-cn/pr=
oject_yocto/poky/build-riscv64/tmp/w
> ork/qemuriscv64-poky-linux/perf/1.0/perf-1.0/libapi/libapi.a /buildarea5/=
hyan-cn/project_yocto/poky/build-ris
> cv64/tmp/work/qemuriscv64-poky-linux/perf/1.0/perf-1.0/libapi/libapi-in.o
> | cc1: all warnings being treated as errors

Hi Haixiao,

this was raised before by Chingbin in:
https://lore.kernel.org/lkml/20260212025127.841090-1-liqb365@163.com/
I was concerned about the introduction of volatile to avoid this
warning. I've mailed out what is hopefully a fix without volatile in
it:
https://lore.kernel.org/lkml/20260319081843.1650640-1-irogers@google.com/
If you could take a look.

Thanks,
Ian

> Steps to reproduce:
>
> git clone -b scarthgap https://git.yoctoproject.org/poky
> cd poky
> sed -i 's/af240d7d57ebf66e87bc2dff34855e630a97ead1/5cf6e76e4f4fee54c00567=
58b639cf4919cffba9/' meta/recipes-kernel/linux/linux-yocto_6.6.bb
>
> source oe-init-build-env build-riscv64
>
> cat >> conf/local.conf << 'EOF'
> MACHINE =3D "qemuriscv64"
> 'KERNEL_VERSION_SANITY_SKIP =3D "1"'
> EOF
>
> bitbake perf
>
> I have confirmed that:
> Known to fail: gcc 13.3.0, 13.4.0
> Known to work: gcc 11.5.0, 12.5.0, 14.3.0, 15.2.0
>
> Not sure whether this is a gcc bug.
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D124549 filed to gcc.
>
> Thanks,
> Haixiao
>
>

