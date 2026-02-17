Return-Path: <stable+bounces-216892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IwGCGu9lGnHHQIAu9opvQ
	(envelope-from <stable+bounces-216892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:11:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D513914F885
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E76C3303F56F
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A401376481;
	Tue, 17 Feb 2026 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgyUiOyd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B837474F;
	Tue, 17 Feb 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355489; cv=none; b=cYnsw67ZieRnH5H5xHTKQcmaACU0QvlXACDQF5bkhBfUcIDO26+c8RH4newelrYwZ5KlBr/hYSNUHoZHS1qRIMdc9XkdY4bgFv9Hq4QvYmdKQnMdoGs4rHP+I1IrePcEL6mkEfmalXDvlo52y2np1iTK+9mF3+Yz8tCvcrg7ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355489; c=relaxed/simple;
	bh=zqC/qwgJG8RYHRP2WndZeH/vSnyshZAupGGIjnFrL/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBPnkjL46u1xiqATcjctUaza/JjtfBE+FB5XfoVy1Oe1SNabnWv55c6xD93Cua/FBUIc7fN9CmjnSGd+lMrwRSikgLOetTrEWKZfZn1/lwK4EAXV6D3GvdfdN3H93dWhsQK4ITtcvAROGrqDJSrz6IWTGAbxjnvWW71cewoQJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgyUiOyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4363C4CEF7;
	Tue, 17 Feb 2026 19:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355489;
	bh=zqC/qwgJG8RYHRP2WndZeH/vSnyshZAupGGIjnFrL/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgyUiOydhHH5iZKZUjdpTpxOoqtylAKCnbEv7PCfr3vVxKd2O6yGvumIIgvQVa2LN
	 7xBcmaSQl1fOD00Ny1A6Q+FJx+2ENdSWk32swoqKRvck75Kcp4OiQmDh/qVhutl8FY
	 +uUWNVymuPxGkH1kWrUo6QR6nUBhRgf7UJFBnjD0+M8ZfFjffcyuoXtywWSG0TaWk2
	 XfAO/MSPai77of6FqV5OZxcdihIq+3txgCO0vXm+cy/S07CvKer7ixIenxkaw1U9rq
	 QnQ2ZEunOZq3nVH/Vq//J8HpxTaJwS5KPwybK0zwM4TOR0UoRnK92BOSf/aePlnO38
	 +zs5yx4wcUMoA==
Date: Tue, 17 Feb 2026 12:11:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
	alex@shazbot.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v9 3/9] PCI: Avoid saving config space state in reset path
Message-ID: <aZS9X_CQBuo7gQpC@kbusch-mbp>
References: <20260217182257.1582-1-alifm@linux.ibm.com>
 <20260217182257.1582-4-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217182257.1582-4-alifm@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216892-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D513914F885
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:22:51AM -0800, Farhan Ali wrote:
> The current reset process saves the device's config space state before
> reset and restores it afterward. However errors may occur unexpectedly and
> it may then be impossible to save config space because the device may be
> inaccessible (e.g. DPC) or config space may be corrupted. This results in
> saving corrupted values that get written back to the device during state
> restoration.
> 
> Since commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times"),
> we now save the state of device at enumeration. On every restore we should
> either use the enumeration saved state or driver's intentional saved state,
> never a state saved at the unpredictable time of an error recovery reset.

The vfio driver calls pci_try_reset_function after pci_enable_device,
but before calling pci_store_saved_state. Won't this change, then, mean
that the PCI Command register will get restored to the wrong state with
the resources disabled?

