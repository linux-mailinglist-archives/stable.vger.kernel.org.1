Return-Path: <stable+bounces-194605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B89C51D4D
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 12:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3587E4F53F4
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E830B521;
	Wed, 12 Nov 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rdUYumqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18130ACED;
	Wed, 12 Nov 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945166; cv=none; b=jD2LERzvI4r3KERO3+0FNqGz7BJ368+wYw0EgtKqtiKBKUmRsJjc4C+PA+fvwpMr5i0H6h6+OH+zrbo0O1D+uuXu9Rd6pKchKVFmRIbSx3s+m64VmD6AhTIlU0SGDq8CypcNeBXarps7iz01U6lYC/wp/dIqpRq/lwKbiSlayug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945166; c=relaxed/simple;
	bh=kDc26jylMCjx5lPAYh2LgJVWyF7lQbmkJzm1ShisrSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIVLI35wOTq1QlavrBK8T+g13CKXgIPz7rRXkK5R856RLTpfeP25inF74gXvmze3GD+52ozhLSB1WCrhy3SXNKCrzlZPlgiU7BWrZv4S95IVHzRLaMdVAOWI/Sw/xJpd2dEb7QMifEN47gxO02QLOUKt7rGF4yQuDkMmuROo8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rdUYumqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C4DC116B1;
	Wed, 12 Nov 2025 10:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762945165;
	bh=kDc26jylMCjx5lPAYh2LgJVWyF7lQbmkJzm1ShisrSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdUYumqKqYMky1mPZ1kbbJVYBSpX+NuhLscpewkjXw+O6FfBcRP58g/jKDWm/gGQk
	 oDddyQxh31Cl34RkiLIRLCCKZg26A3t0iEbEKkb1rGuQxhv/PwUXMW7r2BiGm4jM+A
	 +jawy08INyfOWScwnIwTEKP8gmA/5d4PhQLHM9PM=
Date: Wed, 12 Nov 2025 05:59:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Heidelberg <M.Heidelberg@cab.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.17 468/849] eeprom: at25: support Cypress FRAMs without
 device ID
Message-ID: <2025111252-unmindful-blemish-a2d8@gregkh>
References: <20251111004536.460310036@linuxfoundation.org>
 <20251111004547.745840653@linuxfoundation.org>
 <aRMJ07J1E0C-gjC7@KAN23-025>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMJ07J1E0C-gjC7@KAN23-025>

On Tue, Nov 11, 2025 at 10:03:17AM +0000, Markus Heidelberg wrote:
> On Tue, Nov 11, 2025 at 09:40:38AM +0900, Greg Kroah-Hartman wrote:
> > 6.17-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Markus Heidelberg <m.heidelberg@cab.de>
> > 
> > [ Upstream commit 1b434ed000cd474f074e62e8ab876f87449bb4ac ]
> 
> No objections, but the corresponding bindings patch should be included
> as well then,
> see upstream commit 534c702c3c234665ca2fe426a9fbb12281e55d55
> ("dt-bindings: eeprom: at25: use "size" for FRAMs without device ID").

Great, now added.

> How to handle the third and last patch of the same series?
> See upstream commit dfb962e214788aa5f6dfe9f2bd4a482294533e3e
> ("eeprom: at25: make FRAM device ID error message more precise").

Not really needed for a kernel tree that will only be alive another
month or so, right?

thanks,

greg k-h

