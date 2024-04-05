Return-Path: <stable+bounces-36074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162CF899A6D
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483A81C2142E
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C85161908;
	Fri,  5 Apr 2024 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kl2mJ0y8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6702142E73
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312028; cv=none; b=eAW3tI5Yar2Ax5gXUx+EQ360JFPCuvF/2RuC8MKbyTTda/UQ2A6Txr1OtS95+9JEagYqnEQkheTbrrpAWMNf1ysAbmTJDi+gROvIbwegD1MSNzaEJzI3lAtxYHH3FhkPtByjleX2LXLnBQ5VPlMsOSWZWddQVJ7VseiXpwYArzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312028; c=relaxed/simple;
	bh=ZoHq7jRnJvfvLgg2VIuIjB7eOP2bUA6QaRVqoHq7Diw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YimvqGf1k2HTC7ZO6hs8swr6nRXyl5piMzKAFoKrPStvfoaIOHyV13HQE4h5tmPd5/i+VSCqkoZjUGDHku/kdfcCwBHBJa2gPmcLbhJV4KchhDt9Y6JgePbzSuKItwy0XSNRoLyNCMhotaOIMk13TR9pANq0acOJwAX/O/G7NsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kl2mJ0y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B88C43390;
	Fri,  5 Apr 2024 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712312028;
	bh=ZoHq7jRnJvfvLgg2VIuIjB7eOP2bUA6QaRVqoHq7Diw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kl2mJ0y87eLKqENddPzeWqni3klfokogRj1qE2jb+3+fhaJ2olGlQtRoo2S7N3qMA
	 Atnm8Wcq+WyKbptKt1twPDbMLvR8jh+D2cfGnD7U06zz4W8ER1zuJZvpz+dk6RlxQS
	 SmZr41FM6Ea1yEt7FlS9+LQMyc2TM6cFVX+H9whk=
Date: Fri, 5 Apr 2024 12:13:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/retpoline: Do the necessary fixup to the Zen3/4 srso
 return thunk for !SRSO (was: Re: FAILED: patch "[PATCH] x86/bugs: Fix the
 SRSO mitigation on Zen3/4" failed to apply to 6.8-stable tree)
Message-ID: <2024040537-budget-crusader-3a31@gregkh>
References: <2024033027-tapered-curly-3516@gregkh>
 <20240330224026.GAZgiU2jlEEovxGO2y@fat_crate.local>
 <20240405093651.GAZg_GM7n1rcbfxdGj@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405093651.GAZg_GM7n1rcbfxdGj@fat_crate.local>

On Fri, Apr 05, 2024 at 11:36:51AM +0200, Borislav Petkov wrote:
> On Sat, Mar 30, 2024 at 11:40:26PM +0100, Borislav Petkov wrote:
> > From: "Borislav Petkov (AMD)" <bp@alien8.de>
> > Date: Thu, 28 Mar 2024 13:59:05 +0100
> > Subject: [PATCH] x86/bugs: Fix the SRSO mitigation on Zen3/4
> > 
> > Commit 4535e1a4174c4111d92c5a9a21e542d232e0fcaa upstream.
> 
> One more ontop because one is clearly not enough and I'm a moron. :-\

All now queued up, thanks.

greg k-h

