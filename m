Return-Path: <stable+bounces-66555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7832594F01B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EBDEB252F9
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83AD186295;
	Mon, 12 Aug 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aOZjRMCt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9678183CBB
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473813; cv=none; b=mCvGBl48e4X0s2Q11ujPwFl2JIPvECQDIu72bScNf8NktJCdTGAa5iAq7xDeGdhkn3OnE1o8a04J9jptg5eLQjySSkvZaddVcmPVMmjLgJrdSMN2H9wf0Suw/DoxYwDNiyFZV8LB2mF4Z3O1jwN+YYz8xUlMyR6DXD4eExAYpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473813; c=relaxed/simple;
	bh=t6QUC9tIgvBcYvMGtWVayFupPRYkT+2aVMrDEGZd+3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6BvJcPdPgNwVmlUJUD50Ewp9tnCBxKdmbEsrsid8hSMLULJgwLMAkRVanK6lprXeeVahAKQdIm+CTt0iFvq+oAO7O3pX6sQK2Po/jm2VIN8M0MDEw+/hg4u2yipkdK40IaeadtvEEerRGRM7UiCltb6NTgLGVYLLizd8BnzxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aOZjRMCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEB2C32782;
	Mon, 12 Aug 2024 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473813;
	bh=t6QUC9tIgvBcYvMGtWVayFupPRYkT+2aVMrDEGZd+3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOZjRMCtoX2RA70D906ZVg3Q5QJhmuROVHwH/frSDh/ciCyTFK91HHIGDw+Pa8P/L
	 ZtHbPHsfMBEc4KXxBzC3GRReTQ/8Lw3d67yNX4gIbIN+gSA6w/Y78GVtF7Gy6/+6J5
	 6h7WoZS6XJqHDCv8D+yCqgfTQi5p08Mr8VljiBsY=
Date: Mon, 12 Aug 2024 16:43:28 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] drm/amdgpu: fix locking scope when
 flushing tlb" failed to apply to 6.10-stable tree
Message-ID: <2024081202-rework-childcare-3069@gregkh>
References: <2024080738-tarmac-unproven-1f45@gregkh>
 <SA1PR12MB85999CF5386E2AADEA301076EDBA2@SA1PR12MB8599.namprd12.prod.outlook.com>
 <2024081132-sterling-serving-8b4f@gregkh>
 <SA1PR12MB859927992245170E20E489D9ED852@SA1PR12MB8599.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB859927992245170E20E489D9ED852@SA1PR12MB8599.namprd12.prod.outlook.com>

On Mon, Aug 12, 2024 at 02:30:00PM +0000, Li, Yunxiang (Teddy) wrote:
> >From what I can piece together with git history, it seems the patch was both in amd-drm-fixes-6.10-2024-06-19 and amd-drm-next-6.11-2024-06-22 and this caused the double commit. @Deucher, Alexander

Again, PLEASE FIX YOUR BROKEN DEVELOPMENT PROCESS!

This isn't ok, and is wasting our time :(

greg k-h

