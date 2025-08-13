Return-Path: <stable+bounces-169406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51198B24C47
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297301C226B2
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C641CDA3F;
	Wed, 13 Aug 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isS8OVK/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00D166F0C
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095883; cv=none; b=lpoQCW+ChiHGKCnnST6Znehxr2brUPG1NytXFjZ1+UcXLbi77UAIn+YSrCukWbhlLExlfTHx2KNEOwUhKg+9sRA0LVqgjs8FR2Yit21dlXVFDYp7X4HnxdkwGKy4GLTgkO8OQ5qz3zgSf6ErlpRqtlVdLxo4CVQNp3+J50UNKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095883; c=relaxed/simple;
	bh=FjloqKdggHKatAv2F21hK2/DVkBVuqjEt1atV9qsGn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0r7gMfzXl3MFegTvjOCAUY76kA3x9q8OpQPVnyV71qKSChkprcYcRr6d0ezwlQ8dLcimklY/vXcYi1C6ds252+6wQzwn2hPoBfJqVdnKKfFiJoiuWKVjdPG5RC53UsE5k+NJoCOzgQ4Kykhmyi8RER0qje8rRk/RQ+teyZ5HzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isS8OVK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EFDC4CEEB;
	Wed, 13 Aug 2025 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095883;
	bh=FjloqKdggHKatAv2F21hK2/DVkBVuqjEt1atV9qsGn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=isS8OVK/FU642hdnvYCxFlVfjd7z5vWnherTQ5p7mjl5NTWBuqFhppYwoznUDZKJA
	 N31hxZ0YgaeiLnKDNRG0JoPjLUmEwUH5ALIvFy3l64lBu8CpLuB5zSCqetzPkYg7nG
	 flU1FlfSTgHdKYgaXKEpRW8fdeI3pOnxJtVMuXJKSuRhjLwk85sUKp+tz7UAblRmGq
	 IVi/llp7Wian1WoHZDU9BwyX6r81cPvNpwDalLZXn7IKZdlDZcBAiRpISgnn9nLDcI
	 7wPV0FYzUxwQE2mLMFbwZQ4IgYnh0CPuT9whI6o0hzjyN+58UGP3o9LSDz+OaG4FAI
	 VIb3GBs3znu7w==
Date: Wed, 13 Aug 2025 07:38:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH 5.4.y] net: usbnet: Avoid potential RCU stall on
 LINK_CHANGE event
Message-ID: <20250813073802.3f28d69c@kernel.org>
In-Reply-To: <20250813134932.2037778-1-sashal@kernel.org>
References: <2025081259-headset-swinger-4805@gregkh>
	<20250813134932.2037778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 09:49:32 -0400 Sasha Levin wrote:
> From: John Ernberg <john.ernberg@actia.se>
> 
> [ Upstream commit 0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f ]
> 
> The Gemalto Cinterion PLS83-W modem (cdc_ether) is emitting confusing link
> up and down events when the WWAN interface is activated on the modem-side.
> 
> Interrupt URBs will in consecutive polls grab:
> * Link Connected
> * Link Disconnected
> * Link Connected

Be sure to pull in 8466d393700f9cc into the same release.
This change broke Linus's laptop.

