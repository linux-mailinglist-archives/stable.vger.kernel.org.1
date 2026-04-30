Return-Path: <stable+bounces-242177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LrEBZSQ82ky5AEAu9opvQ
	(envelope-from <stable+bounces-242177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:25:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFE94A65AE
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49C9530277F7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9775E44D688;
	Thu, 30 Apr 2026 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq6yh5Vc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFF4611FF
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569856; cv=none; b=CQDt4LDubfMWIN+RcluYrrfZiMa+L7sZfw5ZcEYF8zRvw53fXWOXgdmy82/I9BlB1tRl6prG+xqNHNzddGqtoVqTrf8GDRAqbmtrr3dF6YcIJH2CrVNku/0v5YlDc+qnQQCHYNBUYED/Ti1NqGxJRJ4yJrSQKZxyrD+y9GGE5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569856; c=relaxed/simple;
	bh=5jnnMZbdE3Kv+HAQM2cpPpp5ffHMDfQm3jg7X/t7sQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsNq/ksvk8bwr9Ekg9utM4l48lcwPGqTss8j7wDkvF8kXoneRKZqEVvpgGs9N9yxC4/YeUZhqYENe/L17Kpn1fk7aKcQVUdnXN2StaRAa6UTAQcnvuY/w10WrCwLWSchfTAMhdRbtlpgPjjNUQkwyl5wKmsCH8GUSvqGMSam//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iq6yh5Vc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso457476a12.3
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777569855; x=1778174655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ss/d5BxGn+KBRcms2g4Npg2cD3lutl8/H/gA06wn6Do=;
        b=iq6yh5VceMggHL7Ixd93NOfkIyNrjqTSasDRXkjUPDf7+I/ZICxa+gEZkPx1U0B32d
         dDXpZdWybZkQI/J70kQZ+ypW+lmP/6KI/FUEPsblzf6Iy5EbZ4UdFvlBwsg4slmMdAs0
         kF6/oxdupwePL6FTd17O08vhd5tTBXLprT7ZMJYF+jNVLxhPkyEnL3LMHK40kSmXjTS7
         e9UWIKIMsWRmj34NFJN6Bi9paK8rAPPlDaUc3W+X5L2SZZgaZJ2Z3NJMepelY3/OtLBL
         SapByww1wfJdXtnllgd2z654qFguEmwza/jZXnWkpvbpnFI6rj7xLGZg2/JYr56GGDLN
         06rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569855; x=1778174655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ss/d5BxGn+KBRcms2g4Npg2cD3lutl8/H/gA06wn6Do=;
        b=CgZildjPbNqSsWym/KdepTJpBRyjjbPjr+rvlM9LDsSbBt6Jv+7Nzs7MQGf2HgCuOo
         mAI14b0Ye3dcqK4TR/8dhbMnVl5hTt5XaUFw0n4HglIvPV7DWMS6qvyQC8Vb+fnfsqRz
         68wu+GbgSVUgJQnTJVUp8smMgFfkUignguTmq8ILT/K83dCj33EBxG7i83T68uel18HK
         RgPJmXpQZkXgDhZ8WAxNl4Hbae/RR12lmr58hHIkVbkUwclMr+vCOA/2yT6im72vgZAS
         4nzik6Wl4pe2aGj7d5VK+r+M7DHObToAdkuCNP/BVrvgVGl0T8iDhIJHTAz+kOjLk9Xr
         zEbw==
X-Forwarded-Encrypted: i=1; AFNElJ+Wjc2QqEnCsT5sKo/ZqEZCi2JHsIeHou3ZVDn6KoOTDeJz+OTNDm7afX40ruA3HpjQo+xR2k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGt73OwuQC1TfC84eds/DmUWMJ3rNrb9m+AWN6MIMPp5gVK6R
	IoI8viy5E8CzmNYv1UzBQKFb6UqJ+V5VaIq1xnNbUo5DYU6xW3RGlVbp
X-Gm-Gg: AeBDievI3AwCK6lgh8VOyISbI7eExnfUKR+Fay7geF7FinuTKmCif8TQSlkl3iNUL31
	70WKMaQzQMbrZ3Voxtn9RJSfygOLP7k4RZ9fEqctjFnK4jYuNBgYdGWFpn4mQ0CacWqc9aDasn3
	guSMyZuI7yEAViQefoCSdqm7E9EceQ469vuraDqljneDPPeBxahgj+bU/LOBdQJQ895FcnqWGVP
	KX9LgZ/A2JSBWiIWF1vQr8btktqo7IlaskiLkf3llC1RZCXghzoOB+avzDYLJ1fpBvOdR78B2Xc
	5rrzybZtPxXQXsEdoYVihtP1W8JCCzsB0o/YzMdzJ3dhLUPWRtoS6x03L9iJiXPzQK8WXquqVdy
	skWYCpDVqaGpxHufSSKGpR2J6KtNhQwo2GCXLmo4lDw7cq+UGswJDdYUihmv+uR5HvpF1qCPrtN
	+GSUWPlhb1JjeWKfk2tCrJCaHlxjWvumOiFjAnrnc697XsWvA=
X-Received: by 2002:a05:6a20:3949:b0:39f:706d:62e3 with SMTP id adf61e73a8af0-3a3cf8d59c2mr4406073637.54.1777569854543;
        Thu, 30 Apr 2026 10:24:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc85c61sm211872a12.22.2026.04.30.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:24:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 30 Apr 2026 10:24:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"alexandru.tachici@analog.com" <alexandru.tachici@analog.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (ltc2992) Fix u32 overflow in power read path
Message-ID: <54523114-cb32-4351-8261-daa2c19070ca@roeck-us.net>
References: <20260416215904.101969-1-sanman.pradhan@hpe.com>
 <20260416215904.101969-3-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416215904.101969-3-sanman.pradhan@hpe.com>
X-Rspamd-Queue-Id: 6FFE94A65AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242177-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email,roeck-us.net:mid]

On Thu, Apr 16, 2026 at 09:59:40PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> ltc2992_get_power() computes the divisor for mul_u64_u32_div() as
> r_sense_uohm * 1000. This multiplication overflows u32 when
> r_sense_uohm exceeds about 4.29 ohms (4294967 micro-ohms), producing
> a truncated divisor and an incorrect power reading.
> 
> Cancel the factor of 1000 from both the numerator
> (VADC_UV_LSB * IADC_NANOV_LSB = 312500000) and the divisor
> (r_sense_uohm * 1000), giving (VADC_UV_LSB / 1000) * IADC_NANOV_LSB
> = 312500 as the numerator and plain r_sense_uohm as the divisor.
> The cancellation is exact because LTC2992_VADC_UV_LSB (25000) is
> divisible by 1000.
> 
> This is the read-path counterpart of the write-path fix applied in
> the preceding patch.
> 
> Fixes: b0bd407e94b03 ("hwmon: (ltc2992) Add support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

