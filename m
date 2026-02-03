Return-Path: <stable+bounces-213277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB7qEjImgmnPPgMAu9opvQ
	(envelope-from <stable+bounces-213277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 17:45:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4082DC2E9
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 17:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9B530D0AC3
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3BC3D300A;
	Tue,  3 Feb 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VBt3hDo9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1D3C1960
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136564; cv=none; b=uEnlZn46xjtB8xogUJ3JOyPl3uHD/Cd72fG1Zj1z4pqdjlfKPptX1jTmjVpUZq9osihU8jehc+WSoM6NT8jdq7NtGXHURIYiv7KdomMIJ5vjfozEZ4d1aYZINyTqCxojIHCDigZK3jg+caR4rXXrrtVL8LR/CDLSYHbd7iZEaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136564; c=relaxed/simple;
	bh=qap9S7WORoUubJqTBtETXU0xFt0az5wDCXk0PrXYzOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMlNPxBSTxskQ2XK8e7HJ6SXZ9XYV6PgqzzLOFIAa+IW1aAWO5QvgRLrQJfhlM5xaKRuvbmSift5RlQ2q52B2xSrI+f+2ow6l8IRXssoYW7nE6fIDkvmrqeMNqW6cxhRRXp7O3whv5/uuX2cci9NHk45KuKU8XKP0AUyOFcWyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VBt3hDo9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359a16a400so5089567f8f.1
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 08:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770136561; x=1770741361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQuo/p5AInQk1R/8pvqh/pjovAKXDnSWHvDzZRsI+LE=;
        b=VBt3hDo9vGybANjrUkwXqw61AVGw+GKLWLzBalRMHC30ytCT/TyulnB7Its5Caic0y
         TDeSGPb16o50+O50oUF1ZJWqWswIFcQ8B4B265ftHqNKeOajGJjIpXG4m/bYkgU5lcsy
         DxmftfxirMJ9SnqJdwVE6NABPND8GB4wsjNEtGQ8f1MZpH8jpVySxLmfmcgrdg8YkjLq
         xqTPFxYk4LFKDg6/+L/uloaF1hPRtYlH0bUS5AThzCEep+xioywe90qDRdkpzZ+h48pu
         TM/JdZN8Zf7hiRuDweHSoDbuDp7iaITj/g8WdQmNaYZUb36u4AU6HEFrxAHJrWi56iYX
         9iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770136561; x=1770741361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQuo/p5AInQk1R/8pvqh/pjovAKXDnSWHvDzZRsI+LE=;
        b=LAjW1IzTK3D27HNll4b+xQEkgeQrr/6iPW82fk8WOqvS2iXlZW8xZnNrSgUdq1UQtV
         vH3v8sNcbvEpX3RbTi00Kppe0QLmpeQPXnJ1e0ywfFVRAn3/SPZutI2zhtwTv+SGT+Lp
         k5pjUFcduzlptDucpvkc1qtyjh5OsTG9LdhmAg+lcpNnQhwZeFJoE4AHHUCguepjhcIq
         zX+GbRZrDez8GIgb/KqQlP6+sNzclHhJ9CYSVqeLus+0IOCK2RaxhqvxnBn9QP3wMvd9
         4/WqLsPfxImveUo9NVAIS3qptshCYTYT5I8H0d3gVCuwLjiBtmvfxHhTpBhSCN3Cb1Xn
         IqqA==
X-Forwarded-Encrypted: i=1; AJvYcCUlkN7jmTPSYUsu3dfeTiEok2qSB4KXTIfiEzr+TIxtvVG50b5S9jXdgUTzeNIdNvoHC1A9QcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUtxKoclsXk1s2NBC9EHzc3r5J3swDZ91tQblMuyRuMLEUXcI
	CHK0/VaE0P+WFiAdTj10JwlyALQhxwVEhUYcj1C+IDN7RPI1mCcTsUI3vLRnT1FQ7Uo=
X-Gm-Gg: AZuq6aJc1lBHF5+rKf6ruhA6F9RjytGHR/TxksAlKhycvyowkOyLJMEjMblNBggDGDU
	LqwS4ssaoTAWBqmRNyo1lmsIaf1TzeL/7G5iTEDewXul1rCacZjm4f4LGF1TKZHK+g2HXuBzwf7
	YB5EvtrIHsrbewtFl/sdOGzaYCDA1hDj1p21Y1n5U69ydqw1QXmLruDtpv0NRwInbo68Dt2yI5w
	rKVt/mINvSs7iqEZ3aDiuTpV7F4Vnu+skuqe5dJ9NgyP4lVBTN5B+fHXKGwaK1PHBehQI56NTcT
	mHU34sd7o3ZI+X9GACMwqVWCEU211KBlo4uprG9oPc7Yvx5VrgqLME1nyE3ZDtiPL51OfV/zTQD
	jm1Id7p5+P+9UDbtIZ67e6dcoSWh/awRMhm2yPoGA3Ox/1MZDMi4bs25R15KjNy9N99fbEK4m9W
	zQngULua6hsn8obg==
X-Received: by 2002:a05:6000:401e:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-435f3ad7646mr20374411f8f.55.1770136560693;
        Tue, 03 Feb 2026 08:36:00 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e48a6sm51375458f8f.8.2026.02.03.08.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:36:00 -0800 (PST)
Date: Tue, 3 Feb 2026 17:35:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org, mm-commits@vger.kernel.org,
	Shouxin Sun <sunshx@chinatelecom.cn>,
	Junnan Zhang <zhangjn11@chinatelecom.cn>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>, Song Liu <song@kernel.org>,
	stable@vger.kernel.org,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] watchdog/hardlockup: Fix UAF in perf event cleanup
 due to migration race
Message-ID: <aYIj7BzCI46iz2wj@pathway.suse.cz>
References: <20260127022238.1182079-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127022238.1182079-1-realwujing@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213277-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,huawei.com,linux.dev,gmail.com,hisilicon.com,mediatek.com,chromium.org,vger.kernel.org,chinatelecom.cn];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B4082DC2E9
X-Rspamd-Action: no action

On Mon 2026-01-26 21:22:24, Qiliang Yuan wrote:
> The hardlockup detector's probe path (watchdog_hardlockup_probe()) can
> be executed in a non-pinned context, such as during the asynchronous
> retry mechanism (lockup_detector_delay_init) which runs in a standard
> unbound workqueue.

[...]

> Refactor hardlockup_detector_event_create() to be stateless by returning
> the created perf_event pointer instead of directly modifying the per-cpu
> 'watchdog_ev' variable. This allows the probe logic to safely manage
> the temporary event. Use cpu_hotplug_disable() during the probe to ensure
> the target CPU remains valid throughout the check.
> 
> Fixes: 930d8f8dbab9 ("watchdog/perf: adapt the watchdog_perf interface for async model")
> Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
> Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Cc: Song Liu <song@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Jinchao Wang <wangjinchao600@gmail.com>
> Cc: <stable@vger.kernel.org>

Please, do not remove people from Cc, especially when you send new
versions on such a rapid speed.

I was on Cc only for this version. There were no replies. I started
review just to realize that another 4 versions were sent within
a week and they got some proper review and v9 already ended in
linux-next...

Best Regards,
Petr

