Return-Path: <stable+bounces-231181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OU7Fc9kymn27gUAu9opvQ
	(envelope-from <stable+bounces-231181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:55:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A45E735AAAD
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC92300BDA1
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA833BED77;
	Mon, 30 Mar 2026 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtbF+CjU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD93C2E;
	Mon, 30 Mar 2026 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871329; cv=none; b=JOn/9TWm/AWPoP1RweLPK7oiQKhJX5mE18venD3zTOp2DGDsWlJfvEbxwHMwkRXTp4vDgAK4+m3xjedRHdvzFu2rBnwviL2rUkpEFauz/FGGO5YYpTvatuGMs5ipxKyZwDHeZMu5UGen06SarnmoKx6QTzYxT9W5b72Hfev/Lxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871329; c=relaxed/simple;
	bh=i32uvfOSfPk98MwjTMpN1fmYt3V+WqF2yQynG7Q618o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx7iGdjTEYeAkf4+WcR0/aQozr9zw7PUc5yuWpavxaaQyMUR87cNU1cg7zTX+IjPsM9Q5Xz+OXUGlJzqR3Qtyv1Hj9LabyW/7CxPxmDfCgloriM8UIRkKH8ZQ/I6Hce31Vvkh60Qpu54q3GRhpc18FM8WrGdvKLCae74t2X3nQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtbF+CjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29472C2BCB0;
	Mon, 30 Mar 2026 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774871329;
	bh=i32uvfOSfPk98MwjTMpN1fmYt3V+WqF2yQynG7Q618o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtbF+CjUivAnB+YYaz8x8PurDE91w/8gLqK9vRPaVpB0i1RwdahLtAkujbbDtzNKU
	 mDA6onLM9gAEGni0dS5pjHv8H+q96EdZtu1aGgbw7A2H0u3f8yQM76Q3vdvg78Vpin
	 fFmuhQBUjekvJYfTIpO5kq8Z+6rJCTsxzm8oMAcNEG/tMofEP70OZeNoP7CwBs+x9/
	 JoEMfBosW/u9CpsO6HLnJuo9jLpR695pSaBMVFFZxK3r7/ioxO4n5ZrbhtViflX1cm
	 jdS0QeziLzhQdV5XgbwSVfMK9L5QbJ8WH0HWh/4dQZToQ7EyV9NCRbBS7MWXOnHtmH
	 8Ez5orQpLEwiA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w7B6s-00000007211-4BRu;
	Mon, 30 Mar 2026 13:48:47 +0200
Date: Mon, 30 Mar 2026 13:48:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpib: lpvo_usb: fix memory leak on disconnect
Message-ID: <acpjHoARQcsHwuFq@hovoldconsulting.com>
References: <20260310105127.17538-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310105127.17538-1-johan@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231181-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hovoldconsulting.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A45E735AAAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 11:51:27AM +0100, Johan Hovold wrote:
> The driver iterates over the registered USB interfaces during GPIB
> attach and takes a reference to their USB devices until a match is
> found. These references are never released which leads to a memory leak
> when devices are disconnected.
> 
> Fix the leak by dropping the unnecessary references.
> 
> Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
> Cc: stable@vger.kernel.org	# 6.13
> Cc: Dave Penkler <dpenkler@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Can this one be picked up for 7.1?

Johan

