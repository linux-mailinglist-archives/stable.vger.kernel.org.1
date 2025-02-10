Return-Path: <stable+bounces-114492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5EA2E714
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 09:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033FB3A1606
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8721E1C1F08;
	Mon, 10 Feb 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE59dC24"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8643151;
	Mon, 10 Feb 2025 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739177867; cv=none; b=dVafx01Qmt4DFEdRHrtPEEZYJHz13E3jX9s7GfZxOEhl8+2ZfwrCkQIyDAhSFsjqlDuyy5E+bKQZxnGmKLg9NSdB0FnMP9Nk+y8eWxE61OBqF9pFqsrR0YaHgXdryKjXRzmA5GkFFHl05UjEIBQ3Nfmt7P0lFhvIUmqtbGUe+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739177867; c=relaxed/simple;
	bh=M0sH78tZwMI80Y0F1mZRq2/tKtoaQo1cIuD3CYUKUiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiTWzfADtrTWIHGdFfFNquaBkzoLa5E91DP6VdbMLnUBW3E7TK8pVqK6tQka4pGUMZrPN+xsrIJgx4XPRkxOWaQW0fVcQ6wn9jggi+r/ha5cEWClpQWieoRLaIaoIZ2V3TC+VGdVLM9FMBTGu2knMQCtjKqX2S1Aamw9yB6R/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE59dC24; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso663318766b.1;
        Mon, 10 Feb 2025 00:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739177862; x=1739782662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0sH78tZwMI80Y0F1mZRq2/tKtoaQo1cIuD3CYUKUiQ=;
        b=XE59dC24JNH7KPCCivlNp3OQCvylEWcvsC0vXWkSyIjMVxwpQfht2Hh+07R+ZlfPQe
         HUPR38YpuKxJyVGySHgpLlBeI2d3OT7G6EvPV6jSzbTugqjTFkxOwqvHxlNaSwF/Q1Wo
         Lk2/aNh2Sr9PVrWIiGFNpjrvR1CGHmneiqU1FsZZpKQ7CMNahQx5LWqjylThvuIe+8wA
         RTmzbyAb/NYAifPq+4WfYb1xVyQkymjTVQ6aStDD5JHI9aV1yTdrhlR6kI6+k/A4Zfji
         DRXeyU6ypbPJioT4bogZPCSS9E/XA8qZuxgT4q58EssuSKR5UcieLVOAsmQF6LVWWW9g
         13Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739177862; x=1739782662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0sH78tZwMI80Y0F1mZRq2/tKtoaQo1cIuD3CYUKUiQ=;
        b=rGPbozI6q9Y+vT3F+n3uRsLsIu22bAwj4VE09UwUNNLU6lfKtpf1rfV2xFOccRhDNX
         W7m1Q2hQoR0b5z3m78rxuWAjcpxx5izVIhzErXGM2wzkCza3ihJ2XDshw9QPbwb1xnXh
         6wd7QUfv04ZrC9iAIIyofsdSr4N7zEmOLMg67WadOILaXe9fp20ucDvZVjexwIK/E91b
         3sJXWzH74cBVd+PBqEC7ScuRXf1lz9+In0wA1qVIm1tyIK5P+Lk/eJNpd//K5wvoMN2Q
         MsQKlMYRZLHWDVg3IpXiNnhY/y5fKMRC81NmI7LBemzl1FMFOy6+2v0Ktw7DbDZGltNp
         /SCg==
X-Forwarded-Encrypted: i=1; AJvYcCUN8b3XdB18tOT/4Mol/mxMn120H4H1rjsp4oI0rpr9zJLSUBo/6AMA6DSfmfwKta+GbI0pDb+EtD9S@vger.kernel.org, AJvYcCUZ6nVc9hiHKINS9Hqaiqd7D5BxVervLtetc1QF6uPlDQ2tbKS3EzQPzn+8FhDUi1HJFcmvyR7/LHNYX/E=@vger.kernel.org, AJvYcCVHKA/BdKgGgMRyR7PgLxZ+ijVpn56svM2CxjmQBPPANScbAPWIv4V4LBKz2/kcRrHqp7u7CltR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01VbTS6GNWKp06akjlK8o/yGdXK2z/RtS4OhEKasyKUjkdrX8
	7yttm8+CM4MBhEM+IAkwWRmQsd0axkZqBU1Kd6bGXB9KdsWT5XR4
X-Gm-Gg: ASbGncuUvf2e9sHsQtrTMfls/HygooeBgoADRREKVF0j+uETXlLelAQWXXP61IfG6o1
	c2N/eZWf3u4YOEF/nIMEU5PG7wIY4XpYPWtiXJYjQprXRPtwYud7dp0KgdOMJRX7x4fkH1XcaOP
	rKfkiA6Px7H15w5ftzn/nQqJ1H0ARGQ63diCZWE/P4+34sOYHYG68XLa0rC4HNk8tJ2XdCgGQCS
	sII3l/Qa0rIy5A08wKWEAjVAo/wWomQ4Xjp0frXqyzkEyD5kOMdVngvDl29/LKACRV68QAdDiNP
	EEMRc4VDvUTOOJ41DpqTINykzvUft0ty
X-Google-Smtp-Source: AGHT+IHWy2HCAxr64K+YU8mksNKshPp5ilP6jGfEAyGv9Owc1pqgtN5klIXTjKwViM4z7rE2O0gVJQ==
X-Received: by 2002:a17:907:2d27:b0:aa6:89b9:e9c6 with SMTP id a640c23a62f3a-ab789ac0dcdmr1193362666b.21.1739177861549;
        Mon, 10 Feb 2025 00:57:41 -0800 (PST)
Received: from foxbook (adtq181.neoplus.adsl.tpnet.pl. [79.185.228.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7860da0e7sm710625566b.110.2025.02.10.00.57.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Feb 2025 00:57:41 -0800 (PST)
Date: Mon, 10 Feb 2025 09:57:36 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, ki.chiang65@gmail.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
Message-ID: <20250210095736.6607f098@foxbook>
In-Reply-To: <b19218ab-5248-47ba-8111-157818415247@linux.intel.com>
References: <20250205234205.73ca4ff8@foxbook>
	<b19218ab-5248-47ba-8111-157818415247@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Feb 2025 14:06:54 +0200, Mathias Nyman wrote:
> On 6.2.2025 0.42, Micha=C5=82 Pecio wrote:
> > error_mid_td can cope with hosts which don't produce the extra
> > success event, it was done this way to deal with buggy NECs. The
> > cost is one more ESIT of latency on TDs with error. =20
>=20
> It makes giving back the TD depend on a future event we can't
> guarantee.

For the record, this is not the same disaster as failing to give back
an unlinked URB. Situation here is no different from usual 'error mid
TD' case on buggy HCs (known so far: NEC uPD720200 and most if not all
of ASMedia, including at least 1st gen AMD Promontory).

We are owed an event in the next ESIT, worst case it will be something
weird like Missed Service or Ring Underrun. I've sent you some patches
for that, they also apply to the existing NEC/ASMedia problem.

> I still think it better fits the spurious success case.
> It's not an error mid TD, it's a spurious success event sent by host
> after a completion (error) event for the last TRB in the TD.

Legally you are right of course, but materially we know what happens:
the damn thing still holds an internal reference to the last TRB for
some unknown reason. We would need to know that it doesn't actually
use it for anything and will not mind the TRB being overwritten.

This may well be true, but I guess I prefer known evils over unknown
ones so I immediately suggested using 'erorr mid TD' instead.
=20
> Making this change to error_mid_td code also makes that code more
> confusing and harder to follow.

I will see if I can come up with something clean.

I will also try the patch you sent, it looks like it would work.

One thing I don't like is that it fails to distinguish the known
spurious events from other invalid events due to hardware or kernel
bugs. In the past last_td_was_short caused me similar problems.

Regards,
Michal

