Return-Path: <stable+bounces-245052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN6UJNq6AGoAMAEAu9opvQ
	(envelope-from <stable+bounces-245052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:05:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75164505463
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89AC030054F4
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4A13A1E72;
	Sun, 10 May 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCKSS2ss"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056B3B27FC
	for <stable@vger.kernel.org>; Sun, 10 May 2026 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432725; cv=none; b=A0oQ6pY6xRBcFagb/RM+0LSVaE+kiymNKEi/3n/Cu2Uja2P1BLsL2YW4B4csZzIcnJxtnWlr/XzFzhAcSLvQ6FuFhrsL2CMSLIotErhCerI3yUjJNR0y79sTvLIgV5omTnkmxRI56o0Z1kIrssnkc3l+TtncNp9o9GWFkzl8840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432725; c=relaxed/simple;
	bh=njvUjJYapm4Evggff9XsbWKk1pd6mVJCB4SLimX+gPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4fRgzdAKaQzWVo2IjdVMUBxuo1giNXDGaXIrL2vPcu+vnF/I3nH7VKp05oRnngPXATMLj0I9HwvHkSpSJi4lX71hLr1qSdOE66AJEalze23kQtDJ3t/Ks+ffaHbu03k/SU+VME6CakLTYTlTDrrSsOS3CH0U2Vi6/ynMa2hc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCKSS2ss; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367c26471f5so952021a91.1
        for <stable@vger.kernel.org>; Sun, 10 May 2026 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778432723; x=1779037523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rt7DZxBgxaqgF3EaEv3GbAdygrDAfwMu6OaO3VKjDZM=;
        b=DCKSS2ssq6fExUr1i4GUtPTyD5DDOv3gAVHNaLOShmpx2cL8briDTWV+qvgv/0c4yl
         GPVKxkwT71oA8uJ2eBLNCHNsTUjNefcMZVvow2q5SB8VLq5LU90LCqvW02mTfFp1W6ha
         GT1yNdX6dLVubE0Aj9KzaClK9afbKYlgdmZuLsE9ItVKaWD6cmFaEncPhUuSJhMwx8Y9
         CW+Xvn6MWVlK/7sr/FzkrUoxzITcsVnwts6UNOxgD8xQ62ComAXn34WZZVc2poNLNAxT
         KaEVuNyH1sAAugF/H7EbGPUQXVXMHm4pr6Ka3P4jCZE+SwU7B06e3MaKqGYnppCE61Eo
         ikJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778432723; x=1779037523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt7DZxBgxaqgF3EaEv3GbAdygrDAfwMu6OaO3VKjDZM=;
        b=VUeQ90DMuNxpa/lG8bGAFh0I9LgTDvn+DX92uJJhwOtZ9c965BpuHOtmf/d+Vxr+gm
         vJfWmQUBWwKO3KECCFhRJ0ym5QGRaH5u/Tk79F3X3kGCa0fJkGKOTs6/kA+qSkRTwyl6
         mwzoS45ngSsuHKBJRMw2O5p86awMHY3v4PHGj1JH65Gb/jND+FiZi/K1253mkQHwBJIr
         ahNbJzWmUHIlA4gnMF+FRfTeMFB9+BvgCxepxxA23M+HKxYlE8SJ66m6kgDGtGF181Ny
         KiVtzLC/OB3eegByONLtuwwGNxnjjiJAW98Ud9hRcyYJxtpt6Mg0spZxD+kz+XjUpapg
         rL3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9iDWZtLF+XCYA2ujOdSuM7PRecnAWLAJEkdW+pci/hBZaTEyJFu6JkhE+UvaCV76Cq9MWRYbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffylFyNsk1yvdqE7jgVVhTLVUWLw6gBAlKKMGTMnLG8hLTEJt
	OLMxxb/SBussZdPr/qarXULOyjCDiRGn1MT8NIGomN4f8tJuEStnFUIx
X-Gm-Gg: Acq92OFZkeFB6Z/9EZGYNBUEg71bU8Hfql8kBk82Xwu1bzH8p6VLo2S7/FxXPdcH+F9
	Pf5JTgqUgWh4MqojHA3GJqXIM2Yjlt0hvKAZlnDN7Pj4v4fs47Iq7601h/tMfaZMh7aNgcOFu3o
	NxsIXSLT39KcDHa5XTZLKUTvgFdnGrUFIsBpSB9oWSrMqG4sZKswv45VOhosKW5oLMxg4TwPj+j
	xTRq3/89+d/AOs8JLcjszXuJblZ+HFmKksNiABZj945cZARukvuUBYr0yPPjpeQ2WOrbsLNOiNv
	ayd3gUHEQrXvCKtnFrWQNB6lAf0Wh4WB1cYtZBmTqcaRAsv3ICIKHQpTIe8ggTkYDjv+ziLYpnS
	obJIo3UbIwYJRe+FPh8zaJMtLiI2nit6rk2s+qHXaQyoQidqQ72LDTDakMoqDBG+A9ZGXwZPAUm
	GZXHu+cUtaJveU+PavWHQL5P8QaDuaj2N2f7MS6v3m4yuqOC7o+c47fA==
X-Received: by 2002:a17:90b:3bc8:b0:35f:b3fe:18dc with SMTP id 98e67ed59e1d1-365ac47ab2fmr21925302a91.19.1778432723423;
        Sun, 10 May 2026 10:05:23 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d625f126sm5653554a91.3.2026.05.10.10.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 10:05:23 -0700 (PDT)
Date: Mon, 11 May 2026 02:05:19 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
Message-ID: <agC6z1FeEN6jMjyk@v4bel>
References: <af2kdW2F1gJ9U-Gg@v4bel>
 <20260510084520.476745b5@kernel.org>
 <agC256wVYa4Gnvy1@v4bel>
 <20260510100310.230b15ed@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510100310.230b15ed@kernel.org>
X-Rspamd-Queue-Id: 75164505463
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245052-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,linux.dev,lists.infradead.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 10:03:10AM -0700, Jakub Kicinski wrote:
> On Mon, 11 May 2026 01:48:39 +0900 Hyunwoo Kim wrote:
> > On Sun, May 10, 2026 at 08:45:20AM -0700, Jakub Kicinski wrote:
> > > On Fri, 8 May 2026 17:53:09 +0900 Hyunwoo Kim wrote:  
> > > >  			    sp->hdr.securityIndex != 0 &&
> > > > -			    skb_cloned(skb)) {
> > > > +			    (skb_cloned(skb) ||
> > > > +			     skb_has_frag_list(skb) ||
> > > > +			     skb_has_shared_frag(skb))) {  
> > > 
> > > We seem to be getting a lot of fixes for this issue, and this one is
> > > incorrect :| Writing to _any_ frags is incorrect. You have to copy
> > > if skb is not linear. skb_ensure_writable()  
> > 
> > I was testing a patch based on skb_ensure_writable() but it seems v3
> > has just been merged to mainline...
> > 
> > What would be the best way to proceed?
> 
> Depends on the tree. Where was it merged?

That's the torvalds tree:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71

