Return-Path: <stable+bounces-245377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLsPID6LAmrbuAEAu9opvQ
	(envelope-from <stable+bounces-245377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:06:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EADB6518AA3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8AE301C6D5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181192DF6F4;
	Tue, 12 May 2026 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="G9uwIhOK"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78611A680C
	for <stable@vger.kernel.org>; Tue, 12 May 2026 02:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551593; cv=none; b=NQhUZon8ycg5hys6JwTme3XGgE2aHYlVd4dV0v2KYHR6eNiFEHdo2ZiZ7VLqizUs1sq3HG6kFlzDGpBQeOo4PoJYNm13a0avw/S1hk7bdokYoAsvGOOiJCCaK6ScJ1kA2KNrzYbRs7p+78GGY/7xQD1gFneVNBQdg4ecOLkpqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551593; c=relaxed/simple;
	bh=CyoGjvNuCe5EBO9A5hfw4zEkooMUyzvJg0x1KpM/Yi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nztdLISft1XwMifRNPscD61gV68sYsQWXRu2QW9Vs/1u91UlLKmJU+2L+ox8QStNbPqAiPMvridJZ0hjV16YtgfvFS5X/QJ+WH3CGGYBrwip6iJe7LTk1I42Jdc3tRD1v4s32HOScsadn3W2LFsSMe5Qg66bJvpJXLVhbhDi9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=G9uwIhOK; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40427db1300so3779281fac.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 19:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778551590; x=1779156390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKAHwtd0x8foxJCKVHcHld6f1A4a8Lh+4dJCYOpSgkY=;
        b=G9uwIhOK+9IlWo+Uo51e9ZxfwDGiRpfr25Zr6v/reLlv2LGx+g6C39YlUlRJ9mJuuG
         Xr6P4j2BUzt431m0dlHCPca9WFe7ZpPpiteLxB1EuUJGgyRKw8wT9Zw4SJZzEhqwXSgB
         cjCJAEQyZAt5ZCD8GOPP6dBYEZXhD01zpB0keuskJqn+qRJWUEdrKO8QK99SL8Klycjk
         sq/SQPA32K5xlCXwkKVtcn4vUE5gLZdAerq45aFGcmDIZrsJuvpqq3cME7fpOcSBcPVZ
         WAwuIau3vhp4KQ9tShfrGKm8rgH4+08tMGYSOawi25kRmQ2iwxqgxVcpV/OHukjIkvLl
         bXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551590; x=1779156390;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKAHwtd0x8foxJCKVHcHld6f1A4a8Lh+4dJCYOpSgkY=;
        b=s6JxoGyUKKT1JjAlXqH3jPxOIjc81t9mvqzn5DL4s/UeHpFiVX7tUnMpEy6RS6tVpz
         pnS+p+c9DFq0wVslyvpBhNYBMcqfDAj2x9LR9VGFWymesn9rBU09k24mLMsvpVddmsoH
         hNC3/hiPv4eUfQJF4cgvmj62p5ToRiU9lWRRHu2ry/+WZnSXdbzupiCKZ9KyP5KRQkLh
         5orZlGhgqdcq+057m52VNmqdMMKH7gwKR89FcuzIprTW1OKuxdjXxxFj0M2e4lZWRqzo
         fHsjRK1It93qgFyj8fRPkDaMLPsGODGHFvuHkXqJIXG+iTwn1pFX4f9RJ3/Uu05mNkgh
         0WDA==
X-Gm-Message-State: AOJu0YzuKEkS70BOIJQ2ZsKm4Dg1nQusUCXiBxqZ/vIHIVCkHhwgIBLT
	yauPr00Tmpg1g04UuYqHt8oe2iTBGq6EPb/h8ifKkDzdg8DtJgh9QrHpY3K+tUKzl2k=
X-Gm-Gg: Acq92OESGOFB1u01O5KM+q3gM+6M/ve++eq894/IN1GMPjEGG9/2GG9s/I1XU+ebdAO
	3drKZgd4ZBVVtXyhe1F/9h11s40cwtwijtCqQ8iHhAD+bhq7zxD8JXr09aa8Eui4cPmUTGTfY3p
	42IPTPAPuUl8SxwkapEacg2NkoHiqf9zPKLxZhS9oiMrpm5MuLywjJXL2hCTUYCN35PKbOBoRFl
	+OzPKDikm5bepx5H0jU1Q7QdWitIXtUPs8VRQyYRIWBDckubhAU+75iq3Kn/omo0NC8/9sIc6rg
	3WkMgM/VGywp7Oq4Y1zYNtNPMrLlGoWiwD0z/rur4p9XFmgkj4BDGHZZq+EPq+HnN97mr3928e8
	NBojsxDKxBNvCYhsHwwE0dvEJaFzxSKRPdWmH1QCSGUCtx1LI7S/nfakIN5FycN4Fzmr1N1zuD/
	xaShmGtQ37Z8rinLu4caagRk4a8PlUZkeEv3/lQm97ayZr5Zy+t/SArlAWe5jzaPnqsrKNME2ua
	XsHn0voS8/k
X-Received: by 2002:a05:6820:300d:b0:69b:3a56:9289 with SMTP id 006d021491bc7-69b3a5692d3mr4635736eaf.38.1778551590144;
        Mon, 11 May 2026 19:06:30 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25dc00acsm6619642eaf.10.2026.05.11.19.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:06:29 -0700 (PDT)
Date: Mon, 11 May 2026 21:06:25 -0500
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Li Xiao <252270051@hdu.edu.cn>
Subject: Re: [PATCH 5.10.y v3 1/4] Fix error in IPMI SSIF shutdown
Message-ID: <agKLIbEljHVcGp3w@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260511132012.1831026-1-corey@minyard.net>
 <20260511220000.stable-reply-item006-510@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511220000.stable-reply-item006-510@kernel.org>
X-Rspamd-Queue-Id: EADB6518AA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245377-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,minyard.net:replyto,minyard.net:dkim,mail.minyard.net:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 08:17:56PM -0400, Sasha Levin wrote:
> On Mon, May 11, 2026 at 08:19:38AM -0500, Corey Minyard wrote:
> > This is a backport of 75c486cb1bca ("ipmi:ssif: Clean up kthread on
> > errors") and other necessary patches with it.
> >
> > Version 3: Include a8aebe93a493 ("ipmi:ssif: NULL thread on error")
> > in the patch set.
> 
> Queued all four for 5.10 too, thanks.

Thanks for getting this in.

-corey

> 
> -- 
> Thanks,
> Sasha

