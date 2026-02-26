Return-Path: <stable+bounces-219742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDHmKhKkn2lfdAQAu9opvQ
	(envelope-from <stable+bounces-219742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:38:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C3419FDE7
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6ADE4300A643
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 01:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9654B36F42C;
	Thu, 26 Feb 2026 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OLQNozUT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6222A4E9;
	Thu, 26 Feb 2026 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069899; cv=none; b=P1/KjAg1XDPGndRAkDF93PDkVp7WbqWUTxZPI91Q5brQ0J4CsE1TKYeEKXTM30C6XcEDw3ahihXyPjylMjsVN4zqYXQaz5y7mKMfmTUTsZqw6pigp+T3m/ut5lK/BvQr26ZPHnXqOZa62xdpxWLNmkzw6678wDKlGNJTfip9184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069899; c=relaxed/simple;
	bh=eoBtqfiCcTvPh8JuPuhuSDJFW//KmTf+hr21rg56gl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F41udy1N1GmfYtSiwh2fS9p2djRtHvZytJAY+kcGG8ukCKjggFVnDPVQ/f9nTFpeiOeIKPlNiBWTZ8Ibzr4JvMHg8rOwr2rcMaqgOn50NpA8Szo9pdMLlLU7crq808jpp76nEvIGt0uTAHI4tvuUrpIC2dxFRIQZIgQ6XbIFj6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OLQNozUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53C3C116D0;
	Thu, 26 Feb 2026 01:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772069898;
	bh=eoBtqfiCcTvPh8JuPuhuSDJFW//KmTf+hr21rg56gl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLQNozUTaCptxXJdDhdheU8m29InXke5A7E2SfpRxWGcnEODYca6Iej68mG+oys2s
	 cQpZ1iNm9QygG/vsWxu3jEnxWrV2tatjzLuiFzh6JhL0oH3nAK/1iRW8e8G72iusLi
	 68prDQoKrY7ylNz4xE0r5zfjTjPNNkBOSoUvJBdk=
Date: Wed, 25 Feb 2026 17:38:11 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] uio: uio_pci_generic_sva: fix double free of
 devm_kzalloc() memory
Message-ID: <2026022555-improper-fanatic-cd10@gregkh>
References: <20260226011632.4186353-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226011632.4186353-1-lgs201920130244@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219742-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D7C3419FDE7
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:16:32AM +0800, Guangshuo Li wrote:
> uio_pci_sva allocates struct uio_pci_sva_dev with devm_kzalloc() in
> probe(), but then calls kfree(udev) both on the probe() error path
> (label out_free) and again in remove().
> 
> Because devm_kzalloc() allocations are devres-managed and are freed
> automatically when the device is detached (including after a failing
> probe() and during driver unbind), the explicit kfree() can lead to a
> double free.
> 
> If probe() fails after devm_kzalloc(), the error path frees udev and
> devres cleanup will free it again when the core unwinds the partially
> bound device.  On normal driver removal, remove() frees udev and devres
> will free it again when the device is detached.
> 
> Fix by removing the manual kfree() calls and dropping the now-unused
> label.
> 
> Fixes: 3397c3cd859a2 ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - Add changelog below the --- line describing changes since v2.
> 
> v2:
>   - Reflow commit message to keep lines within 75 characters.

You forgot my question of "how was this found and tested"?

thanks,

greg k-h

