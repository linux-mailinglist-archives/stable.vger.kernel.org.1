Return-Path: <stable+bounces-15916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1D83E22B
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 20:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062FB2851F4
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449A621A1C;
	Fri, 26 Jan 2024 19:07:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1858224C9;
	Fri, 26 Jan 2024 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296048; cv=none; b=dBFQW53Iy/W89aBfPGGpoNqte4RmjefzPKYqrVBZvyQeUZCpIa13gfkgLWhMjUvVrZpBVfD4D647QKhY7MnuAO6dB8hOHhEujV7IIrkqnQ99lhoYrC7wiuHaPmQeBIwe5hWCcv8YQEGhonTR+dUkn0AdUo4L+QrqFXBYwySL28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296048; c=relaxed/simple;
	bh=jhvDe0thAEiKCA34gd8buHPg5oE2GpZU1QyPUxOXkCU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIjP4Ua5aswT33sa5Kw/Ey6FrBQRcOjh03T43bJdUnwHfPEiXhgryOBev5LcHBt+DiX1bE5GjRO5ikxTe2KzrdZ5u1LA2ocQdru8y2nfgXxbbCdI7zHuD0z2B1RhQoaNQOm500OfB6i0Isz+NcN/hLPCk9UOy+hnGL90QhIPlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 05AFF520153;
	Fri, 26 Jan 2024 20:07:23 +0100 (CET)
Received: from lxhi-087 (10.72.93.211) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 20:07:22 +0100
Date: Fri, 26 Jan 2024 20:07:22 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: <fdmanana@kernel.org>
CC: <linux-btrfs@vger.kernel.org>, <erosca@de.adit-jv.com>,
	<Maksim.Paimushkin@se.bosch.com>, <Matthias.Thomae@de.bosch.com>,
	<Sebastian.Unger@bosch.com>, <Dirk.Behme@de.bosch.com>,
	<Eugeniu.Rosca@bosch.com>, <wqu@suse.com>, <dsterba@suse.com>,
	<stable@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Eugeniu Rosca
	<roscaeugeniu@gmail.com>
Subject: Re: [PATCH 2/4 for 5.15 stable] btrfs: set last dir index to the
 current last index when opening dir
Message-ID: <20240126190722.GC2668448@lxhi-087>
References: <cover.1706183427.git.fdmanana@suse.com>
 <b433c98aae18577662767e98d4119450913dc516.1706183427.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b433c98aae18577662767e98d4119450913dc516.1706183427.git.fdmanana@suse.com>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Thu, Jan 25, 2024 at 11:59:36AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit 357950361cbc6d54fb68ed878265c647384684ae upstream.
> 
> When opening a directory for reading it, we set the last index where we
> stop iteration to the value in struct btrfs_inode::index_cnt. That value
> does not match the index of the most recently added directory entry but
> it's instead the index number that will be assigned the next directory
> entry.

[..]

> CC: stable@vger.kernel.org # 6.5+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Based on https://lore.kernel.org/stable/20240126185534.GA2668448@lxhi-087:

Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>

