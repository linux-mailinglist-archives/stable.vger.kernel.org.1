Return-Path: <stable+bounces-165080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F7B14F5C
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9910D18A0E34
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6551D7999;
	Tue, 29 Jul 2025 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGJKU9aF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75B51022
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799876; cv=none; b=BF4oIXCBcI7Q8EBOzcnoo9XdMEZWw0HT3rhBJfODq97UBld0pohNzIef1W7mttkXPFUMJ4ggVSXceH36DVVozHQsdgZmuzYrwhJ81OreNPW+C7Vas18OWKAn/psRtRSLIP+tBIf8ImqrUd+EM0tYWD9f/x+e39oy2+yogjmMcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799876; c=relaxed/simple;
	bh=wwj3LJSTSIIJ5Uj++d4YUsSIrbV0n7XPYejF9gNqY/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmWAO4Q9hzRCpZ1w8PVZNA43jJ2u/FZyWPvBzZc3xw+xsfo92pSeBsjSbg3QKms3GBYuh97S6+uqgVI+Sjl5hMbQTOXOdh9I+7JCbJSvuahudHgMKsJcDYPVtudqC2M6/xptpV4ao4Z/ppjVNubvql1lvcg4qj4fjbCRnQd19lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGJKU9aF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B755CC4CEEF;
	Tue, 29 Jul 2025 14:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753799875;
	bh=wwj3LJSTSIIJ5Uj++d4YUsSIrbV0n7XPYejF9gNqY/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TGJKU9aF6J+e3eHsZZ25PYTCLJKQvJRaJe/iw2cEBZ20SmiDWYdrAJix+tA1ZzPj/
	 FLMcMgS0PYgCwuNL/jMctnZ4tqajEoD2m9d4X29Lj7SkPY486Qt6jth/pvIJ2uyysY
	 6yWp9IDiCP891JaQMvDS/xEAU4YsN7No+yApHIAd3L2Q9/qFdnKNzq3XmiyA6IGQgu
	 1VtxGCU3NXhzpV34WMzAMC0OgRvly02BU+opN3v9dqouwkaHO7G79CPlC+B62mDpxM
	 y8eO1Uc6b1iMfAFooEHQmeKoOCUuFV6F6jAPCNMFR7khIJE1tuoZpcYcidKgtMJ2P9
	 //63jloCGAJDQ==
Message-ID: <abd712de-f7b3-4c75-8a3f-c94a57e36460@kernel.org>
Date: Tue, 29 Jul 2025 16:37:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 5.15.y] selftests: mptcp: connect: also cover checksum
Content-Language: en-GB, fr-BE
To: Sasha Levin <sashal@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <2025072855-ligament-reliable-75fa@gregkh>
 <20250729034856.2353329-1-sashal@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250729034856.2353329-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 29/07/2025 05:48, Sasha Levin wrote:
> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> 
> [ Upstream commit fdf0f60a2bb02ba581d9e71d583e69dd0714a521 ]
> 
> The checksum mode has been added a while ago, but it is only validated
> when manually launching mptcp_connect.sh with "-C".
> 
> The different CIs were then not validating these MPTCP Connect tests
> with checksum enabled. To make sure they do, add a new test program
> executing mptcp_connect.sh with the checksum mode.
> 
> Fixes: 94d66ba1d8e4 ("selftests: mptcp: enable checksum in mptcp_connect.sh")
> Cc: stable@vger.kernel.org
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20250715-net-mptcp-sft-connect-alt-v2-2-8230ddd82454@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ exclude newer test scripts ]

Thank you for having fixed the conflict.

Similar to what I mentioned on ...

 https://lore.kernel.org/ce3d987f-047a-4b5d-a2e9-f924e0700b15@kernel.org

... is it possible to hold this one please?

I can re-send it later on, when the related issue is fixed.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


