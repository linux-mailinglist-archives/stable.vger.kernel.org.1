Return-Path: <stable+bounces-96208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCCC9E1639
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B96163C98
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9BE8C11;
	Tue,  3 Dec 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lfD4ZPoe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529B18595B;
	Tue,  3 Dec 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215806; cv=none; b=h4y2O1Kb8FvPQeP5AhB5qJ90OfUiX8LIUSZyAzqqE6h6uJnos4212Abt0+Ze9HqF+vt9koxWCseQt3D2/DBqpLf0++0RZOM6bm/RMKF389Fgr7gkF9OnW7e8+o3Z7j+jnlyYflvAxSnIhOn/99bXTmGCkwSeopbZWs88IgQ7z3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215806; c=relaxed/simple;
	bh=v07t7rzMmZwvPDGdeYqdiPqaus7qZ/sQHmh9z9CDOl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPbVtP6xHJqNb9DWJxtp4k0QXf2XGZRUlylaGuuDcqUL/BEQsa7//3jQMmJnP45s1RUATm5o5RiL31vPE1i4Rxa0TQuezY4QeOF0aKLjYYTMIpAoAEr7NvJKC+jLN0sCAGMt6mvVCuKTSQOTfB1InM3jG8cxaXO+hRhnds+eDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lfD4ZPoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F35C4CECF;
	Tue,  3 Dec 2024 08:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733215806;
	bh=v07t7rzMmZwvPDGdeYqdiPqaus7qZ/sQHmh9z9CDOl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfD4ZPoeB1feqr7rOd+7sVIyqTExlzu9eJevl+tvmLrJ8Vgfi7lHgOAxKbXiMS3t4
	 dv8wHArCUGzZ2CQ0ir7Zniy1sUIC51gsRHsXvFTgCkn0V+rv27ePikTWp7fZyChJRw
	 GTdm9aAbqv2PcXPp4xfCWUcxWe4IkJZY5duIrtIE=
Date: Tue, 3 Dec 2024 09:50:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	stable@vger.kernel.org, kevinyang.wang@amd.com,
	alexander.deucher@amd.com, liuyongqiang13@huawei.com
Subject: Re: Possible wrong fix patch for some stable branches
Message-ID: <2024120351-slighted-canary-12a2@gregkh>
References: <2024111943-CVE-2024-50282-1579@gregkh>
 <20241203020651.100855-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203020651.100855-1-zhangzekun11@huawei.com>

On Tue, Dec 03, 2024 at 10:06:51AM +0800, Zhang Zekun wrote:
> Hi, All
> 
> The mainline patch to fix CVE-2024-50282 add a check to fix a potential buffer overflow issue in amdgpu_debugfs_gprwave_read() which is introduced in commit 553f973a0d7b ("drm/amd/amdgpu: Update debugfs for XCC support (v3)"), but some linux-stable fix patches add the check in some other funcitons, is something wrong here?
> 
> Stable version which contain the suspicious patches:
> Fixed in 4.19.324 with commit 673bdb4200c0: Fixed in amdgpu_debugfs_regs_smc_read()
> Fixed in 5.4.286 with commit 7ccd781794d2: Fixed in amdgpu_debugfs_regs_smc_read()
> Fixed in 5.10.230 with commit 17f5f18085ac: Fixed in amdgpu_debugfs_regs_pcie_write()
> Fixed in 5.15.172 with commit aaf6160a4b7f: Fixed in amdgpu_debugfs_regs_didt_write()
> Fixed in 6.1.117 with commit 25d7e84343e1: Fixed in amdgpu_debugfs_regs_pcie_write()
> 
> Link to mainline fix patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d75b9468021c73108b4439794d69e892b1d24e3

If this is incorrect, can you send patches fixing this up?

thanks,

greg k-h

