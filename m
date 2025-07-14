Return-Path: <stable+bounces-161869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B554FB04572
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09AF01886118
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C987F25FA10;
	Mon, 14 Jul 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpHsex4z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98D246BC1
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510613; cv=none; b=qmvXAklwNv6uJGbuIF78qNUaSQdOL8rbaLsIe3C9838nWkpLT61Q8kwLyUJc6Fe9P6z5GfmbamxR3CVuhtIs6GROzk5GOXnn6qYwvTAF9WNSZWpiRNa4PWKtVkDL7xYEqVpJBHnSK4iirq3mTOZjas3QNGvhuDRJIf9uT5VK3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510613; c=relaxed/simple;
	bh=2jyPQy6P0I+aVHeJCF5mSCw3307vjz+sKXVLcWh9TPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7+aaKFKapqEjiy8yLroFa8ZdF4g0PDcpMojXZtDFrV+KWiaqTxUfdwUPwe4vKziQ06YSsPLsZvwb6mHyhonleqLUaLHKbJyPa/ttnDF9nyLC1Ptxt5UP4b3ww/ABnp3aVBX7ldB59MFFFyCVKcSVRW4e8q7z1GHYmF1kvX+LFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpHsex4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61CFC4CEED;
	Mon, 14 Jul 2025 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752510613;
	bh=2jyPQy6P0I+aVHeJCF5mSCw3307vjz+sKXVLcWh9TPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpHsex4zLvJRWgWzSddhHzIQjFbPQvRUcvhbKmYfOtiCRingM1XYDo/X93ywrYnRF
	 cOPsfHGcEh2nGgiHKsY1wHhj/nL5IB2v+DG7BuacbYF/FKhyffo/jPGWovGhBls9ui
	 k8zDPv5cLxqCEkO+2Nops+vaD2SGCsY+rJPY2QrgTdl/QvxL6piXzLxWMsGsgCRH97
	 edcvZ++jHRfok7oaAly6l/nWBmxRL7WcdWoQWDu5Oym+6zJ6WexZQ3fObV3DZAVfyP
	 XCRCjrMhx+XiMDLl4G7I3OjL+mZY3N5VehTiWiIPKT/yCGQ7Zy2r44Q0pLNz+wkR3Q
	 TbB8X62VoOxHA==
Date: Mon, 14 Jul 2025 12:30:11 -0400
From: Sasha Levin <sashal@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15-stable] x86/CPU/AMD: Properly check the TSA microcode
Message-ID: <aHUwk83588ey0hUO@lappy>
References: <20250711194558.GLaHFp9kw1s5dSmBUa@fat_crate.local>
 <20250712211157-88bc729ab524b77b@stable.kernel.org>
 <20250713161032.GCaHPaeCpf5Y0_WBiq@fat_crate.local>
 <aHRiYX_T-I--jgaT@lappy>
 <20250714102819.GEaHTbw207UYtxKnL7@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714102819.GEaHTbw207UYtxKnL7@fat_crate.local>

On Mon, Jul 14, 2025 at 12:28:19PM +0200, Borislav Petkov wrote:
>On Sun, Jul 13, 2025 at 09:50:25PM -0400, Sasha Levin wrote:
>> I'll add "stable-only" as a filter, but you have to promise using it on
>> all of these backports going forward :)
>
>Pinky swear!
>
>:-P

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=821ca5c7308ff85cef8028124dd0755d0eeced0c

-- 
Thanks,
Sasha

