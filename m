Return-Path: <stable+bounces-121727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C7EA59AD8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46853A4115
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E9226CFA;
	Mon, 10 Mar 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OfyWgS3/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837719D8A0
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623717; cv=none; b=jrlG205TfJ42yzW3Ww7J3oVM9YKOlWbOnCuCML9m2X8XcSmVR4ril4K4riyVPlg1BKeVHs3SrgRDZurxaxFSH6pYiTW/Yly8ACeXJqS5rHTIYoGXlzksDYFVGRdF+32r+ymC3uLMBjveDPOmUpGha/8jy+jt8+tlE+o2lYxWtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623717; c=relaxed/simple;
	bh=E6oy7jeFP+aWKFIjCMI1vRpOMHIiJff0zIJx3uw52VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTQzKJ+xx7kJaN66mNeHevjxug+efYyYVp0J3ScQqIgH/wPpcFces6SCVrdd2q6YURfn6oyjqHtfYu07fbZykH0Le1hpu3uyk5FwGHyEz9SLhivHFEPXi8PrA5HT6QF2zmflfKrxLZhJpyIJa9A/3IA7bzfEaSJxret/DrhL3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OfyWgS3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A14DC4CEE5;
	Mon, 10 Mar 2025 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741623716;
	bh=E6oy7jeFP+aWKFIjCMI1vRpOMHIiJff0zIJx3uw52VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfyWgS3/IDc3r8ySkkXarBotvGGyaovB0zQYtwXCICcJ+7hMe2Xv6YkGWpIy2+y48
	 70Ig4zw1lmsLT/iKP9DojDZ8x3PUS5QeWwbt+/K+5N9PIB8RDMzwp03auLIN0rTgZE
	 DAlXVhTVBb99Ng04IGiihZUox2ZIaA6KfFqVXYlY=
Date: Mon, 10 Mar 2025 17:21:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel =?iso-8859-1?Q?Garc=EDa?= <miguelgarciaroman8@gmail.com>
Cc: stable@vger.kernel.org, skhan@linuxfoundation.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+010986becd65dbf9464b@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.15.y] fs/ntfs3: Fix shift-out-of-bounds in
 ntfs_fill_super
Message-ID: <2025031032-bamboo-unsent-00fa@gregkh>
References: <20250309145636.633501-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250309145636.633501-1-miguelgarciaroman8@gmail.com>

On Sun, Mar 09, 2025 at 03:56:36PM +0100, Miguel García wrote:
> From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> 
> commit 91a4b1ee78cb ("fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super")
> 
> This patch is a backport and fixes an UBSAN warning about shift-out-of-bounds in
> ntfs_fill_super() function of the NTFS3 driver. The original code
> incorrectly calculated MFT record size, causing undefined behavior
> when performing bit shifts with values that exceed type limits.
> 
> The fix has been verified by executing the syzkaller reproducer test case.
> After applying this patch, the system successfully handles the test case
> without kernel panic or UBSAN warnings.
> 
> Bug: https://syzkaller.appspot.com/bug?extid=010986becd65dbf9464b
> Reported-by: syzbot+010986becd65dbf9464b@syzkaller.appspotmail.com
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Signed-off-by: Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
> (cherry picked from commit 91a4b1ee78cb100b19b70f077c247f211110348f)
> ---
>  fs/ntfs3/ntfs_fs.h |  2 ++
>  fs/ntfs3/super.c   | 63 +++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 50 insertions(+), 15 deletions(-)

We need a 6.1.y version of this first.  Please submit that first and
then resend this for older kernels.

thanks,

greg k-h

