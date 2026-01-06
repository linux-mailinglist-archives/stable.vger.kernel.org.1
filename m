Return-Path: <stable+bounces-205072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B83FBCF8175
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 12:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2372302A973
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29B32721D;
	Tue,  6 Jan 2026 11:33:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97D31AABC
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699216; cv=none; b=FPHPErN1QFxHIPxtCcuJz78slDJcFllUcqG9rcuG9bWVkSQQIfm4VKxFVITR/7DCPJ0hgbH6mzn7gT2es/Ml6Vo/v9rPA6bLHde7VG4DNHP1oAZlm5J7gK6V81WnkzHqIyZSvavQyOrSsbi6u3g9y8HR9/KNEPztb50TWSN34q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699216; c=relaxed/simple;
	bh=A6LqIfDgKDeozuV1RCujGg1NJdi4mYw8+E40Sot9BoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZVQn0IBOJTqzqccYnXQdc8OupPo12pZJEaUQdDtXP88Ip9MTPzeXhqQsWpO7DzHxvpbw76rnbjC7fwaNi0JDgu+Kw2ReNzZsjF0PCGXfuiQblMcswlN7AiktihlO8MiPYKJSHsoH1O4WhNfg+x8Yu4+8zirkNcGZrFMuKaMRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-455af5758fdso579411b6e.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 03:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699213; x=1768304013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aY5FARf65kfsbdb7ftnB/uPYG4AgZz8PgCWDolIuCL0=;
        b=UuWEHBcdSsdo0HYty8J4BrSjYv+GGp5KErSUKfd1TC4XjASshOtW15D1yX6ZDZmRRu
         Ug5XFl3IT1JhDZ30S5upKxogzTqRUTkwQvk91REpuPvzBbLyFvpE4ixvcQvLGtfXJEIw
         xIWyX33pVSJsLzABaykzCAtmx7V1bPDaBt0srOxduIiXzduDqhSH82ugk+hxS4hiXJ1v
         UYHpVrWfatda+3AGo/zuH1YOxIXZMUBM+OODFW1xA923AjmnihwdZk5Y9UR9e3E4LMwf
         p44Quq7nV3ZOtVcP82D1vJGQ4xpVyz0UnxRj4D2zN57O4s4MX6Pie7FG3ipCamdsmI8B
         PD3g==
X-Forwarded-Encrypted: i=1; AJvYcCVNn6wgEkKnRnQQDcgvTwygMcX0T5hhPX5rtdfsrBOHrNn3T0nT1KSnslxLeKyHDCD599eLga8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jD7PIo5nQgNI7CWqla9KpRMaPRImlvXl5zmQbPv9lzdlQvFR
	efMH75oeeQF3fYG/LbEu1vUB5M8Mx7tIATbmV/XoM4YpEcDuNeuTxQCh
X-Gm-Gg: AY/fxX4KOTHxcI7MlW+AmpaqBRdI65lvKCNnGGuE/1nboLHdtyHcej2RDZbnJnpK9oF
	sZ28lvszseII1PAllpFxS1YsdM0S29PM78NocGjP/7qWMLcz+u2sBhZJOtU+0wYdKSlmqQwQ1tu
	TJwfqVTMIMD+MMluRRi8IhChaBjZSc8wQT3+jEfcYV3J51Tvyw1L81nPk2JhxHdi+QgDgSS1nWh
	xPgw/GUNGesnUKaty6cjQyqvQYLyPffFDGboqh07U/A1fpOhmSjLKwTpZeZhf0tVhKgM/0a/L4R
	p6I6UyhQCE+0LUlw++xA476XRkQKvOgq/vlXp9m2ne2eQlRnm25oOlwp8Iy4aToZcLwOFND1IsN
	y5YQTd4JscPt5wkJj4lrJD6PQwxM5UCqejhh+W3mjcQ/1qmmGoIkykXweoF3YnbvgPYdrm2idcC
	t9pt73tuknFEZOYdnT+RnMUYEd
X-Google-Smtp-Source: AGHT+IFKAjFYphYrDLHhk+T24gU/abKK3UAW6NHo0VX7fL8TrRcAZexjFpgP0TK8XjvR+rJnKRdFMQ==
X-Received: by 2002:a05:6808:bd4:b0:450:b7a0:41d3 with SMTP id 5614622812f47-45a5b1a49famr1581987b6e.67.1767699212842;
        Tue, 06 Jan 2026 03:33:32 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ede38sm1246486a34.26.2026.01.06.03.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:33:32 -0800 (PST)
Date: Tue, 6 Jan 2026 03:33:30 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in
 bnxt_ptp_enable during error cleanup
Message-ID: <eitjt4fn4kty35a7ilfuygdwrpbye2gaz3zu6uoposmtbk52ax@skrxzmvkz6p4>
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
 <20260105160458.5483a5ea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105160458.5483a5ea@kernel.org>

On Mon, Jan 05, 2026 at 04:04:58PM -0800, Jakub Kicinski wrote:
> On Mon, 05 Jan 2026 04:00:16 -0800 Breno Leitao wrote:
> >  init_err_pci_clean:
> >  	bnxt_hwrm_func_drv_unrgtr(bp);
> > +	bnxt_ptp_clear(bp);
> > +	kfree(bp->ptp_cfg);
> >  	bnxt_free_hwrm_resources(bp);
> >  	bnxt_hwmon_uninit(bp);
> >  	bnxt_ethtool_free(bp);
> > -	bnxt_ptp_clear(bp);
> > -	kfree(bp->ptp_cfg);
> >  	bp->ptp_cfg = NULL;
> 
> Is there a reason to leave clearing of the pointer behind?
> I don't see it mentioned in the commit msg..
> Checking previous discussion it sounds like Pavan asked for the
> clearing to also be moved.

no reason, just a mistake. I will update.

