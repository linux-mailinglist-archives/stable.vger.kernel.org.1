Return-Path: <stable+bounces-87673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DA89A9A7B
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982281C220CE
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 07:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807D12FB2E;
	Tue, 22 Oct 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lky6i8h+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5568149C51
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580827; cv=none; b=R4boS5q6DsGtr/b3yh/zC5YLnRCZfOqUx0NNVJSqHu2n/cg1QWuH9MPMOaBzBfEIVV/Cefup+D9f9DigqrrW09PEyLgw5RpbGJvA5SqoRfh+JlcntzD2+GeBNMabY52oJkP1zKEKGi5aa31ejJdc4JkcswIOXUmKcn8hkZFdINE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580827; c=relaxed/simple;
	bh=V/b9dQ5/6PtMrCovKmJgt8AaPD1qaKslf4TkR/TV1hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sncXpT1F5rAlOKYZYCTuRpX4pOsuZBPthEo/qsqEyjRGHR8iTwVeSDYVs0xIAPxMVRgOW93C2PEt7kGbddApw9bq8g8bxJ0MTShZZitYNAB3uN1xV9cog5qV99gPXEvIJZbM6vDb3HtMFsQYXLeEXx2NXw4KStLfDDa9cmFRt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lky6i8h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2C2C4CEC3;
	Tue, 22 Oct 2024 07:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729580827;
	bh=V/b9dQ5/6PtMrCovKmJgt8AaPD1qaKslf4TkR/TV1hw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lky6i8h+etoJ+qsnyvW6rLpbNRJ2yimcezBMmVrtg1zG7WLIKBt/Y5oQ3S7M+0df8
	 u834+t2UVyTdqlcNdftVKPmrRLZwpmO7L0I8QwAbHPK7TV/00GRrTo0aoZD0jyVLe7
	 KtTWaJlD/+VW40yl4ycV18RksRkhquNMdOLyRZEfBpBFZ3zix243K7st+TsTiU9kRd
	 J2y9fxym9EKy6ljtQC8wtMsCuG4DXO1M+cabpiuHZyCLecIwmUYU36x6rRGVcJNxjc
	 dTlkwbR939M4jZpWWuxvvxHtFX9dOqUxK+G9ykj/eAQQrQQxk06sQCf3d7QpGi3LS+
	 PDy2TV7XbujcQ==
Message-ID: <da0f3bee-9ad4-479b-af42-92b9e12ef4bb@kernel.org>
Date: Tue, 22 Oct 2024 10:07:03 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] usb: dwc3: core: Fix system suspend on TI
 AM62 platforms" failed to apply to 5.10-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, d-gole@ti.com, msp@baylibre.com,
 stable@vger.kernel.org
References: <2024102152-salvage-pursuable-3b7c@gregkh>
 <c8c33676-d05b-4cbb-974e-398784cb8b8a@kernel.org>
 <2024102201-pushup-unmoral-aed0@gregkh>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2024102201-pushup-unmoral-aed0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/10/2024 09:55, Greg KH wrote:
> On Tue, Oct 22, 2024 at 09:37:30AM +0300, Roger Quadros wrote:
>> Hi Greg,
>>
>> Patch was marked for 6.9+ but I added a 'v' in the tag and that's probably why it
>> was attempted for earlier trees.
>>
>>> Cc: stable@vger.kernel.org # v6.9+
> 
> No, it was attempted for earlier trees because:
> 
>>> Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
> 
> That commit is in the following kernel releases:
> 	5.10.217 5.15.159 6.1.91 6.6.31 6.8.10 6.9

Thanks for this information.

> 
> So if a backport is needed, that would be great.

USB support for AM62 platform was only added in v6.3 [1]. I will check
and see if it can be ported to stable trees after that.

[1] - 2d94dfc43885 arm64: dts: ti: k3-am625-sk: Add support for USB

-- 
cheers,
-roger

