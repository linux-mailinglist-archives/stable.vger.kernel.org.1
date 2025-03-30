Return-Path: <stable+bounces-127014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2042CA758D9
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 09:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8F43AAA08
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48417A2E7;
	Sun, 30 Mar 2025 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBQQFmF4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194A81AC8;
	Sun, 30 Mar 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743319913; cv=none; b=QBByVYq4BIfK1VhqzTcgyKqRKoI5lQ+IuaWBjwEW8iJHDQFf/E/+tveEXJ2H6dnkXv51JcjrZmI6nff7+v4YHVfFlHBJ+WDU7ARkajcHrN3xmIrbe74RdGcWNxwMiWIyYBiN1Gz+FmfFODo0+F7LRgc6eL3QXXylxelLDtJOgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743319913; c=relaxed/simple;
	bh=XT++m8L00AHqR60PiDT6jFZLNRZAi4GYXrVsMkTv7DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggt3Qv3FUz2Hcf/H2aO5Xmes7CkMbHWs9t6kN0FZL3PR8sLGN3askGblwqinlm71aNODcpw9gL4Q7H0fRJz0wsVlNXN755Sq8v3YFw6o1ipZNn7uDODbdBfwQ4hD6jukbMHFX/h1LIzngOVRc0oZ7i8t0WtdaiDdGuN2fZgxwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBQQFmF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD10C4CEDD;
	Sun, 30 Mar 2025 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743319913;
	bh=XT++m8L00AHqR60PiDT6jFZLNRZAi4GYXrVsMkTv7DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBQQFmF4Uf0XPZsFdycqML7Qg2RH+kPKmMpNsGdFeAfKdzh6Bw5oKMI5uO+79nsyH
	 6nRpxg8ECmXKeBFsp9QBxxIiLZICaPRzDGp0aWbX0fHRPyEKgEVrvoP3hRnclzoY+d
	 EQ4lMbOmVhPc3t2j4yoohKuQmGC5b8tPba9Cmiw4=
Date: Sun, 30 Mar 2025 09:30:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, jirislaby@kernel.org,
	john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pmladek@suse.com,
	samuel.holland@sifive.com, bigeasy@linutronix.de,
	conor.dooley@microchip.com, u.kleine-koenig@baylibre.com,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] serial: sifive: lock port in startup()/shutdown()
 callbacks
Message-ID: <2025033015-blanching-pagan-db09@gregkh>
References: <Z-iSb0ryR-tiUCj0@42be267012b8>
 <20250330011610.388077-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330011610.388077-1-ryotkkr98@gmail.com>

On Sun, Mar 30, 2025 at 10:16:10AM +0900, Ryo Takakura wrote:
> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
> The register is also accessed from write() callback.
> 
> If console were printing and startup()/shutdown() callback
> gets called, its access to the register could be overwritten.
> 
> Add port->lock to startup()/shutdown() callbacks to make sure
> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
> write() callback.
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> 
> Hi,
> 
> I'm sorry that I wasn't aware of how Cc stable should be done. 
> 
> I added Cc for stable but please tell me if this patch should be
> resent or if there is any that is missing.

Please resend a v3.

thanks,

greg k-h

