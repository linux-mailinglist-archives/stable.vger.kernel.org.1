Return-Path: <stable+bounces-100559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2E9EC6D5
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB5B2810A1
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B71C233E;
	Wed, 11 Dec 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WMNXfUHM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85C1D61AF
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904999; cv=none; b=rdhsvo+tLKPsnozA39lGlQEDZXt2Prpz4dYHmW697tR5HM5Ju5XZfz1m+RAfQLpKWztFC8cy1KLcoM0KcVHMFVHSUZmoCnO2zAq0uRtFz9q54T4DurvPFXBmO8rMDvt0x9cX9DdTHlArLyDjUJzRPe96b5K0iiordyaD6yTuRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904999; c=relaxed/simple;
	bh=PurrkkEdGfFN63rZ1jHjv4E9oTqZ7TDoXB2q53wjDeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCZ6C3lEKTIxbXX8hBUE8FOmRxEH1DuIYCMLirpEN/pRbJXs4sl5cdtBP5Fw3c1BtIdQh0JJuA0YswfxMNzhW6jT5Sb7klBGbvTPgVXiyNZ93QTcH/kQX3WVJVfGzqEc21TX5P1nn1LdY/P2UFh4pizbkgh8gJ42MrRnEckl9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WMNXfUHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D50C4CEE1;
	Wed, 11 Dec 2024 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904998;
	bh=PurrkkEdGfFN63rZ1jHjv4E9oTqZ7TDoXB2q53wjDeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMNXfUHMsnN105kQR3OrjawMEtFEmbNPvYceRIDFRBJW+wDtKXomdJWULBkFSg7bB
	 IoMdwaGkO3juG65aBLpHTsh3oK4AEfStQO6+7lUgjUx064Pfs9K/WXPumegCy7/pAN
	 no6HyQE/5qiynWdhbtFq4VHDWKj+K4U0te1XLdao=
Date: Wed, 11 Dec 2024 09:16:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: sohaib.nadeem@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/amd/display: fixed integer types and null
 check locations
Message-ID: <2024121159-pandemic-morale-4f80@gregkh>
References: <20241205032629.3496629-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205032629.3496629-1-jianqi.ren.cn@windriver.com>

On Thu, Dec 05, 2024 at 11:26:29AM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Sohaib Nadeem <sohaib.nadeem@amd.com>
> 
> [ Upstream commit 0484e05d048b66d01d1f3c1d2306010bb57d8738 ]

Please cc: all relevant people on backports.

