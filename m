Return-Path: <stable+bounces-118937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E750EA422B0
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA9B165E28
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E2A1607B7;
	Mon, 24 Feb 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wNuUIbnp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966615198B
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405853; cv=none; b=cOZP8hb4oOLsogdKpyS+2zMIaYxpqpR6+g2Ub2IvyTxm1GUoyAYIq8L041xTiOUv98dmsolYsMglBpdf//eIKn379f7WiR52MF1mMIj9rTB+0tVK0poOlXEHE6id5GPpjv3e6W0moktf6ihg5RtdrPVzFF6U1UiapsENJ3wFGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405853; c=relaxed/simple;
	bh=/d72KXrWl5BZ4l60jtgl4LhRAmSy6SfJggWrEoAJj7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0H4rdk+AWZS6XdWvhGRmCEg8N08NXODNhMVZzLIEtd6BTMTRFSHaGSAyywrMts7T/M99mzuvKG0Mbcnv2hrZJk50H4Rw7tcJasjPM9uD+CyrlcTY1CJ44E1CmEgawlvfs68IPDOq2MP6ozwQeqtsE0i6UCkz2upCgl4l865EPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wNuUIbnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9205DC4CED6;
	Mon, 24 Feb 2025 14:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740405853;
	bh=/d72KXrWl5BZ4l60jtgl4LhRAmSy6SfJggWrEoAJj7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wNuUIbnpxTiirsQgwE3DAQUNFw3KK9/OzJ9K8Um8ehHsPjwEHIPxWgMYBhItfpX7Z
	 irPmDi3UAWDSBcvO7DkE4zOeCK6bHPgIrLkC3sroD9ahrhWpxq5rTBZzvk/Z9JyaI5
	 g0QfFaqeZ2n9YaMjgtM3c4wKkvA0NnGuT9yyMqZo=
Date: Mon, 24 Feb 2025 15:04:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lancelot SIX <lancelot.six@amd.com>
Cc: stable@vger.kernel.org, Jay Cornwall <jay.cornwall@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Ensure consistent barrier state saved in
 gfx12 trap handler
Message-ID: <2025022457-congested-effective-3aec@gregkh>
References: <2025021803-fondness-ship-dc72@gregkh>
 <20250221180852.465651-1-lancelot.six@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221180852.465651-1-lancelot.six@amd.com>

On Fri, Feb 21, 2025 at 06:08:52PM +0000, Lancelot SIX wrote:
> It is possible for some waves in a workgroup to finish their save
> sequence before the group leader has had time to capture the workgroup
> barrier state.  When this happens, having those waves exit do impact the
> barrier state.  As a consequence, the state captured by the group leader
> is invalid, and is eventually incorrectly restored.
> 
> This patch proposes to have all waves in a workgroup wait for each other
> at the end of their save sequence (just before calling s_endpgm_saved).
> 
> This is a cherry-pick.  The cwsr_trap_handler.h part of the original
> part was valid and applied cleanly.  The part of the patch that applied
> to cwsr_trap_handler_gfx12.asm did not apply cleanly since
> 80ae55e6115ef "drm/amdkfd: Move gfx12 trap handler to separate file" is
> not part of this branch.  Instead, I ported the change to
> cwsr_trap_handler_gfx10.asm, and guarded it with "ASIC_FAMILY >=
> CHIP_GFX12".
> 
> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org # 6.12.x
> (cherry picked from commit d584198a6fe4c51f4aa88ad72f258f8961a0f11c)
> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h         | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

What stable branch is this to be applied to?

thanks,

greg k-h

