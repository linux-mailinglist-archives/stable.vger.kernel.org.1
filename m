Return-Path: <stable+bounces-231059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ga4M8BCymky7AUAu9opvQ
	(envelope-from <stable+bounces-231059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:30:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45068358370
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E0A302658E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72193A7F72;
	Mon, 30 Mar 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nBLVtwTg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB520B22;
	Mon, 30 Mar 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862547; cv=none; b=AeeWQpqloFUS1hDQ6nHF/hebJ/5L5EH2nG//vOBqGj7jOu8jzhiodGiBTI3ZyoL+4ZzltbBQ+0MfdeM0TsuD6OYvzskWmtoJvaploNsZ2e/ublF3Xgpp0D9YaSJOmncNhf+WUO58DB5WCt/1Ykmr5k7Cn/OM98nDiKMOolnE0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862547; c=relaxed/simple;
	bh=ugbjI7yTKQFUFYEMKehwp32e0x62z8HVVFegB17j+3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlHKjVWcFXrucdvxYA0dKT6rVs3AGSCbMR8TP7Ap0xD4rhL5M7z3S4ZOiGYn+67Relr4xkKa1ehRwdIX7LqG9w8HpFtg2S2Zx4npbNXHRMmyP2E7XkuR8EpU/T6MrLxA6HRkDxdctYKkdXTou/rF5OAVeV90R8ZkahGv6b+5QAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nBLVtwTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6621C4CEF7;
	Mon, 30 Mar 2026 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774862547;
	bh=ugbjI7yTKQFUFYEMKehwp32e0x62z8HVVFegB17j+3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBLVtwTg+Mk+pAq2Y/1V3mqP6HfPsDkTaR/sgPx57cTlqsEUX5TpiMVY/uc/OjB+q
	 A11XxMu28JYrvNLV1teSZ0tArgCVTau0ixrRz70CNyCIIs2EXEe6eBBO9WtH8WffRA
	 xCZYKkcs3mcAGaC439B0sqDgXoyoRUrgheq6V5DY=
Date: Mon, 30 Mar 2026 11:22:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	stable-commits@vger.kernel.org
Subject: Re: Patch "KVM: arm64: Discard PC update state on vcpu reset" has
 been added to the 5.15-stable tree
Message-ID: <2026033051-fidelity-outdated-3211@gregkh>
References: <2026032918-porthole-overshoot-bef3@gregkh>
 <86bjg54t2j.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bjg54t2j.wl-maz@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231059-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 45068358370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 09:31:16AM +0100, Marc Zyngier wrote:
> On Sun, 29 Mar 2026 13:48:18 +0100,
> <gregkh@linuxfoundation.org> wrote:
> > 
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     KVM: arm64: Discard PC update state on vcpu reset
> > 
> > to the 5.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      kvm-arm64-discard-pc-update-state-on-vcpu-reset.patch
> > and it can be found in the queue-5.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This won't even compile, as the helpers required were only added in
> 6.0.

Ah, then the "Fixes:" tag was wrong here :(

> Please drop this from 5.10 and 5.15 stable branches.

Will do, thanks!

greg k-h

