Return-Path: <stable+bounces-58285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CDD92B571
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 12:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1831F23A5C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D31215664C;
	Tue,  9 Jul 2024 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RFEylIVe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4E2E62D
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521378; cv=none; b=aw4YTRHujSOY0akPoHWXq/TQJDKn6LyuKC86OOj0uvGGW/BRZoiPcZ60ZE9ri7tu8MDZ9vlYaZTxG0LZQlOGQe7xei2E2mjv2gzo4akqFJo2a9KCQfhGNn3nTzw8Gl0hpazpU7dpdlNYy995sKbRrue96Glajp+3sckEyBSYZ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521378; c=relaxed/simple;
	bh=MTZgg7aeao1trU2Ck0VDmyYq+0Oebij38DC241KOgw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYQYmkzcWOan+urcMDBcRa1/D7BzrBPBHnyw/gBgqMKqj47IAZ4UxRslrOmYOelDFpreW8JO3B3S3sVs0j41mQf0leWnzeRphbFPXA2OrpH+6cGGKPXlLUm6wmG6ZZwwUVp6HiqWdh7nPwX/GNkDJNqBQCsmbnd7FJFzdjbwz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RFEylIVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E069C3277B;
	Tue,  9 Jul 2024 10:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720521377;
	bh=MTZgg7aeao1trU2Ck0VDmyYq+0Oebij38DC241KOgw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFEylIVehwM/zB1K31gk3en9QwE3sSrVfiv2FzmBBtvbos23IFhOW0SCXhEGDTF/L
	 RtRkgL6nHG4kW+1OqkCRw2lnRhTsyUqiMlFEQhaU2yRClL2apgDk7fQY8FDt508d/m
	 c5lcO4Zm6nsidY+iXsoDgp9BM8C+JOH08cK9iNN0=
Date: Tue, 9 Jul 2024 12:36:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org, hdanton@sina.com,
	jack@suse.cz, willy@infradead.org
Subject: Re: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6] nilfs2: fix incorrect inode
 allocation from reserved inodes
Message-ID: <2024070908-fructose-ozone-34cf@gregkh>
References: <20240709053318.4528-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709053318.4528-1-konishi.ryusuke@gmail.com>

On Tue, Jul 09, 2024 at 02:33:18PM +0900, Ryusuke Konishi wrote:
> commit 93aef9eda1cea9e84ab2453fcceb8addad0e46f1 upstream.
> 
> If the bitmap block that manages the inode allocation status is corrupted,
> nilfs_ifile_create_inode() may allocate a new inode from the reserved
> inode area where it should not be allocated.
> 
> Previous fix commit d325dc6eb763 ("nilfs2: fix use-after-free bug of
> struct nilfs_root"), fixed the problem that reserved inodes with inode
> numbers less than NILFS_USER_INO (=11) were incorrectly reallocated due to
> bitmap corruption, but since the start number of non-reserved inodes is
> read from the super block and may change, in which case inode allocation
> may occur from the extended reserved inode area.
> 
> If that happens, access to that inode will cause an IO error, causing the
> file system to degrade to an error state.
> 
> Fix this potential issue by adding a wraparound option to the common
> metadata object allocation routine and by modifying
> nilfs_ifile_create_inode() to disable the option so that it only allocates
> inodes with inode numbers greater than or equal to the inode number read
> in "nilfs->ns_first_ino", regardless of the bitmap status of reserved
> inodes.
> 
> Link: https://lkml.kernel.org/r/20240623051135.4180-4-konishi.ryusuke@gmail.com
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Please apply this patch to the stable trees indicated by the subject
> prefix instead of the patch that failed.
> 
> This patch is tailored to avoid conflicts with a series involving
> extensive conversions and can be applied from v4.8 to v6.8.
> 
> Also, all the builds and tests I did on each stable tree passed.

Now queued up, thanks.

greg k-h

