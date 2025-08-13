Return-Path: <stable+bounces-169303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F10B23DAE
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 03:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F281B6201D
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 01:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152D17D346;
	Wed, 13 Aug 2025 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LmJ5uirH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B34273FD;
	Wed, 13 Aug 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755048563; cv=none; b=H/k8b8JMfS+jl1weSMwWtQ9kWdtE3H8zobYFV/Z2VFhVb6XPp/DR1Z09OHGVKpBUsEjsw0r5QoG4+8dCdA53Y/Nhuy8QN3QUNSKEv8tqZRpNFXQMvFGsIF2C3sy+9gErHgqcZs0tLvzEovYyjK02m/STd8lIgmYrZSXX3yH2wL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755048563; c=relaxed/simple;
	bh=ZCTgfKqNa+LgytjlqH4lOd5R0jewhiOS/nlshZC7PQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjO+Wxqjew0q1SfzviSP45HpeJRae45b35iAI8wMs24cG+5bOv74uOLiUTNPeZjGgvgYAzzH0SuKHFD5wGkTdd53jygvKKsxtfv4foW8xISll/7mDJwZf3fMbVzve+U03sLgfTVTL/Ft3V/Yc1o2UJL/xcJ9XdcoTiZmQEASyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LmJ5uirH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so3853737f8f.3;
        Tue, 12 Aug 2025 18:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755048559; x=1755653359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8rnD+xv18p/AxJUBrvHZm0xOy/Y25N8osSJ9mIdmrek=;
        b=LmJ5uirHD4nl9mkRygJzs6lYzuqqJVG500iJo1JN0FwYEO2uPpXgZ58GfQKoGSOBjx
         hfmqprt8xZSCXNGySX2vsHpeFf8v2g5HSq4+Q9BEaukiM4oV325KSrC2bel5mRHFZgGJ
         z8XLbsXR888PpRSSeDLeIkyLE3Q/4l0TZGA1Ghn8Q4HOiURt1EWE6CKOuXHFM8A2tCks
         ihEge+Zu3rVhJBMD+bwnlt3JU8zto73ih2QVtTsRfzuBDHGZnvVBDOJnvxkPbGxCcrEf
         zUW8Z34wwGSQj2BZlClr7KE3nQd/RF43Lju7VHNxDEH7bXqKlpxeFTqELdbQ7ljCZxB9
         JEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755048559; x=1755653359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rnD+xv18p/AxJUBrvHZm0xOy/Y25N8osSJ9mIdmrek=;
        b=ScXNVVU2QjzsrDTPFWPNpckGP0wsjtHw+PIWWahslnVtPdrnKjC5geduJ/e0BUZSX2
         b9b8uY0SpZiBLs/c3GJs3z87zNribi14fWCzlRCk6ysxoeABQP9+aA9AUJMjcZNvFiqU
         ZHzGsLEa/Yfq6spGBMvYy8lZFhUElE8EJc4IZF7xy9gvuNL1LzTtx/vPUTclPObv/M4e
         EQw5xmAKnIlZH4n2z7jD2FIpTbhr3G1fYQ35BA+KRLHvLX2g2J01h+qqqwQaklp/TZWV
         Iat9r+WMVH5lnFXDDfbIhxhy0gr9C+FrO9OXiovxAKSJjCqR2ixtg95Bn5yHwnu9JNcW
         I6ww==
X-Forwarded-Encrypted: i=1; AJvYcCXh3L0dzngPbkPG/mZNh8gEYU+cn8yCXxia4Lw3wb/zaH+aC3eYmssPOKkqdR+l4yGwSI4+kPCb@vger.kernel.org, AJvYcCXvzlVqka0z19NSRuDdxCnKqq9zb1rds6aPsPehKPF2/3ffaLQkoF4dflMrgw1/3FAuvEX0nn5B/D6kfQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ymMbrFTPClwellP5ZEWTHVlmTJQhYYafPdxIbORVmOy/3k1G
	KoZUMOD/iMOPOAqjU5BoJ+ud52D/V9O7PyYd2ybuNtfliK53S2FdS5o=
X-Gm-Gg: ASbGncv5NY6IYorRzjGUCpZ97lTWURjvtzpfGexEhCIayma9OqH2f3MFZBKBT/EOAf6
	49Z1Bwb/GpvZXr3q4B29ZLGapqB8QlXznLPd7F6lrvOKalxzTCOecJbIs5J0+Uaw//+6ZZf2+N/
	EFvMAQBzv70xNv5F0VYb/r60ckzhvbhhPBWwDcIA4noFZVJhO3/XtjaMwfFXDTd3UlCEJZ06Ec1
	DZDl0DDzQS39T0VZyuUHxsypQ8QlvVJX6RF/+PLlZkbjk2uyujNjtsX4JnXkxgFsWjhz0pQTKhe
	Y32kdkb2QOgRZpTZlSW/TGZXb3QtMGb25guMOlZOtcEJiwKwOMdgJIvKzRJ7o1lvjzboiHH6JzN
	riNy2MaHw4GLhHnkiEaOaLf8aE2I0B465RDGE4derSWjuwvJKRqdOiVfAQsiF4hrDUZoKlZfKO2
	JLcVPxU42u7w==
X-Google-Smtp-Source: AGHT+IF6ANTBUGWn6c/+tjvpGwdQGKJylAO1qgBQXq77hqzcQ4nArUWu0jEtObWqZRhmA+oj9jsv8A==
X-Received: by 2002:a05:6000:250a:b0:3b6:cf8:64b3 with SMTP id ffacd0b85a97d-3b917ead5c6mr549289f8f.34.1755048559206;
        Tue, 12 Aug 2025 18:29:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b0570d7.dip0.t-ipconnect.de. [91.5.112.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac51asm46964655f8f.1.2025.08.12.18.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 18:29:17 -0700 (PDT)
Message-ID: <cd616763-06c7-4f40-a1e0-7fe46002db68@googlemail.com>
Date: Wed, 13 Aug 2025 03:29:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/253] 6.1.148-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250812172948.675299901@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.08.2025 um 19:26 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.148 release.
> There are 253 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

When I was starting the build, I did get a lot of strange warning messages from a Python script which I have never seen 
before in a kernel build. I upgraded this machine some days ago from Proxmox VE 8.4 (based on Debian 12 Bookworm) to 
Proxmox VE 9.0 (bases on Debian 13 Trixie), so I now have Python 3.13.5. Before the upgrade it was Python 3.11. It now 
also has GCC 14.2 instead of GCC 12 before.

The messages I'm seeing are these (with some context), and I'm unfortunately not knowledgeable enough to understand 
their significance:


   UPD     include/generated/uapi/linux/version.h
   HOSTLD  arch/x86/tools/relocs
   UPD     include/generated/utsrelease.h
   UPD     include/generated/compile.h
   HOSTCC  scripts/bin2c
   HOSTCC  scripts/kallsyms
   HOSTCC  scripts/sorttable
   HOSTCC  scripts/asn1_compiler
   HOSTCC  scripts/genksyms/genksyms.o
   YACC    scripts/genksyms/parse.tab.[ch]
   LEX     scripts/genksyms/lex.lex.c
   HOSTCC  scripts/sign-file
   HOSTCC  scripts/selinux/genheaders/genheaders
   HOSTCC  scripts/insert-sys-cert
   HOSTCC  scripts/selinux/mdp/mdp
   DESCEND objtool
   DESCEND bpf/resolve_btfids
   HOSTCC  scripts/genksyms/parse.tab.o
   HOSTCC  scripts/genksyms/lex.lex.o
/usr/src/linux-stable-rc/scripts/bpf_doc.py --header \
         --file /usr/src/linux-stable-rc/tools/include/uapi/linux/bpf.h > 
/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/bpf_helper_defs.h
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 bpf.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 libbpf.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 btf.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 libbpf_common.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 libbpf_legacy.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 bpf_helpers.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 bpf_tracing.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 bpf_endian.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
gcc   -o /usr/src/linux-stable-rc/tools/objtool/fixdep /usr/src/linux-stable-rc/tools/objtool/fixdep-in.o
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 bpf_core_read.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 skel_internal.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 libbpf_version.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 usdt.bpf.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
gcc   -o /usr/src/linux-stable-rc/tools/bpf/resolve_btfids/fixdep 
/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/fixdep-in.o
/usr/src/linux-stable-rc/scripts/bpf_doc.py:62: SyntaxWarning: invalid escape sequence '\w'
   arg_re = re.compile('((\w+ )*?(\w+|...))( (\**)(\w+))?$')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:64: SyntaxWarning: invalid escape sequence '\*'
   proto_re = re.compile('(.+) (\**)(\w+)\(((([^,]+)(, )?){1,5})\)$')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:116: SyntaxWarning: invalid escape sequence '\*'
   p = re.compile(' \* ?(BPF\w+)$')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:120: SyntaxWarning: invalid escape sequence '\*'
   end_re = re.compile(' \* ?NOTES$')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:135: SyntaxWarning: invalid escape sequence '\*'
   p = re.compile(' \* ?((.+) \**\w+\((((const )?(struct )?(\w+|\.\.\.)( \**\w+)?)(, )?){1,5}\))$')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:143: SyntaxWarning: invalid escape sequence '\*'
   p = re.compile(' \* ?(?:\t| {5,8})Description$')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:156: SyntaxWarning: invalid escape sequence '\*'
   p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:169: SyntaxWarning: invalid escape sequence '\*'
   p = re.compile(' \* ?(?:\t| {5,8})Return$')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:182: SyntaxWarning: invalid escape sequence '\*'
   p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:221: SyntaxWarning: invalid escape sequence '\s'
   bpf_p = re.compile('\s*(BPF\w+)+')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:226: SyntaxWarning: invalid escape sequence '\s'
   assign_p = re.compile('\s*(BPF\w+)\s*=\s*(BPF\w+)')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:241: SyntaxWarning: invalid escape sequence '\w'
   self.enum_syscalls = re.findall('(BPF\w+)+', bpf_cmd_str)
/usr/src/linux-stable-rc/scripts/bpf_doc.py:264: SyntaxWarning: invalid escape sequence '\s'
   p = re.compile('\s*FN\((\w+)\)|\\\\')
/usr/src/linux-stable-rc/scripts/bpf_doc.py:277: SyntaxWarning: invalid escape sequence '\('
   self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
/usr/src/linux-stable-rc/scripts/bpf_doc.py:410: SyntaxWarning: invalid escape sequence '\*'
   '/{}/,/\*\//:include/uapi/linux/bpf.h'.format(delimiter)]
/usr/src/linux-stable-rc/scripts/bpf_doc.py:501: SyntaxWarning: invalid escape sequence '\ '
   license string passed (via **attr**) to the **bpf**\ () system call, and this
/usr/src/linux-stable-rc/scripts/bpf_doc.py:583: SyntaxWarning: invalid escape sequence '\ '
   one_arg += ' {}**\ '.format(a['star'].replace('*', '\\*'))
\
                 if [ ! -d '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/' ]; then 
install -d -m 755 '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/'; fi; install exec-cmd.h 
-m 644 '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/'
\
                 if [ ! -d '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/' ]; then 
install -d -m 755 '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/'; fi; install help.h -m 
644 '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/'
\
                 if [ ! -d '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/' ]; then 
install -d -m 755 '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/'; fi; install pager.h -m 
644 '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/'
\
                 if [ ! -d '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/' ]; then 
install -d -m 755 '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/'; fi; install 
parse-options.h -m 644 '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/'
\
                 if [ ! -d '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/' ]; then 
install -d -m 755 '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/'; fi; install 
run-command.h -m 644 '/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd//include/subcmd/'
\
                 if [ ! -d ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf' ]; then install -d 
-m 755 ''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'; fi; install -m 644 
/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/bpf_helper_defs.h 
''/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libbpf/'/include/bpf'
   HOSTLD  scripts/genksyms/genksyms
   CC      scripts/mod/empty.o
   HOSTCC  scripts/mod/mk_elfconfig
   CC      scripts/mod/devicetable-offsets.s
   MKELF   scripts/mod/elfconfig.h
   HOSTCC  scripts/mod/modpost.o
   UPD     scripts/mod/devicetable-offsets.h
   HOSTCC  scripts/mod/sumversion.o
   HOSTCC  scripts/mod/file2alias.o
rm -f /usr/src/linux-stable-rc/tools/objtool/libsubcmd.a && ar rcs /usr/src/linux-stable-rc/tools/objtool/libsubcmd.a 
/usr/src/linux-stable-rc/tools/objtool/libsubcmd-in.o
rm -f /usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd/libsubcmd.a && ar rcs 
/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd/libsubcmd.a 
/usr/src/linux-stable-rc/tools/bpf/resolve_btfids/libsubcmd/libsubcmd-in.o
   HOSTLD  scripts/mod/modpost
   CC      kernel/bounds.s
   CHKSHA1 include/linux/atomic/atomic-arch-fallback.h
   CHKSHA1 include/linux/atomic/atomic-instrumented.h
   UPD     include/generated/timeconst.h
   CHKSHA1 include/linux/atomic/atomic-long.h
   UPD     include/generated/bounds.h



I will start over with trying to build the other 6.y stable RCs and see whether this is specific to 6.1.148-rc1 or 
whether it occurs there, too.


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

