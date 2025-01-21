Return-Path: <stable+bounces-109615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA4AA17EC3
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D13A3260
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422EA1F1308;
	Tue, 21 Jan 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jzAd+ZN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32381DFD1
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465816; cv=none; b=KuuhawmOsdfOdPRvYvqBEHCxhPrbLsxgAgsb53eUWqmSlT8lBsVGncFeu8U7JWjPkXFlZhc9FMF3A6RPEZeEMNZJDgJ4fCr7sCWLlt0/lpF1udD/22aYVl8P9Q1qYVYtt97M7KfdRp5oKG5LGVF4ZSKKT37mK7d0eLTMmiRLyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465816; c=relaxed/simple;
	bh=VQBy0en5ta3s73UmW+T8A5N+WqBUR/dA0G6chB1H3bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpYio9q3a6Cz9ekbu+x3REo0oBqWejrbyga24n4AEjmZQcA1SOgOO2GONheQT0GxadGnGNrqxirVwUtRKTfVVjnrcPH7HsZawCHsyGIH+nk95pNUdNX4ahLaT7Sf34YMV6isW8iGOYehMj7ss2tMWpOfQGe+VlCDHttVkm9ylM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jzAd+ZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D963EC4CEDF;
	Tue, 21 Jan 2025 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737465814;
	bh=VQBy0en5ta3s73UmW+T8A5N+WqBUR/dA0G6chB1H3bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1jzAd+ZNvQp/0uZtU43TUbS3zA5U1x4zCypGBPXqjqyQys20M4ZXgEpcF5CtDnGfM
	 EQaMty68MQTZXdxk+MArWHrc8m3E+DUVjN0vkmAJzo4pamRUgCGyoOD5CVWe/hMvhL
	 XSp9zjuFKeGzPLcGxMRgHvOn8uRAHhyJyPv90S8I=
Date: Tue, 21 Jan 2025 14:23:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: stable@vger.kernel.org, broonie@kernel.org, rafael@kernel.org,
	demonsingur@gmail.com
Subject: Re: [PATCH 6.1.y] regmap: fix wrong backport
Message-ID: <2025012144-whinny-haggler-9aba@gregkh>
References: <20250115033244.2540522-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115033244.2540522-1-tzungbi@kernel.org>

On Wed, Jan 15, 2025 at 03:32:44AM +0000, Tzung-Bi Shih wrote:
> 48dc44f3c1af ("regmap: detach regmap from dev on regmap_exit")
> wrongly backported upstream commit 3061e170381a.
> 
> It should patch regmap_exit() instead of regmap_reinit_cache().
> 
> Fixes: 48dc44f3c1af ("regmap: detach regmap from dev on regmap_exit")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/base/regmap/regmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

How about submitting a revert of the mistake and then the original
commit properly backported as a patch series of 2 commits?  That way it
makes it more obvious what is happening here.

thanks,

greg k-h

