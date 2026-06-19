Return-Path: <stable+bounces-267320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /1RaOFvENGoPggYAu9opvQ
	(envelope-from <stable+bounces-267320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:23:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C93F6A3C92
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:23:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=VX0uJ8OJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267320-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267320-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B17D302A06A
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 04:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC552C3245;
	Fri, 19 Jun 2026 04:23:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1990263F5E
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:23:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781843021; cv=none; b=dz+ylHUXhXlOmKlLe3iF9hGZif+i3RjbVkj0xIxIdEUGrNKBmNn3ySParo0RCRDHTuXaV7dX/e21S00xo0aqMXBne50aJ3vQ5lfGlSDA9ys+7LH5dtTQ6QveLasWksEz5Rs1sbyPCvWDWHyh25WijGCLpLIpsRgXBeNnIJcLuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781843021; c=relaxed/simple;
	bh=/e265C6i/biTzzYyRJtb7JuyV49cEBHj3hfmUf6eN3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAfThfj+IYRH/38T1W3sJj4Ob46oFUT68tAvPWlalhVUpfR/aDWv03vQaA/aoA3lw1aXCP/l5vhu6+0SMkrubiuR2PQ8fMVnsDIRuhGEBZLuqa3JSr1GUpLaZUhtmWlwPpsxGznkVOW8caHeDTl6KRJRCxlYYL6a3l2sIoxEHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VX0uJ8OJ; arc=none smtp.client-ip=209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c07ea058c1aso216041566b.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 21:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781843018; x=1782447818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0soBiUkGzsvWXSaTMVs0Nu0PkgoN9UKZzGfSOEdsY8=;
        b=VX0uJ8OJBYuASLe1tCPTZxhGkfX3MOWb7zuhi/HSbyW3BFyanS0BX3FT+m6omLSGRt
         r9pWlKYmpKn9P9x+QqFK12+H+wpzaRMCM9n0lYcCGynXA+zY+PViiLzT/x3pXt+TeeJx
         UAxvEDl1o77Z+N/Wtz6kiQOJHOssPCUlYV6R6MlPdAN38vdeluo3DgH52wOKT4LDSq2a
         NJ7OSO2FL3jckDeCffRKzcHUZbBnjMoEP1bvQ9IWZY3QAnfngcEVJ+oM2PkyguMy7mnZ
         PgKB1l3PNzL1hhsJzlh0/pOmUtasxboWKFpBEZid57dpNzPcVCmZ5PD0vXZgVLIJ+CjZ
         EQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781843018; x=1782447818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0soBiUkGzsvWXSaTMVs0Nu0PkgoN9UKZzGfSOEdsY8=;
        b=Pi9sPFBIgr1sLgcHrBHomex1OUfxCU89P8I6eGsY+yewlBHYxXWS5hWS7OzEZNatjI
         B3MTA8iLal/kyzLwwIRFced4qWuzv5XSrmuNlEsV2CEoMr6kZl+34ZYzDdQRil1Li3Wz
         DaBy2cfOeTpIiN1OfEE6QqZw2rD9V0fjfAODy/qZv6q0lML0Gb2NwD8jeh091GG7JEf4
         QrUpm9xew6IVZxd4WqSB3oivc7m1ZR2mcj7bqFuFJZLTF1cvGnqYdQoqa6dbib8rJ2fJ
         0lAaXA4noRG6GlBOsiLUO1MH7fuM3PQUV+iEOTmjmv74pC3fMrnAyra10p1/Hfsc8glv
         p9Ng==
X-Gm-Message-State: AOJu0Yz4fbhO2GQQeCgll2WsIQCj5/TsHqDQNCPmB8++BmE/lvfKsmrZ
	N2vJ6UjGLnwvAmjMUPIFUS+b1LegWlZldcFBpl/2TMWWxetCiKfXiZ+ZsBbBbgQ6k8TY+BgRmKU
	h+j92yC5iHQ==
X-Gm-Gg: AfdE7cm2Nc4Gvt87ObpkAyWFkN6mlee+oWlXMsXNEJfDzWh0DekmEPl8J1gvdDXl8Ys
	7PMYRfwGCq7Fe/DNpNqlmoHsecO6YDxg9Aast9Sax3D64Z1lOhzBmsHotGJDqb6oV0KSBxGT0ZJ
	BuEPcF0/0tQ9NetQYWIGZJiZ/ibe94znBz+2fCCkQ7KM1M+Y7gV7QJeK58MaScVOB22Ad9NJOvD
	R06+vW2qBnnunIIYmRekw7MxawVyONWEUH2FcIRnqs3VMefp4Nrcrpykzb2dcCYZdzjqBvy2wvf
	iQgntFRwEqwHvUlj275h/WU0rMIdvV+GyJhyMuLRe4Gk0wVpcdPAfIpxadofE3clVjm+Nk3/CWb
	OKFoY9RCaWInMc+H2xefSaRRYBj3Ar4TZ8Bfcx/KCt/Czf/bhoKygN5kC/qQ6ozL+49Y5qqRMSp
	gdFWkRSG8Q4LtE2vQtq8ug56mc2K+m+YQhEJmeNgKI
X-Received: by 2002:a17:907:7b99:b0:bed:eb8b:d404 with SMTP id a640c23a62f3a-c097ae2db44mr85153266b.16.1781843018007;
        Thu, 18 Jun 2026 21:23:38 -0700 (PDT)
Received: from u94a (27-53-24-58.adsl.fetnet.net. [27.53.24.58])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0d8d471b5sm1081709eaf.8.2026.06.18.21.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:23:36 -0700 (PDT)
Date: Fri, 19 Jun 2026 12:23:29 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Ihor Solodrai <ihor.solodrai@pm.me>, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH stable 6.1 1/1] selftests/bpf: Check for timeout in
 perf_link test
Message-ID: <ajTEGXglAOmVhlir@u94a>
References: <20260618074114.16091-1-shung-hsi.yu@suse.com>
 <20260618-reply-item039-perflink-61@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-reply-item039-perflink-61@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267320-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:ihor.solodrai@pm.me,m:andrii@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C93F6A3C92

On Fri, Jun 19, 2026 at 12:07:08AM -0400, Sasha Levin wrote:
> > [PATCH stable 6.1 1/1] selftests/bpf: Check for timeout in perf_link
> > test
> 
> Thanks, but will this even build on 6.1? it depends on the get_time_ns()...

Oops, yes it is indeed failing. Will send v2. Sorry about this.

