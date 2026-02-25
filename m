Return-Path: <stable+bounces-219629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL7wDH0En2mZYgQAu9opvQ
	(envelope-from <stable+bounces-219629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:17:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E633198977
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BC5A305D2B0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2861D3C1970;
	Wed, 25 Feb 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bic4zeMd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532834E769;
	Wed, 25 Feb 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029017; cv=none; b=En43EljuSM+n30iJVvV3rMcF4mCWFCieSVI3hBNNPh6vRHZgqwHfC37PJbI+deMZCaSF8MgOetVAgIFb6YchqXf++n1Er3qqNb2Tw078GaUWVjOUdYTzheDUnY20yQDhHDtY6z2xkdkeTYzS1vXg+rWxbxgdU8bHlGy6TOksybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029017; c=relaxed/simple;
	bh=Cn/P13jzPyGCU7lYYVNN1npFey8dA1wOd1XPu1CYI6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYMGzzY0BmNGzRh1F5PugWLG8L1cPMER+n9UnD+sVU9Zhklxaqy7wfYqMweWs4Z7hZ/Fd8TuWvLe1L3H6TLx3lAndHSHXdCuw2R4nvNrSOfQitns9mAx7fG93hLE0qdgM4WZrMgYPO8GKZBgmdwKFZVzENEffAahTWL8WHqV6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bic4zeMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E075C116D0;
	Wed, 25 Feb 2026 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772029017;
	bh=Cn/P13jzPyGCU7lYYVNN1npFey8dA1wOd1XPu1CYI6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bic4zeMdQgeYUrRSTMLjo+IXkkSWqxItxTz4ZqpkVtWhGA0j4jkqeoWnfjZXNrwKF
	 C0B9w4btbefSLfibhMgqXTAQcI8r40nDw8tvLPturbHzET8LLqSIo2zc0ZgxwxkmCr
	 aHhllnFIOnt2lFfTPDs/4ohPvSwA/CPuyU2/a/2U=
Date: Wed, 25 Feb 2026 06:16:50 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] uio: uio_pci_generic_sva: fix double free of
 devm_kzalloc() memory
Message-ID: <2026022502-buckshot-unlovable-35a6@gregkh>
References: <20260225132737.4176605-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225132737.4176605-1-lgs201920130244@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219629-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9E633198977
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:27:36PM +0800, Guangshuo Li wrote:
> uio_pci_sva allocates struct uio_pci_sva_dev with devm_kzalloc() in probe(), but then calls kfree(udev) both on the probe() error path (label out_free) and again in remove().
> Because devm_kzalloc() allocations are devres-managed and are freed automatically when the device is detached, which also happens after a failing probe() and during driver unbind, the explicit kfree() can result in a double free. If probe() fails after devm_kzalloc(), the error path kfree(udev) frees the object, and devres cleanup will free it again when the core unwinds the partially bound device. On normal driver removal, remove() explicitly frees udev, and devres will free it again when the device is detached.

Something went wrong here, please wrap your changelog text at 72
columns.

> Fix by removing the manual kfree() calls and dropping the now-unused label.
> 
> Fixes: 3397c3cd859a2 ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

How was this found and tested?

thanks,

greg k-h

