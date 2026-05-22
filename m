Return-Path: <stable+bounces-253737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF+RKUkqEGpQUQYAu9opvQ
	(envelope-from <stable+bounces-253737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:04:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0415B1A5F
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90369301BCE2
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C13C76A2;
	Fri, 22 May 2026 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iBdlznk4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED83C73D7;
	Fri, 22 May 2026 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444217; cv=none; b=K/xuXar28t3YEcdu2qIswuoR0OxI5MnASOlSiIMNzB7A1TgDKj/EcdzUIRk1Y5Fsr/2QXCgkKaTNKTq9mhuyD9IPgfteynLWLKxO6bpUEL77lPPwpKK6pudPGGZ1sC8G2Kx7DmlHdJZkfCG/15ceM3mUz6tCEcCgyP0GexcGVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444217; c=relaxed/simple;
	bh=fRg+8cZEWAdCeT7xONOsJiiolaiSDVjOIDJM6RZhA80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep0Kxcc9gvn0tunEnCc+bc9yz7xPjD9pZNuKkDzkRMpoN+fKqhWKgiDjl51qFDDAzCObxHwbaoVNMfOCjfTgUbumQstZP932+CeQ89SpSOiAGR/ZE4FFDoOGvSe/aLIK4YYIN+QfVKQeJlk1oeaZ6/E/urlnSYYErnlIye5ghFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iBdlznk4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F1D1F00A3D;
	Fri, 22 May 2026 10:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779444216;
	bh=6oHe71iCXa1hzHpNL7hlH6xbBi9/7T08BideWZR/Huk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iBdlznk4mn3/cev9fOxBtayMs2TT0sj6C/+rP/CtkmrCg1l0hYiao8PJj6RJDTkPy
	 ompcLqjvG4HGXyN6YizSVcwBfJaq/zQOqrWU8s81gpcd9D37vMkftQoKALBONgfOL3
	 PhzN+E6OfPXX+3GUHrDRpNDwdTMm6QHy75Jrcu3E=
Date: Fri, 22 May 2026 12:03:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] uio: fix IRQ vector leak on probe failure and remove
Message-ID: <2026052229-overspend-preoccupy-2f6f@gregkh>
References: <20260416155443.3949056-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416155443.3949056-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253737-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.947];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: AE0415B1A5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 11:54:43PM +0800, Guangshuo Li wrote:
> probe() allocates MSI/MSI-X vectors with pci_alloc_irq_vectors(), but
> neither the error path nor remove() releases them with
> pci_free_irq_vectors().
> 
> Unlike drivers using pcim_enable_device(), this driver uses
> pci_enable_device(), so the IRQ vectors are not managed automatically
> and must be freed explicitly.
> 
> Add pci_free_irq_vectors() to the probe error path after successful
> vector allocation and to remove(). The issue was identified by a
> static analysis tool I developed.
> 
> Fixes: 3397c3cd859a ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/uio/uio_pci_generic_sva.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
> index 4a46acd994a8..ea531f9a164c 100644
> --- a/drivers/uio/uio_pci_generic_sva.c
> +++ b/drivers/uio/uio_pci_generic_sva.c
> @@ -62,7 +62,7 @@ static int uio_pci_sva_release(struct uio_info *info, struct inode *inode)
>  static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct uio_pci_sva_dev *udev;
> -	int ret, i, irq = 0;
> +	int ret, i, irq = 0, have_irq_vectors = 0;

have_irq_vectors should be a bool.

