Return-Path: <stable+bounces-114395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEFBA2D6DB
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 16:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DFF166B7B
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E33248194;
	Sat,  8 Feb 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ENhQquUW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0446248178;
	Sat,  8 Feb 2025 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739028578; cv=none; b=q9eerBnNsjgtMnSA1+xHLcsRjr8bRlK0HuOlcoW3uBUfRDTtM3+K9VSDsNZoUgw+zF0N0xcQwjFzjoRCBpL5YFRmIMQZcKGEI2ZwC2Cott5BnTM/SxY6NwDH3M+HC/cdO5ulWf3bk2t8JxjYELe4hCrlr/eJ9mTdId42/HwrAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739028578; c=relaxed/simple;
	bh=/GwDMC7y+cAKFfHA97KdkF0mbTgUz0wSOCHxhWk35Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFoxz67tP11iev2uDvk5CCUA9/Q7E4+38gd3GcFQELNoWig3mqbFms0WfsoGK8oSq91YDHldCiR06r84mswn67lce8+4W6bVhvmJAgGPGd7YBLB2VCmRn5S3ih8/iY+14SFPSIVqmU0VpKAr44XlPVfa9Q5BVg9Znt4dEPHNU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ENhQquUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5A3C4CED6;
	Sat,  8 Feb 2025 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739028576;
	bh=/GwDMC7y+cAKFfHA97KdkF0mbTgUz0wSOCHxhWk35Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENhQquUWCfnOYL3ZorndRfUv9+gQv9kNaZ0ov/XX7C7sAulmmMR5ZBTP90HDLgijB
	 sSf9Li5Ep0Esfn8xrjk1g8dSCsGemULNyKZPyjrO1EIu/NTYdwbhjYnAfM2OTGBNBV
	 /rqL4Miwz1tK3FZi/r2mvk/QLnQxFT6ARivvxMHE=
Date: Sat, 8 Feb 2025 16:28:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jared Finder <jared@finder.org>
Cc: kees@kernel.org, gnoack@google.com, hanno@hboeck.de, jannh@google.com,
	jirislaby@kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without
 CAP_SYS_ADMIN
Message-ID: <2025020812-refusing-selection-a717@gregkh>
References: <202501100850.5E4D0A5@keescook>
 <cd83bd96b0b536dd96965329e282122c@finder.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd83bd96b0b536dd96965329e282122c@finder.org>

On Sat, Feb 08, 2025 at 07:18:22AM -0800, Jared Finder wrote:
> Hi, I'm the original reporter of this regression (noticed because it
> impacted GNU Emacs) and I'm wondering if there's any traction on creating an
> updated patch? This thread appears to have stalled out. I haven't seen any
> reply for three weeks.

It's already in 6.14-rc1 as commit 2f83e38a095f ("tty: Permit some
TIOCL_SETSEL modes without CAP_SYS_ADMIN").

thanks,

greg k-h

