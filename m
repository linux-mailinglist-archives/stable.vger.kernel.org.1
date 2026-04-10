Return-Path: <stable+bounces-235635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIwqA2MZ2WnfmAgAu9opvQ
	(envelope-from <stable+bounces-235635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:38:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A87A83D9754
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F64A3037930
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631A3DC4D7;
	Fri, 10 Apr 2026 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5qSdiRv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456363DA7EE
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835137; cv=none; b=WY3cvBwru9v7fTh25S79PFgnlLdDyUx7LR2/pdtPPXBGs8LpAgSR3h19028l2ste9/ppTmvms9tHvQheoe5WsQAPugVivSIAewXiBK8ympWzezeFFIsPp3Abh4agdUle7HTZlwQQUqGVriEnAWFmef2OjEdmpHwnGMzUiDXsJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835137; c=relaxed/simple;
	bh=JWL2FQ3oRbFaONkjSbrDXal+LKNFqAX1HKv5oapCmx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMc2boKX4S85Q2F3B8SLUvZG90u6EpzDMQF9+2eMniJ75/QRiRiZUw74kXj8/6hY/gqMWirvzJVJmZ6/+AkEEQBa4bSqE76f9j9nWpKjBpvrogt+WwHICPMML15oZeiQDk8abgkrUBMnj5DzdJBF9/Gzx5rOrpRToWgr5cqMtFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5qSdiRv; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c33bad4bbso165445c88.0
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835135; x=1776439935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URJQRIK4vwElyY+o0kjrCKyZ6daBmdsIlXjoaBfNo7w=;
        b=O5qSdiRvrksVHgWZGeqYQ2oZctIYQWnmKBe5Z+Q9Zb7teqFCDivOACyANaeE3ljMME
         sKM8QAg0wuudxcvt0+NnFm68gT6VQ+7gbh02VWNlzBxAoPWmKL76sJGxthKfIX5Ev6nJ
         n2es+mVx7lRYBkRNSt29gJVY5CXpOFhGqregfBnHoanZ/kAkvMto415yk1/GQIvl5aWd
         zg7Mn8bKZGz8fJc6ERDF06UusSEnMHmJ0ORJnmP8DNb3gS+qhNPuRTSy5k29bLCjorX2
         x02UGkJL/wQ9sl+i6I/4oM//meY6NLF60D5eel4k6yZtLcQcXzkQc7IIV30ByQ3S/gex
         S7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835135; x=1776439935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=URJQRIK4vwElyY+o0kjrCKyZ6daBmdsIlXjoaBfNo7w=;
        b=HHeY9+l4NHTybrxYH21KHL0xhU6PVVdnQrusWgmWhjCop2u7aIYYiWSXHZ22LxXCSl
         Wzb2xkfrRlOyqL1tpAIWEI+S+nB+99qtLDDDb5KLRDsARz0PR/Ka5Rk369Jf0Q2DCzJn
         qEJN1tIRmWlBSmKxp2R+Hfwsg38nn2/Nh1i+VKTPX6DncZMEPdpUJcq3Rb3QRqJcYAsv
         H92cIOr6sA857lIImk/odsClWjnNfuEJrYigHn7s/dBHYbFdazzRlxgKqbIaTBnYMYo3
         yWHyFddVgHyKny+WLSDGzm3XyNwmZ2BZlGMr2hBIWh8by0Ak9H1Nx5nI/e1Dkd5zVoJ+
         UYaA==
X-Forwarded-Encrypted: i=1; AJvYcCUyxhEY9NsPvuegn2+5Eay8tuIaHMh49Eo5DTQ35W51u8+GAGUhLMx7URUy8IpM3/SC+Ma3AAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGgNvocO2V6sv9tgpZ2RyYwwqD3pVD9seIkcXkempWu7HnjhA/
	xgGN/15LnLcO7pxEl7kYFSuGrRUPaCKpecE8lZlyPq0/UnsaCZbc31Kn
X-Gm-Gg: AeBDiesgOP/EJ0FLZK5l+bbE7NEQxwlN1IxVbMA6V3T1wh6LKi+YEYBpsRCtPfZhOtZ
	Z2ogHz4Bc8HqWUgE8WfmBxssDvPciHHSVs4Q0oB6f5vYjWLOHX9kXLLRNgNYlEouGyE5jhVoK2R
	Are39CreuCCUsYYMG/AgJCX6UOof5nrYcOeoU3QwpEFt90VdXVE41t0+zBvKi0Trxx6RXBo5rnk
	aSE61W1WfnnbbSykTIaDBnfRlQXEdr81gzf6ZvoOX1bjfl8kegSI3x84C84RHGWRBshEUDr0uoo
	srE63qTyZic6G5mT1imU4ucrbyUSqm8oms2XUTpe7YvILvvsJpdqEg8pP2mOMn117SioIvrZ+hs
	zi8dGOQ5B7vO6AakSBG06IbzFh9ohY+o1NqjTxFOS1eLq5OJikE62O+AJDeKzMbqFziwBw2O29C
	v2Juutx7NFaS+th1UFM/nZaHsG3B+HTLAwRtm+
X-Received: by 2002:a05:7022:662a:b0:128:e0dc:6428 with SMTP id a92af1059eb24-12c34ede980mr2287217c88.17.1775835135295;
        Fri, 10 Apr 2026 08:32:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34acb077sm3453956c88.6.2026.04.10.08.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:32:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 10 Apr 2026 08:32:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"mail@carsten-spiess.de" <mail@carsten-spiess.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] hwmon: (isl28022) Fix integer overflow in power
 calculation on 32-bit
Message-ID: <8d621efb-55aa-471e-9332-9c3c74a765a3@roeck-us.net>
References: <20260410002613.424557-1-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410002613.424557-1-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235635-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,juniper.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A87A83D9754
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 12:26:19AM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> isl28022_read_power() computes:
> 
>   *val = ((51200000L * ((long)data->gain)) /
>           (long)data->shunt) * (long)regval;
> 
> On 32-bit platforms, 'long' is 32 bits. With gain=8 and shunt=10000
> (the default configuration):
> 
>   (51200000 * 8) / 10000 = 40960
>   40960 * 65535 = 2,684,313,600
> 
> This exceeds LONG_MAX (2,147,483,647), resulting in signed integer
> overflow.
> 
> Additionally, dividing before multiplying by regval loses precision
> unnecessarily.
> 
> Use u64 arithmetic with div_u64() and multiply before dividing to
> retain precision. The intermediate product cannot overflow u64
> (worst case: 51200000 * 8 * 65535 = 26843136000000). Power is
> inherently non-negative, so unsigned types are the natural fit.
> Cap the result to LONG_MAX before returning it through the hwmon
> callback.
> 
> Fixes: 39671a14df4f2 ("hwmon: (isl28022) new driver for ISL28022 power monitor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

