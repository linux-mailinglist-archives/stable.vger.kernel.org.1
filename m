Return-Path: <stable+bounces-176485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320FB37F3D
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C864616A0
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C022ECE91;
	Wed, 27 Aug 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1rV1avx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579A28312E;
	Wed, 27 Aug 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288252; cv=none; b=AtnfFtzD6QFH+fXG8CGuJhsKa7m2gOK3hqY51syz/RbI33gSPjehuR8fe8Z9ojoVC7CEw82JBod4ob4P8wgrBeC52H0l9B57EocS/7aDnajNPFGSD7AJG6i5SzVjcg/hopwb5uGu3UwZOFVCUJHKPA9ARL3GhpW9lne3yDq3z90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288252; c=relaxed/simple;
	bh=Z9v7tOyCLbVTC4vbmMT5DzEjyMHuEBoDGU4LdAB1szI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFx3hGMDRm2PrnVil5wJZb/chxakJJGPm7z8oC5UMrrgxPO8abO0oWW9UoIwK9dAuIiuAJse1VZ97AWs2jGenV/GIfSWDoX7018Knko5SGcc4yO//hsuyMOHzFWX1hHFMrngMJjkYb0ZueTIHZuOofS0liFea7vvSYG5OmOKMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1rV1avx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BBBC4CEEB;
	Wed, 27 Aug 2025 09:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756288252;
	bh=Z9v7tOyCLbVTC4vbmMT5DzEjyMHuEBoDGU4LdAB1szI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1rV1avxJGTQkHo2kkYr9KjIlQIEsq4jp2M+0eC+XLVYV2v/Z9KWSQZW06cy/y7bm
	 CGHKJcpZ8WOCC+igAh/FgfalIRE417Q2tNSs3Up4pJt11+6RGSh+jGMzgQ9jqDekHm
	 Ywzbnjx96ycDhZPFZwS+72u+/MRorJkn4I5QCMixVFFdFltmOnlhefAJh94kPz1PC+
	 t+b4UkMse3Er+MxQjpG4cDH5yIwKjZckkJeWQqhUaH1WHayO2XUNjrxYqvavjTFmG7
	 J6GV/vpAmc+Ymvn/fP5xCcDLUL0POUnb9GujFIBbhJN3PQTuUu3Ilxth9v8Z3EzBEf
	 70Ggujy2F15Yw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1urCnf-000000002L0-1A0D;
	Wed, 27 Aug 2025 11:50:39 +0200
Date: Wed, 27 Aug 2025 11:50:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Carlo Caione <ccaione@baylibre.com>,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] firmware: meson_sm: fix device leak at probe
Message-ID: <aK7U7-ebrPcxwEIj@hovoldconsulting.com>
References: <20250725074019.8765-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725074019.8765-1-johan@kernel.org>

On Fri, Jul 25, 2025 at 09:40:19AM +0200, Johan Hovold wrote:
> Make sure to drop the reference to the secure monitor device taken by
> of_find_device_by_node() when looking up its driver data on behalf of
> other drivers (e.g. during probe).
> 
> Note that holding a reference to the platform device does not prevent
> its driver data from going away so there is no point in keeping the
> reference after the helper returns.
> 
> Fixes: 8cde3c2153e8 ("firmware: meson_sm: Rework driver as a proper platform driver")
> Cc: stable@vger.kernel.org	# 5.5
> Cc: Carlo Caione <ccaione@baylibre.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Can someone pick this one up (along with the compile-test patch)?

Johan

