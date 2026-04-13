Return-Path: <stable+bounces-236997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APryK/0e3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-236997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2693EFFC5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94D523015FEF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6892D8364;
	Mon, 13 Apr 2026 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFPF3tFg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="smAY3nfw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31CC280CFB
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098324; cv=none; b=lhkHmWMGUDgz44ec+C17WBO9bRIE+RNEz57JfhzTd2SS09zR6rrW02tktgscEAqvESSRSBTRERpAvF0bKI8p+7bb62SBKQw4/oWtcc0EHQGWG9mZnzySstULtfTSZ1di38SfH0DZH0BUow79GUtbHDZHXNmcv6EgARoX0Y33tcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098324; c=relaxed/simple;
	bh=hrzx/dvbEJpnRQ0vhxEwjvSnC2pT23xrRo3AuEIFtfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpDjyit5t94rPcpYCdyE7nJgcCWQfmuMNNxy9b12p88KySYAKbqGUrDUqblERSoq/mpvqwVUawKaZU4LjghpcPaYg4VZeaUKkJBILGhfQwhgqbfsv7wNEdW8njcth1y0bos8bEkhubnb3RasFYmvwehOhj8usE4LeyZFxL3rJ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFPF3tFg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=smAY3nfw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776098321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwH/TKeUG4gKy0pVdjPrCTUeZNlRp2XeMAZFKzWMR4U=;
	b=hFPF3tFgRu5zWc+cYc2gcx66GXATuM+8pZ1L+VIobvEFCqX33Ybpf44wjHqjau/jkovtvC
	Oi6xNF8TYLFd8DLISyNqHDYDd52XK0TLuPgfar88Ro/NB5qJmz/PI9B3Ao7aq5QY9JEEmv
	xtRj6DaYP4/aFhH0SKhYW9RSoWwS7NM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-mnKmG8BDP5CSPWQZ6Cm4uA-1; Mon, 13 Apr 2026 12:38:40 -0400
X-MC-Unique: mnKmG8BDP5CSPWQZ6Cm4uA-1
X-Mimecast-MFC-AGG-ID: mnKmG8BDP5CSPWQZ6Cm4uA_1776098320
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b220c72bbso103438161cf.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776098320; x=1776703120; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwH/TKeUG4gKy0pVdjPrCTUeZNlRp2XeMAZFKzWMR4U=;
        b=smAY3nfw2AD8a99Ogc4+G623bOzDNm2v4s051JZpUeOVsG3ms8jmxhKr7L24LM8WI/
         e+WMg06FNq+0qqP0sgLxHKn/TwrtbZfhcXKp32HaAKrabeSpSDPDzQ2bmnOVztf1QUX2
         Z+FC3K3OaJRIJJYajUVor+bLxzW4AUIHA/zp84BSh5evh3kePL60uqLBLAFaxAxo8c2u
         Mndh2JSR+Uq994hlqWFb0keR72CS1BX47fP3mPq8yr/QM5OXQAQO/ADyoWj5YKuzQ86b
         xqR1ExfKuFaoF1xbK0BIdFCMb8unJSfZg4FJ+i1Qy+ygJHMKPaOz3R3zCdsKqLipZzI2
         m8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776098320; x=1776703120;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MwH/TKeUG4gKy0pVdjPrCTUeZNlRp2XeMAZFKzWMR4U=;
        b=WnQP4fvG6LsV8CvnmyALcIe5gCyjD3E6tLx1Zr+sPkMxEsYITCTgGgaZfENx+AgXAh
         2ShUH1UelV3Hi/4MwVoaRrdhdtRit9oDcOhZGdDPe1SxhPu1Q8PnWZtqcc6ryv4iDjnZ
         H4F9YKjRpZidCKl40SnMdnZtHy2OyBQQ/CT7fsM0TDVfFHyIm43wdn9nijZqAiGbL5P1
         Kf7OhKED6qJvwd3LYpdAPqS3nMowplwTMTpBAjotxPsrupitBc1cMhpugqcDma7iu1C1
         N9S11YnIUeQoS9YwwEONIu8yhWGY1uS0AqL55wIR3hfAlajIO/8AZZOX1Tsp3NKjE8l2
         k2Pg==
X-Forwarded-Encrypted: i=1; AFNElJ/1ghZzofc8uinXei8jwTMBzOLE8LPZxlhOwK5IrhHb5wjEO+JzgvuEn06S0963rB78HH8rUno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNW0t3JqVwBc+/W1Eu1m1RO/tArONkTZic0rGXfkD/HG3Y6bx9
	4JOWj9+71ZMb1FpTmA8M7DgGOTijAzgeuAYvuppjibr9n0DighY35eLaJhiYbmgJdJiJWBJJhXy
	rclxPy1SCkq5oATQ+lTOCTwW/d0yFFXs5sbXuz9u2fycB40b1o/DYTpCDTnsI4ILJhQ==
X-Gm-Gg: AeBDies2WPSSqtWcG+QhcPRuo8rd8dBLSmhgYHKW93MaOAd3a67xuEoCD9PPv8oh3os
	uXfSpiYXFmSseed3xFFCGxKXQdV2X3ZS444ct2toQuPHKM5uzZZ7JFKNcialk+DXOxAXk/I80NT
	BOsyW0mX8yeH72HIF6Z+ZZYXB7g2axW/5jDHiaETQLm7Hb+4E8NvdDr1Y+6VqFuGsbu6Sli2YO3
	3yCVO23NYBEMrb/cankCwDya2MLE5WiFnzUrJcaZyaQA8QvtpcwcC+4jdRv5ZKigIHNRJZE9bOZ
	roktISW2wh8t5236+omTG6CrgbEc1YYsPg/4QgvjWbMoREzX/Xn7WZbysaqOtGQ01w2qS0q2IGt
	bO3OVQMY1AabB3mRX/FGpiukMQbVARFHrC32rNXBp9dicL9sawVr0NP79
X-Received: by 2002:a05:622a:19a9:b0:509:4198:5468 with SMTP id d75a77b69052e-50dd5b104d2mr213512481cf.8.1776098319822;
        Mon, 13 Apr 2026 09:38:39 -0700 (PDT)
X-Received: by 2002:a05:622a:19a9:b0:509:4198:5468 with SMTP id d75a77b69052e-50dd5b104d2mr213511921cf.8.1776098319324;
        Mon, 13 Apr 2026 09:38:39 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd54fcaa4sm87789731cf.20.2026.04.13.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:38:38 -0700 (PDT)
Date: Mon, 13 Apr 2026 12:38:37 -0400
From: Brian Masney <bmasney@redhat.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] clk: starfive: jh7110: fix memory leak in
 jh7110_reset_controller_register() error path
Message-ID: <ad0cDbXWfSlTaXQX@redhat.com>
References: <20260412125450.2509092-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412125450.2509092-1-lgs201920130244@gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-236997-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA2693EFFC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Guangshuo,

On Sun, Apr 12, 2026 at 08:54:50PM +0800, Guangshuo Li wrote:
> jh7110_reset_controller_register() allocates a jh71x0_reset_adev with
> kzalloc() before calling auxiliary_device_init().
> 
> When auxiliary_device_init() returns an error, the function exits
> without freeing rdev. Since the release callback is only expected to
> handle cleanup after successful initialization, rdev should be freed
> explicitly in this path.
> 
> Add the missing kfree(rdev) before returning from the
> auxiliary_device_init() error path.
> 
> Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/clk/starfive/clk-starfive-jh7110-sys.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> index 52833d4241c5..55cd0ccbdb84 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -360,8 +360,10 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>  	adev->id = adev_id;
>  
>  	ret = auxiliary_device_init(adev);
> -	if (ret)
> +	if (ret) {
> +		kfree(rdev);
>  		return ret;
> +	}
>  
>  	ret = auxiliary_device_add(adev);
>  	if (ret) {

There's actually another leak in the error path for
auxiliary_device_add(). I think this code should be
converted to devm_kzalloc().

There is no devm_kzalloc_obj() yet, however according to [1] that should
be coming soon.

[1] https://lore.kernel.org/lkml/20260330154108.GA3389518@killaraus.ideasonboard.com/

Brian


