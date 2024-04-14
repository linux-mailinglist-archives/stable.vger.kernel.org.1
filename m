Return-Path: <stable+bounces-39384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF0E8A42AA
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 15:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788791C20C1E
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E98D43AD1;
	Sun, 14 Apr 2024 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nlkd53+N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A8328DB
	for <stable@vger.kernel.org>; Sun, 14 Apr 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713101927; cv=none; b=C47OSbnD8VZGsMQ6NB2Bes5zTwue3jX4csD8ncu4seEEOaYdxQ/udnadjS+1YnlsNZVIMnxU1mgzmHnglmbLGUCsdoTH+BcxKeO689g+3OxfoWn95g+ax86ibzTcegXjn3yzPkTex4lh0iJATr/V/b6GAz9J/VLvAwkEYu5zTYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713101927; c=relaxed/simple;
	bh=DuRZhsV6X/wtUWNFETMA7cMQRBeJzNd1d4c3986PUMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0j4KfvMkHBHCYcrIhws7Cue5hQYgp1HOoaZJMA2rVsi//ElDwIH9ZXkbu9W9m+1xhgSHwfROtlE2Vcn+0S4+P/yDY77FgpqdCxLW3PgASjbU4kpbf8ix/EG/N7allSsBi/DEo44rp0neN74p3D8huZ6XMKN5UEj2qGCKdNrcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nlkd53+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209B4C072AA;
	Sun, 14 Apr 2024 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713101926;
	bh=DuRZhsV6X/wtUWNFETMA7cMQRBeJzNd1d4c3986PUMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlkd53+N4s7CRImUXXARPnH9ZTzYUyuosG/+lJUeVOjomfs5AJ+ef+4q+1Njn5jFq
	 hZw6/qdos114j2bDjp11TYH4Jwxy7We1ljJQzu6tXDmLKZx4VFaLrzhttHhy/yvAxY
	 x3IhITutTsa8kIYmSrKcIMIaT4sg03GP5oeA/O0s=
Date: Sun, 14 Apr 2024 15:38:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@gmail.com>
Cc: stable@vger.kernel.org, David Markey <david@dmarkey.com>
Subject: Re: S4 fix for Phoenix laptops
Message-ID: <2024041436-reptilian-elastic-4256@gregkh>
References: <CA+EcB1OKkBSj-VoJpyAgTxPEuj9EOBz-B6Li6fcByYjME7QxDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EcB1OKkBSj-VoJpyAgTxPEuj9EOBz-B6Li6fcByYjME7QxDQ@mail.gmail.com>

On Fri, Apr 12, 2024 at 01:19:30PM -0500, Mario Limonciello wrote:
> Hi,
> 
> This fix was sent out for fixing S4 under stress on some Phoenix laptops.
> 
> 31729e8c21ec ("drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11")
> 
> David Markey confirmed[1] it helps Framework 13 under S4 stress
> testing.  Can you please bring it to 6.1.y and later?
> 
> [1] https://community.frame.work/t/responded-arch-hibernation-woes-on-amd-13/45474/38

Now queued up, thanks.

greg k-h

