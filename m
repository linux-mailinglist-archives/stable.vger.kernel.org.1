Return-Path: <stable+bounces-247316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0wpVJzmGBmockgIAu9opvQ
	(envelope-from <stable+bounces-247316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:34:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 488FA548BFB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 309CF301A2A1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 02:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8CA3BFAD1;
	Fri, 15 May 2026 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBfcVcQp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05112335575
	for <stable@vger.kernel.org>; Fri, 15 May 2026 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812471; cv=none; b=IuLRWfrMSiEn9FFS2jmvmpIGYim7uf6492OQQcxeHXI6gGib60mJ9FThdtw+D6Rg6oKFBE1SCevaGCuiHokGBWinRi1xVExaEa8Jkxa4WmTxfiDbINT7n+gQGgZaynauiTeA0Q9OkLVDod3eDpVGG4lvZZ5osM4gEfoECWwX+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812471; c=relaxed/simple;
	bh=kMYZOxEs5UEJno+m4KDusv2vSvrhW+tJcs1SclzzftU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDqAE4BODDA/a98pDLNOb4QUh1GQT9jzpdUk001xCpJeI+a58ilVFTKNw7OGRLStFFRN7q/sZZtIWKSf/rL1xQ1NQJKDYl3fW9JCWh5ukusqp+U6/k3l74keNyLXgsxs750UFhM9WRQmC7MyrZD0u5eRa01lYNKFhhZvca5kMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBfcVcQp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so45812a91.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 19:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778812469; x=1779417269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6aioJ/VruACcjnO0ZQq/BSwgMBliRL2boTCfWV1KhVA=;
        b=HBfcVcQpEbcGImRT99w1jXmmgM6/XjjcGqS0jFKT4ozVYVWAy9joU9wkaTaQB4dRjf
         7ozvD/+o6Kt5Rwc1C6TXikPrupawNrcB1Y7M7m7qEoHIVQFfYLOqsdzVxU+OdeHkup4q
         56hj/e/tZ5Gfm3sgxNvRoXzRBZ7DPeVTG6S9q6oCm2cNObK+cghxE+3muuLCtqMr4mdv
         EvhPPaP172AlP2qEU/xKXQRgqILSls99Q8EKzHGGVJpGhsUty+kEQp52hIU4r+wESwlj
         qqJ3qMoXxXtxrifjcGpDBlksH7uCXK78xk4SPXTNAJdKIwS13ghOX2JP/DQBapM2D1C7
         +nBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812469; x=1779417269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aioJ/VruACcjnO0ZQq/BSwgMBliRL2boTCfWV1KhVA=;
        b=f2Pn3MsdzEabSBdsys2U8YTVolvTd55HIYLmRoJODqhcWMhH2sSXgxhkXagSgHrmaF
         Ay3XM0Q5lmBPRwvoKWMxPAo9Fk16QIYAqA7qZw5GHCdnCRjRi6VW1YFtgjXbzTmB6kqb
         EnlcA55HTUdR5Qz7XvkAzGojaWttPXJthn17Zxk6ML8Rk933u1DHDXOYMi4nNgjDDLCp
         Sn+WdswEQkdFFhPP1Dq+eOiLpGcPtRe0TlrIqKfkvfrszEk0u7+7p9yRb4gnrFKYDvzL
         oYEx/QeSiMJojFQybiuwXGx4UNoVIqU8Wy5NJ70msKGSg2iGKXSJJ+f3ppT7DTpS2erS
         VpAw==
X-Forwarded-Encrypted: i=1; AFNElJ+NCR7nwYdcjkFC62rwt33rlcckF05CigoQFCo0MqCvXItFAsoKPBHOIeGHbX7/whLWn/aayss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZvrlnPq4VIeebOKlU245sQXWo3Wb0cE2GTbLakjFy5xW5EEfc
	Br5aSNnF/ZMX6RKpQAEuouqVK1P04aHe8A2oufJXYlOMAdgBDbhcBHQ2
X-Gm-Gg: Acq92OE73Vc2aCnvtiZn0SCouMQLQtqh8cxFRJrCup2N8mMQsKSh8iwXdFs+jtewiRw
	im7Docx0L6O6qvBrW8RMtmsbh2fs3J7R6KFiihq0ue3ZzLcnnuYF5EtL7sW59DeXuyj9nPCh3ly
	/0oFTIg7tzGDW9mcpWf+c2jSzfaaBJRpYcpMgEmMzQ0kFdkdbskqUZ5dX5VEf9L4PnQjRGonG8C
	OYVn8Uqto1oy0DNIU0H0DP6Gs6Pa7hFDBA/kivtDxfnpYun0wg7Bb50rAU6+QU6ZuYQaw0HGjPc
	0L1Zk3hJesOHdT3YhNhQWYFJc+82HZi7h/pf9OhAIX3+hDenF5DcZcVvxaaVbzsAyzUAJAQEHiR
	vs4TkkbzQRCFxlTZTHjH1OBZugc0e2gYk3UQfzJrikjsFg1b0GCJ7rHpVTFCAlYSLGLP/PMsuS3
	MyfC0q1RAmOSXYYs8324UwD4fedeM0zpqxtVoOFk0ovQ4=
X-Received: by 2002:a17:90b:33c4:b0:367:f9f1:af78 with SMTP id 98e67ed59e1d1-369519decbcmr1813546a91.7.1778812469198;
        Thu, 14 May 2026 19:34:29 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0f9155sm41812535ad.59.2026.05.14.19.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 19:34:28 -0700 (PDT)
Date: Fri, 15 May 2026 11:34:23 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kerneljasonxing@gmail.com, kuniyu@google.com,
	mhal@rbox.co, steffen.klassert@secunet.com, vakzz@zellic.io,
	ben@decadent.org.uk, herbert@gondor.apana.org.au,
	dsahern@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agaGL7AARVk2OdAT@v4bel>
References: <agToIEDI4TaTNLRb@v4bel>
 <agVpIsaSherjHTYg@sultan-box>
 <agWUdie1xBvBu22I@v4bel>
 <f747602d-8208-4b3a-9e16-78632ec7b919@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f747602d-8208-4b3a-9e16-78632ec7b919@linux.dev>
X-Rspamd-Queue-Id: 488FA548BFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247316-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kerneltoast.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,secunet.com,zellic.io,decadent.org.uk,gondor.apana.org.au,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 10:01:50AM +0800, Jiayuan Chen wrote:
> 
> On 5/14/26 5:23 PM, Hyunwoo Kim wrote:
> > On Wed, May 13, 2026 at 11:18:10PM -0700, Sultan Alsawaf wrote:
> > > On Thu, May 14, 2026 at 06:07:44AM +0900, Hyunwoo Kim wrote:
> > > > Changes in v2:
> > > > - Also propagate SHARED_FRAG in skb_shift()
> > > > - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
> > > Hi Hyunwoo,
> > > 
> > > I've been working on mitigating this vulnerability as a member of the kernel
> > > team at CIQ, a distro vendor. In particular, we wanted to make sure that there
> > > weren't any lingering places missing SHARED_FRAG propagation.
> > > 
> > > To that end, I used Claude to discover that skb_gro_receive() remained unpatched
> > > (as you pointed out in the v1 thread). And then I generated a PoC exploiting the
> > > vulnerable skb_gro_receive() path.
> > > 
> > > The PoC is a modified version of the original fragnesia PoC. It works 100% of
> > > the time, just like the original fragnesia PoC.
> > > 
> > > I have attached the PoC and a patch that fixes skb_gro_receive(). Please take a
> > > look at them.
> > > 
> > > Thanks,
> > > Sultan
> > Nice catch. Thank you.
> > 
> > After testing, I plan to merge your patch with v2 into a single patch (not a
> > series) and submit it as v3. I would appreciate it if you could then add an
> > appropriate credit tag of your own.
> 
> When sending v3, remember to rebase net tree first then generate the patch.
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=f84eca5817390257cef78013d0112481c503b4a3

Thanks for the heads-up. I'll send v4 shortly. See also:
https://lore.kernel.org/all/agZEC3YDCAhkrcvr@v4bel/

Will rebase onto netdev before sending.


Best regards,
Hyunwoo Kim

> 
> 
> Thanks
> 
> > Also, I would appreciate it if you could use AI to explore additional
> > propagation variant paths. From my own analysis, no further ones have been
> > identified.
> > 
> > 
> > Best regards,
> > Hyunwoo Kim
> > 
> > 
> 
> 

