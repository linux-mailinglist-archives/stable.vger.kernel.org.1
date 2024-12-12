Return-Path: <stable+bounces-100825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0479EDE18
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 05:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EB21888E8A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 04:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31A31531C4;
	Thu, 12 Dec 2024 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUse4SRn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE3257D;
	Thu, 12 Dec 2024 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733976460; cv=none; b=f7+Ur8pLjdbJZuGBEflM1IXBtWjcz5Seby+N6MA8OnGQ0y2dZTPxGTCeYJU439an2/L7gfGbwdMFl8Ou44IfGV0V312sgQuZCrb/6uE0rndrzToZCEvsHWMThi9rh2KpRvhGtOUx/IVF5/jwD5ae3l6M563o4rETNqtyCPvLTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733976460; c=relaxed/simple;
	bh=eLXYWlzIVT2anxBWKTIb4bivf4yqr+3CWaVmL+hTVNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2F2zadCZpKATewTSoA/qgWWNJWsw6Th963ntMAmT0splDUGt8trxtj4rhW+iUaP5AChsVyCxbSMBVjltPi6x6Qpx2s1+PV9Gr7qQRQaZvEaFw685ODF9eOLvMZlwJ2VOlHqoQXOxPh77OfB51Ze6sjdsNM2ffh/N+F7ZjxX9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUse4SRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D0CC4CED1;
	Thu, 12 Dec 2024 04:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733976460;
	bh=eLXYWlzIVT2anxBWKTIb4bivf4yqr+3CWaVmL+hTVNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lUse4SRnceK8WBPBSCbJVt35nCR65jlwBzpZjbTlGfQ+Oc2Vb6j0MAAsfsojoy/rh
	 mamjSBuK06+paCs1gz8tPFR+mN9l9OkoHN8AsDVCLDQ6SWafxmqAiopPyXLboEQ0cM
	 TXWs/q2Pc51FMrmRCp8CjJ7wfw6u/DR/YEm601pWs2qBsy/YMzEP3Me/Il5V3nx7Dt
	 Drjd3Pbl8jsC6N7GFra0ZkHLx50FDYwDiXYVAcOYBSyH2hvtRxGu53I+NCyMGZt7lG
	 /VYgj6jFah6mNA+un5WxH+EggeVTvDC1THGf5703rezi9Uvo1f4TTUikVeHt7vuVvp
	 V10j+4XOOVypQ==
Date: Wed, 11 Dec 2024 20:07:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <jianqi.ren.cn@windriver.com>
Cc: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <sashal@kernel.org>, <jamie.bainbridge@gmail.com>, <jdamato@fastly.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.1.y] net: napi: Prevent overflow of
 napi_defer_hard_irqs
Message-ID: <20241211200739.47686258@kernel.org>
In-Reply-To: <20241211040304.3212711-1-jianqi.ren.cn@windriver.com>
References: <20241211040304.3212711-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 12:03:04 +0800 jianqi.ren.cn@windriver.com wrote:
> From: Joe Damato <jdamato@fastly.com>
> 
> [ Upstream commit 08062af0a52107a243f7608fd972edb54ca5b7f8 ]
> 
> In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> napi_defer_irqs was added to net_device and napi_defer_irqs_count was
> added to napi_struct, both as type int.
> 
> This value never goes below zero, so there is not reason for it to be a
> signed int. Change the type for both from int to u32, and add an
> overflow check to sysfs to limit the value to S32_MAX.

Could you explain why you want to backport this change to stable?

