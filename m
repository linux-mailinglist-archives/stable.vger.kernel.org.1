Return-Path: <stable+bounces-238647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFFoLGzu5GmVcAEAu9opvQ
	(envelope-from <stable+bounces-238647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 17:02:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A12CB4246CB
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4003F300407B
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF8037BE8F;
	Sun, 19 Apr 2026 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jP5d7BXv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E526F29C
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776610918; cv=pass; b=twIhwrtDimGn9Tzn6KG9iXbI18Ogfm0/lFIHgH9uzUA05bFe6N8ldxxWkrR9lnD4w4MwvnvXVWeXcjhioBBeqncrzmEJalpkm+Q5JwZqAahaSWwJ5bcaRj/JQyvKThzZw6Ca3C3dsWskTAkVL4wNWN50TrAa4zCmujoLv0zHrVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776610918; c=relaxed/simple;
	bh=oajmnfUT0ewEISMxls8cp07i4k5MNYH63Qg3BrPwfTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cz62tfCsecj1vK4wPmBDq7bK6xjKYwFz1LzRN9vw1P8Dzxecu3Rnhlrr2NHVS+QQBP9/wWh898QE9MtYFlypvL/ajyQxElh3HfjaZebZyahYJGCkx+qYUAH5T4zHt7IHx8PqixUipkHqvwL3KJmXKDSlrxu3Nj+i0mCQQO1qMnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jP5d7BXv; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9697so6586c88.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 08:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776610916; cv=none;
        d=google.com; s=arc-20240605;
        b=Fu4K96cePnrTFb6Wa7lL8NOOpJ7bdOGeeap+RAJbJOK30PKT73rqv2NGAgJoqtcPW6
         vOvYkfcSgYoq3kPxdacShBOeJNClmcHr0xsk4XShbporZlPCODx+FIiZibbv4hgy83qi
         +mLIPWzI9ZbK91SEiLUrxX3sooLkqJNvjUtRr6tckGF6r8iJfLXWHGjLT7JRSCdyumds
         kEjOaj6Vyw6JBiBoKX/VHVKtj0BWWv60kaSxhyXpzSChDdLH8QOhW26ARC+Y5sURRWO2
         +UXiEIfUTVEgQyNgVFPG/kVcq6olAj0Zk5ZzU2nwEhl78NfauCxUqTCeiWwiPAlzOFrU
         r62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EO7gB0nQmhkZHYAXrduT64kOSIDUwU/IpbCgv7t2Vks=;
        fh=Oo34rkSpaFF8bVQK2yS3+7ZaBAVaPAmnsbf3F7hMYrQ=;
        b=eWqeIqHRvU3X7hjnB0v+Me/iduY3i75G6HX3C5Dj0nPnyx7GR7OYUaEaE8MuacJVM4
         6nXaLp9Z0EWycAMvocvVAhsXIiIDqI4kujRPqiVaM+NBCC3NJveLpd+mmtdlrhQ09dDH
         jIqFhWP+4xa9nVrdoCGE+e1aQzr00OYtHMEkMwfkdsTC9eNRxsqLa+PEmWRn92ugAZav
         bBIO3mGMfwyuzveKVDNpfbLKpc+WTFA1/ygEuEyRoHcXvRH8VhYoBDNDscCLz6YSGli2
         gufFQOvhKnKgOShSWp/WrOBgXuHMW2uClWJ2mDPtzJWc+ps6WJRrLHHSyYelNcj2XYcK
         ky8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776610916; x=1777215716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO7gB0nQmhkZHYAXrduT64kOSIDUwU/IpbCgv7t2Vks=;
        b=jP5d7BXvcwNVjM20UEiD9ex4aGzM0e+Sha8gOXVAHC+8tcqYxza9qQp9hUREbeL2oZ
         Wl4w6dj8DSfE+wL0cwbGZEpvYGO7bibb9Lssr53/RiQ8aqtVPvzrx5VMkEdNnPBcfHI7
         KYOVbQ8G/bbhTXCu4Wful/BJhF70XSdRLSlQBzOLDtWFLEtcF0jDgw7jjN2B9CC4ZInS
         c+Pw0xhQ4LsHnKMW/6yJe25DYfdlORXAmshJ9fV9Y1JuqK16QV9mmpTOZEe8+6AF611H
         r2YdiYtcgrE91TRL9FiljfCM6znomgv7xCNHGqLXNTf/ryooIofQwK47xApSxNRcoX+h
         qmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776610916; x=1777215716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EO7gB0nQmhkZHYAXrduT64kOSIDUwU/IpbCgv7t2Vks=;
        b=k5fZD46o4tQszRb6DSVlfT5Fn81xhskL/vW3z/L8hk/rOQd/KEfH+E12bCvaSmYJHT
         gXCrT+OgYPvx9PPfD9g9yVX1tkA+9f5Q9xobnQdQtkclNuBSWDBdWa6Z4G+ecPxACLFY
         vsuO5mU7bM00ssWgwr5CDK/smquYhEKLin7pX3BOupFtmhC45eC4+CAzY335A042CeGE
         QEYFH4ax4nKvk32+m/oulEX9TbpShW8e96vyMGF5OjL5uX4ks1q+qiPmuIjLUlO2Ku5b
         KKclujmE/93CfqqNBADWfkUQ0QEqL59NEXcldWLwXSdr3u0etUWOrSeHc/XCoo69zatX
         m0bA==
X-Forwarded-Encrypted: i=1; AFNElJ8HUNc/FR1jrQhrulmhec0cCgXq8SvNPznMgVy6rF17v2sl0ZVP3UyC5Ra58+CnNYuiIa1YsCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0OyWF4eP5pY3OFmfYuA5ooAyGeiJkLKK964/39gdRzbIKrPo
	EInRD3jN8BQjXdAYN4fALJ7fVg/QXv+0/Cy/GJHmycceu40n8ctmWHumiYfzz4qwsPZSt6GXXP6
	Y8fWCg6oZgXzAaw1U7sbA1gnHvKEjNWmsc6DbcV+N
X-Gm-Gg: AeBDietI0BsropWrBsYItUCH1qTYtg0XawqKMw8jDX9A/8PBvXyiYh58DW3BqMQtmWy
	yT1qk1yqcUhaaPxNA+Ib9dkG0LQwMzeRJWU7uH00M7hyNk45qW/ruxLS3Yj/n266PEyq9fjyy4f
	erdA7EIS9ddMi3e/DE5GGtAI74PFAqiH3jRNFZ9Vmu6aR/I7SWrrZ9ugrpbsEXtInADcDtX75AQ
	oUN2ARPtsD2mb4meBKHu+pXbdJoRwGWtoZmzpk54OFhCq+bCeDbglaacwB2avxrCuvJojA6ZBGW
	1mthzXXpjYf9hu93x45iSTo2WE/oQw==
X-Received: by 2002:a05:7023:b04:b0:12b:fa7f:e24b with SMTP id
 a92af1059eb24-12c7b2570b1mr107867c88.13.1776610915457; Sun, 19 Apr 2026
 08:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419090756.2190201-1-zhengxingda@iscas.ac.cn>
In-Reply-To: <20260419090756.2190201-1-zhengxingda@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Sun, 19 Apr 2026 08:01:43 -0700
X-Gm-Features: AQROBzBStw1beLm8GiHCmsv5MOwelYHHtOzwIKqt0bbRh8Hc1as4FPv9pELhQFw
Message-ID: <CAP-5=fX=+2oNYHDqsNnFrOZya=RxpnPFF_ojZTQP8v8Umt951w@mail.gmail.com>
Subject: Re: [PATCH] perf unwind-libdw: Fix stale object reference in arch/loongarch
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Shimin Guo <shimin.guo@skydio.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238647-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: A12CB4246CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 2:08=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> The arch/loongarch/util/unwind-libdw.c file is already moved to util/,
> but the Build statement for it is forgot to be removed.
>
> Remove the stale Build statement.
>
> This fixes the build failure of perf tool in kernel v7.0 on LoongArch.
>
> Fixes: e62fae9d9e85 ("perf unwind-libdw: Fix a cross-arch unwinding bug")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Cc: stable@vger.kernel.org

I think this is already fixed:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next
I also sent out a fix, fwiw:
https://lore.kernel.org/linux-perf-users/20260305221927.3237145-3-irogers@g=
oogle.com/

Thanks,
Ian

> ---
>  tools/perf/arch/loongarch/util/Build | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loong=
arch/util/Build
> index 3ad73d0289f3e..8d91e78d31c94 100644
> --- a/tools/perf/arch/loongarch/util/Build
> +++ b/tools/perf/arch/loongarch/util/Build
> @@ -1,4 +1,3 @@
>  perf-util-y +=3D header.o
>
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> --
> 2.52.0
>

