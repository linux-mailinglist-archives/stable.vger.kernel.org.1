Return-Path: <stable+bounces-196910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F76C85557
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 15:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C08A4E338A
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E969B324717;
	Tue, 25 Nov 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="SBcItfeB"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5226FA77;
	Tue, 25 Nov 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079850; cv=none; b=nwM/hUw2KdWv0Ldz2ZyBylL/+uLURhym1AuJPenfk1bjJCZzDYtPcA560o4+tDccKG6B77LjMXSP30s2Ycl2WspNufrpdIZ4Bk5h9F/nq8NVpWb5Fu53AJCgiaMsBQlGlohOxNWZ8CcNmGQlED9BVtrmRuKdbvw1mcXuT+xwUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079850; c=relaxed/simple;
	bh=DaE6T0zxmcl0luyUOTESARfKNWvPKrzFIO8i5mwTF/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i463ic5/ohcplzM3fkdnwNbL/UQGJ0la5Ewa7v1D7Z7a/Y4H814DBTud96rWM0LIYFsgfyE/KO2rbIyhW0QvtZ41YjB37FNwrahzXd0/Md9Z9KGoOAxxVMavyE5iy57gUOzvH8rExqGcOrLBZ/iaRoRUdVdqWQHyfkOBGQ7+63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=SBcItfeB; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1DED45C40D;
	Tue, 25 Nov 2025 15:10:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1764079848;
	bh=DaE6T0zxmcl0luyUOTESARfKNWvPKrzFIO8i5mwTF/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBcItfeB3p+IVNFHL5mLfxijJNUsnmoMyHEdg1Er7IzH8UKcEiGPkyQfEk6TKkEBU
	 vL+q7pQ0vxnlkBUeONqNcPifaI6VoztjELqTpy3VnDvYhpZbJfVTjJ0nmwFz7CS9IW
	 qf7USbFhUMGOczwry45btpAec1pH87tQM5vFGNtPq3+NGZNhSM9lrfzB8+aLjYvpZA
	 JGatPKRN89m9q5YMTggvBm+dZeh+9OFEWcXkkkOwTzDm8xHZmdFt1X0dSAVgIrWgh9
	 zXvrKyUngWWAV3l2uNf4EqyzkmgcxF9sefh+eYBDb+7nyFhKzpa+Y7e8t+zrXegWTO
	 XpcyCYyNjBqGg==
Date: Tue, 25 Nov 2025 15:10:46 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Propagate the error code returned by
 __modify_irte_ga() in modify_irte_ga()
Message-ID: <rl2w22cx26vca3gi3c64axt2enez6qcna2w4qpfbfjeopjygst@ttvuj6gdgb7v>
References: <20251120154725.435-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120154725.435-1-guojinhui.liam@bytedance.com>

On Thu, Nov 20, 2025 at 11:47:25PM +0800, Jinhui Guo wrote:
> The return type of __modify_irte_ga() is int, but modify_irte_ga()
> treats it as a bool. Casting the int to bool discards the error code.
> 
> To fix the issue, change the type of ret to int in modify_irte_ga().
> 
> Fixes: 57cdb720eaa5 ("iommu/amd: Do not flush IRTE when only updating isRun and destination fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

