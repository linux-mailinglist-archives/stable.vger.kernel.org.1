Return-Path: <stable+bounces-165103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD7B151B4
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B9D5440E5
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35526298981;
	Tue, 29 Jul 2025 16:54:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2E226D1F
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808096; cv=none; b=MXIfUX5WCeUnTIIUTJUg1UexhiDxlNirE6eBXyBhwTMdYEuGi1f6mgferLRT5v0BWpShN/FW83bXn2K2lrZEzfFNUqmO7ctuhBUSkhFtMTkFcA5w9jil+kCHgx/PEsRDrGtNbcdEzWy6Jib8mAOD0YTttx4EfZyOLOz5Z5UbawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808096; c=relaxed/simple;
	bh=Zzq8/gcF1U/bNSeSp6T6p6Jh8NSn0N6qz1l7subbEIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRYAxwJyMvAa2x6XZqhQOpdxtOnI4t6HmqsoQFjBxryYuPu923IoviQlNvqhdWuEVlZ0tghf9Br2PbvPXiKZ6f7cjqGen3yQy1aqYoTCGiRNZcJx/6UEc1wgvpsv0mfITpjuIaE80smOeBBrPLFt++7yZW4LsGNwCvLq4ACyym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD5981516;
	Tue, 29 Jul 2025 09:54:44 -0700 (PDT)
Received: from [10.1.26.201] (e137867.arm.com [10.1.26.201])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA41C3F66E;
	Tue, 29 Jul 2025 09:54:51 -0700 (PDT)
Message-ID: <0a9da0f1-96f3-4c63-a8fd-b18279ed62af@arm.com>
Date: Tue, 29 Jul 2025 17:54:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] arm64/entry: Mask DAIF in cpu_switch_to(),
 call_on_irq_stack()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Cristian Prundeanu <cpru@amazon.com>, Will Deacon <will@kernel.org>,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <2025072817-deeply-galleria-d758@gregkh>
 <20250729122421.2688525-1-sashal@kernel.org>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <20250729122421.2688525-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 29/07/2025 13:24, Sasha Levin wrote:
> From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
>
> [ Upstream commit d42e6c20de6192f8e4ab4cf10be8c694ef27e8cb ]
> [...]
> [ removed duplicate save_and_disable_daif macro ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
I had the same fix prepared locally, but you were much faster !
Thanks for taking care of it,
Ada

