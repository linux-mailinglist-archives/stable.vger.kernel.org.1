Return-Path: <stable+bounces-38017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242B8A005F
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 21:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1399FB2AC0B
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E2180A82;
	Wed, 10 Apr 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSDjXPWh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591253372
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776175; cv=none; b=raLDu4x4ZPavuxBOWO81sXNaDqksTwoguDJsOetbFInAnqQggW1roH8EA1yeJczFTk/2Yg0bM7+6+gz066uxY1DVLnIJ0qKy7Tsdc/nPL23FDHKlMB5df6LcAAp2/9FbIsz3H6HMkIPuRycCEdCDMrg9cbJReGUWiXLju+BBg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776175; c=relaxed/simple;
	bh=U7SSOjmbAxJh4cQM9cJ4pC646tIUq72GQnL0eukztHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcEFZ/X+Mx8yRcP+ZS7m9pboEGdrYPREE9ZrvEuPYjhZUEF8F7YXrnxQme125SVHJtvvroHl+Z8kQLqTDR/lD7UCkLZEDwgq73Qa1ZpSVwM9gX5LiSE6cU5qDN8jkfjevJDbHlQFjZdKXANlCyfAz5i5WC4PHt7YtHGbHBRR88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jSDjXPWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C7EC433C7;
	Wed, 10 Apr 2024 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712776174;
	bh=U7SSOjmbAxJh4cQM9cJ4pC646tIUq72GQnL0eukztHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSDjXPWhdeH6sqB+EnfBGWy4rTTKlBkPf+fDWHyVxZnh4tnJf7wq12b2bk5Sq95qI
	 CCF6eqrGlaNAfnvlF1reXxvUfv3m9xLD2Om010sQvXeJR0LODLzYuH22cDhj/w7dIQ
	 CcDaSDrDwElkcyLgvrn2BRvY4z1P03joXYxBAbC8=
Date: Wed, 10 Apr 2024 21:09:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Re: Backport of 67c37756898a ("tty: n_gsm: require CAP_NET_ADMIN to
 attach N_GSM0710 ldisc") to older stable series? (at least 6.1.y)
Message-ID: <2024041054-asleep-replace-96e8@gregkh>
References: <ZhbiWp9DexB_gJh_@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhbiWp9DexB_gJh_@eldamar.lan>

On Wed, Apr 10, 2024 at 09:02:50PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg, Sasha, Thadeu,
> 
> Today there was mentioning of 
> 
> https://www.jmpeax.dev/The-tale-of-a-GSM-Kernel-LPE.html
> 
> a LPE from the n_gsm module. I do realize, Thadeu mentioned the
> possible attack surface already back in
> 
> https://lore.kernel.org/all/ZMuRoDbMcQrsCs3m@quatroqueijos.cascardo.eti.br/#t
> 
> Published exploits are referenced as well through the potential
> initial finder in https://github.com/YuriiCrimson/ExploitGSM .
> 
> While 67c37756898a ("tty: n_gsm: require CAP_NET_ADMIN to attach
> N_GSM0710 ldisc") is not the fix itself, it helps mitigating against
> this issue.
> 
> Thus can you consider applying this still to the stable series as
> needed? I think it should go at least back to 5.15.y but if
> Iunderstood Thadeu correctly then even further back to the still
> supported stable branches.
> 
> What do you think?

Sure, I'll queue it up.  I think the "real" bugs there are already
resolved in the various older kernel trees, but adding this is "defense
in depth" and makes sense.

thanks,

greg k-h

