Return-Path: <stable+bounces-237834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB+LOhEq3mmSoQkAu9opvQ
	(envelope-from <stable+bounces-237834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:50:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8D3F99AC
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16FD13050A22
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D233E0C62;
	Tue, 14 Apr 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URejJB3K"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0413939D3
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167381; cv=pass; b=UDnkYP4bMTJJKtFHcG0EBeY+R6LQakgY5j/LL7m+zC/mRqVJwloDGvSioN8cZkaX3wz4h/1E2zzOOtlGyuAjARP8NUYTe6xKawUgn6xua0dDSSrEgwmkHIfdp1x8WGz1NRtlKmK1ee5pz6/9vTy/3PlJ+xZ4nZ2R/SMbTjYZ/GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167381; c=relaxed/simple;
	bh=Ufv4J6baPU2WSi/6wgzJOqGGMtNG672dGk0L3nk8cPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxd2sAmuLB0mE2OgEtX28kTENj7KPIQ0GEkGzj/RaBdjzSsoLYHDNTNQcnOXqIM2XKuZTYdWsFspKIBJbkKzY07IMwCH0R6KRPxYSFCo0AUQKkqYPrZ+X9T9zgLnW0VAhQRJXGzdvfECoAoDErKZ9ptkLvNaY/DAJimEpXf2INs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URejJB3K; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65005a8840dso4955586d50.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 04:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776167380; cv=none;
        d=google.com; s=arc-20240605;
        b=AoW9YI3bd30UngWvAg3chh5GigBviZ9EAdvJTtRDvYt7SnwHNi5rZ3oeO1siTTRAzX
         XknMGfX61XbwWcZTteEp8CX/XdKF1UJ+rkw/h+ra3aw/U08jdiRRIXFGvM4wLDTU/8cW
         hy8Xziay8WLQ8oa1b7obNWB33DrWHPq9t9mT+wh6tLpw/zNIicp7H7Wzpy8h2YYnishV
         Rf0tsSyqpT/o9wxgK++iZTEc+sRttL6wjWJ3Zca1JokbzcAHP+yyswf4sY7aOIUktL7E
         CNm1jLViaM7CKV1KIcIkLrvGdCg4Oilfd6vfYHmuse+8hsmuQ3v2LT9rKRb5CXWG8rf6
         KSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HiDQJibsW8Dy2yLg815wN14aFJJg7FhsN8DrnEwbqfQ=;
        fh=cgHBweUdbR1I3MZVC/7Um2nX6oVmWnjkq8qqXmUEbhg=;
        b=LKD1TZpq/Nyy3wxciXs3mJIxltiApkGzJRv8CIHVSe9fzkWp7mcDR31Q7WBGBDvlEd
         G0mXC8o26xCn0UVcLDpCJtpsum0jHW533R8zeT98DmB7O3P32cB5wfBeI/aRrKji6aY7
         cvy3v4AwyTLXMlxGOHety6LKCGTzXaRol2OZuqm3DSUAWZwnrWleApx8PBJFTFSdUwLm
         eVWrN21q52Xeexfm9EyMnV1aLYUo9m3M4LN9fkGLpE5jRDdK7Ub3cti6UQ/0cXy3pJHO
         5Lr8zY7orOte8i6Wud/3iZkeTCP6IdUSY2ewn89IQ9zARmwl/ize+dsvdOI9uOc9KIEt
         3XpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776167380; x=1776772180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HiDQJibsW8Dy2yLg815wN14aFJJg7FhsN8DrnEwbqfQ=;
        b=URejJB3KMDS8eGFvlvpxhNXW3QoWDlX/5lhYSui6BdQxQoOi/imB9QpwVpMUK5XJ2q
         pyJMDP1AwRbZc6+dO1yrrKtCpsO3ybftnZMw+5hHNX0Jhh7M54nGq8ZiwnpR/MzbtRhR
         fZhZHGZzpSnpLhvBp9YWmAOHqRwiyhoXYxnsU+rRmBF7wotHxbb8XJnzu4iRWpZFDsv3
         P++dFwmXobx5MdArAgHOSW/J2KSyr89uYTxHiuf1ewJKBAxBSLWxKXLOz5OHk1tZ3Rgs
         2FY0ym9LO32IDmfUN139hggs36w4u8pBUePz+6c8cO65zKoCjvdO8nEqkx/xUO4snRk1
         gHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776167380; x=1776772180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiDQJibsW8Dy2yLg815wN14aFJJg7FhsN8DrnEwbqfQ=;
        b=ac+lOzvkcQVb4jX8LrhsPprsihSamJGBXPZDKiaoFk6h0xPd50PMSYboqP//I7Sbyn
         OqbYkYTyjX4h2LXp+vW8HAMjJK31A47Ffu4SW9rzPyX8erAqTFVak/i4VCRPLbDhJd5p
         Fh4aMGo4gaJJED4d/w/xD2E/+NmPJd28UJu1J0DIeQ4JWKcgzcKdeEUL9VuZuV9EtTXv
         wOZrHpvdHFQM3k7emPgVsok3yNBxxjNqGrq+faCuNohObxhXUdxTTLRtb0BiKoSjjSk8
         bPCRibbwMrFN8ajGf86w/+wZTee6kCBJO9p2aD31MFonzIfuZxTimraQKLurJqH+2uFz
         q0bg==
X-Forwarded-Encrypted: i=1; AFNElJ8gXn0TeN2/I/7ug6n7vwDdixfSo9QmFOB4mWotNrD747TUfIPm1F/MUDza1R9kKPQhPC8fTzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjevMWsTOmkp9mTxrLc1h1vqGNLHR5J8l+DIk5ByyZuOBkjaVF
	WMb8Eq5c6PtlatC9PUVGrK1SGWNWM9/R677lHDhl2UwfKUUE8+creyF5j/rGRlXqb5nlScC84G9
	CZGIrGH/YXerEALfolgXFRuWxVrKlGbc=
X-Gm-Gg: AeBDieulyxLMffXn1HHuipH6WtcAQerTrPu8AkDshiRE4b2WaQOrYGUbx8dPjW/SaXF
	Bvsw8R1nFCi99Qp0SEqIzdhJE+n/gRlTOZoMr88qQi3MDufBGQhEYNfC36o3Xyg0PUUgXoSFwXh
	mcnvinQrYtAew+GpFdf/odBkCbqcQR+WxH+wDM6hjc1+7rv5KljMOou6409MJykR4lsqWpsk0sd
	RmKwt8ihHXy56QcQ34KfclNcUAU4r5bxD8PUOwGr6u4e9h+/bHMboktm9tN+wdixoBqZC7fmwVP
	YKhlh/kIOw==
X-Received: by 2002:a05:690e:1511:b0:651:cf23:6612 with SMTP id
 956f58d0204a3-651cf23695cmr5327604d50.34.1776167379766; Tue, 14 Apr 2026
 04:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412124247.2494971-1-lgs201920130244@gmail.com> <ad0c8y1u5zAhheJX@redhat.com>
In-Reply-To: <ad0c8y1u5zAhheJX@redhat.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 14 Apr 2026 19:49:31 +0800
X-Gm-Features: AQROBzAHa2QmuGgpHDSe-Y4PCign0qhbR1MGtTMMAaOeS4o008iXPrSOjj65ZYk
Message-ID: <CANUHTR-9HYnCuavM9O_wcVg3VuDyV4zQH4P9jYhViBj_PbYV9A@mail.gmail.com>
Subject: Re: [PATCH v2] clk: eyeq: fix memory leak in eqc_auxdev_create()
 error path
To: Brian Masney <bmasney@redhat.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-mips@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-237834-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97C8D3F99AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Brian,

Thanks for reviewing.

On Tue, 14 Apr 2026 at 00:42, Brian Masney <bmasney@redhat.com> wrote:
>
> There is a leak in the error path here as well. I think this code
> should be converted to devm_kzalloc().
>
> There is no devm_kzalloc_obj() yet, however according to [1] that should
> be coming soon.
>
> [1] https://lore.kernel.org/lkml/20260330154108.GA3389518@killaraus.ideasonboard.com/
>
> Brian
>

I may be missing something, but I think the auxiliary_device_add() error
path is already handled here:

ret = auxiliary_device_add(adev);
if (ret)
        auxiliary_device_uninit(adev);

The auxiliary device also has:

adev->dev.release = eqc_auxdev_release;

with:

static void eqc_auxdev_release(struct device *dev)
{
        struct auxiliary_device *adev = to_auxiliary_dev(dev);

        kfree(adev);
}

So my understanding was that after a successful auxiliary_device_init(),
the auxiliary_device_add() failure path should be cleaned up through
auxiliary_device_uninit(), which would eventually invoke the release
callback and free adev.

The leak I was trying to fix is only the auxiliary_device_init() failure
path, where the function returns directly before that cleanup path is
available.

Please let me know if I overlooked something.

Thanks,
Guangshuo

