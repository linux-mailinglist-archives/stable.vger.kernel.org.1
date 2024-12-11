Return-Path: <stable+bounces-100557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966C9EC6D4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E97188B764
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654421D6195;
	Wed, 11 Dec 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Stn/ORua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F33C17
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904985; cv=none; b=eNjpaypLkVUPamChL87Q9G1/gIQLyMq+Q/6+mZsCCDuodEEplciNB0cpbkIdgr1epTvXP6j39qOFek16riiJBYr7WwbdOAMjmXkNWrG4XzppXZ7hVGLBG6KJ7HfkHaLHXlXWjT11OB3H1z2TPwSMWPxYznI3TCz2CMtMtnGvYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904985; c=relaxed/simple;
	bh=bIZspBJCRNsUYbz9+eaAEjWv9Oz3elEtctZZEopMEXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR2O/B+GmFiGD5omAHB17rgGaEBJM4brmLRGy+Pa9unQ9HD5HNwjLpamIBZcjGBufyG3rZS+rwEI3yQAHx6L7T23mdiGL7BlS7TtExabTNV7iF+i58Qf8Jsgg2bNkiDMiKdlgzC8mG7Gi3n9G6Ebj2FO6utsh2fPT0RHjUvyuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Stn/ORua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A93FC4CED2;
	Wed, 11 Dec 2024 08:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904984;
	bh=bIZspBJCRNsUYbz9+eaAEjWv9Oz3elEtctZZEopMEXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Stn/ORuaJlhS6c1FX/XFGkv4Ov6YcBhika8GB7MrSc/ePwg7HFxlSCZYX9/gNuXzT
	 uTJnNpGD/IMPhLe7Y6WvLDm/L4B5ZMG0G0RMMkSi1VDtz1LoCDIvqckDBEXQqKXI0I
	 X0b1ms3yBJ9AXu8/4Mf9kBUq/QPe0BGnGNcV2DzM=
Date: Wed, 11 Dec 2024 09:15:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: fullwaywang@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] media: mtk-vcodec: potential null pointer
 deference in SCP
Message-ID: <2024121144-mashing-everglade-2ccb@gregkh>
References: <20241206091657.154070-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206091657.154070-1-jianqi.ren.cn@windriver.com>

On Fri, Dec 06, 2024 at 05:16:57PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Fullway Wang <fullwaywang@outlook.com>
> 
> [ Upstream commit 53dbe08504442dc7ba4865c09b3bbf5fe849681b ]

Please cc: all relevant people on backports.

