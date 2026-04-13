Return-Path: <stable+bounces-235938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGDtBvKT3GkkTQkAu9opvQ
	(envelope-from <stable+bounces-235938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:57:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEDB3E8016
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED47630059B9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC21392C25;
	Mon, 13 Apr 2026 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbQsGh+e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1524285C8B;
	Mon, 13 Apr 2026 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063468; cv=none; b=Yd0r6PzqucejTxzZNgijXJ4gYvmKqkGMSWuK/Ixd0BNQsro3VVqqVYLU4etHj4JZ3a3kfjwhvcUKIrlPLaq8HEf43qzkzYdvG7Rw43ZQdDR8+WaGCflUHKMgDdbe5Qf3+s+wvdYCfhu9CYycGDYC+GZ0TNIcSvqfl1Ce+LgxrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063468; c=relaxed/simple;
	bh=GKEznWIa3rRKH37mtLp50Bhr5xCseHMf9QweV0XCE9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g05v0rGNgOmJvYIAPTB7FIpu7BNNUDjDZftRmY344tbhvINyK4Gk2VHQABBlKf1JXTB5/JH0LhgE32c1B/Yd/D/cxvYD6qvZBaPw9T1fKMgTlff9mV+PWWAsMOmFVJEMjmsa9U9WclZhkKvGwEjSCUw/+IePx/IUDj6/KLO4pW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbQsGh+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CEDC116C6;
	Mon, 13 Apr 2026 06:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776063468;
	bh=GKEznWIa3rRKH37mtLp50Bhr5xCseHMf9QweV0XCE9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbQsGh+eEwKetiwiOGowa6Nx5lKC89Y0xFstu+iaTH/WSLB+gPgCsJA4yHXZmQD2Y
	 oSgWpWRA1wZHErAxDwW8018Zs0NX6mt4ZZYBEgliVzMP612jLCahdITg5dCH1RH0FD
	 mb6+EoAVrwK9ipyu3GsvMum2qUlTIvpfaxt/ptlvxRJH7Azx5lqTurXMta1wz0qiyC
	 AKTjLY7DoUsjLcda4QD84F3LX3jPgJT9C2eT6Li61H1bDHAeQc5yak+DGPZ8nrifg0
	 QBX6A49ssWUh7JZeJr3cPE7buFNPl7ORZberhcP3NAhSZB7RiAP1TWK0oDG7crDBHL
	 G0ffuyTJApk6g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCBEw-00000000mBF-0mFw;
	Mon, 13 Apr 2026 08:57:46 +0200
Date: Mon, 13 Apr 2026 08:57:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb-serial: fix port device refcount leak when
 device_add() fails
Message-ID: <adyT6oW0UgvcEQbX@hovoldconsulting.com>
References: <20260412165311.2578501-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412165311.2578501-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235938-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEEDB3E8016
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 12:53:11AM +0800, Guangshuo Li wrote:
> usb_serial_probe() initializes each port device with
> device_initialize() before registering it with device_add().
> 
> If device_add() fails, the current code only logs an error and
> continues, but does not drop the reference acquired by
> device_initialize(). This leaves the failed port device referenced
> until a later teardown path, if any.
> 
> Fix it by calling put_device() when device_add() fails. Also clear
> serial->port[i] after put_device() so destroy_serial() will not try
> to put the same device again.

Any port that fails to register is released in destroy_serial() which is
called when the last reference to the device is dropped (e.g. when the
device is disconnected).

So there is nothing to fix here.

Are you using some kind of tool to find these "issues"?

Johan

