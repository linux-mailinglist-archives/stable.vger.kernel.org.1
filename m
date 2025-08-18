Return-Path: <stable+bounces-171629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1611B2AE6D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 18:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F597B190B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF4224AF9;
	Mon, 18 Aug 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a0zyRSu7"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC9258EFF;
	Mon, 18 Aug 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535417; cv=none; b=MXu/OIIyiaYfmbWJUljuXEQyMexgCyxamt6mLbhMaPtij6ktInHToOQP1QLN/XqGzj5SMmJw/KyHNtTpU9ieOE8N0k0qmlNSi7vX40CNxC/xR+AEWKmzporS7qAobyrqQ9LG/CcH+288vf95SV/ZDCiUj8F6ckuifd2hqHVGV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535417; c=relaxed/simple;
	bh=cxA/jRM961QH+QNA2nNyFKdZriwUq0YMT0+51oaljKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFfipM7LNhVg9WtZxlIPU4t+D+Mdanm6srzKFXhJuVzo99vU/QTc2LyQKwH4CHgYVbQi91so32uI9LKrsntRdmitUmofe5UFHERHBODn08QuBfmeVlNmDJV9FJSyuQP+OzrRXzTCUEb98YU/rca4NN5n2dCXRcSglZIhJXErfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a0zyRSu7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.51] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1A83C201C745;
	Mon, 18 Aug 2025 09:43:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A83C201C745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755535416;
	bh=SXGLci2op51kbabXqNAVoe6QjO2o3XZvk4PJDh5Hm0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a0zyRSu78NhvKB1A177TycHu22xaISLK0klzuaYLvKLjjE43lZMkPnEA3Vc4MZHjz
	 UzQ/CSQmoynxisbCbNZleUD9JJ5vpj2hHe1vNMlvZGis+OUYPj6nHolFx96RFOqnB0
	 wPiEvfPFJfAp3WqlVRN3DHJqw8goLeB3PdWUtceI=
Message-ID: <66d68e9a-bbf5-4212-8ca3-175064af545c@linux.microsoft.com>
Date: Mon, 18 Aug 2025 09:43:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "rtc: ds1307: remove clear of oscillator stop flag (OSF) in
 probe" has been added to the 5.4-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 stable-commits@vger.kernel.org, stable@vger.kernel.org
References: <20250817154824.2401461-1-sashal@kernel.org>
Content-Language: en-US
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
In-Reply-To: <20250817154824.2401461-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/2025 8:48 AM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>     rtc: ds1307: remove clear of oscillator stop flag (OSF) in probe
>
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Hi Sasha,

FYI, patch 2/2 of the series wasn't applied to 5.4, but was applied to all the other trees.

"rtc: ds1307: handle oscillator stop flag (OSF) for ds1341"

[PATCH 2/2] rtc: ds1307: handle oscillator stop flag (OSF) for ds1341 - Meagan Lloyd <https://lore.kernel.org/all/1749665656-30108-3-git-send-email-meaganlloyd@linux.microsoft.com/>

(upstream commit 523923cfd5d622b8f4ba893fdaf29fa6adeb8c3e)

Thank you,

Meagan


