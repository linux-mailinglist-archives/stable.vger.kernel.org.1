Return-Path: <stable+bounces-124388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEEFA602E5
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7DB189017B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23F61F4622;
	Thu, 13 Mar 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gXgVphce"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA101145A11;
	Thu, 13 Mar 2025 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898648; cv=none; b=qwfifXDev3qWqjUw6ZocZX8TGr1vG4Z/9hM/N3aQhS1opDv0imqjVMCw6OEe3eSdOaIq7JNp/SFNdRcxincNpREy2JY1HRONUkL2P0A6Lml09vWBL9AqfVS5qM8qbcdhI/VLkcxf/ZxobPLNlSrrDUzfZHHqyEvYKQ017c2bOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898648; c=relaxed/simple;
	bh=RryZonxvV0vbSqPsHbYtQoEo7xLmDtXVIgIbIc6z+Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyprMP/ujXUpKOewX++m7pC1RynpRuzskhWEtS/1MjT/nxUEyF61o1CGsYezttpWWFN7/Abzp5iqnQwwAwKceLu9MQNYOR6fvaiphQqTi9QRKgKFrjwTwp1ZXGbABxtsaxX76RGqxxtS07qelgvsNw5s6LCS8MblZKAlKUpWVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gXgVphce; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HplivPJycpi91IA2rzFE+l/FsDz+UagBls7/xN1sTmM=; b=gXgVphcesq3Y6JWeEGqEicExfO
	+q5wCF0I5WF180fpjuI838fUQ8rBP1tpsiGKIJfvoXWTl8F6DZT+DgjY03ifc1qo5UBXi8OsRO4Hm
	Cy3gpXvxclhjIt8vgrrs0szX8W0tybPOK6aqrsbq6gKhxOz1UJaYMuuwdjmaomMXQEd0j6zxXj1oN
	xJVxt2ficAOePcoCYtoX0+K/YAllzMzxwMwHf5UD5MEjZSHTLiCSn74fPE7rT/+88Pfw5OlfmBTUO
	cBP5HG8ZYsNX9NNl+vxuHvkljtABlTchrTf9awpRrHcmCPnTT2DSmdlxcHRYvHyTq7spwC9751Veh
	B/tqr29g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tspPM-00000004DM9-2cZm;
	Thu, 13 Mar 2025 20:44:00 +0000
Date: Thu, 13 Mar 2025 20:44:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dev Jain <dev.jain@arm.com>
Cc: jroedel@suse.de, akpm@linux-foundation.org, ryan.roberts@arm.com,
	david@redhat.com, hch@lst.de, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Update mask post pxd_clear_bad()
Message-ID: <Z9NDkFzSj-vnvGOy@casper.infradead.org>
References: <20250313181414.78512-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313181414.78512-1-dev.jain@arm.com>

On Thu, Mar 13, 2025 at 11:44:14PM +0530, Dev Jain wrote:
> Since pxd_clear_bad() is an operation changing the state of the page tables,
> we should call arch_sync_kernel_mappings() post this.

Could you explain why?  What effect does not calling
arch_sync_kernel_mappings() have in this case?

