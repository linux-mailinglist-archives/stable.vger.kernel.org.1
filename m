Return-Path: <stable+bounces-126042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77203A6F7CA
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E423ADE2E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E8A1E833A;
	Tue, 25 Mar 2025 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmZYKBPy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA40537E9;
	Tue, 25 Mar 2025 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903524; cv=none; b=AUyklEUCTrah3Eyse/NWuVs5aP6DhXOomtdesrb1cKuwJ0J+EzUCWAwmYi0k545XHRbX7j0uk0IIQj0e69rMCdnJGfgfTi08vSi5bhr+LgO1vLQxiP7TUxfVxI7SWyMVNtBvK3gxi535gf7W/bgMAK8d1OTwMjzpSRYtw0VXv84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903524; c=relaxed/simple;
	bh=njnwEJyt8K7lwR132JkMh3c5yfD1915hNCz0lyDEn7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcrnyR7wo+vyyhGw0azu8vsEI16RN1dHsWX+yFrajmZELxXdkYT5xyv+/ULBj9PjjlPB5fR0Vns75D2lQkjOOqww1C5I/o14mSXSnKBeCThj7sPA8TeZXhIrgdSR7LMJrTZc1cccs+C8Fbf17KnqlS/w38V3/C0SfJOROK+gl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmZYKBPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B46C4CEE4;
	Tue, 25 Mar 2025 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742903523;
	bh=njnwEJyt8K7lwR132JkMh3c5yfD1915hNCz0lyDEn7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmZYKBPykLYm/lxF6jdD0FuC625MHxmv4jbvDmkWadDgiqaSDi2NzBCoV11oZFJ4y
	 BLij/uOryidNB9aT7tglkxlVNzt0+g1ET6U4hNo4/JncAUp2tBrm/fagkvI/TTdXcY
	 ELwrSJcQRF0igJgLQADi2cvaG9lL5Qi1JdP2C5M0=
Date: Tue, 25 Mar 2025 07:50:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, stable@vger.kernel.org,
	xfs-stable@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover
 intent items
Message-ID: <2025032533-bamboo-dagger-7ba7@gregkh>
References: <20250313202550.2257219-15-leah.rumancik@gmail.com>
 <6pxyzwujo52p4bp2otliyssjcvsfydd6ju32eusdlyhzhpjh4q@eze6eh7rtidg>
 <CACzhbgRpgGFvmizpS16L4bRqtAzGAhspkO1Gs2NP67RTpfn-vA@mail.gmail.com>
 <oowb64nazgqkj2ozqfodnqgihyviwkfrdassz7ou5nacpuppr3@msmmbqpp355i>
 <CACzhbgQ4k6Lk33CrdPsO12aiy1gEpvodvtLMWp6Ue7V2J4pu4Q@mail.gmail.com>
 <wv2if5xumnqjlw6dnedf5644swcdxkc6yrpf7lplrkyqxwdy4r@rt4ccsmvgby4>
 <CACzhbgQ2dD7A4hYDES-QdcCQtkMsrdifsaTORTDebPHEooZSLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzhbgQ2dD7A4hYDES-QdcCQtkMsrdifsaTORTDebPHEooZSLg@mail.gmail.com>

On Mon, Mar 24, 2025 at 02:10:03PM -0700, Leah Rumancik wrote:
> This sounds good to me.
> 
> Greg, can we drop the following patches?
> 
> '[PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover'
> '[PATCH 6.1 15/29] xfs: pass the xfs_defer_pending object to iop_recover'
> '[PATCH 6.1 16/29] xfs: transfer recovered intent item ownership in
> ->iop_recover'

Now dropped, thanks!

greg k-h

