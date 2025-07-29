Return-Path: <stable+bounces-165104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3FB151B5
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325805440A4
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34313292B35;
	Tue, 29 Jul 2025 16:55:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD73226D1F
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808122; cv=none; b=RN66U7epA6q9lq0HpbqT/sXCGWddjwbMDD+Z4YGZGRbNBjhqI3UxzvhcjWzMgXexkQ3cAgfrh4HaGg9TQU7icTHiYCObjZJz4j+0PfOKmJQKF4WZN/Eo4BX+oZXU7ROFgSwRnnAUGn5BtXRLEABH0Fl0Yeoh0c+JZ1rNykZoN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808122; c=relaxed/simple;
	bh=F+/LyjFWjwBUgdRic1KNxmjdCMRngJXtIt+Ahtz0qnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhjoUci9spwxBBTHEMbjLntX58rJdaO5SH67Fig0LTkf30cmXdFhlVoEgszd60+xtJEFDJhzqXlbsz7NIVfTxVIQ/xPIuBrKlYTcQkrRknf2sBsH/CF4SFTMlAixeTksbh+g0XKV1Kt+uGoOJ2zmLgOF6+vI8ILU27mmb7PHS9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2467A1516;
	Tue, 29 Jul 2025 09:55:12 -0700 (PDT)
Received: from [10.1.26.201] (e137867.arm.com [10.1.26.201])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0073B3F66E;
	Tue, 29 Jul 2025 09:55:18 -0700 (PDT)
Message-ID: <6ae28517-3665-41b9-bf2c-ce5beba8d422@arm.com>
Date: Tue, 29 Jul 2025 17:55:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] arm64/entry: Mask DAIF in cpu_switch_to(),
 call_on_irq_stack()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Cristian Prundeanu <cpru@amazon.com>, Will Deacon <will@kernel.org>,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <2025072811-pension-lyrics-6070@gregkh>
 <20250729124424.2699860-1-sashal@kernel.org>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <20250729124424.2699860-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 29/07/2025 13:44, Sasha Levin wrote:
> From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
>
> [ Upstream commit d42e6c20de6192f8e4ab4cf10be8c694ef27e8cb ]
> [...]
> [ removed duplicate save_and_disable_daif macro ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
I had the same fix prepared locally, but you were much faster !
Thanks for taking care of it,
Ada
(PS : I hope it is not inappropriate to respond on both fixes,
sorry for the noise if that is the case.)

