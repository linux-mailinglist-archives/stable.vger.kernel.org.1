Return-Path: <stable+bounces-45549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F8F8CBA44
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 06:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73437B217AD
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 04:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243372CCB7;
	Wed, 22 May 2024 04:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hrLYOzHb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7908360
	for <stable@vger.kernel.org>; Wed, 22 May 2024 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716351535; cv=none; b=BQpCUdnmHhbczXWgE9jYQtUibOqukBWOlvVRYE8lAf14jZluD6z+ptbuddnFaQ0Dj/dHPfdHy+zXbzWrfU6GkA7nYsLuXhpGdCHVJS92ST52KMUQ1h8tLvbWNhN4fAPwY/GvVxz6bF8x78z9JtNNU/4NODpN0alCkPYRGoSHhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716351535; c=relaxed/simple;
	bh=reC6CCwUTdrT6OkLgqCjaIJvsWVF9XpnBK2JTtetPnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgL2o/88X1bJ+E6VC2pUX45zDAyvvMtE0dJbcJdEZhMhdR4kuarY+660mMuX5DMC1htpeo/o3bcF9TTw3JO4ULtzdkLLn07xugRAfkg9KNLi4xJv4AyZoViytvpygNgFS0NDjAxVQwaugkI9Ixz3IK0uzZrAuJS4ZnJY2LwDrjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hrLYOzHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D036C2BD11;
	Wed, 22 May 2024 04:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716351535;
	bh=reC6CCwUTdrT6OkLgqCjaIJvsWVF9XpnBK2JTtetPnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrLYOzHb0ZHY52mZOXMxQEnbw+YWY1pgbDYqESKbFf6zrjJjC5fQqAQn4tUVBhu+4
	 cJgfZmiH+X1cO/8T6l4hDXDlPm6JmaDrvri/QJyYSOSwdTcQCZZ7MCnNC2RUgEpUXH
	 RsOq7QX4NfDwV1/u3wVALF4P+/Xb7dNDl8XZeDxw=
Date: Wed, 22 May 2024 06:18:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Liam Kearney <liam.kearney@canonical.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org
Subject: Re: [PATCH v2] crypto: arm64: use simd_skcipher_create() when
 registering aes internal algs
Message-ID: <2024052212-saved-manmade-9c8e@gregkh>
References: <20240522035837.18610-1-liam.kearney@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522035837.18610-1-liam.kearney@canonical.com>

On Wed, May 22, 2024 at 01:58:37PM +1000, Liam Kearney wrote:
> The arm64 crypto drivers duplicate driver names when adding simd
> variants, which after backported commit 27016f75f5ed ("crypto: api -
> Disallow identical driver names"), causes an error that leads to the
> aes algs not being installed. On weaker processors this results in hangs
> due to falling back to SW crypto.

But that commit has already been reverted in the stable releases, right?

> Use simd_skcipher_create() as it will properly namespace the new algs.
> This issue does not exist in mainline/latest (and stable v6.1+) as the
> driver has been refactored to remove the simd algs from this code path.
> 
> Fixes: 27016f75f5ed ("crypto: api - Disallow identical driver names")
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: stable@vger.kernel.org
> Signed-off-by: Liam Kearney <liam.kearney@canonical.com>

What kernel tree(s) are you thinking this needs to go to?

thanks,

greg k-h

