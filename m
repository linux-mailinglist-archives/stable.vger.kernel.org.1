Return-Path: <stable+bounces-238294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNjZKzO14Gn5kwAAu9opvQ
	(envelope-from <stable+bounces-238294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:08:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E49C40CBB7
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A42EA301F29C
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B988B39DBE9;
	Thu, 16 Apr 2026 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+1Ofs8/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4539E16B
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334128; cv=pass; b=cGWQRGkCnrKekZO5UwVGZd3h8JwwgxUBNCF3bvIPBxeFFuJYlz+Q+z9suWSnqfF0S/kZUFuXyRx5csWulKhm5PFj0nFaXDIeYW8HBcKnpJOmPvlu8D3b67vV+ljIwFFwVySi0FjbqFyLQ7PSxEy71n2YTUriUTLtGAa9nuVzpOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334128; c=relaxed/simple;
	bh=zEB5HcHU9q0EcT9F6l3nHGl5sT13qq55hsj22g7GCPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYL1LkgHV/5VrC3Jdo+aQeSgiOagaZy/qLYTW3+pYH8WDMqxuYQoxWSTZaXX+KkVuppx+LzICrcR5+8WZ0dwgoUmfghxJLjRPTB62ZvKw5t0q7M7BUDJW2e9Y6HTSHYy4G1edtIywWwew0SlLE41vqTPy5RxQHaglVTC7+ZeRCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+1Ofs8/; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6501418152cso7470147d50.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 03:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776334125; cv=none;
        d=google.com; s=arc-20240605;
        b=WuUa2ro3l3HQyJvIf9L/KEevulhM4DyewgNU2AQOiw1sN30VgeY64HQoEBRtArg5zm
         qCfIWCJhdkohpR/i1dSRxHE2iKCy6PWMA0RKNBZGTbOiUCm+cK/yxafIi07pGpCjfiUn
         TOGxXtlGFJtcCqeVvfKIo1IO6jzF2IRFCRvyYKKVWgx5Y13DgzkHUTFhupu6zc2mMg8n
         D1nn5Ln7DVZjfaKmbTLtLO+ePMYXQDGp/6cglyjjK73kRrt6EI2eRNYY/C0w9BV95wGH
         dQNULmNN6S3QgRMX9vnMN3WmmMq6CA0jfCXpAOeQQ02yiUAA/XBcl3jOqGqhHbZhpJ55
         36LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZCa5TDSOTBDDHCBKmyirCxSkjy8N+uWnUPZoqRXfgUg=;
        fh=kCo/VDPudTSm4VJWGeg80+jJj260b+72cxfi88zRZU8=;
        b=fgn0GCgB8pZ9L9EjaaljPEA3WqrRu8zzqQJ1SdNcES4hQOFwFOVEr6sIJehAr42qKR
         hfwk66Rysa1wk98YAjFEyRHeOzeNOeurAKO71iSbUBqrjYnUcEu3I76ALbJitYgGbw1f
         qall0qfAYbRDu9a7vGp0djF5ae+jU17XocSlEBGz7HBARPUX0a6X7obh5L+VaE0FRVgD
         oFkN4X8HFnq8tmQzkGfWf5/CovkTPdlegBwoiCh1pJK/WnkF1plYhJ3tgCDNqoxnyn3p
         2IwuCfs/26lhM3cUeCAMlM9MgzcN8hW3214IurWKWipBaeS1+uLnfXDK1+GDUEajby4g
         tN4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776334125; x=1776938925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCa5TDSOTBDDHCBKmyirCxSkjy8N+uWnUPZoqRXfgUg=;
        b=n+1Ofs8/oteRxn7wC2E1uLVnUUFEVWIhS3kWGK79BmGPQedHpXrfYFIQuCY2H1DBJF
         BxBr2aG3iPt+ZyRyUc6Zjk/WZH/WonYh0wLF8rwOSBTaTjoo6WYlVHd6ehFEa9tS1WV9
         KjNmyhqT6G6PD1ekGGMi2sWCArfRUeEMIleknSBW2xXIacUrb2lDfgtzQUlKmFeh8WGC
         2W3CBWgxQzRGkK18cKIqcKn9eB4vHip/+rFocXGzecpCIxTb4tG+bc5YmtiuKxjIsj6n
         n0s6cwNzNP1GcRWWImA2cA0vl63LNef0dXYVt/O8SRuxQntHgGpwMuPezmX9TpoTXZM1
         hUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776334125; x=1776938925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCa5TDSOTBDDHCBKmyirCxSkjy8N+uWnUPZoqRXfgUg=;
        b=Kd/Fy6ZptUnmDMnUTVVLU86PNDfXdWY8gFaoJtT0/O9ED/XragSxJ9Ek9yaVZPL8hi
         UmtTTO9H4i6Q+QWYjSfyz+x/JSWCxA4KTCxqP0oMl7tmw1M04v/T/RSxTye5RL8vPcUP
         bWei9unTjITnDPROimTsKUHb456T5CzB71Dp6NIzlgzQ4oNAZIXSlrTn8GkDUH8YqJA0
         T0qobT4c4rv5Y7hcFM9Gnh/wKNQWsCOqmgxt9oS40Hic9NSxO8Y3es5BXMP9cNdPLtNA
         ovLtYy19fquo47ajpNA0OupM6Ng7xRN9IHNRYsWkxRH/yQN3g8c8uwMY8QhvlLF8MMPI
         OyZg==
X-Forwarded-Encrypted: i=1; AFNElJ9gCqXteT4qeBXKL6/G027cFauQ5MWM3Nc7rF9rQu+RpoGAMEv3Rq22+nuLuIOSHILBt/wM7Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+2MMkQ6aINPSa+uA9NOvqwNdXN0XzcYfk6zYzSfjv2abXALz
	IyELvMOr24ijv2TiTTpY1unEC5b/0vxukam98KeW/WECy82vhpI1xoPyOg0hENh1bdW+qZQ0sVl
	U7m7l6Z+Zwd/KiYFQU7erINjlQQ0HF3s=
X-Gm-Gg: AeBDiev17Y4dbNW6MDYeCdufNUA/2aNkiLBabhT9o5XpaM3pS06hKiO4wzRDxGVe+lt
	dO5fvYEDCrhr2ie0DGEMd/iMXMO+TI+w1P1e6fdd+llHTgLWuu35Y6YZcmq8JZcdXqJiAPYBFy/
	tRODX5wAs6g3f+AFZor7QdtOT4nVNtcxdv0NIf4gGGO2ouBFMWA6INzLGxT4svGJnmIEXTO9eQT
	svX8rOLoDVHn28rCV6hgIcpxPsynP1oQhVTekbYEa+KsBj22t9V2zBaqSPqjWKA6MIBm1vBZjIj
	DNuMihArDBmgXLudPQhd
X-Received: by 2002:a05:690e:4196:b0:651:9286:57a0 with SMTP id
 956f58d0204a3-651988599efmr20819218d50.0.1776334125288; Thu, 16 Apr 2026
 03:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414123857.3162673-1-lgs201920130244@gmail.com> <aeCp0Xe5G531vHBj@gondor.apana.org.au>
In-Reply-To: <aeCp0Xe5G531vHBj@gondor.apana.org.au>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 18:08:31 +0800
X-Gm-Features: AQROBzBlVonOYU68cO6MUquPGIUrZcJ7ZQ7pqMxalBF0GpuaTdoNNdTd60OFy44
Message-ID: <CANUHTR9zW=i8UxS=rNoHf-mcq09QyK3243yu6oOySuZqiwbvjQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: octeontx2: fix IRQ vector leak in otx2_cptpf_probe()
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Srujana Challa <schalla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	"David S. Miller" <davem@davemloft.net>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Kees Cook <kees@kernel.org>, Lukasz Bartosik <lbartosik@marvell.com>, 
	Suheil Chandran <schandran@marvell.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238294-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4E49C40CBB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Herbert,

Thanks for the review.

On Thu, 16 Apr 2026 at 17:20, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Good catch.  But what about the remove path, shouldn't the vectors
> be freed there as well?
>
> Thanks,
> --

I investigated this further after your comment and found that this
driver relies on the PCI managed cleanup associated with
pcim_enable_device(). In other words, the IRQ vectors allocated by
pci_alloc_irq_vectors() are already reclaimed through that path, so an
explicit pci_free_irq_vectors() is not needed in remove/error unwind
here.

So this patch is not needed. I'll drop it.

Thanks,
Guangshuo

