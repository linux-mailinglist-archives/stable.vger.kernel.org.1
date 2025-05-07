Return-Path: <stable+bounces-142010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B22AADB69
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11387B6E37
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852001DDA32;
	Wed,  7 May 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BpMuyzUM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7B1B87EB
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609923; cv=none; b=PINdg2Ib3Gmz753eS/qxeUwrmQbiZPflDnS6evW52lImYxWwuKQBS9FJpqm4TM6NCpvATTGYxGU0OVfzwVh6okMB4d5dUWBcCQf57o8OyUSd5tFIcU9KZr8+aKScNDtgTLfiIPXQDLBohtUHmap0cbMqeZM6UWIw5rIp1//rOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609923; c=relaxed/simple;
	bh=JpiZ7vzGDRSfaw6KXsTbvxS2f+ACgQGlxMgQoPZBiIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCPl1akv5OJQ7WkH6mXohxZFRGQr/tQCczmX2g2Z33cjINHeCljz2m8rPl92l4o/yEx4OAVlwMiM/vmdWuDcVxhHNJ7C93lIeAq9I8mxytpRjZChA+LdUOk2gN+JE0lyIjIqeNO+ESVHrysEDQnejOzSOefMsOV2fC8XkLwTXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BpMuyzUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A23C4CEE7;
	Wed,  7 May 2025 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746609922;
	bh=JpiZ7vzGDRSfaw6KXsTbvxS2f+ACgQGlxMgQoPZBiIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpMuyzUMS/O0hIQ7Fx7jreVBqMTK4kTIgtt/kadiFxJukLz8Ws9cJT/k4oTjFj81I
	 T6nxvJhniQ7NYahbw5BN7bGQaXhkSQZiWT1PZOwax/XX+bZ6AuzzKX7rHvMx00g4sQ
	 AuthGO4rI/phcUH6BQblQVo9Pw9wfZf5fRifdgIE=
Date: Wed, 7 May 2025 11:25:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: stable@vger.kernel.org,
	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: Re: [PATCH 6.12.y] drm/xe: Ensure fixed_slice_mode gets set after
 ccs_mode change
Message-ID: <2025050745-fifteen-shaky-2bca@gregkh>
References: <2025042256-unshackle-unwashed-bd50@gregkh>
 <20250505161316.3451888-2-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505161316.3451888-2-lucas.demarchi@intel.com>

On Mon, May 05, 2025 at 09:13:17AM -0700, Lucas De Marchi wrote:
> From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> 
> The RCU_MODE_FIXED_SLICE_CCS_MODE setting is not getting invoked
> in the gt reset path after the ccs_mode setting by the user.
> Add it to engine register update list (in hw_engine_setup_default_state())
> which ensures it gets set in the gt reset and engine reset paths.
> 
> v2: Add register update to engine list to ensure it gets updated
> after engine reset also.
> 
> Fixes: 0d97ecce16bd ("drm/xe: Enable Fixed CCS mode setting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Link: https://lore.kernel.org/r/20250327185604.18230-1-niranjana.vishwanathapura@intel.com
> (cherry picked from commit 12468e519f98e4d93370712e3607fab61df9dae9)
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> (cherry picked from commit 262de94a3a7ef23c326534b3d9483602b7af841e)

Wrong git id, please use the git id that the original commit is in
Linus's tree, NOT the stable branch only.  Please fix and resend a v2.

thanks,

greg k-h

