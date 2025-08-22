Return-Path: <stable+bounces-172330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2206BB311FB
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 10:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10AA3B3FA0
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B882EB86C;
	Fri, 22 Aug 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hvl+eNdO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DC21883E
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852122; cv=none; b=n7Q5jtuDxB+NCjIEf5aMeYljTmjFuXMIzRrz7D4NVuCpV7dYXgEjVgkVz2FphW0CYaALso7vwkLCnG0o6UHxElUOWNgho9aK4WeqRzGnxLGKz5dA+MiUY4NPhT1uDkKo280dckOTNXjF2n6xI7PbYp9Ks94v/MEQE/RcBj0f0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852122; c=relaxed/simple;
	bh=n3+jajy5boksX3TgAW1I7VxIYG3jgRuwOVpGoRLN1Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3/QXtwIv3E+s/2AE//YLf1aIqRjnaDGbortp3amTdBDReel86lzq0YWFDGbXAkCXgemi/5SH2QegN4t3mWJmNEIneJQM3AKnoXtAusiLGxhDsCmuDe9sgtG+amoX/dQrlzy7jKGMbDao0vPfvZP92MWwVaefhh8qCV0SHYcjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hvl+eNdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600ECC4CEF1;
	Fri, 22 Aug 2025 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755852121;
	bh=n3+jajy5boksX3TgAW1I7VxIYG3jgRuwOVpGoRLN1Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvl+eNdOEtAsGRjKgDjFUkUq3QvEdGuXZ3G6MM57IeKGQNVYBvPemKRRNXo0uDfci
	 0lfamrkEZpyCEgqyjB9OfpThLMUt7qjjoXN6iczJThi7fjU8wMisI90KOvSCYhH8Wu
	 YaPmz5dWrPHZ94v4FleG94UpMQHZVAiH8w2aYvWE=
Date: Fri, 22 Aug 2025 10:41:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.6.y] btrfs: don't skip remaining extrefs if dir not
 found during log replay
Message-ID: <2025082219-decal-wired-6568@gregkh>
References: <2025081818-rimless-financial-6942@gregkh>
 <20250819001451.192078-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819001451.192078-1-sashal@kernel.org>

On Mon, Aug 18, 2025 at 08:14:51PM -0400, Sasha Levin wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> [ Upstream commit 24e066ded45b8147b79c7455ac43a5bff7b5f378 ]
> 
> During log replay, at add_inode_ref(), if we have an extref item that
> contains multiple extrefs and one of them points to a directory that does
> not exist in the subvolume tree, we are supposed to ignore it and process
> the remaining extrefs encoded in the extref item, since each extref can
> point to a different parent inode. However when that happens we just
> return from the function and ignore the remaining extrefs.
> 
> The problem has been around since extrefs were introduced, in commit
> f186373fef00 ("btrfs: extended inode refs"), but it's hard to hit in
> practice because getting extref items encoding multiple extref requires
> getting a hash collision when computing the offset of the extref's
> key. The offset if computed like this:
> 
>   key.offset = btrfs_extref_hash(dir_ino, name->name, name->len);
> 
> and btrfs_extref_hash() is just a wrapper around crc32c().
> 
> Fix this by moving to next iteration of the loop when we don't find
> the parent directory that an extref points to.
> 
> Fixes: f186373fef00 ("btrfs: extended inode refs")
> CC: stable@vger.kernel.org # 6.1+
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/btrfs/tree-log.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

This isn't applying to the 6.6.y queue right now:
	patching file fs/btrfs/tree-log.c
	Hunk #1 succeeded at 1446 (offset 1 line).
	Hunk #2 FAILED at 1458.
	Hunk #3 succeeded at 1512 (offset 10 lines).
	1 out of 3 hunks FAILED -- rejects in file fs/btrfs/tree-log.c

Can you rebase and resend?

thanks,

greg k-h

