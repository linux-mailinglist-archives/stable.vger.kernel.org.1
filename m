Return-Path: <stable+bounces-54759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2877910D3B
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B7DB253F9
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B911B47DF;
	Thu, 20 Jun 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2s4mr0Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39741B47D2
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901419; cv=none; b=W4YHdZv4A+KcEtaHapTBHjtdnrjoEUD1T8/6e3FTcTPVupGTZfZiSZob563qGKEq2s6Y37ZVBAFY28SkThEYJJPZvacIighMJr9YeVYEw0JtWX1HgFc2s4a3tEXDq6+EN4IGLKzwda89LxPhapVg111NEpsMJz0Ld+4aWdhDqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901419; c=relaxed/simple;
	bh=DcaboQ7B3JmHo97botsQRQ+5atQTWcS0b/XRS7eC+xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeZMSzSNpQ/CQsGYaeRPrwWCYWOk65/825C2VRToVGXDNkTN9KaaFLTxRznizfTq0vL7MSOU6+6yFmVhvY8bwPbKmMkZEn++0Yy4Z1JiYX3KlFfWjK7+d7N8yofaF/DZ7bINYA6IfroW4KdhM2WbpBn1ywZnE9IBJwun7F40FwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2s4mr0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A20DC2BD10;
	Thu, 20 Jun 2024 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718901419;
	bh=DcaboQ7B3JmHo97botsQRQ+5atQTWcS0b/XRS7eC+xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x2s4mr0Z10Rgkos3+lh1fUBgwioOxg0KhpBgZRPsSWdrSptRvjvUizResDrTE18Mb
	 1o3j1xiTy/8gd9S2+50r/x6avrxjDWZXDSVY8u6d2hlH6aSpE1O3yp6ZESL2fp5gVL
	 pHE9f9RpOl+F/I3J+CaR42J6ecULHm4SyVGhyvVw=
Date: Thu, 20 Jun 2024 18:36:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
	Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
	Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
	agustin.gutierrez@amd.com, chiahsuan.chung@amd.com,
	jerry.zuo@amd.com, Dillon Varone <dillon.varone@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH 21/39] drm/amd/display: Make DML2.1 P-State method force
 per stream
Message-ID: <2024062032-emoticon-nifty-337d@gregkh>
References: <20240620161145.2489774-1-alex.hung@amd.com>
 <20240620161145.2489774-22-alex.hung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620161145.2489774-22-alex.hung@amd.com>

On Thu, Jun 20, 2024 at 10:11:27AM -0600, Alex Hung wrote:
> From: Dillon Varone <dillon.varone@amd.com>
> 
> [WHY & HOW]
> Currently the force only works for a single display, make it so it can
> be forced per stream.
> 
> Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Dillon Varone <dillon.varone@amd.com>

When submitting patches from others, you too have to sign-off on the
patch.  Read the DCO in the documentation for details.

thanks,

greg k-h

