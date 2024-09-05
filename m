Return-Path: <stable+bounces-73155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214F296D1B3
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4171C219C7
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 08:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF565194C86;
	Thu,  5 Sep 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BSPyjanc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E0194AEE
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523932; cv=none; b=as5tvE7Cq4DLYYdxaZrW6+C2RWdyyVhykUxkWiNnFiSrIm5tJmTooVATVepFclIObZWJghwPvx3r1z42YIb3G91sI+PfdxDoiF89yxMCbKx8TtPkSEQsEgxLMSx+QOVAeFxpjMkOq50AAoICQcEbK+AQpnBkAD7ZgFJ8CcXGG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523932; c=relaxed/simple;
	bh=yqTMfqhSKEQck3azA3eDAi40mgMOdLU4EXA40IcwahA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e20mQVh82Ix95xLUsVugyzZ3g60AhEeMZhThzpFILFrMbr78mHX9ED+3c8Hau5m9b9cjMehJVhfumPD5jAgDEEwGPzVq/ysfA60Zy745OnSLnt6tGbGd8Py8O7I0mzmX2UDvc++pqhlz04KPvatIh24rcXGP2XDRd57IxJ8LP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BSPyjanc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3E4C4CEC4;
	Thu,  5 Sep 2024 08:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725523932;
	bh=yqTMfqhSKEQck3azA3eDAi40mgMOdLU4EXA40IcwahA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSPyjancUgHUcjpgIMmT3O8OjhLRF7ssaO3p992h7rw1e9hS5qSgiHi4y5iivYsVS
	 K2U85KeKY3KGem2kzioAG0r7f1wXnXVGii4Cd4N2VTybIbWXzlfBWYzOVo0mcKgV3h
	 Pf6+R906PUQsOSh9bErX+uuKN1q7N0F1lV3DXhJg=
Date: Thu, 5 Sep 2024 10:12:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: sashal@kernel.org, dvyukov@google.com, stable@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: Missing fix backports detected by syzbot
Message-ID: <2024090546-decorator-sublet-8a26@gregkh>
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
> c2efd13a2ed4f29bf9ef14ac2fbb7474084655f8 "udf: Limit file size to 4TB"
> 4b827b3f305d1fcf837265f1e12acc22ee84327c "xfs: remove WARN when dquot cache insertion fails"
> 
> These were verified to apply cleanly on top of v6.1.107 and to
> build/boot.
> 
> The following commits to LTS v5.15:
> 8216776ccff6fcd40e3fdaa109aa4150ebe760b3 "ext4: reject casefold inode flag without casefold feature"

Wait, what about 6.1 for this?  We can't move to a new kernel and have a
regression.

> c2efd13a2ed4f29bf9ef14ac2fbb7474084655f8 "udf: Limit file size to 4TB"
> 
> These were verified to apply cleanly on top of v5.15.165 and to
> build/boot.
> 
> The following commits to LTS v5.10:
> 04e568a3b31cfbd545c04c8bfc35c20e5ccfce0f "ext4: handle redirtying in ext4_bio_write_page()"

Same here, what about 5.15.y?

> 2a1fc7dc36260fbe74b6ca29dc6d9088194a2115 "KVM: x86: Suppress MMIO that is triggered during task switch emulation"
> 2454ad83b90afbc6ed2c22ec1310b624c40bf0d3 "fs: Restrict lock_two_nondirectories() to non-directory inodes"
> (fixes 2454ad) 33ab231f83cc12d0157711bbf84e180c3be7d7bc "fs: don't assume arguments are non-NULL"

Why are these last two needed?

Can you provide full lists of what needs to go to what tree, and better
yet, tested patch series for this type of thing in the future?

thanks,

greg k-h

