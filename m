Return-Path: <stable+bounces-32953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC588E74C
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5E82A0FD6
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C349D130A44;
	Wed, 27 Mar 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="swS5lbs0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69117130A42
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547291; cv=none; b=WhOxQzRIPUwCptHFXcZFphaCuiFcfpnPCmlHTCKY92pLbmoNMDXgymiTg6jYK1NXSD9NoKVfFX3wdU7E2pnuwbgw+wbuYuZlPIhw6S959PWeda71ueVh+WhxWQTaKPgIuNnLenMA2+YcUI+VwuOlMt167zbQqV/nT/4Rrx3Me6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547291; c=relaxed/simple;
	bh=h621EV0BAzcni0diSO70P8wQX8ZggVhhV2thuDOx1Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOtPS9Sm6DDi3NgwH8UneZzQ4czOTY+9X/TFgOxMSw5EuBpN/3iwTrLZK51I/i4E5Ud2bK9wPOD2BNJiDZfE2nEZe8/hdeXXvoqf7/cpsHQIZQpb9KTlWY5aHt8qA6MeMYNJ3EWHmjCndfwOMc/6OhqfSyy7kQljQhrf4Xfxg+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=swS5lbs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89774C433C7;
	Wed, 27 Mar 2024 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711547291;
	bh=h621EV0BAzcni0diSO70P8wQX8ZggVhhV2thuDOx1Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swS5lbs0VnptcQ8t3vyPbcj+bhzjnDtUwvLkWXqRWZA4JFgPq0OYEjh+V2vJOHVWD
	 bjvECR5tw48faVrT3suivu8MAXkj9jV1PCtgfSbfqC55FdQfTsSdiJ236vuZ+Scwyq
	 1KAoAjvxo7TCnHBxjlYIyTqUA3WhAl0Xg02RjuNY=
Date: Wed, 27 Mar 2024 14:48:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: VRR on Framework 16
Message-ID: <2024032701-pushy-launder-a1ca@gregkh>
References: <c5e3c677-0687-4417-a8af-b5000295309b@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e3c677-0687-4417-a8af-b5000295309b@gmail.com>

On Sat, Mar 23, 2024 at 12:49:53PM -0500, Mario Limonciello wrote:
> Hi,
> 
> Framework 16 supports variable refresh rates in it's panel but only
> advertises it in the DisplayID block not the EDID.  As Plasma 6 and GNOME 46
> support VRR this problem is exposed to more people.
> 
> This is fixed by:
> 
> 2f14c0c8cae8 ("drm/amd/display: Use freesync when
> `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found")
> 
> Can you please bring this back to 6.6.y+?

Now queued up, thanks.

greg k-h

