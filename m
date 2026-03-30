Return-Path: <stable+bounces-231273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB30NnzbymkQAwYAu9opvQ
	(envelope-from <stable+bounces-231273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:22:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B6360EB7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72475302416B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4342BE7DC;
	Mon, 30 Mar 2026 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBiv6Bhq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038942C158A
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774902079; cv=none; b=O/2cpFT4MWuEErS7Hsz13keAkoivbzFyI6IVzBwzaRLYwjUNorbH2uEmk3lf+grj0A2BLRieDjaG0UHPIKs/bwJngl7N0oO7acPXquHaiiEAGTV6DUHtlAyiUGUVn1D8eu3FYbKK48IL9l6huFr4NpGgsjRuuEviwX3Y3v5QDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774902079; c=relaxed/simple;
	bh=KNdH9jfeaOOFlpTu7G90oWexxiY3M4YjurkZNCsIjMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fqy0PpoljmZHSI1LvxT97w4Tt3xASeIpANYXIc3wZDr1TjkZPT9hUUTPWDGnwD0HjbnpnSQU5XHgW07nzPY+UWpGF5K2X+N/fL4WT8u0lHmdb7Lhuz4B5ErZUFT1I0zsNbZeVHc2MLQe7ZvYvBZ/RNObbneyh0i/e4oe0mOlOyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBiv6Bhq; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so3950155eec.1
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774902077; x=1775506877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOukF9SDFQnuJqoAphZ1SypmYNAJ+5RMsItbeGF3neg=;
        b=IBiv6BhqoTLTWc+5SmGphs4tePK5eWElbZ/ylQmmHpe0enN/zKQwM5coUODYKz/SZK
         BfqB5QiNOOauQ8EGOrNzFh7/y1ivBeh9oXWRGWtxr6puv6PJqlEBpJkQrAmsMIDSyy3P
         QoZCv+sl6T9GByfu6ITSKSeFo94zzCkLsgjVe14gRDvmJuWrbRqeKtk1C9fXydENibLx
         j+dqe2ANqxUslr4GxYwMZanfvvlxWP2JCZmZSi3oiSQm6Hoi7K+LZtK67s/j138PqxOY
         GcWMIsiSip7zg585L07bVKoEZgqznd3VUTnuALatx2d4w3zGOAnGyZJyNTIE/Tzv+e6L
         lBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774902077; x=1775506877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hOukF9SDFQnuJqoAphZ1SypmYNAJ+5RMsItbeGF3neg=;
        b=qGZS6VpULaFxXGyrGDveaxJ4aAJ/jyiXT8IAmvCnblpKMC80b6D35FLW9HvJBl3gi2
         WrSPFJ9aGOXiIY3mwbaXOMEY/rvv2oOReJXLM7V2ikZ8dYl2JgRDNLl/Vdqm9b04oP7f
         e200Va8ivBBowXIEqxXV5imoZ68xbtRYo2Zqog1iYogMDmYeQd2TC/q1Obzstk7Kbme1
         svgnlpcl+e7vp9+oMb/D/CxHWaRcOH92GoyXGcl0XlWV78nAO74nXk9Jg2FvFJSN0G20
         fFtaVf+JWBW2hAQYaJdv7MzEtv3FSPWQJL3WOlt0LBd5K0jm+72xyOBQ3MialXYhNPn+
         aJmw==
X-Forwarded-Encrypted: i=1; AJvYcCXa2nBfx1cvBALm/3vJcmTjbLXWw+qk6Bo/owHVm250Fnq4IO5kVM4VOCj4wdooxkM59620X7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXCQ9LRlkouXvHKuHACK83fscLnWoj7mpeVIwiOAEETlUixoH
	qrdEgd+ixCorm+sM+M+fdJpMLXPM67fp7MTGhCp5msBW61QrHwgupgx80JK2Xg==
X-Gm-Gg: ATEYQzzg2mM+z3KPZbbC/TuqBIWBltVEVr539oOBQfpBBMC0fPJGoTlkTmMVcNs86VB
	BVOlL5qL6AdDnXsYrMNGVcY2sB/NSBr2cq0kMH84Giw2EqpD8eLGPU6fAskrrDlCK1UiVVrL981
	dIuK6dg+CJ50Yj1+fBr/4Cr/OGxJ8TWr7XfBE1LlTNJXH4rhVIcX9kdVw5La1BjAbG90p5007K2
	xl6wlXT3OhpKg9oWv/DW+g/fyj0CDmq8eBPFtSSywfEtKFeeLcncJ/w00W/9OjnylFKaLggc8n1
	jWTWiL5AbMSVPaBYfCK+iCflIAbulFUm3yl663TCpuaEp9P96NdWyYhxzgCR3dymR9ib2poAj1F
	suKVqmV6G7BF0secGEzUJ3Ux/KRnRTH10NCyrtGslJwFCBFtCNAhM0yczSoFdZzs1bwaqtJcxrT
	daQ/hjJU7A8Y8lPRpiljxrGRORQu0nAr11PsCK
X-Received: by 2002:a05:7300:6426:b0:2c7:31b2:44ad with SMTP id 5a478bee46e88-2c731b24c6dmr1699038eec.31.1774902076911;
        Mon, 30 Mar 2026 13:21:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b272esm7877309eec.15.2026.03.30.13.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:21:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 30 Mar 2026 13:21:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] hwmon: (occ) Fix division by zero in
 occ_show_power_1()
Message-ID: <49542ce4-7ce4-4476-8567-7717e862ae63@roeck-us.net>
References: <20260326224510.294619-1-sanman.pradhan@hpe.com>
 <20260326224510.294619-2-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326224510.294619-2-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231273-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: 344B6360EB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:45:23PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> In occ_show_power_1() case 1, the accumulator is divided by
> update_tag without checking for zero. If no samples have been
> collected yet (e.g. during early boot when the sensor block is
> included but hasn't been updated), update_tag is zero, causing
> a kernel divide-by-zero crash.
> 
> The 2019 fix in commit 211186cae14d ("hwmon: (occ) Fix division by
> zero issue") only addressed occ_get_powr_avg() used by
> occ_show_power_2() and occ_show_power_a0(). This separate code
> path in occ_show_power_1() was missed.
> 
> Fix this by reusing the existing occ_get_powr_avg() helper, which
> already handles the zero-sample case and uses mul_u64_u32_div()
> to multiply before dividing for better precision. Move the helper
> above occ_show_power_1() so it is visible at the call site.
> 
> Fixes: c10e753d43eb ("hwmon (occ): Add sensor types and versions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

