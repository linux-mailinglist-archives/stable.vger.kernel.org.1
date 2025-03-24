Return-Path: <stable+bounces-125958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF78DA6E27A
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA3C188F22B
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F106264A9A;
	Mon, 24 Mar 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f5JPDWIJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FB26157E
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841327; cv=none; b=RIbiJelo6+GtYubI0ENiTI5wenLp8zy/OKOLlKx8UqBkqScHQATtlvO+pbR7NJseqLYZunb1tSBpsc7Evp4d053JwdINr6J6iW0L4KUiDPQBP1nk86VxV5J+72ts2s3uG675149vPlCDuKA1ysOAVcD5Jyex4CqKyYvDmuVUKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841327; c=relaxed/simple;
	bh=66x4rT4dhuV0mHB3DwyzwFY2vPrOTrNN/JUqQMehXUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS48K8bppxOCikuATgAEzURvBQMWCd0ZtPc0+O1GKXypzydWNrcQoaFyUff+UIUL3CL06H2QDwO5d5mrPu1ix8AcELKNyxBrd08S+byiV0tU1+GFCNqO0S4CGgXrwNDkL3zv1YQ45RH1NZy050a1ndbXj/2OhXACkrpfL7PK3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f5JPDWIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F10BC4CEE4;
	Mon, 24 Mar 2025 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742841327;
	bh=66x4rT4dhuV0mHB3DwyzwFY2vPrOTrNN/JUqQMehXUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5JPDWIJjelsRsUcSoKGqgGrFo0TEU6QDvKpoyncxOHAxevuVHmfWfvfMXcBn050B
	 DIOpq4cd02zKahF4buUP4b+9zFTzqsGqauCea3yUW8hMJRGXT4IUw8jtzZ84nrNEdT
	 Ty2xdHJG0791UNtOvboNj2Len5u6Z4lddhEutcNQ=
Date: Mon, 24 Mar 2025 11:34:04 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: stable@vger.kernel.org, Martin Tsai <martin.tsai@amd.com>,
	Robin Chen <robin.chen@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6.1.y] drm/amd/display: should support dmub hw lock on
 Replay
Message-ID: <2025032452-tarantula-encircle-6fd3@gregkh>
References: <2025032457-occultist-maximum-38b6@gregkh>
 <20250324164929.2622811-1-aurabindo.pillai@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324164929.2622811-1-aurabindo.pillai@amd.com>

On Mon, Mar 24, 2025 at 12:49:29PM -0400, Aurabindo Pillai wrote:
> From: Martin Tsai <martin.tsai@amd.com>
> 
> [Why]
> Without acquiring DMCUB hw lock, a race condition is caused with
> Panel Replay feature, which will trigger a hang. Indicate that a
> lock is necessary to prevent this when replay feature is enabled.
> 
> [How]
> To allow dmub hw lock on Replay.
> 
> Reviewed-by: Robin Chen <robin.chen@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Martin Tsai <martin.tsai@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit bfeefe6ea5f18cabb8fda55364079573804623f9)
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 3 +++
>  1 file changed, 3 insertions(+)

Does not apply to the tree at all :(

