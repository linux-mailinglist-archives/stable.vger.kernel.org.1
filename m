Return-Path: <stable+bounces-211368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JSKLu5Nc2lDugAAu9opvQ
	(envelope-from <stable+bounces-211368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 11:31:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32434745C9
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 11:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AB54306556D
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 10:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80A9377574;
	Fri, 23 Jan 2026 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBTT10Da"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0AB352FB1
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164067; cv=none; b=V8U7z/QyaFXV5/t+FIR/qlLQK7uFt13cU3DTKqVd+njoOnrylpOPP6Qak2cLV42rF7WcqgibP/DKrbfSJld6Pb3FptZLO2w+G6gejqpjYd61Ys4aK0rRcFeI8QoBO1vmv7G/EAN3/X/LEIU5YPsllKCrfhklsJHISOnKDYKqNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164067; c=relaxed/simple;
	bh=7IaTajV/+dkBgAhYABMFyBGpmbeadMJYvwi9yXjkLRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMkSlJig9XZGUuZe4XqH4a8Si8shbJIyNjEggL/Rwm38g6GFbGcQhcsTmqqID0/g0c6FxVCoYopT0/LWbNXjsA97QPacDJpOFtuK1K/ExJVtgo9RwFiQgXL5HzU8aBwk3x29shAaSEwPmpcDPpamCyB4ncs54+0oQLrEwZUaSHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nBTT10Da; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47edffe5540so23676355e9.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 02:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769164064; x=1769768864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bt7TAVcRMZnTWPF3p56NDBk0ozlKnXVnrXA2jTNoF28=;
        b=nBTT10Dak+boVmv/rjO4zWrrA0MaCI/NC6G88i/GG6ePAXEb1JRCTmNtfhbvCJvbT+
         N59fSMNnBKwPGQMZduvpjcu7Wd07xM27lb5MCeYoGHsbhjEzEUfavKDqu8gC9vs74boe
         hQuhpzsL7GwNx+tXhjtKitX10M99Kc2xZ+1UYPlqR0HAP1/UJLHQMFRgXmS4OMwoSi2H
         rfznppIsS5Zardbyth3UkeILSzlfr+bA6Qw132nYEynA70Z+yeKmNQFfVamiSTeP02uz
         Il85d4hwDkXrk0BPfe5FUKhokrT9jMtncI7uEP4I5r6my+TZ7Q0QNlT5+J6JYjlSeTtF
         +mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769164064; x=1769768864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bt7TAVcRMZnTWPF3p56NDBk0ozlKnXVnrXA2jTNoF28=;
        b=cFHeVWJGc2reyrovF29xjudwurqzTPIOkqkS1MpSDa1fVde6fGliC9fNShmx/GC7PW
         g7xByDCtAuG4pJ7YuA9zf/fAEtpCodK3lqK4oSXBsk7qwoCetBqcRONP9ibS3f8tMntK
         krleAxx8T+1jYSCABC0a/yPoOc3pz/9cW0tWiMLvk2E0GQ33SDM/HwRu5hH/RJwjDZf5
         fjNU0akiVnU/hxNFRq3froR5NZRnATEe8ubM9fO1+xd770NtQTRBqsLlf3LUG29Bg1WN
         AS773jEXEbmVFdd3Dh8kWjcchJeih6eTExUvw08o+dxAwGHO0uhVDPx1FCyTYVC10BTZ
         TeIA==
X-Forwarded-Encrypted: i=1; AJvYcCUCN1mJij9pasqRofOPe5yo1lI7BwMHYEKySExI5oDxDpsJnyA4hKn3bC6dzdddEFccjLzsJCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUkwypybCYZRuQpMnSSLxK+RUFNBISUYDv1pNf+HNILAqBRa7
	Um+PX751fia+ByMFr3q4bHDo12t1w8mEa0rkqyuQEQZDrBVXkl1/WUbG/m/z5jWNyCE=
X-Gm-Gg: AZuq6aIYKNVwOaARjcDkwiuYCx/QJTe7HqGzGIrQgtP2LScmSsYex9nlxMW/wXFKVO6
	V2v3yEH8tNQKEau/RjYHpH+GU8Zm1D6SuMIzLY93adnA7/0L5uBDCaO3ycFZlaI0HNGkGWHEn2/
	dlQUCI4MNL3d98DCKkoUImlPNcuqnyPpjnkVWYfWdy2voANJli2xu2kzmbsoqVAXNaroDQTiwh8
	4o6lFjREhrDj1UpdxuQwZtWXuRuJnmesR0FRHRB8sz2no8hTC0Md3isBjs58wWUDn+C9Jxr2xdg
	wExCwgJOEHraT0+yFyGoV4hSwo7yQKJDrcqDeq2mIpwtOrFiTKWnACQdqLQALTedmm7676IQaTV
	e7IpUHpLw5hTa3A4s9Hp4sZNcWyW71EBSeNfKEwbOanEPhmLrZ8sk7rgD0mdu6WWGuCmk3hfDhH
	AELFun9cwuFjnD3//7
X-Received: by 2002:a05:600c:8b0e:b0:480:3230:6c9b with SMTP id 5b1f17b1804b1-4804c946d2fmr45973205e9.7.1769164064086;
        Fri, 23 Jan 2026 02:27:44 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d8a5b2dsm47439825e9.9.2026.01.23.02.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 02:27:43 -0800 (PST)
Message-ID: <705c0889-ffb6-4758-941c-ccfdb367d9c8@linaro.org>
Date: Fri, 23 Jan 2026 10:27:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf arm_spe: Fix bitfield dependency failure
To: Leo Yan <leo.yan@arm.com>
Cc: Thomas Voegtle <tv@lio96.de>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org
References: <20260123100218.233246-1-leo.yan@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260123100218.233246-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211368-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[james.clark@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lio96.de:email,linaro.org:mid,linaro.org:dkim,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32434745C9
X-Rspamd-Action: no action



On 23/01/2026 10:02 am, Leo Yan wrote:
> A perf build failure was reported by Thomas Voegtle on stable kernel
> v6.6.120:
> 
>    make perf NO_JEVENTS=1 NO_LIBTRACEEVENT=1
>      BUILD:   Doing 'make -j12' parallel build
>      HOSTCC  fixdep.o
>      HOSTLD  fixdep-in.o
>    ...
>    ...
>      CC      tests/sample-parsing.o
>      CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
>      CC      util/perf-regs-arch/perf_regs_csky.o
>      CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
>      CC      util/perf-regs-arch/perf_regs_loongarch.o
>    In file included from util/arm-spe-decoder/arm-spe-pkt-decoder.h:10,
>                     from util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:
>    /local/git/linux-stable-rc/tools/include/linux/bitfield.h: In function ‘le16_encode_bits’:
>    /local/git/linux-stable-rc/tools/include/linux/bitfield.h:166:31: error: implicit declaration of
>    function ‘cpu_to_le16’; did you mean ‘htole16’? [-Werror=implicit-function-declaration]
>      ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
>                                   ^~~~~~~~~
>    /local/git/linux-stable-rc/tools/include/linux/bitfield.h:149:9: note: in definition of macro
>    ‘____MAKE_OP’
>      return to((v & field_mask(field)) * field_multiplier(field)); \
>             ^~
>    /local/git/linux-stable-rc/tools/include/linux/bitfield.h:170:1: note: in expansion of macro
>    ‘__MAKE_OP’
>     __MAKE_OP(16)
> 
> Fix this by including linux/kernel.h, which provides the required
> definitions.
> 
> The relevant C file in mainline already includes kernel.h, so the issue is
> not exposed.  It'd be good to merge this change on mainline as well for
> robustness.
> 
> Fixes: 64d86c03e144 ("perf arm-spe: Extend branch operations")
> Reported-by: Thomas Voegtle <tv@lio96.de>
> Closes: https://lore.kernel.org/stable/3a44500b-d7c8-179f-61f6-e51cb50d3512@lio96.de/
> Cc: stable@vger.kernel.org
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index adf4cde320aa..8d16619cd098 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -7,6 +7,7 @@
>   #ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
>   #define INCLUDE__ARM_SPE_PKT_DECODER_H__
>   
> +#include <linux/kernel.h>
>   #include <linux/bitfield.h>

This isn't the first time I've seen this issue. Isn't the real fix to 
include kernel.h in bitfield.h if it depends on it? Usually you 
shouldn't have to know what all the dependencies of a header are when 
you include it. Or is there a reason it wasn't done that way in the 
first place? Maybe this has been discussed before?

>   #include <stddef.h>
>   #include <stdint.h>


