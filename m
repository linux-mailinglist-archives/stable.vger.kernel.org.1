Return-Path: <stable+bounces-77875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D9987F98
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 09:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A5CB21871
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330E17C9F6;
	Fri, 27 Sep 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jq68H/De"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B4165EE3
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422903; cv=none; b=MwETHY7UuW3burUQpq470xhk/mwFA6VLZfPepAZzYCy4ULmSxdfq6UBIq3/Gk3yNX09fXkLCYw9e2N+ZEmmmylxbCOp+yUpHXH3efDykwAvga/On7EadsED1lflDM4Nn05UeiGQ8WbxaWV4xDMUjtNyobATOp6SF+UAkaRCa9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422903; c=relaxed/simple;
	bh=h+SdPEdFTij33hhfMitM7mLHKdLNFA74P6pcl9mJGts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGvouRJVpIaL9O/3iB71KaqkoqsPC7E7361HZM7kZvT5OgJpqV2RlNkycesn6SfVVuG+034zK/pA734wGRKT0K8v3tparFkhQ76uJgypfHhfX5CXQPCynNdDGkBCX2mAnJShJBTdWt44y4FyJ9M7EfM3X09Tn8FzpqR8zjcwjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jq68H/De; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB8DC4CEC4;
	Fri, 27 Sep 2024 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727422903;
	bh=h+SdPEdFTij33hhfMitM7mLHKdLNFA74P6pcl9mJGts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jq68H/DeezFrB8xe30yxde3zoCIIoU1FZRTmFCJgN62jHloEfbpf0apLH9Kp8b0R9
	 0IuEEHOjqzkrWOQUPquvhvH/7y7qma4yDCac8QDDTcvSJADU6hXEDC2/L2VE2hiQqG
	 utVLN+bpk+F6AL24w6fhYQ7IlVT17PaTn0cjhLUQ=
Date: Fri, 27 Sep 2024 09:41:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: Fix regression from "drm/amd/display: Fix MST BW calculation
 Regression"
Message-ID: <2024092752-taunt-pushing-7654@gregkh>
References: <9c551c15-b23d-4911-99ee-352fad143295@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c551c15-b23d-4911-99ee-352fad143295@kernel.org>

On Mon, Sep 23, 2024 at 11:23:57PM -0500, Mario Limonciello wrote:
> Hello,
> 
> The commit 338567d17627 ("drm/amd/display: Fix MST BW calculation
> Regression") caused a regression with some MST displays due to a mistake.
> 
> For 6.11.y here is the series of commits that fixes it:
> 
> commit 4599aef0c97b ("drm/amd/display: Fix Synaptics Cascaded Panamera DSC
> Determination")

I don't see this commit in Linus's tree :(

> commit ecc4038ec1de ("drm/amd/display: Add DSC Debug Log")
> commit b2b4afb9cf07 ("drm/amdgpu/display: Fix a mistake in revert commit")

Nor either of these :(

> Can you please bring them back to 6.11.y?

Are you sure you are looking at the right tree?

thanks,

greg k-h

