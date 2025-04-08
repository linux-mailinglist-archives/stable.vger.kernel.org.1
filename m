Return-Path: <stable+bounces-128816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0412A7F3D1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 06:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B0B167336
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 04:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4621CAA89;
	Tue,  8 Apr 2025 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="aKN+zk1N"
X-Original-To: stable@vger.kernel.org
Received: from out187-1.us.a.mail.aliyun.com (out187-1.us.a.mail.aliyun.com [47.90.187.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B96B23AD;
	Tue,  8 Apr 2025 04:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744088050; cv=none; b=Jlx3h5F6Enu1kB4g4Pk4iBAYSUurwFk23L3FSxi+AacjnaCmx5NKXo5rTciSdvmn3PZD3/zooDx9pyZyoGst/3u1f0cwI8i+SU81/h5o5R1j4aZbZsy0vDlbvb39PwRApVHOEpdT+o1mL8+O4uRKDpiVTPYRap4YR2RtxTo9Wew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744088050; c=relaxed/simple;
	bh=THts4x8lAg2CXDirVmNIxj8FwPRaS1SHPGFkz2avijk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l99hEVpZL2y4NHRVCZLENYH7by0WUTFq6FlFiLSZDPvI9PxxyBAcCs0wy2KZjCfPu1u9k4BboUGHcXSjFRiUktp33TuCme0dXH2zYoDdLybBSUIVFyrWNsTXTc5l8pz7spdjfDdToQikXzBnzQRVkNvbGwml9jfQT68FMvvN93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=aKN+zk1N; arc=none smtp.client-ip=47.90.187.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1744088033; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xc3RQHbbWhjaENeV54tCo3uz4MbXYhwQLPGC2Mc716Q=;
	b=aKN+zk1NYCD9hjqg8NZg8UBPEH2BFHOYt1yq8g1110dyxzriOgELfxseNJHJ+LeKRMwf0WpOvIVyH3FDPpoE+QahzuhlOjFRftSBB7qPX2e0ESG1fs07pDwO2rzYxlYjL+1zjxoH9TkJskbl1kHEldLj8fCA6fYbB3LstUlGC+M=
Received: from 30.174.97.68(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cGd.uV9_1744087093 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 12:38:13 +0800
Message-ID: <621e867f-5427-4062-8783-e474e3dcdb3f@antgroup.com>
Date: Tue, 08 Apr 2025 12:38:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.13 23/28] um: Rewrite the sigio workaround based
 on epoll and tgkill
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 benjamin.berg@intel.com, linux-um@lists.infradead.org
References: <20250407181224.3180941-1-sashal@kernel.org>
 <20250407181224.3180941-23-sashal@kernel.org>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20250407181224.3180941-23-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/4/8 02:12, Sasha Levin wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> [ Upstream commit 33c9da5dfb18c2ff5a88d01aca2cf253cd0ac3bc ]
> 
> The existing sigio workaround implementation removes FDs from the
> poll when events are triggered, requiring users to re-add them via
> add_sigio_fd() after processing. This introduces a potential race
> condition between FD removal in write_sigio_thread() and next_poll
> update in __add_sigio_fd(), and is inefficient due to frequent FD
> removal and re-addition. Rewrite the implementation based on epoll
> and tgkill for improved efficiency and reliability.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> Link: https://patch.msgid.link/20250315161910.4082396-2-tiwei.btw@antgroup.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/um/drivers/random.c       |   2 +-
>  arch/um/drivers/rtc_user.c     |   2 +-
>  arch/um/include/shared/os.h    |   2 +-
>  arch/um/include/shared/sigio.h |   1 -
>  arch/um/kernel/sigio.c         |  26 ---
>  arch/um/os-Linux/sigio.c       | 330 +++++----------------------------
>  6 files changed, 47 insertions(+), 316 deletions(-)

Please drop this patch. Thanks! Details can be found here: 

https://lore.kernel.org/linux-um/ffa0b6af-523d-4e3e-9952-92f5b04b82b3@antgroup.com/

Regards,
Tiwei

