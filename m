Return-Path: <stable+bounces-40284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDBC8AAD84
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 13:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5F9282061
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F268120D;
	Fri, 19 Apr 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wI14gQcu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4342AAF
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525455; cv=none; b=jv0FBH7UPIs2qB5GXWA9hj/OxkAloPQ6ykjWncgF+Vecsb7pkf1MTgsrbDgYOBYOmVux7lvhq0AIKoO/mBJDVTqyc7/19zemxExNV/q+7NoRKe3fJHaYdnlDHJJy3tbY1eQdyIg2XP+NKOPa9A2YLRi7z+8+6NjeWon0o8LrAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525455; c=relaxed/simple;
	bh=I4+7U3xvhgUEAhE6hbgwNUb4yuAljcPOswsn6Rd3Bpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCtg+jrq0XP+JYe5IuoYtSkIIYwMy1OKs9mk2y9Tr+Cy8xAuwHWaLXzIgXznLunKA0sl/NOg++NgKeoRsTevmplSc8y24NXlhYiLM7/PQ62T5vaKUE9ZzykkGTsNbvkw2C4C6FNon51n2Ek3Uefyxh6eQGqNojekhH5qPPjpXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wI14gQcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E76C2BD10;
	Fri, 19 Apr 2024 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713525455;
	bh=I4+7U3xvhgUEAhE6hbgwNUb4yuAljcPOswsn6Rd3Bpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wI14gQcu2Tp98KIMr08IE5PCPUaBGIG1spUrLqBZvboE0UWGYFnVMMqUFUvc9OxKp
	 FvlDL4+7lH1sO9zAtqk9xsKq5OEqAGz41lHcosaBO8SljapG34dw/jWTLmY+KYhkqr
	 C0iaCuWM8nwLTNZ2UHxTXn7bKY+l6+hT+IobWx18=
Date: Fri, 19 Apr 2024 13:17:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] r8169: add missing conditional compiling for call to
 r8169_remove_leds
Message-ID: <2024041922-triumph-stubbly-4866@gregkh>
References: <8bfda5e5-083c-4555-a79b-155bb426ccc3@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bfda5e5-083c-4555-a79b-155bb426ccc3@gmail.com>

On Thu, Apr 18, 2024 at 10:36:26PM +0200, Heiner Kallweit wrote:
> [ Upstream commit 97e176fcbbf3c0f2bd410c9b241177c051f57176 ]
> 
> Add missing dependency on CONFIG_R8169_LEDS. As-is a link error occurs
> if config option CONFIG_R8169_LEDS isn't enabled.
> 
> Fixes: 19fa4f2a85d7 ("r8169: fix LED-related deadlock on module removal")
> Cc: <stable@vger.kernel.org> # 6.8.x
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> This for v6.8 only.

Both now queued up, thanks.

greg k-h

