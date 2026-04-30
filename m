Return-Path: <stable+bounces-242173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEiZAlOQ82lJ5AEAu9opvQ
	(envelope-from <stable+bounces-242173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:24:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D54A6545
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A943037DFF
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9A47278A;
	Thu, 30 Apr 2026 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yol647O1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAB407572
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569787; cv=none; b=AAtVmg7qrLrTrfCI46H4FQXmh6Vcb7wr/+kD3mzEuan4WGtJ/Ufs6KuOK0mfwe9vMhC/Vq+eV13i6ksD2RJqXrg/jxIKqNcMAU57CJ9jiMbGk0P8DkDy+AU54AOy6DguExm8RMMJorewPQgdCxv/UYxSkhreXvwpdvTjVdoB4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569787; c=relaxed/simple;
	bh=zFB/iOZ19wQjJXG0nzOV7p8jbdcKKyA1ghYwzJk8F+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcnmHdKPd6HI5aoQ9L3c64HdRUzezNrPyc8p8rGeoOhu0064NoxfldOn8M/qETEzlrRte8TGdHN2q4sSHVDKx+0pTCExtHKbyxAiSkmDTxxsd/+5D9eLPF8lzpq9gXBDoeKVoIGtH0SaiX88fn/ezTGr468iqpiKzAJjd1Tu3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yol647O1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso7825785ad.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777569785; x=1778174585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Fsgwp7UDQpeyb+JW2HoyU5IVU1CSyJAoqsfmKXtsW4=;
        b=Yol647O1gjCVwM1TL8PUeaplA4PMzJPBh/m3pjGDVmR6O6kS9bJMnmZgCmBOilEv5q
         9dXmTTdCFN/T8D4/HjAZkYlrK5BxgTxc/Eda9ZRFlhcI9mJYH69o8vaOfHYz+2iaV1TW
         lg9Fpw1JoQFv2Jpk9Ln1x8cboeAUIUODre1GVwGRhPYX3Yn6o0PpDcpBie7n/J/4cy7+
         PzgfOvlS05EesG22ra80vXy2765o8v1KUS0eghlHuhTmjz+F1f1oOuGKdHDj4Ui3p+bB
         kDHSCHr8lcdEEv8snxp0PPrMQ05hFt8979N+Qs6eiLtay2nVXINxMSDidtfS9XPwMUL0
         xdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569785; x=1778174585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Fsgwp7UDQpeyb+JW2HoyU5IVU1CSyJAoqsfmKXtsW4=;
        b=ZzGh1xXRkp8tV/Z81XB6Hd/39FMDAwCgpGWSia7o2iJb+ihH26Iu/DoPcs/hANi9ao
         epn5NZPjAMBsaA9Dq7K4TWsNRzkPgnajvGtQI1Nx1JvIO3p/LpTvnAMFjAZj7ZQVbn1v
         XWY/ONr0dFDvniYy3sBVQSJVOSMMkx4ik8YGSrW14BrpxxYMmrIFw7NmcZpK+cS8kZqm
         vu01YA/aE2z1BRDqjov0OHRve/3N8sLhCSU40sOHkoKM6TgLBvpf9xZv/XW880wt7lCS
         acRfO9lJXA2SyEr2jxoYQcIHhrfFdfzltRP+wlc+ZqhBtGWZU/3uR63/IFyfZ+7haPFz
         WFoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KuhTrccrxPpH7Smte5Pa+L7AJoxf50RgSe+IrN8S0H0hszUlNIeGBH+rc+3mV6bBehr9kLfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzipcXvM5paWUDDHvz0jy3yBuC9qdsCZ8SWV/79RO49G3h7XsP
	cCU7dnB1tI3+MZqhqKgTfSRGRRdku9+nc4pf11+EIZj9jnZmyyjsoaZN
X-Gm-Gg: AeBDieswz4Gs24Ch25+BwfCQACesquxatyduJjYjQWEeN43TM/Vjk7JYQyrpc8MvGMr
	xkVHA9F7nnTRCKJAnLQP+P7gZfsk/RViBF73v0zh1lqmmHCsHav/I+a8DTY4zw7aCvy3mxIrbAY
	KIVyn3CP60IbzOUj1dkk3CBVazXN4wVN4keJWXSelwc3gcscFmEGd/YZq9po0RoP8D5kaA+swWw
	XMo7rNOv6YkDHPkMZgnDgd2et/WMckeGjD/95p2SEek7NZNQw5hu7zbH5Mnl8BbfgrLwkW1wkRv
	X9xO7ESNK/tj8NFgBibUhp7bWGIZPMUTCjV6sREH+1ujd9g/OvLZOJr//gdw4BFSkfLFJZuCa5X
	+oyUOMtB7YTrsr8oyB+Aa2/AqCdHVh+QB/2oDpr68jfdeMK5o0AVUyIViRvlOVcGeodokAc3w5K
	V7hBCSK7Rb+HQimbyp9qvYNMShbqdGK2dFEqza2G2/UQ6x0LQ=
X-Received: by 2002:a17:903:5cf:b0:2b0:7225:d2c0 with SMTP id d9443c01a7336-2b9a2504c12mr24809985ad.30.1777569785201;
        Thu, 30 Apr 2026 10:23:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e47asm1984265ad.15.2026.04.30.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:23:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 30 Apr 2026 10:23:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"alexandru.tachici@analog.com" <alexandru.tachici@analog.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] hwmon: (ltc2992) Clamp threshold writes to hardware
 range
Message-ID: <693bf2bf-55ee-4985-b8d6-344d358e933b@roeck-us.net>
References: <20260416215904.101969-1-sanman.pradhan@hpe.com>
 <20260416215904.101969-2-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416215904.101969-2-sanman.pradhan@hpe.com>
X-Rspamd-Queue-Id: 4E7D54A6545
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242173-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid,juniper.net:email]

On Thu, Apr 16, 2026 at 09:59:30PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> ltc2992_set_voltage(), ltc2992_set_current(), and ltc2992_set_power()
> do not validate the user-supplied value before converting it to a
> register value. This can result in:
> 
> 1. Negative input values wrapping to large positive register values.
>    For power, the negative long is implicitly cast to u64 in
>    mul_u64_u32_div(), producing an incorrect value. For voltage and
>    current, the negative converted value wraps when passed to
>    ltc2992_write_reg() as a u32.
> 
> 2. Intermediate arithmetic exceeding the range representable in u64 on
>    64-bit platforms. In ltc2992_set_voltage(), (u64)val * 1000 can
>    exceed U64_MAX when val is a large positive long. In
>    ltc2992_set_current(), (u64)val * r_sense_uohm can overflow
>    similarly. In ltc2992_set_power(), the computed value may not fit
>    in u64.
> 
> 3. Register values exceeding the hardware field width. Voltage and
>    current threshold registers are 12-bit (stored left-justified in
>    16 bits), and power threshold registers are 24-bit. Without
>    clamping, bits above the field width are truncated in
>    ltc2992_write_reg().
> 
> Fix by clamping negative values to zero, clamping positive values to
> the rounded hardware-representable maximum (the value returned by the
> read path for a full-scale register) to prevent intermediate overflow,
> and clamping the converted register value to the hardware field width
> before writing. The existing conversion formula and rounding behavior
> are preserved.
> 
> In the power write path, cancel the factor of 1000 from both the
> numerator (r_sense_uohm * 1000) and the denominator
> (VADC_UV_LSB * IADC_NANOV_LSB) to also eliminate a u32 overflow of
> r_sense_uohm * 1000 when r_sense_uohm exceeds about 4.29 ohms.
> 
> Fixes: b0bd407e94b03 ("hwmon: (ltc2992) Add support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

