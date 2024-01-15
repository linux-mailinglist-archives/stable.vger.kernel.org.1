Return-Path: <stable+bounces-10943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F4F82E325
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 00:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F48283B82
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 23:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796771B5BB;
	Mon, 15 Jan 2024 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3Q6RNKY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF61B7E0
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 23:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DE5C433C7;
	Mon, 15 Jan 2024 23:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705359792;
	bh=XHEROysl/RUUK/mTAZh0duhwO4dgAjDKyd905jX/FCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3Q6RNKY0FLWNsTegzNyZQqq7kaRST/opUVcKcJjCte1Iaui5tJ+n1l8agGbfu9pm
	 NTxcM7OT3lURVV3Qb8NihgI+bFYhtKQd3m07xmjKUJ68FpJsHlGK1blrbhslCyvdwp
	 Fow+MZBxYV4bwsvRmix+i7plrXdB5smDB9A7m7nVF5dWB0bgQ64oW0mgwfXIypWGzY
	 IEdg0L0Hj/Qd/yOVS2p/O9bM68DcwEhkxO1EXQ5aF+KuLt0hebN6EZAbwId1epo7mG
	 gs05olf27R+R9bbVBJybv/hGhFAsbUL6vz0DYAC4rm+KC6CcEvhm9/B6TwfB2zPtL/
	 d6rQ9kOMU+ixA==
Date: Mon, 15 Jan 2024 18:03:11 -0500
From: Sasha Levin <sashal@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <ZaW5r5kRbOcKveVn@sashalap>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>

On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
>Hi stable team - please don't take patches for fs/bcachefs/ except from
>myself; I'll be doing backports and sending pull requests after stuff
>has been tested by my CI.
>
>Thanks, and let me know if there's any other workflow things I should
>know about

Sure, we can ignore fs/bcachefs/ patches.

Note that the proposed workflow would only work through patches coming
through your tree, but patches in other subsystems that could affect
bcachefs might break it in stable trees without being caught by your CI.

I'd recommend integrating your pre-release tests with something like
kernelci, which would let us catch bcachefs-affecting issues coming from
other sources.

What more, if we do the above, we could in the future avoid special
casing bcachefs :)

-- 
Thanks,
Sasha

