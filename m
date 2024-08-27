Return-Path: <stable+bounces-70342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A972960AA7
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72117B22EA2
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA319885D;
	Tue, 27 Aug 2024 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MBng4F5I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597101BA86C;
	Tue, 27 Aug 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762393; cv=none; b=r3lamOHyvgthV9Q0PZ3CdPk99T8L5OJ+dT9gpKFkUc3aLYElGp7gg9aBmDq69i8uXgL1kYidNyLdv1VIBbfirjnsRbpKFm/VIK4KEDJWEkh/Lqw0jw5+sQMzw2adCiZjyyreR4hn7deQfna/7JRWqsa/8p/Ng62te0iVsJ2vduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762393; c=relaxed/simple;
	bh=mudCoXkz4CTSYt8dzE8uGRUx6U0FFoETk2nwROgEuSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIT/+3QMr2IEogsF57+7Do+JoFmOg43k05FSBHKwfv+LS3o2QxT0UnAuwtUHffwugoMHNSiTCAYz3lTz3YLZKPkawqu7vfZ6VYqBDJs1RoLcw7y7TQE+hcqodD86bH5BXPKKpgBN40cG5ZTIQiaRsigwUN0amVDfk7WmGxB8I6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MBng4F5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743B1C4FDF7;
	Tue, 27 Aug 2024 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724762392;
	bh=mudCoXkz4CTSYt8dzE8uGRUx6U0FFoETk2nwROgEuSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBng4F5IaIf0EmY0FAIrYQxcpXbk6sFB3e/4GqPny91B/moEHfnsGcTe4b4z/oN4V
	 Sd1fD45i0BEGeL5X/1vPT/ex1WUyA+H7rhPs2tJ5nO1vCQRKm+8bhOSZ9bu04cRnu4
	 aNklSOKtcwOZPxZt9pnCqTm41CeLjxLud0NkY6B0=
Date: Tue, 27 Aug 2024 14:39:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Philip.Yang@amd.com, Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Patch "drm/amdkfd: Move dma unmapping after TLB flush" has been
 added to the 6.6-stable tree
Message-ID: <2024082704-stilt-bacteria-1d73@gregkh>
References: <20240820120055.2972871-1-sashal@kernel.org>
 <16bbce82-35bc-4ee7-ad00-b8319148a415@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16bbce82-35bc-4ee7-ad00-b8319148a415@amd.com>

On Tue, Aug 20, 2024 at 11:58:30AM -0400, Felix Kuehling wrote:
> This patch introduced a regression. If you want to backport it, I'd recommend including this fix as well:
> 
> commit 9c29282ecbeeb1b43fced3055c6a5bb244b9390b

Wrong git id :(

Or right one, but the amd graphics tree is so messed up it's hard to
tell, there's a different commit with the same content but different id.

{sigh}

greg k-h

