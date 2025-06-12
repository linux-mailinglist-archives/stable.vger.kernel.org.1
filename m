Return-Path: <stable+bounces-152575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4143AD7B02
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 21:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DF13B2102
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 19:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD202D1F6B;
	Thu, 12 Jun 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3lzPo1e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B747263C
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749756124; cv=none; b=YZoRJzcC6XxG2o/Sk+E5ogiW0AYZH5S5NAQT1bHrDGKxpv3X1SgVYHbysmrneU5JCNkDRwc3gSor0jG8K311KZOSDa/l/UlHxwa2KfzA6TPL8aHuVMaylxGNJxRpHoWzX2k0hSk/xpwlcg/k6FVDsxnD3S8VqKe55cxRAy4xvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749756124; c=relaxed/simple;
	bh=SzFXLbECCBndAJylJyMh+nH94qG8g5bjeL+5uVrUkKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuWfotAM8XlePY3VdcCtuhauivj26Qhxm1MPygbn+Wzlncvd4eGXzrjiR7L6JziM0AY2exkZTMPzjQwW3mGVhwPi01jZycEb76T64xT9/34MNStC3joL6UelwhWL2b2RAfqazcFdJq1F7wJR586j2Sa63ZZzBkRW4ZtSVIx77A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3lzPo1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D180C4CEEA;
	Thu, 12 Jun 2025 19:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749756123;
	bh=SzFXLbECCBndAJylJyMh+nH94qG8g5bjeL+5uVrUkKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3lzPo1evaJx4dNcHDat5TQQ61QbozQJZ+zoY1TZ+KJRLWqoIaABc1zdKIIkIcAFM
	 Mmux+4VqV64vG54dMac0SR0zN88oWn1KTuk7nRZLqGs/rvYsnATygWMuLhcvY5q/MS
	 45ITAsUtkrLxa0Z008IyJKQmALkbRivg5l7o7ZxsKTXGjG0Uz/RwQoDArpXAG2LRjD
	 07L3nY3KbVjK8anYFWKvTGqRxq3oq/7QuIvN15ODiaCvTwDOHv95LR4e9zX6DTaGKn
	 3q55z5HUoy4vgmipWKOrIsgYt9p+HBV0s4qyo/5qe6yxn+XQ9HLIxRpSi8ZZ/Z0YsR
	 klWr3hqivmsIA==
Date: Thu, 12 Jun 2025 15:22:01 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] iio: dac: ad3552r: fix ad3541/2r ranges
Message-ID: <aEso2bRau3lErydw@lappy>
References: <20250611153723-67792efb94647fa3@stable.kernel.org>
 <dd93fd01-8eab-425f-a1c2-72b5241409a8@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd93fd01-8eab-425f-a1c2-72b5241409a8@baylibre.com>

On Thu, Jun 12, 2025 at 08:42:33AM -0500, David Lechner wrote:
>On 6/11/25 9:22 PM, Sasha Levin wrote:
>> [ Sasha's backport helper bot ]
>>
>> Hi,
>>
>> Summary of potential issues:
>> ⚠️ Could not find matching upstream commit
>
>Not sure why. It is there:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e758b613212b6964518a67939535910b5aee831

The backport you've sent has a commit with the subject line:

	iio: dac: ad3552r: fix ad3541/2r ranges

The commit you've linked above and is upstream, has the subject line:

	iio: dac: ad3552r-common: fix ad3541/2r ranges

-- 
Thanks,
Sasha

