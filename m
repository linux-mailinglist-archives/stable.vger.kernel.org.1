Return-Path: <stable+bounces-164906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FFDB139B4
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C72188B909
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC52E257448;
	Mon, 28 Jul 2025 11:13:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53A7DA9C;
	Mon, 28 Jul 2025 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701238; cv=none; b=HKhbB+HY172ENR/1zSZg35bldC4aHfCdQtYRAqy8648zYpAjTS114x4HnEkqiLh8X+GB+4z7eLOoun/WbQg6+gL3FqP7p612vGpDcG+IQ1Wgd+0KILQk36u0RfcMdtXsxo4MzeQdZmIPoXxyLuE5RDvfhKknkKvcA95kYk5Hedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701238; c=relaxed/simple;
	bh=wjkyTwatuyEzK4/8RfL6yoOXMw6U3B3sKosIVHHufBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Le0gqXhwXCT02szTKQLzk1rTwpGfQuntZB9oU7IYi2dhuNXKSPZ4hC5sAB/LFim4+WHwwNSR2hkjcOoNknn/bpxwN6Zkrm9ataVc7YQRQul+CUEX7deH/8n9/E89MCvqv0ZLZnke13z753dkN3ZkbqXL3bKxgzgDZ6lOlqhJJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7B99152B;
	Mon, 28 Jul 2025 04:13:47 -0700 (PDT)
Received: from [10.57.87.40] (unknown [10.57.87.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 829243F66E;
	Mon, 28 Jul 2025 04:13:53 -0700 (PDT)
Message-ID: <f0e12d1e-110d-4a56-9f77-8fe2d664b0d1@arm.com>
Date: Mon, 28 Jul 2025 12:13:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Fix use-after-free due to race between memory
 hotunplug and ptdump
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, maz@kernel.org, stable@vger.kernel.org
References: <20250728103137.94726-1-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250728103137.94726-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/07/2025 11:31, Dev Jain wrote:
> Memory hotunplug is done under the hotplug lock and ptdump walk is done
> under the init_mm.mmap_lock. Therefore, ptdump and hotunplug can run
> simultaneously without any synchronization. During hotunplug,
> free_empty_tables() is ultimately called to free up the pagetables.
> The following race can happen, where x denotes the level of the pagetable:
> 
> CPU1					CPU2
> free_empty_pxd_table
> 					ptdump_walk_pgd()
> 					Get p(x+1)d table from pxd entry
> pxd_clear
> free_hotplug_pgtable_page(p(x+1)dp)
> 					Still using the p(x+1)d table
> 
> which leads to a user-after-free.

I'm not sure I understand this. ptdump_show() protects against this with
get_online_mems()/put_online_mems(), doesn't it? There are 2 paths that call
ptdump_walk_pgd(). This protects one of them. The other is ptdump_check_wx(); I
thought you (or Anshuman?) had a patch in flight to fix that with
[get|put]_online_mems() too?

Sorry if my memory is failing me here...

