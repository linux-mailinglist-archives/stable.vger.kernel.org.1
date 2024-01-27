Return-Path: <stable+bounces-16046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D58483E8C1
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134D3285F39
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990F81FAF;
	Sat, 27 Jan 2024 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KEOluqC5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957E5390
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316603; cv=none; b=XpoNIloygXYPRmIQlkrEPlQqRmVoG+73WffR+mxlV3WvdA45IedfEisALO/qsvK9y6cb4QzFxwaTVlFlRJNGsZEvJsmIraukSPQxnYAKNDBjqv+5ljj3A5x11XwDKDTkW4rHXOab1kuwH3WSaKt4IlO1joLiZL/oabFIHnirw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316603; c=relaxed/simple;
	bh=QO+HjwM34u9feupS1mlKhZWobTcEkGPLzhPBcbM0FZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFFsM5lAQeZV23V+FSNiJtay2k4yw3Oh6MM9QnnDVHEXKthCiodIbTywt1JfthzTKac3k0v+Ti/cUGI1zf3Sg6Cklpos8BSmVTK2xK+1nA34uaEUBhK+wYNGl6ThyokyAPGsteeiCDHl0tP130lYiA+hjIlF5AIc9aHFpqAPeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KEOluqC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0591C433F1;
	Sat, 27 Jan 2024 00:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706316602;
	bh=QO+HjwM34u9feupS1mlKhZWobTcEkGPLzhPBcbM0FZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEOluqC5vd4h3kr/xy1IVNy3uO5dHiZRlPhs6j3i6ecO8YLDVDqTTbn5Fy6aRqgUa
	 gdbHcCKKvfTryFCYPY8nwaAzfU8oQSbJ3EeKeua7g/7i4jfkFXZFzGhn+Gz0GKAYrt
	 u3T8Gl/Uy6p0yoz+FhYbzGbBrUiNOy0DBdNywP8Y=
Date: Fri, 26 Jan 2024 16:50:00 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: oficerovas@altlinux.org
Cc: stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>, kovalev@altlinux.org,
	nickel@altlinux.org, dutyrok@altlinux.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] mm: vmalloc: introduce array allocation functions
Message-ID: <2024012641-yiddish-vividly-7fa7@gregkh>
References: <20240126095514.2681649-1-oficerovas@altlinux.org>
 <20240126095514.2681649-2-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126095514.2681649-2-oficerovas@altlinux.org>

On Fri, Jan 26, 2024 at 12:55:13PM +0300, oficerovas@altlinux.org wrote:
> From: Alexander Ofitserov <oficerovas@altlinux.org>
> 
> From: Paolo Bonzini <pbonzini@redhat.com>

Nit, duplicate From: lines :(

I'll fix it up by hand, watch out for that next time please.

thanks,

greg k-h

