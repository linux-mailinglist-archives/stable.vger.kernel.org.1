Return-Path: <stable+bounces-76554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1290897AC62
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88311F23D39
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E493149E16;
	Tue, 17 Sep 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xhxt53I8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DE364BE;
	Tue, 17 Sep 2024 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559372; cv=none; b=s/XFGiC83hJpGWt3A2e1AplrG9s3Z79iWExeXwa3u56C4RcDp1abFFtPmVBXUepGCbnaJRJMKDjgItNdxvFhn3l91ZA6B5qUlB4bEZbgSqRuSI1/p4B0AKdeSPQXhjhwrWyprJVgf4KfaAMqJ3uWKaLXyq0zTaoiRmQ+aGUDhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559372; c=relaxed/simple;
	bh=358E0okUPbU385P9yKRBH41FfQjs18Lb/yyRalxR+LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii2EbD9t7cjYZ6phVIzrXzrj2sxCXk0u+mv4uVx5Y5RGQXM5KoM98v9NSpiUaHjC/y7oMJ17AY14E987SyP1Uw0S/byWLTcmvnyulnoymbxed6mEbRKN9PhTrR2t+xeYQhqXk4LJnkPPpuNJnYOqSMdt5A4wTO1Af0K7XR/NzTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xhxt53I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFC5C4CEC6;
	Tue, 17 Sep 2024 07:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726559371;
	bh=358E0okUPbU385P9yKRBH41FfQjs18Lb/yyRalxR+LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xhxt53I8+YHqaaCRT3yYHs1U/f6tIgrkLalt96SrIIygJEBRJzybz6teOw8suONsD
	 bpxlxTYvQoSaEy4uKnlcsWTal2oFfN949fexL544kvEYepVZ/XVMNbrpG6xTZNAJFC
	 ngbHzg2pn8gT79msutfvAcnwew3CqdIAttKy6Of8=
Date: Tue, 17 Sep 2024 09:49:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH] list: Remove duplicated and unused macro
 list_for_each_reverse
Message-ID: <2024091752-passivism-donut-ccca@gregkh>
References: <20240917-fix_list-v1-1-8fb8beb41e5d@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917-fix_list-v1-1-8fb8beb41e5d@quicinc.com>

On Tue, Sep 17, 2024 at 03:28:18PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Remove macro list_for_each_reverse due to below reasons:
> 
> - it is same as list_for_each_prev.
> - it is not used by current kernel tree.
> 
> Fixes: 8bf0cdfac7f8 ("<linux/list.h>: Introduce the list_for_each_reverse() method")

Why is this a "Fix:"?

> Cc: stable@vger.kernel.org

Why is this for stable?  What does this fix?  Just removing code that no
one uses doesn't need to be backported, it's just dead, delete it.

thanks,

greg k-h

