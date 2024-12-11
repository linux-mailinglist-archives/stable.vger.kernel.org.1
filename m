Return-Path: <stable+bounces-100571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402BA9EC764
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5307F16A2D9
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2A31C4A1B;
	Wed, 11 Dec 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mojPj1v2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F08ECC
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906000; cv=none; b=JrbHHfmCmr5oXPgrN1AeB9+VnUl2W3mQgZKNQWoDTFW2DINafAAIsU9kF6ZlF1PG1UJfD5/hKKMozExlcf7LDP7OLGGMXEXJDQGPDNEbcSxOrE+n9/iBpMi0X5Hm8UDoEayJEJ0RIalCeIhpqKeivwsJhmGDTQQxDJQiUPVCPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906000; c=relaxed/simple;
	bh=R2v+WHOaV1PkDwso9C1SXiMKNDN8C6HHsPdR9UbHwnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGu5lhHTH8U4HNmzQSVbP2ijQf7VZEFEBOYF8MB+7/wZYDSpvEIYk/2V8K0iFFtOtlbvFbfJQ6PbNL5I60HSBHIOXaAJ6Qk+ambB0/JTj0L7ivfpcB9sNgBXovUlF4BC78boXGe92BdobgfHImTc9ZAkrXqC2sj28mzrBpxCqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mojPj1v2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D7FC4CED2;
	Wed, 11 Dec 2024 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733905999;
	bh=R2v+WHOaV1PkDwso9C1SXiMKNDN8C6HHsPdR9UbHwnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mojPj1v2OyxjVnIdLqxyjnC/AuWfhLPBbf5fZVAmUJU3bIKGsrX3S5XbKRov1A7gR
	 v7eR8F14uuW1N5CDfnHk4tyhG+S84H6Q1sgcrJh7AQAdovsuPbOkmHEsiPWrggLCp3
	 SJA73mertn8jBKrb4KvydHHSB4IBUOXoBXETzibM=
Date: Wed, 11 Dec 2024 09:32:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: juntong.deng@outlook.com, agruenba@redhat.com,
	majortomtosourcecontrol@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH V2][5.15.y] gfs2: Fix slab-use-after-free in
 gfs2_qd_dealloc
Message-ID: <2024121137-devotion-overstate-a2cf@gregkh>
References: <20241211081023.3365559-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211081023.3365559-1-guocai.he.cn@windriver.com>

On Wed, Dec 11, 2024 at 04:10:23PM +0800, guocai.he.cn@windriver.com wrote:
> From: Juntong Deng <juntong.deng@outlook.com>
> 
> commit 7ad4e0a4f61c57c3ca291ee010a9d677d0199fba upstream.
> 
> In gfs2_put_super(), whether withdrawn or not, the quota should
> be cleaned up by gfs2_quota_cleanup().
> 
> Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
> callback) has run for all gfs2_quota_data objects, resulting in
> use-after-free.
> 
> Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
> by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
> gfs2_make_fs_ro(), there is no need to call them again.
> 
> Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
> ---
> This commit is backporting 7ad4e0a4f61c7ad4e0a4f61c57c3ca291ee010a9d677d0199fba to the branch linux-5.15.y to
> solve the CVE-2024-52760. Please merge this commit to linux-5.15.y.

What changed from v1?

