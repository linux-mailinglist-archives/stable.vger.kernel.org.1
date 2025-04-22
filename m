Return-Path: <stable+bounces-135169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A029A97525
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692911B6164A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B314C2857CD;
	Tue, 22 Apr 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyn6C8QG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B21A76BB
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349024; cv=none; b=UYakA5okXyNoU0iCOrqivQDahWKVh53YsKHg3gP4mYQLqdsLj063CFDmgxC7QGojnKx9gRNsXlEedQyKSxWBQko2d8+IlrVa4RPyrGF/CGrZWXqiuuiZPlKWTRCHdaNrHDVaZDLFuYS7IF8jARbixOqxRgzzpLJ2zKoy8qfX+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349024; c=relaxed/simple;
	bh=0C8mhybkwZqdVBoSkYhsO13+FPw9k1H5l9iOirwpaxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8N4dtIT2qHdqhDDcPXcXEQVA4AmlE8UAAcynEywHAWPb/tzOL45ZgBQwSnYmiyThnqQSGAGRSXAI5G5gY+SAVf9Es7YgFSsUfFQgvxmjNdv/jyM1z4sV3sVAXixmq4hLCOt1dhaIG2R7VYXfUJWodH/DnC4n/NJssx5yexNSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyn6C8QG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE49DC4CEE9;
	Tue, 22 Apr 2025 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349023;
	bh=0C8mhybkwZqdVBoSkYhsO13+FPw9k1H5l9iOirwpaxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyn6C8QGQs268zvxgGt/ja3Ty5B9l8SYuU4rnpeDlOMSNKrGpTrsPaeoH7zKYlzxq
	 2B79c9AySvD3vJwcZwtZGGR1UTIuVR+GPDXYqWTya1FTWTy4IFQ3tTmTMCnjnf3uAy
	 hIao73JrXXFyZNnnK17Pp2+VOkGOAKyy8mmPZzrC11WvCwCyM6qDpZel71etxvIwE8
	 gWZ+UDwdUjPVPTz+gLCXiLGjtwrhXecLVG7S2a1OyD5l0JG7ya8ce4T44UlxOKctax
	 SIp+g/RCJniO4c9gNiNi5YOHfLphxEk3IR/emoIyMk8Dm4+d5fRXvM0O8W074e+PLH
	 8DJrzggBFHzNg==
Date: Tue, 22 Apr 2025 12:10:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.14] lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP
Message-ID: <20250422191020.GA3724784@ax162>
References: <2025042119-imbecile-greeter-0ce1@gregkh>
 <20250421154059.3248712-1-nathan@kernel.org>
 <2025042230-uncouple-ajar-0ee8@gregkh>
 <202504220959.7DAFFC4@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504220959.7DAFFC4@keescook>

On Tue, Apr 22, 2025 at 09:59:40AM -0700, Kees Cook wrote:
> On Tue, Apr 22, 2025 at 09:20:41AM +0200, Greg KH wrote:
> > On Mon, Apr 21, 2025 at 08:40:59AM -0700, Nathan Chancellor wrote:
> > > commit ed2b548f1017586c44f50654ef9febb42d491f31 upstream.
> > 
> > Wrong git id :(
> 
> Should be cdc2e1d9d929d7f7009b3a5edca52388a2b0891f
> 
> (ed2b548f1017586c44f50654ef9febb42d491f31 is what was fixed, I assume a
> paste-o)

Indeed a paste-o or maybe a copy-o depending on how you look at it :P

If that cannot be fixed up easily, I can send a v2.

Cheers,
Nathan

