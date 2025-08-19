Return-Path: <stable+bounces-171804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91988B2C72E
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5DD1C20909
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410F275861;
	Tue, 19 Aug 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvLaSI2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E86263C9E
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614102; cv=none; b=PJNbd1IzOtmDzm0LVr61NxDXzUJNXeN7VFeIjgHaCD2v83w9gD8Q/qd5++KJEcWNIxsBlurJ4vYUF9BnujBkhaBj1DbXufFgaWoF45D0Nse5j+zPH1I8JoSEamiag6bWbA572Xa2QaCmsgpGl9sqQdQFBH8CjoWXf8fS2nv2zrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614102; c=relaxed/simple;
	bh=XLLY40NLY+m5F775ht8+cSH6hAi7+Ercxl+MM2h5msc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMiXYBMOwpNfeLIZhW/Nkr7eRafXzqxNGXM24wDUIf3/2vUg2IXVHn26i9FxdTg2E/dlWjgj2cQB7p9kQyuGWIiWyTJMxr83YG6N4DMk+7kIFG4KHw48QmMPgCtV15d4oK6KnchBzTwLEqsOEiAu1+dGP5dHCX5RYQz8vyUGb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvLaSI2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA0AC4CEF1;
	Tue, 19 Aug 2025 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755614101;
	bh=XLLY40NLY+m5F775ht8+cSH6hAi7+Ercxl+MM2h5msc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvLaSI2UUOQ4EniHMeMeHZVLanWU8PpWPvCmPWyOj6iLg5aOhGWRs0yvQTDy3Yuw4
	 ISVfIzVD/qKoIPwTNeYHjt95ljDRcvC4MK6o7K3uFKevzK2g7DKcfZhk8ozew20x6X
	 7e9V7XR3NBb6a+oz6HDJsg0OXaAoNNuC3eJkXIlkVQRCXlGzHdXXQMiIFtzlSIiizN
	 DfSBZmkk4TRgmawrNB3e303PtUACZyoi9ClcrgugDS5lvuvvRzwSgs2hPhh6C3xm47
	 wQFaSO4ffeLiirhrb1avkKY2/B22lPn1RmVAIlLdZlsy5VBnEx9EkmAns8EPzmhCtO
	 HU7C3hYgFUtug==
Date: Tue, 19 Aug 2025 10:35:00 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.12.y 7/7] btrfs: send: make fs_path_len() inline and
 constify its argument
Message-ID: <aKSLlP5I77xpO1F-@laps>
References: <2025081827-washed-yelp-3c3e@gregkh>
 <20250819021601.274993-1-sashal@kernel.org>
 <20250819021601.274993-7-sashal@kernel.org>
 <20250819121714.GQ22430@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250819121714.GQ22430@suse.cz>

On Tue, Aug 19, 2025 at 02:17:14PM +0200, David Sterba wrote:
>On Mon, Aug 18, 2025 at 10:16:01PM -0400, Sasha Levin wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> [ Upstream commit 920e8ee2bfcaf886fd8c0ad9df097a7dddfeb2d8 ]
>>
>> The helper function fs_path_len() is trivial and doesn't need to change
>> its path argument, so make it inline and constify the argument.
>>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> Reviewed-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This is neither a fix nor a dependency of other patches, please drop it.

Please see the explanation in
https://lore.kernel.org/all/aKSK8rNSFR3TrhH3@laps/ . This backport is for the
same reason.

-- 
Thanks,
Sasha

