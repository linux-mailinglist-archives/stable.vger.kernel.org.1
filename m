Return-Path: <stable+bounces-61845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E6A93CFE5
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8101F24357
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BFD176AD6;
	Fri, 26 Jul 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DEagb6SV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7D176AB3;
	Fri, 26 Jul 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983930; cv=none; b=HilBgAMqscVyeK208l1uWfTbHM8Qb8YcKudt0DDVdHyxem/X16ZsnX9CtYBtO4VghHCWNOc7BNu7WtReyAb9uOdSPSsqd0HEuqJ0muApQzEvfu72nBnbBJEkI9k8bbwNgO+wSb5V9rnZRMfcVyOdus6xrRsh32izIJBMMvoQl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983930; c=relaxed/simple;
	bh=x9Q3f7TMlV009Dj8p5KmSZQbGiGv8Hng0TFWaEJwdsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+5Gvg3dj5YNBcKfEPUt71Ht8HFNCRh5HY9Q14QdnM3fOjTluIK6lLW9Yugo1haypLtgQ2gMfcW/nQbi6ALBhKb87W6ctevQBk5541vQCYgljb59J5D1lNavIrjhqEzS/fQRK2Loin/PGBqR7m6iUDLkoxgV2cW3LRd3KZO6444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DEagb6SV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC32C32782;
	Fri, 26 Jul 2024 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721983929;
	bh=x9Q3f7TMlV009Dj8p5KmSZQbGiGv8Hng0TFWaEJwdsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEagb6SVsWRjCgxah+mjFUSOD3rnDpflXKlNNZ4SlWJk/dVooNkzO+g8/6Tc05U2I
	 Ohwkq9mfYmcP61yuITuDzdZzKVgXyXUMXuAXs3/g+hngMSM3nuW+rXx7sgyrRhmREj
	 GgFaW8P+IipwI1uibs4V95By59902lznZWWFvNQ0=
Date: Fri, 26 Jul 2024 10:52:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/59] 5.10.223-rc1 review
Message-ID: <2024072635-dose-ferment-53c8@gregkh>
References: <veJcp8NcM5qwkB_p0qsjQCFvZR5U4SqezKKMnUgM-khGFC4sCcvkodk-beWQ2a4qd3IxUYaLdGp9_GBwf3FLvkoU8f1MXjSk3gCsQOKnXZw=@protonmail.com>
 <2024072633-easel-erasure-18fa@gregkh>
 <vp205FIjWV7QqFTJ2-8mUjk6Y8nw6_9naNa31Puw1AvHK8EinlyR9vPiJdEtUgk0Aqz9xuMd62uJLq0F1ANI5OGyjiYOs3vxd0aFXtnGnJ4=@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vp205FIjWV7QqFTJ2-8mUjk6Y8nw6_9naNa31Puw1AvHK8EinlyR9vPiJdEtUgk0Aqz9xuMd62uJLq0F1ANI5OGyjiYOs3vxd0aFXtnGnJ4=@protonmail.com>

On Fri, Jul 26, 2024 at 08:21:47AM +0000, Jari Ruusu wrote:
> On Friday, July 26th, 2024 at 10:49, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Fri, Jul 26, 2024 at 07:25:21AM +0000, Jari Ruusu wrote:
> > > Fixes: upstream fd7eea27a3ae "Compiler Attributes: Add __uninitialized macro"
> > > Signed-off-by: Jari Ruusu jariruusu@protonmail.com
> > 
> > Please submit this in a format in which we can apply it, thanks!
> 
> Protonmail seems to involuntarily inject mime-poop to outgoing mails.
> Sorry about that. For the time being, the best I can do is to re-send
> the patch as gzipped attachment.

For obvious reasons, we can't take that either :(

Also the "Fixes:" tag is not in the correct format, please fix that up
at the very least.

thanks,

greg k-h

