Return-Path: <stable+bounces-135236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F248CA97EE1
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 08:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D01A16BD6C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 06:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268E242D8F;
	Wed, 23 Apr 2025 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O7zXWKNg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024AD264FB8
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388678; cv=none; b=H49kog1UjjudleenBxPuTTPAjxIC1nY/QuYbSd6D3lnCv4RyYD3g4EphOsLxQjzH/Zs7mwzH2xJ+Elh5/wY8MSRG4e3f3h7QaTHpGtUKkDz0IR5BooP3ehiKKmGKN51Yy11hmwglGtwXrC7dyNSRgH6E8PYMJYvrF9rB+cFrqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388678; c=relaxed/simple;
	bh=tie4c1oLM6DJuMSTUytnqUMJB+AYJPD68DX08M+safw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QENzuisARmtFv70BJ+0KW/mY+5plzSkxvM3JDA55cKkVVDTHbkZoAFcTKzW8YspjaPUjaxLRKZqmc/k+YYcWBkKVa+ZCquFrgSUEKvDtb29x+pYrxoqQJAGSc0H2lMsUsGmSERDfQjpNgJf8skcsmHILXBK8xl2kQM/uTflxHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O7zXWKNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18D0C4CEEA;
	Wed, 23 Apr 2025 06:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745388676;
	bh=tie4c1oLM6DJuMSTUytnqUMJB+AYJPD68DX08M+safw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7zXWKNgqKfTQsVeqjPFopwcHWwOo4UqrMI8cmnQ7JZ0YUNJ7U58767vaSeRXdiVU
	 rz74NKj2uVUN+zH7NWYxQ2oxNoeBvMtXcv9pPnVXWU9wJe1p7mGFd6DUP8GuaC7bLC
	 y+QGBNonP4bnvM95Q5fUSiGYO5FCI3ovJ5JRWs6k=
Date: Wed, 23 Apr 2025 08:11:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.14] lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP
Message-ID: <2025042306-calcium-arson-c212@gregkh>
References: <2025042119-imbecile-greeter-0ce1@gregkh>
 <20250421154059.3248712-1-nathan@kernel.org>
 <2025042230-uncouple-ajar-0ee8@gregkh>
 <202504220959.7DAFFC4@keescook>
 <20250422191020.GA3724784@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422191020.GA3724784@ax162>

On Tue, Apr 22, 2025 at 12:10:20PM -0700, Nathan Chancellor wrote:
> On Tue, Apr 22, 2025 at 09:59:40AM -0700, Kees Cook wrote:
> > On Tue, Apr 22, 2025 at 09:20:41AM +0200, Greg KH wrote:
> > > On Mon, Apr 21, 2025 at 08:40:59AM -0700, Nathan Chancellor wrote:
> > > > commit ed2b548f1017586c44f50654ef9febb42d491f31 upstream.
> > > 
> > > Wrong git id :(
> > 
> > Should be cdc2e1d9d929d7f7009b3a5edca52388a2b0891f
> > 
> > (ed2b548f1017586c44f50654ef9febb42d491f31 is what was fixed, I assume a
> > paste-o)
> 
> Indeed a paste-o or maybe a copy-o depending on how you look at it :P
> 
> If that cannot be fixed up easily, I can send a v2.

Please send a v2.

thanks,

greg k-h

