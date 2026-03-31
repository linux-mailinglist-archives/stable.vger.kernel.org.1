Return-Path: <stable+bounces-232575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIYlJHE0zGlRRQYAu9opvQ
	(envelope-from <stable+bounces-232575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:54:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F098637148C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5829C302DBBB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45803E0239;
	Tue, 31 Mar 2026 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biARpTj9"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152583DB62D
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990447; cv=none; b=h6xWUfB7sviaPa0F8z+ItWvrH6OCSmQCUq9GUf9IjmUFX2SUAycdRGvyojHMKEEgG2Fve6kWxnB43p8zIephsTRa5T2CmzKgJd+VIUl5tCz27SI3F/ERFAFiAFKdBIMR7vNqRTmeetQFImEdkXIf6TiTpltn2kJR4ePVf9QAmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990447; c=relaxed/simple;
	bh=xzZNSyXLHafrytf3VN4xGFqU7adjtRPPfSXD0Gs3mLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dG0CLNj9D3U5Ve8HNUvaenOlhc7hlLayxpNIxEB9mYSnlRAGDpRFwxxVOKStbAD8b6WLJd5F0nmu0wKUv/PNV8eqo0O3/6ZiEz9ykfql9AaRnSZWg/6OAaK82MfLgKoeE2lhO+5D/MARTlXep11i4Tci1Gi8TpdowG+OGI6/dFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biARpTj9; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c66eafc1easo4470669eec.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774990444; x=1775595244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZspNX5rs+mbfHqezyzp4ll5OJtm1yyo5L/3asPtSr14=;
        b=biARpTj9/QQwG/GWm2OaLc850ThcmromQWq0S6hENjGaLFnobmwzqhbIFFXNEonXtb
         oMZwypR6wkjVmzlTNTB58fS8ojw4OP6LfEvhyynI5zWCKLbE1qB5Ky402qp0Dxww/CmC
         r6pEDLb2JXGMEbQmLht7W6v/mFSQns1ymG8eAP7RXt6BQqYD2GlKU0xBmBJs29S2DKba
         719pCPPqmrDJLNPT96IGGo4yeZK6R4Dx7FpShMXuG9fXB/KP5U03cwq0XHZS0auqNZHy
         y/3maR/eD7DK0jm4ETq2uoj+PVX9HtTrUHOKmOd1GRcHki/Fkn6CILpTg4HbEYNoztli
         bm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774990444; x=1775595244;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZspNX5rs+mbfHqezyzp4ll5OJtm1yyo5L/3asPtSr14=;
        b=iOdbApF033KIZcwdEYA8+KRMTARhUD6CbP3f+enjxG0q9Nc+QskVmhInqGTlIFuluj
         uzpA5+2odOSga1Uq+FLWs5sULOqUgsVIVCU9JIgAWRVLoNQUHwBCaYDhQxKv18T2yHDm
         hs2OXkegfUYf4Z6cN9hT6tIZqNRCsZ74JNl/vXpmSgVZfXpNezeiPPBZsjDkh5FfqHOu
         RdMEgxwMbF7tTpcbKtymR+EGO6d3oEc98Q1O6kWLewyztxN9PiB0aX9i6c/bJTtK3Wfx
         +FNtBKjLhOFd1w650eAx+k1FLvZAZ7L9uTRxR+/IGQ5eVl6zhF3i1r5tPrMb4YsFfVZG
         DKhg==
X-Forwarded-Encrypted: i=1; AJvYcCUzW57fM8ksFXv2OzU4Njwja5se3/QvQQbxVzfp3SPt7h9vONjQNBZ3pjyOqAcnQ0xi1/lzFcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJ5F0zxXnpCx4i8n0SD5hxyccZWBPZHnRrPWs/s5Cslp4gwMz
	v6Kr3sfJfJnnQfsTZ2PRAJJdZvLwivgjmRpyO+FmmQk0InaZjcV4vn6h
X-Gm-Gg: ATEYQzxoTAiezXjMVL2z+COoYmTwGm4ZwNm5Y0WIP+9ovwLQu7N/zzor6YzpNTZLvcY
	U/lm9QdrKI4ci+/Kd7QBbSp2O7wdu0ervz2gBG963kq6G8LOeG9nlvcS8g9EyuKwcGtgoraDqHG
	SmzBdRnX8Ws0w2J85BTYI6Cctzd/5TSU3ITx3dHBxAU3+l7p4vpBFm27048i5DeXDZcUEvVqfbO
	w6+VleTXUUUHVpkLxuq7mieYUfihbWVAxmFcA5R7TOwmWMzoc8bJTKgGigc+o+bWRIbDg/tN+/k
	8Pv8slaeK/KhwRRpzirQNa37/VOOxLYoQaBRKeohHHIGTsesR3lFqVEgiBlXpeZzs24tWkycRJV
	8N/HGzXKpIxNjlEmWxdxD1VRzferbT2bzHqDoB7ZQ7Tnf7IwFowQZ2C6jKneRltHAa8zuvirmT4
	kBffJynqYomQMy7J+VBoHy4J4WCDdKagSUGvSsUeqBmBJu6W06sIX7+p+OI64bYVahV/RDX/vJT
	Ec=
X-Received: by 2002:a05:7300:fb8e:b0:2c7:11f2:d072 with SMTP id 5a478bee46e88-2c9323b8c8cmr558693eec.16.1774990443987;
        Tue, 31 Mar 2026 13:54:03 -0700 (PDT)
Received: from [192.168.1.8] (177-4-161-218.user3p.v-tal.net.br. [177.4.161.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c41c1513sm11457738eec.8.2026.03.31.13.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 13:54:03 -0700 (PDT)
Message-ID: <c1aac723-8a60-4b37-9c8b-74b2ea4daebb@gmail.com>
Date: Tue, 31 Mar 2026 17:53:59 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
 <202604010125.AvkWBYKI-lkp@intel.com>
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <202604010125.AvkWBYKI-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-232575-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,01.org:url]
X-Rspamd-Queue-Id: F098637148C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 14:10, kernel test robot wrote:
> Hi Cássio,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 46a6512f4a74dd7b18d9a455669c226843fc49ce]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/C-ssio-Gabriel/ALSA-aoa-i2sbus-clear-stale-prepared-state/20260331-113724
> base:   46a6512f4a74dd7b18d9a455669c226843fc49ce
> patch link:    https://lore.kernel.org/r/20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e%40gmail.com
> patch subject: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260401/202604010125.AvkWBYKI-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010125.AvkWBYKI-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604010125.AvkWBYKI-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> sound/aoa/soundbus/i2sbus/pcm.c:760:25: error: initialization of 'int (*)(struct snd_pcm_substream *, struct snd_pcm_hw_params *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *)' [-Wincompatible-pointer-types]
>      760 |         .hw_params =    i2sbus_playback_hw_params,
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>    sound/aoa/soundbus/i2sbus/pcm.c:760:25: note: (near initialization for 'i2sbus_playback_ops.hw_params')
>    sound/aoa/soundbus/i2sbus/pcm.c:313:12: note: 'i2sbus_playback_hw_params' declared here
>      313 | static int i2sbus_playback_hw_params(struct snd_pcm_substream *substream)
>          |            ^~~~~~~~~~~~~~~~~~~~~~~~~
>    sound/aoa/soundbus/i2sbus/pcm.c:829:25: error: initialization of 'int (*)(struct snd_pcm_substream *, struct snd_pcm_hw_params *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *)' [-Wincompatible-pointer-types]
>      829 |         .hw_params =    i2sbus_record_hw_params,
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~
>    sound/aoa/soundbus/i2sbus/pcm.c:829:25: note: (near initialization for 'i2sbus_record_ops.hw_params')
>    sound/aoa/soundbus/i2sbus/pcm.c:323:12: note: 'i2sbus_record_hw_params' declared here
>      323 | static int i2sbus_record_hw_params(struct snd_pcm_substream *substream)
>          |            ^~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +760 sound/aoa/soundbus/i2sbus/pcm.c
> 
>    756	
>    757	static const struct snd_pcm_ops i2sbus_playback_ops = {
>    758		.open =		i2sbus_playback_open,
>    759		.close =	i2sbus_playback_close,
>  > 760		.hw_params =	i2sbus_playback_hw_params,
>    761		.hw_free =	i2sbus_playback_hw_free,
>    762		.prepare =	i2sbus_playback_prepare,
>    763		.trigger =	i2sbus_playback_trigger,
>    764		.pointer =	i2sbus_playback_pointer,
>    765	};
>    766	
> 
Oops my bad!

I had added i2sbus_playback_hw_params(), i2sbus_record_hw_params(),
and the helper they use without the struct snd_pcm_hw_params *params argument
expected by struct snd_pcm_ops.hw_params, which caused the compilation error.

After fixing the callback signatures to match the ALSA API, the file
builds cleanly.

I will send a v2 patch with the proposed fixes.

-- 
Thanks,
Cássio


