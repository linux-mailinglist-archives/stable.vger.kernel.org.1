Return-Path: <stable+bounces-166776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A25B1D829
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 14:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53782583DD5
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7A24728B;
	Thu,  7 Aug 2025 12:44:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.blochl.de (mail.blochl.de [151.80.40.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF61E48A
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.40.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570662; cv=none; b=sWFuXPbF2caGaqtXD2WI50MeHzUZ0lKbly+uLtl3RyTgcNdl2ysn8Q/Lq/7I6Jt+198VOSh3NcscS9+TnGu+gOe/PmXGHCK/UZqqXvSF7DiR6lCcJBiw1QBcd0VlAmZ1a5i0Ccomeq6k2hOom8hAktmpHqlZiupTFpcglgNebhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570662; c=relaxed/simple;
	bh=XMyS0YC+kP5/HLvQeccevcgfsS//ASxJ6hYjPyaDYcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuBP9fh3378CJlXwn/05uKX/01WDJpnQ1YzlMKO4p4+huWPmwIxACqYHKFeanHDqbqR3rPO0iPshg5qKy566JDp4jcAtSTj5G3AEoq5HRiM5RJ1Cy8YtHl6Htj6Q2XwzECwN9Nuykcbp0Npbmk6rvG6OIYp/wa3icfkkKh/PlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de; spf=pass smtp.mailfrom=blochl.de; arc=none smtp.client-ip=151.80.40.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blochl.de
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.blochl.de 277014466439
Authentication-Results: mail.blochl.de; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: mail.blochl.de; spf=fail smtp.mailfrom=blochl.de
Received: from WorkKnecht (ppp-93-104-0-143.dynamic.mnet-online.de [93.104.0.143])
	by smtp.blochl.de (Postfix) with ESMTPSA id 277014466439;
	Thu, 07 Aug 2025 12:34:25 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.2 at 472b552e6fe8
Date: Thu, 7 Aug 2025 14:34:10 +0200
From: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, markus@blochl.de
Subject: Re: [PATCH] ice/ptp: fix crosstimestamp reporting
Message-ID: <ngpaxbcoagu6uiusrnqds7i62qv3c3nk6ppqv4eovrltnnlvqs@opvhzljlgpib>
References: <20250725-ice_crosstimestamp_reporting-v1-1-3d0473bb7b57@blochl.de>
 <1753492278-e3830ff7@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1753492278-e3830ff7@stable.kernel.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (smtp.blochl.de [0.0.0.0]); Thu, 07 Aug 2025 12:34:25 +0000 (UTC)

Hi Sasha,

Sorry, I don't really know how to handle this response from your bot:

On Fri, Jul 25, 2025 at 09:37:11PM -0400, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ❌ Patch application failures detected
> ⚠️ Found matching upstream commit but patch is missing proper reference to it

The patch clearly mentions `commit a5a441ae283d upstream.` to me.
Am I too blind to spot a typo or similar?

> 
> Found matching upstream commit: a5a441ae283d54ec329aadc7426991dc32786d52
> 
> WARNING: Author mismatch between patch and found commit:
> Backport author: Markus Blöchl <markus@blochl.de>
> Commit author: Anton Nadezhdin <anton.nadezhdin@intel.com>

This mismatch is intentional.
I did not author the original fix. I merely backported it to 6.12.y.
So I kept the original author when cherry-picking.

> 
> Note: Could not generate a diff with upstream commit:
> ---
> Note: Could not generate diff - patch failed to apply for comparison
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | origin/linux-6.15.y       | Failed      | N/A        |
> | origin/linux-6.12.y       | Success     | Success    |
> | origin/linux-6.6.y        | Failed      | N/A        |
> | origin/linux-6.1.y        | Failed      | N/A        |
> | origin/linux-5.15.y       | Failed      | N/A        |
> | origin/linux-5.10.y       | Failed      | N/A        |
> | origin/linux-5.4.y        | Failed      | N/A        |

As written, the backport is for 6.12.y only.

If there is anything I should do or change, please let me know.

Thanks,
Markus


-- 

