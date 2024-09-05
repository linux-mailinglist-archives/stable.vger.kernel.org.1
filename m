Return-Path: <stable+bounces-73152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C38A96D133
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4378BB21C80
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2A193070;
	Thu,  5 Sep 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2kgCy4j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE591925B0
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523466; cv=none; b=lxC1pRRoNgmIMwAx3RZJgVH/nuPZ4A03eSmkyx4jWv51wX+U/SCdrx4Oa8XiJnJo/2rtcbQTIbY0Qhv8sTcVr9pZSz3MSWAWfTkkLhmSzq8Rathhlh+SbsdyP8u0j17pgrv9wDtG1Hwh/PdnowOY/XlRWvQHfo++IJlzMj9ZghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523466; c=relaxed/simple;
	bh=vo7VvD3zDcrOVNqTGgLuDE6YQg9UvOD5NS5YucnhBHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rofaRPUqkFEb3RSrpDy+smVWCLt63Hv1UBWhjHgiHEYT1LY12beNCcrd/e8Q3DeJydl/Xpvyr0hZMuwCTnbhJ/71W28/iG8pBmQyzhJisJR3J1HzRTAOJj5dqi7TC9YVTp1KaGrheR3KC7zaeH2qxU8ztZL5lzzbk7IhdCSHOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2kgCy4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665DEC4CEC3;
	Thu,  5 Sep 2024 08:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725523465;
	bh=vo7VvD3zDcrOVNqTGgLuDE6YQg9UvOD5NS5YucnhBHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2kgCy4jeweHz9gr1AizVW/t1WDfmFMtLf9Ca9VhhNG/KSLwMfY9eOYTMLPu3Tu69
	 /LU8g76oSkSy7oWjHVH8C8ADCQ4vvRRKSVLfeAlMF1BxDKx0ZWix1REqBtTSSKhQau
	 q4QF/LNVs+EFFofuwoyraxzDs/gQ89i/Wc/7gal0=
Date: Thu, 5 Sep 2024 10:04:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: sashal@kernel.org, dvyukov@google.com, stable@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: Missing fix backports detected by syzbot
Message-ID: <2024090538-closure-mom-49c0@gregkh>
References: <20240904102455.911642-1-nogikh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904102455.911642-1-nogikh@google.com>

On Wed, Sep 04, 2024 at 12:24:55PM +0200, Aleksandr Nogikh wrote:
> Hi Greg, Sasha,
> 
> A number of commits were identified[1] by syzbot as non-backported
> fixes for the fuzzer-detected findings in various Linux LTS trees.
> 
> [1] https://syzkaller.appspot.com/upstream/backports
> 
> Please consider backporting the following commits to LTS v6.1:
> 9a8ec9e8ebb5a7c0cfbce2d6b4a6b67b2b78e8f3 "Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm"
> (fixes 9a8ec9e) 3dcaa192ac2159193bc6ab57bc5369dcb84edd8e "Bluetooth: SCO: fix sco_conn related locking and validity issues"
> 3f5424790d4377839093b68c12b130077a4e4510 "ext4: fix inode tree inconsistency caused by ENOMEM"
> 7b0151caf73a656b75b550e361648430233455a0 "KVM: x86: Remove WARN sanity check on hypervisor timer vs. UNINITIALIZED vCPU"

Note, for kvm, and for:

> 4b827b3f305d1fcf837265f1e12acc22ee84327c "xfs: remove WARN when dquot cache insertion fails"

xfs patches, we need explicit approval from the subsystem maintainers to
take them into stable as they were not marked for such.

Please work with them to get those patches merged if you wish to see
them in stable trees.

thanks,

greg k-h

