Return-Path: <stable+bounces-28293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27F87D976
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 10:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6DD1C20E58
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A312A10A2B;
	Sat, 16 Mar 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMk/hNoq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61932175A7
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580923; cv=none; b=Dr0UquJQV3Pgxq6n5wEPPfSh1quJKO7dcD1JhjKJ5W/QRJ7UL40qIUA4JjsHYdLb/LLUAwl4g9TeqgtxI66VbMCagpyZoXCmOAdWa5kRkgL0bsi8+0i1z7vAg5IFLbFiXBRjUVsEnDlc7w5T0GGJEt1qSBesN/JYnTNCnYLZIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580923; c=relaxed/simple;
	bh=BQVLA6HS+AVgJ3+yqVstEbH90Y6JRsXmWA8hoh1452A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXdrNJg4BjBYjR3lp9I6Sd7kTms5/57BtubzvwksrZW0h/B+N1xveEps8r/sIyYW2BCy2MkXidrr4umGShCYmDaedFmYW9N2jNaaRanUeDO0AQraBusT8KfwNFpxugjPKdZUfswlz19dmSmlu78YAR8nJUKG6dUzVqjCInQ6Gjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMk/hNoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068E0C433C7;
	Sat, 16 Mar 2024 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710580923;
	bh=BQVLA6HS+AVgJ3+yqVstEbH90Y6JRsXmWA8hoh1452A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMk/hNoqiXoBUmbZoAOfxWJ8queiNEDFmOQhwsI0mJCioQpX1bXoQ+zYK4WcUfaO4
	 5fPimhAmzGgG1csfVpiu/bP72dviXNBFYHmvndEs78EpGPnnGgRM63kg2DMgsE3ECp
	 PKzYIb3uxMhDon4dAzUbNNFR2JamUAer2syKjy1BAJ9azlPP3pJg0FRCzX+I/05I9j
	 P+KBZ4Mxkj5WU4tGFv+f7vqrb5KLm4rEsjinJNAtncEFtKl5maUOLkOPRq3gewrtvC
	 6wtQE6WU/rmofHOwKqGM+sx9u8HsWpzDRWVJlGcm3Nz9YVk2t629cVO35H3m7HfCzm
	 nr1BZNo1Clk9Q==
Date: Sat, 16 Mar 2024 05:22:01 -0400
From: Sasha Levin <sashal@kernel.org>
To: Max Nguyen <hphyperxdev@gmail.com>
Cc: stable@vger.kernel.org, Chris Toledanes <chris.toledanes@hp.com>,
	Carl Ng <carl.ng@hp.com>, Max Nguyen <maxwell.nguyen@hp.com>
Subject: Re: [PATCH 2/2] Add additional HyperX IDs to xpad.c on LTS v6.6
Message-ID: <ZfVkucDfxVWipwQp@sashalap>
References: <20240315220314.38850-1-hphyperxdev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240315220314.38850-1-hphyperxdev@gmail.com>

On Fri, Mar 15, 2024 at 03:03:15PM -0700, Max Nguyen wrote:
>Add additional HyperX IDs to xpad_device and xpad_table
>
>Add to LTS version 6.6

Why aren't we just taking the upstream commits that add these?

-- 
Thanks,
Sasha

