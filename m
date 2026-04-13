Return-Path: <stable+bounces-235945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNF0D+Sd3GkxUAkAu9opvQ
	(envelope-from <stable+bounces-235945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:40:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D63E85C6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CF25300B3C9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EAC3932ED;
	Mon, 13 Apr 2026 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX7mPsGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB28323BD05;
	Mon, 13 Apr 2026 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066016; cv=none; b=sOdK8PawhFrK1VNXroC4oSoBVZSXDQQlOCmhyccdx0lcJJN+YrLgV+1ZbungKj0NYrPD1xgbANITTQFI1On7TEkdP98QHEVY1zQyQNFKlBVOX1XEGA/W2jEJb7hmlk7Ia6f50jt/y9CpzHCHcUTYploc1p3gfGmv9j1RK8b+DaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066016; c=relaxed/simple;
	bh=r80UljLRQEs1CmWDnzaxpQ214rB39fhGhsJFc8CYhGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsgIHEbAtuCphesOPJcPLznX6xaih1BoHlttqyZQuZK2HdKJEiL/WQeaz4YdBkkcKkZMXyKGG9HjRVgXwwavHScZj2kgi4rdxpXHobv0oY8aKVxA5d8rfYKvyoEVZFZlP5EEnTPR3wqpnaTHTCz2ozyQrKtB2TEfImpuass8a+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX7mPsGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EFDC116C6;
	Mon, 13 Apr 2026 07:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776066016;
	bh=r80UljLRQEs1CmWDnzaxpQ214rB39fhGhsJFc8CYhGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dX7mPsGOxD4TzvIF4FZqGlz4GHy3ZdQvaYF9NhJ3rH7HOy7BDA4/lVv5nKVsVk6kx
	 O3QTVZbXj4KZlnbWGS4STFwtcJexlZZtwMYT7FK3LQ14iV61Up6ZalUZv5gS87RNhR
	 2SNQeRn4Jepa9Zt4xZKqC+30XsMc0yjBj0YtyPtjPxRVG01JpPhT4pHEL5syUG/khm
	 84c7OTysAP5mfaqAAaplpF/pw5XJR16JKRisuvIi02qlXdU+mybZa2b5+klTBsEc1b
	 T34o3V7eaRnGpNe+i8BMENd3dn5ZINz7IOYnIXtxeaORq3BYAce/Mr14pCHuz2fKVA
	 0/E8nLW2KLaeg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCBu1-00000000mj0-3Zd3;
	Mon, 13 Apr 2026 09:40:13 +0200
Date: Mon, 13 Apr 2026 09:40:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ben Hoff <hoff.benjamin.k@gmail.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	William Wu <william.wu@rock-chips.com>,
	Terry Junge <linuxhid@cosmicgizmosystems.com>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	John Keeping <john@keeping.me.uk>, Lee Jones <lee@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: fix device reference leak in
 hidg_alloc()
Message-ID: <adyd3Ud2Pl_KRl6_@hovoldconsulting.com>
References: <20260412161555.2568840-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412161555.2568840-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235945-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,gmail.com,rock-chips.com,cosmicgizmosystems.com,collabora.com,keeping.me.uk,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 8C3D63E85C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 12:15:55AM +0800, Guangshuo Li wrote:
> hidg_alloc() initializes hidg->dev with device_initialize() before
> calling dev_set_name(). If dev_set_name() fails, the function currently
> jumps to err_unlock and returns without calling put_device().
> 
> This leaves the device reference unbalanced and prevents hidg_release()
> from being called. Calling put_device() here is also safe, since
> hidg_release() only frees resources owned by hidg.

Good catch.

> Route the dev_set_name() failure path through err_put_device so the
> device reference is dropped properly.
> 
> Fixes: 944fe915d00d ("usb: gadget: f_hid: tidy error handling in hidg_alloc")

This isn't the commit that introduced the issue, though. This should be:

Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")

With that fixed you can add my:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan

