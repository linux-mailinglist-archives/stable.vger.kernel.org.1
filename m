Return-Path: <stable+bounces-244540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GELEDrFc/GndOQAAu9opvQ
	(envelope-from <stable+bounces-244540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 11:34:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B504E6079
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 11:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA8ED30117F2
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712603C4547;
	Thu,  7 May 2026 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="UJ4ENShi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF773B5842
	for <stable@vger.kernel.org>; Thu,  7 May 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146460; cv=none; b=gYZUX6RARZ0wcSOp+MnQ3081o3ufU7ZgEhuCYSLxZNByFclhOUzQfneyAps/XEyK4KCRwBgDiuEU2H8NtSoVcEZhbjd9cLS5Bd0gfVz3M2XEN8dvfNaZJdzOu+2+vKZtntMA0/gp2sRUI3zFHd1TxXjl/dpGuMzEQZ6ICxdt54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146460; c=relaxed/simple;
	bh=SiL0I7BTqDmOrEYB/RwFyieTxl0aty4XtD8WXRHHt7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWMVn8OiapLuvY0v/Owz1a/lgxn2fYfuUS+jOuZwZPvHIKKVPA9E7sv30sSpSe4rC0GiLofqTagIJDTb1Xw46E0JDGzSWitvrBrQNFrg9nmIq2RFSCeBq+/qbcJrxhkpYfQBTGnvvv3/lUjcvVZ4JXMmdMlp0WIraZ/Li0rwjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=UJ4ENShi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44c350a5b87so384746f8f.3
        for <stable@vger.kernel.org>; Thu, 07 May 2026 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1778146457; x=1778751257; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0RDPZxyyoA+nLVJX1tOhu7GRz/OpeQnLIvnlbEm9kx4=;
        b=UJ4ENShiWepzea3FlvSbyVzkrxv06OS9rK195BomMZJaYNxNPMVdIPKql8eg8tyMYM
         kfb0+VCzq+YZqC1FbDpCc5nwHABPrK4p9Sjc4oiaxEn6ehyovW11UxYlU9hBZdiqrQAu
         JXNy2bbCM9b2Q89RDFEL+pz9Hp5r0zOU3HF+qHFgSH4o4Qy7S/cS8Nv1pwDkVdPqaR7q
         RVoLoJph4XG9HBvebMI19zuhTawA0WQ7YdMtnAzBsL2xLTyFfQflSRB/D7nG8SF+c8R9
         XEvNCGk1qCFdv4aT3H+zGN90jsUZb9v2UfxKMBd5pOD1tt68SpAUmdDG88po5IsRpsbp
         susA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146457; x=1778751257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RDPZxyyoA+nLVJX1tOhu7GRz/OpeQnLIvnlbEm9kx4=;
        b=YlFJnfwGNukrRzj9TL8oP0MJiNNCVELBJg1Nx9OgotpmUj1KnPFnYvadu/tHmKrFru
         qZc3chEtYN0G/dtugTu/36lQCZwrJBMgFcw3HiYsDqADtnqZmIMfuGQWv4heZ7g8pcPQ
         9pF70qZD0nVPOSIYHeNpNITCOmiH2Esz8JVdUWCxXA9oHANYi6duziRprlpD+3viI72A
         ocd+cEhe3SykhblOFcvhZ+Zr2ThY0rwwaLKVDlOs9+zll6LVig3wyXOxHMnK/U55L4sk
         8pLWq/Wh9JzfUm8KOCeWj3Z2Wb7Ch2RbMZZMt5pxstWUur6Qo+/I7t2awrzyhldC8wuP
         tLvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8a8tODhQ0MjNjOVIxnu5ST+1ArBIbcH1ZGgIF7UDDrR94xp2xZiFTuxfwuVG52pbHThsKOYAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tJmjvKuhOnhLKcUhLMIoqnsRy9z0R7VavxQa814pYKBdql0/
	tnYPaHAb7e0+xQHyOCw1nYZQZ3UKvqaVPyisnWLDIs1uEn4vY/+/GJNXgNlMgrYEsIQ=
X-Gm-Gg: AeBDievjxf9cshlrP92B31KA3DHMvajccr/ToPtc5LVZYI/5j+ZXyULkxsZPMM0r8qa
	8nNGYv19W36EFxZ6Fv3oX5cSDZvnsp0Umjs0H/idmBkDcIUQQCf/0Vr6bIXP0rkqSvSovLDPCJp
	CSLbeSpbZHl0lyPuPCZfdtN2vtLLnHHe39Rinx3Br3ikm9GOoKpJUBqj0qGcxBYwjwg1tPszK75
	TXDqdSXcu2AgF9YGHIqcGRKY1ZTfScf9UI4N78yuCrT11RpK8qEZxleZF0PnA8f4EQZAUhK+gZB
	N2h4rHjM0gLZxiU1jI6sjq/GIZThzmJ06Th3/QSZZgC8KZ6/JqupJfimSBMv70bd2WnYPc6sou0
	eCvTIFt9ACiQCxnPTPvsQr60Xc0l1wyL5fMh6v8gKpzJs5wqWl/OJAoUmauzalN/1zWDvAo7MFT
	T8PUWSNhmsf/Jownm5jO/j
X-Received: by 2002:a05:6000:2c0c:b0:43d:7e11:1b72 with SMTP id ffacd0b85a97d-4515a6c32dfmr11386364f8f.9.1778146456983;
        Thu, 07 May 2026 02:34:16 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:294b::41d:50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e7c0sm17157280f8f.3.2026.05.07.02.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:34:16 -0700 (PDT)
Date: Thu, 7 May 2026 10:34:15 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>, stable@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Joyner <eric.joyner@intel.com>, Paul Greenwalt <paul.greenwalt@intel.com>, 
	Alice Michael <alice.michael@intel.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Fix missing 1's complement
 negation in GCS raw checksum
Message-ID: <afxbZjldi1OC3HmS@matt-Precision-5490>
References: <20260501095717.1032151-1-matt@readmodwrite.com>
 <531aec13-c33f-4e77-ab48-de8861f9b6c6@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <531aec13-c33f-4e77-ab48-de8861f9b6c6@intel.com>
X-Rspamd-Queue-Id: C9B504E6079
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244540-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,readmodwrite-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 05:10:23PM -0700, Jacob Keller wrote:
> 
> Hi,
> 
> Based on your patch description, I assume that you've tested this on
> real hardware.
> 
> I dug a little through some of our internal changes history and sawe
> that it looks like the hardware has a register setting in its
> GL_RDPU_CNTRL register which determines whether the checksum value
> reported is inverted or not. In E830 hardware, it is supposed to be off
> (i.e. the checksum value reported already matches the expected setting.
> 
> Perhaps your device somehow got the GL_RDPU_CNTRL register set to the
> wrong mode and that results in the swap being necessary. Hmm.
> 
> I'll ask the team to see if they can confirm this behavior.

Hi Jake,

Thanks for digging into this.

I read GL_RDPU_CNTRL on our affected E830 and the value is the same on
both ports of the NIC:

  0000:c1:00.0: GL_RDPU_CNTRL = 0x0020a275
  0000:c1:00.1: GL_RDPU_CNTRL = 0x0020a275

Decoding bit 22 (E830_GL_RDPU_CNTRL_CHECKSUM_COMPLETE_INV) gives 0,
i.e. the hardware is supposedly in "not inverted" mode, which matches
the default you described.

However, looking at the data on the wire I see:

  - netdev_rx_csum_fault fires ~65 000 times/sec on this host.
  - bpftrace at fexit:ice_process_skb_fields shows skb->csum =
    swab16(raw_csum) directly (no negation), e.g. raw_csum=0xfb4f
    -> skb->csum=0x4ffb.
  - At fentry:__skb_checksum_complete the upper 16 bits of skb->csum
    are 0xFFFF on every TCP/UDP packet -- the signature of nf_ip_checksum
    adding the pseudo-header to a value that was the un-negated raw_csum.
  - fold2(skb->csum_at_fentry + skb_checksum(skb,0,len,0)) ≈ 0xFFFF
    for every packet, which means the two values are ones-complement
    complements of each other, i.e. the driver stored S where the
    stack expects ~S.

Negating the checksum makes the failures go away.

Thanks,
Matt

