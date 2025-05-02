Return-Path: <stable+bounces-139509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC1AA78A8
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 19:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4B85A1F89
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE903256C76;
	Fri,  2 May 2025 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WQCPBWCq"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA41A265E;
	Fri,  2 May 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206875; cv=none; b=bbNbM9FZqmimUZH16aJkxy2SS8xZpStnmibRkV7WZ9eBEv8AZvoK2Sqqr/n/oq4Zjnv5M0o52zPBpoPd4pnilEOqWr2FJmLUF0KLtM/4nRV4qaVgUh+iJuYdPdM/Znhzqnn+JimcNR04OuL1npmOTCq2PDTe7OoQDNFtm3ZyyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206875; c=relaxed/simple;
	bh=Zg3s6l9yHt0bmY9OcEu/mHrSL2EOBJx3dWBv5xqO8ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9S3YIH9JwN5HAPrjEi6gRl4Wt8/GSYSRxbCuLv0FW0Gl9Gu+mOFreKLeRyvj5zXUwBWhGEl0aeiEhQgJTZrAcsWpkRXKpIg8G3uwh/f4oAZcrmL4sNwOnuoP9azmw18hsXgoCzFdv8yUUQ/TU1u09r8ULy0YSYaStWndrXk48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WQCPBWCq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o2CZRmrYH6WViEDb3Ci1U2iZZSMFC+brgZiZSgdJq/E=; b=WQCPBWCqj2+7pye6GzTp1GFPed
	WbiCcgaw86SNHrj3SP5u5SO49x5L/qhbPNXpuPw51E5/CbpxeIryPWKPjqyVtJZfT8r9WWJZAe3A+
	H796609ko6DCye46UfJFirBuryInyInDhe0zp6bKWHRWBSbr3OrxwSJ4jM9vuiS5J8/cEfp6el+Yv
	Z5wxob6+4j3rhPZHK5+o4rkky+ohvZNuA8nKrnJYbK2v8PMiGZSt9YpfsUWSUsUMVqTF2XpPov2Yz
	qNBK63FX8WQp+eSSTSu2zCCJdxGxepmtk5FCmhF6RQnLsYIa1rMAMNTJAwCZ6bcruwbBGsj4Cp/Ll
	m+BetRWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAuAG-00000007sMI-0xrH;
	Fri, 02 May 2025 17:27:08 +0000
Date: Fri, 2 May 2025 18:27:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrey Kriulin <kitotavrik.s@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrey Kriulin <kitotavrik.media@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: minix: Fix handling of corrupted directories
Message-ID: <aBUAbPum1d5dNrpG@casper.infradead.org>
References: <20250502165059.63012-1-kitotavrik.media@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502165059.63012-1-kitotavrik.media@gmail.com>

On Fri, May 02, 2025 at 07:50:57PM +0300, Andrey Kriulin wrote:
> If the directory is corrupted and the number of nlinks is less than 2 

... so should it be EIO or EFSCORRUPTED?

