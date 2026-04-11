Return-Path: <stable+bounces-235710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD/yDkok2mkAywgAu9opvQ
	(envelope-from <stable+bounces-235710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:36:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C253DF5D1
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBC4D300ACAB
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD9033F383;
	Sat, 11 Apr 2026 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTa2hxDV"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877C248886
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775903812; cv=none; b=Zs8omOm9Mm3za4RG3162yH4jv40f7B6ph0cND4k+gD2OTtE1/Q3EskYpK5U6yc35TR3UeT24rqGofV9vvY4kobJuGwNHoHlsS8liMZ282voisvRsX2/+2ImhtsQO/vhqHW0es3AdmYoR8Qg1m/eLsRsy6TusPxMmoiQYYYajvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775903812; c=relaxed/simple;
	bh=jrkvMc2KZ/Iv4DrE00kRYtfKjd873yyNocXxsrkPaD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA84r+2665HHwqRlhlmxnfGKW9S2Niqm1aXSjcFI1khe9/YaS0mYfjH3vmEJxx0E5uj9LhqVzAiXZjhhE/hH6pS4/YggMEh55RAolNgLJxD16fKWlUsYpiuBAMcTHKJXahze/syUrdCfR0DCY1FKEy1ZP3tCNoWfX0Umemyre8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTa2hxDV; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1273349c56bso3876019c88.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775903811; x=1776508611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrhYXHyxwDX1H8cIsOzl7I0KsZOpptKIlYKIA44JX/A=;
        b=qTa2hxDVUMc499MmsqA57SIitNt25ZjCwfrAB6WR+nfSpFTbYvo4SbYMtdr98rAMzk
         bnRnQHgzRFlkdqlR81dLiC0gVcrBJNRy0Fv8wTvxCe7rWk0yntEIOJ+r4Vv7J2KHkR4d
         rbn7+CcTonl1tEn4QsyzPianBWm1yOgp0NILKkOuEaFQwvO2cjUl0G1IA8Aw5oyUdSzJ
         9JFORWVnisDK8ZmlnJjrgHPx0lBJedpTDPVPMgHAtYk0ZQ7a8YLmYxe4F5MiDJDy/McG
         8UoFeQAGV/vkcH1HFW81fSxbLBg/t7kEoLlMxevJPf9xhyL7ZuUaDepD3bHP0AE+ABgd
         jjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775903811; x=1776508611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrhYXHyxwDX1H8cIsOzl7I0KsZOpptKIlYKIA44JX/A=;
        b=GyGldF7qFyhMUfT8RArunfGvJcY2oJu54pbkTaz9OH3PrJiPA7Nw/OgqxBhJYVXHMR
         FrYmgIBOg3Pb4snFnMA8my1N/ZjYSiWIQGCEgWi250bjmTXilqCtYneJuYmp39A5BRhy
         35z4WTcpvNrUspfs3hdSv8/eq/jxotHcNTOCen3wKscwuYp2wP6N1f7d5JgucZkC2qch
         9vJSSeAfW1hDtgTbkHhq5/3Mb1DlUWY4g+0zAcF9JfYNAxVDAHAIQUk6ClXXZgnKPJ7h
         IplFY/HPSEo0Z4SBnorpXyHon0ZkB7h97SWlC4FWhkxwb6PwWxxUVmJfGQPWwEGCp2DU
         OzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrzA/nnPh104jJtqmGYKOpX6UXJKQV6rNFXXZEXn81yninWAHpjJSFPHbb5HVhgK60tJbbjuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgnX61m9ZHMwEgXjCGRYWO3Xjucfu7Xbd7igNY8MECYA02+Rey
	m89V95py79+dst49wDAKHghOTBxr7oL6gPGEkwc/Iw/4lvCs5JPkA9f6
X-Gm-Gg: AeBDieuWqSJw67ZR+BTsNsdoCWVFQE2ok9+JWcK1ycUSCSblKCZoqc1tdDA2ljtcbnZ
	8eLMx3VVf1Uqs89yiU6oVFsIBMy4foOIvg3CQaSKiFnx1rBnXxIEPNLd8yNctB9VpGfEUG0vqHN
	vzSRqewrx1BiCrxxFbAJ1xJlr1fuDTYjN8qpoxQXUoI//7LzO4LZIGsnTWMXlnMrZkK5XZsu0Um
	ig4AwUITl6bjzKFBT7bCtBOzzPBBH9jttA5lVDftJX6nEzxJ056gFXS4UhgQwCfaV20X5d7YN+o
	apHtnzGMEfSH+aAmEApTCLEW8JN4hF8iWtCZ0JJCDo54Q4qzCqWafT2cUQQ+5ZcqXr0WvvVJRgM
	pMTSlmGGrGyk93Czg/Yn6IzoQWoJI27PfDeQmEg0MZgNfHjvOiLUgRZSAicBM8BXRspEZ7wIS7x
	R7acgb7U07DVlGxvI=
X-Received: by 2002:a05:7022:61a5:b0:128:ceac:6db1 with SMTP id a92af1059eb24-12c34f0677bmr3459374c88.28.1775903810563;
        Sat, 11 Apr 2026 03:36:50 -0700 (PDT)
Received: from localhost ([45.86.211.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa571csm9829684eec.10.2026.04.11.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 03:36:49 -0700 (PDT)
Date: Sat, 11 Apr 2026 13:36:43 +0300
From: Dan Carpenter <error27@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Fix refcount leak in viio_trigger_alloc()
 error path
Message-ID: <adokO8-Pf_FjKYCI@stanley.mountain>
References: <20260411080435.2125626-1-lgs201920130244@gmail.com>
 <adoEfbDRO_ZsIUx6@stanley.mountain>
 <CANUHTR-CY2WdPqdheQHHsFqj=y88zs3iiVn=5rE6gh9mRmsong@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANUHTR-CY2WdPqdheQHHsFqj=y88zs3iiVn=5rE6gh9mRmsong@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235710-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: C8C253DF5D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ah, yes.  It *was* a real bug but it was fixed a few months ago
by commit 12b393486c70 ("iio: core: Clean up device correctly on
viio_trigger_alloc() failure").

It's unfortunate that that commit didn't have a Fixes tag.

regards,
dan carpenter


