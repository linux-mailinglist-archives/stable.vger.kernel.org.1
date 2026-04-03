Return-Path: <stable+bounces-233180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPLcDuypz2noywYAu9opvQ
	(envelope-from <stable+bounces-233180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:52:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94327393D11
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6339E3028B0E
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 11:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB67238C2DE;
	Fri,  3 Apr 2026 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="odx/KUTp"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8B1D5160
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217072; cv=none; b=N+4nEnjaHhG6DM1Sav5mTl0SuvYA/iqsyIRAC6v8bsHudfRZlKQdKckq8btQmND6dVzPKZ1dmtuWIMTzo6ssHdejqkOCMexPInl2nnQXrj3ASwj1180J7kADuNby6m21FmQpCbpGd/jDzm26QqrWbb3258bulXipfdrYYLQoQEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217072; c=relaxed/simple;
	bh=PtVXxQMu1XCqLQE3Ta/Rr+nOPLfeF/uyX7a+P5rUXjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6CgMYqLjiOz+tyQEi6tG1NaHjB26gu9w63LLW1y5WZSwamuckjkZ8vV3JRpVXSmLTAUwnmx6jraHWoHA5L8mG8Et76GdtAu/MBmDx4e00X1JN28IhTg2cjeiISLg77OmKw7FZFZuzJP1C7G2CTn0l5UqQW8ec/Y6CaQm0gq7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=odx/KUTp; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40974bf7781so2513540fac.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775217069; x=1775821869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZ/fEHoV5W/nGzj71vUwg8RTluJd/NuseGmKhwyWzDg=;
        b=odx/KUTp0FPvB0hCdmo/VSHY2/+3NSZzZ3mrpvLYSjxsxBaqMS6BbL/qvgQdCiAeyw
         aEZrw9D+fY/3iU4JYQ49KPQz9cUPx33ZBI9DODWk3uCiyCtwz8t25dpKZR3/2ERdCSrV
         LhmY/hW+2aytfqtDaEo1PCQowWB+sr8KGdkwU6yZq0pddn1mFPSnleoTfLeLPiMetaMp
         HJu8RE9KEW6WzjAv4dGLI69rmsWhmJy2wpDUEMCXeRhszCAssVVKS7g46MsgqsThjWq9
         k94Sy4vn6hqi9q4RRRtsn4eZXXJo+rPcB1/X8p6B99h7Jm9BHCjdL3uUME9HvS1X10fY
         sliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775217069; x=1775821869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZ/fEHoV5W/nGzj71vUwg8RTluJd/NuseGmKhwyWzDg=;
        b=IHc1SeeABpvrAkc3t7Sgq90H4uFqNLCBFmAmq9iUNA0lctACEwSOaspqTGeGW2lbyu
         zyCUc13Ys/a+MRPxs9Ij9QdhZfD0CfgWE49btsfEt/wKMrSf5v6nwtDqpcRbLN1/SpnS
         5tnk7UNJQeHvVDbE/Mwv0UWgC6BT1I4xyty54NBr8wkNUctTeTVMXh2h96mtUk1s7U2Z
         FuEptQaGlP9i/ocoU1wBunNKKbHPRr5ozrNZqBwyqGYknBUXsI1wFjlEN0oNJZ/73ZhZ
         bzFOuf1XHU1B3pQ4aoxw9EsuAF5JbDfzP4JFJrYravSSrmEl++82AtEbZdANoQ0dW7Vk
         HSXg==
X-Gm-Message-State: AOJu0Yx/PjtfERf/i4Ri0As7+tro8HO/Q7WIrKlVEzHiigGBbil9PEyY
	CyshcMqswozl6EhJlmNwDeRk0xszDz6Gga6B7C3/tvEv00OVnF36gBE4ObHjLdaxgAnw9M4VD7L
	t5DRH
X-Gm-Gg: ATEYQzyDByOvWCfWHaTrl2cr0iSvM/srrsgNUUbj/gwMr6VnlKKhiGRbnW9pcnUuq0E
	oIK6uZwqSQdfAm51/DF0Tw0YctOlXyQrCoc0N6icyMWL+esLuSmUgd3HLjnk4VlIMMBz+5N2/RD
	QrJSIX6Msz/qcKGeK6wDwLRhJXBdEKwfPA4Xtc9txDg9+yQrDIIY6dCtwvERcg8D4/0EIzkhCAh
	YtTgnn+5B7rZjZuxbJ1nZTicI1F8bL4iUZitjI+Esod0M2HUWgPPM0NCo8UhrfbS+VpVX7AZDeK
	GGA3j7d3/i2MLR1T4WTYrzDRjPOncyHfT2io6PS6+sYJ8y4C6AvNFL/p+HyEzQbyTy8uIW2j6/G
	McR5EijSTiPD2ZeNsPmi3H5/ue7kBqOG/x0Fa/uRVclB+gjgMGwmHXdAbW2ahgpav9Ym71gMB0f
	aSliHrZ2NdDeFf0HyJpUMy869qSSfMWwyzd+nqR0ECGoeBHl1YWUT2u1daipgwDIdH2JDtOWg2u
	Fv0TEJbFw==
X-Received: by 2002:a05:6870:506b:b0:417:6f:9679 with SMTP id 586e51a60fabf-422f37e1b4cmr2969417fac.19.1775217069361;
        Fri, 03 Apr 2026 04:51:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaed47easm4841032fac.4.2026.04.03.04.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 04:51:08 -0700 (PDT)
Message-ID: <58056f1e-fa49-49c0-8688-da6f11e492d7@kernel.dk>
Date: Fri, 3 Apr 2026 05:51:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.12-stable series inclusion
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
References: <493b91ff-32f2-48fc-88e4-0e9f7dd645d8@kernel.dk>
 <2026040344-payee-uncut-9696@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026040344-payee-uncut-9696@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233180-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 94327393D11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 5:47 AM, Greg Kroah-Hartman wrote:
> On Fri, Apr 03, 2026 at 05:28:01AM -0600, Jens Axboe wrote:
>> Hi,
>>
>> 6.18 change how ring selected buffers are handled for io_uring, in an
>> attempt to harden that feature. It'd be nice to have this in 6.12 as
>> well, as it's a long term release. The actual hardening series isn't
>> that large, 12 patches, but it depends on a previous smaller series as
>> well. On top of these two series are a few kbuf related fixes that
>> either ended up in mainline as fixes the former two series, or just
>> fixes that haven't been backported to 6.12-stable yet.
>>
>> Apologize for the big series, but it's always better to keep the stable
>> bases closer to current upstream than it is to diverge them and end up
>> with different bugs in -stable than in upstream.
>>
>> On top of that, this actually kills a lot more code than it adds, which
>> is always a good thing!
>>
>>  8 files changed, 290 insertions(+), 379 deletions(-)
>>
>> Please apply, thanks.
> 
> All now queued up, thanks!

That was quick, thanks Greg!

-- 
Jens Axboe


