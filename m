Return-Path: <stable+bounces-194555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B3C50295
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 01:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 789BE34C0AD
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 00:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD7E1B142D;
	Wed, 12 Nov 2025 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mMcC/mJD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F835957
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 00:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762909060; cv=none; b=uWFvzErf05H/1PKMGRjSF2zE/M7N0jv1OkU4i3/hMcqLp/Ba0hlwcdWYEyFLvjdcj75uiJk/A6ZsSKZwUX81sPBCcFEWuN868dilMc6oNr5yWppHaDAizexXsodYdMmX+za6gXf0aA9XJzB8ZSKriWPhgaQE7RD3aa70d3Xr4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762909060; c=relaxed/simple;
	bh=SVyPGLvWVxtjQuNRt12M6wC7Y1ObIVFbHgZ3cldZ260=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4dKlhvU7fvSbI+UKrqoPpIbJVBdIju9DsyrcC7GB75lQKJOUCvafYX7r8kXqiABp+CVkkdOuVnPeyMzeAgfe3aaiF5kx8xZm/G9RIURLaN6WKbBE47N7gD9Tp+oQm7hAqrBXOgwQVd5XST8JQOcZ80RZbjAJCgLV1jZ33rCeV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mMcC/mJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0629AC4CEFB;
	Wed, 12 Nov 2025 00:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762909060;
	bh=SVyPGLvWVxtjQuNRt12M6wC7Y1ObIVFbHgZ3cldZ260=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMcC/mJDy8ZiZdXgo+3h9rja0QASzPSWoC/2twuqKc76JnKG3n/HE6se2IIGM+HMa
	 Z212OlCGz714F8orEr4Lsgu2vUpYtMLkBtdCfzJoB0+KHC5aPLAlvg9fYGLZYefBRA
	 wMzarpWpm1VkCQBiSPWt17x4UqEZPFXzT7pZt5Ag=
Date: Wed, 12 Nov 2025 09:57:38 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, aliceryhl@google.com, jforbes@fedoraproject.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] rust: kbuild: treat `build_error` and
 `rustdoc` as kernel" failed to apply to 6.12-stable tree
Message-ID: <2025111242-unchanged-catwalk-49f0@gregkh>
References: <2025110816-catalog-residency-716f@gregkh>
 <CANiq72m2Rw2tFVH5e0PKo99k6Bn4fn-6N39DnHGsEDvmNhGYMg@mail.gmail.com>
 <CANiq72kEW52FBsanY2eqs+OXS6xLx6+J052RTBzFLdR5dinNuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kEW52FBsanY2eqs+OXS6xLx6+J052RTBzFLdR5dinNuQ@mail.gmail.com>

On Tue, Nov 11, 2025 at 01:46:20PM +0100, Miguel Ojeda wrote:
> On Sun, Nov 9, 2025 at 6:05 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Sasha's sibling resolution looks fine, thanks!
> 
> Just in case this was missed, I think this one and the related one
> weren't picked up for 6.12.58-rc2.
> 
> Should I do something?

No, I just didn't get the chance to pick up backports for 6.12 and older
just yet, I wanted to push out what we had already.  My queue is big,
due to travel at the moment, sorry.

greg "what day/timezone/continent is it now?" k-h

