Return-Path: <stable+bounces-96192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB279E13C9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BD6B211DC
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2B33080;
	Tue,  3 Dec 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oU2e0otG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A92500A8
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210130; cv=none; b=FgM935nKnrYLnPOQQacPAeDg/JJY/PWhJ+i44WPIJIPeQW63uEFZ647qVgOKYC03ll0aav2yXDrYdZ2A3/xza1mxU5MuPphKdzTuSSOJfEt9489nx6jcLucicRNhWTPwmaCo6Ao3BpOt7cFsBlqX5o8B52XJh73SI4i79gJflzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210130; c=relaxed/simple;
	bh=1LBrk6+KTXv47qd5uL2yCbKGefle3YncFBWxl+gVopg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lsxv0X7+/Gi8tdtC7Do8EVAjWJRY6uAD2AuqEm6dxh+Z3F/nMQ59dZ02XFAO55de/7pG+WS5RsZ3CkrJkiFjvwJXHSxRQS4UUOcn+ph1rMsn58hWxUdbu2lEolf9rrsVyGBtoP7CgIgw0SEB+2Ry+EpBJdtvng8BS9ZuAiwFGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oU2e0otG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448F8C4CECF;
	Tue,  3 Dec 2024 07:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733210129;
	bh=1LBrk6+KTXv47qd5uL2yCbKGefle3YncFBWxl+gVopg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oU2e0otGoL2BU1IdjGb4FgcQ8TTXxiQY8eTAz3oMRXy2LgtYwje1hOCkfk+mumVVs
	 mNmAldVbEZysr860Wj1kcd1u1PbBmO4JV78+QHSOFSqH2go/CMq1lRXoh8/QWkeKi8
	 GcJkD1sGvOPZap+WiYwustVbtUsBbOn3AJlje0gE=
Date: Tue, 3 Dec 2024 08:14:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: mingli.yu@eng.windriver.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15] drm/amd/pm: Fix negative array index read
Message-ID: <2024120343-bottle-gangly-d105@gregkh>
References: <20241203070534.1915215-1-mingli.yu@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203070534.1915215-1-mingli.yu@eng.windriver.com>

On Tue, Dec 03, 2024 at 03:05:34PM +0800, mingli.yu@eng.windriver.com wrote:
> From: Jesse Zhang <jesse.zhang@amd.com>
> 
> Avoid using the negative values
> for clk_idex as an index into an array pptable->DpmDescriptor.
> 
> V2: fix clk_index return check (Tim Huang)
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Reviewed-by: Tim Huang <Tim.Huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [Don't intruduce the change for navi10_emit_clk_levels which doesn't exist]
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 21 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

What is the git commit id of this?

