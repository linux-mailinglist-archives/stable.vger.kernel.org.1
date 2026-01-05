Return-Path: <stable+bounces-204638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC9ECF30E3
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CA69300296B
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2DE31618E;
	Mon,  5 Jan 2026 10:51:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5620F314A6A
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610264; cv=none; b=gxULumoTu9Svdv6tUPnV5nH7hgj7EdqlebxasyJGjVsQr4OVqQUdrvYw9QjKnZA6edpHG0w34Lr8p7FT5+AJb98FbOLWoyBoiqAuu55ZiSPDaLsZXG884NqiGsBq7yCfSnTSAcqs6kXyQME5mteYwF+mxyv6zgn5sWSLEWaueXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610264; c=relaxed/simple;
	bh=IT87PXZ9aJFPb7BaTi+anWhD1WGXaW8lgf+azZwdEQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP1VxdpgzGunw31L+N3InfsouFcjMcnk5aaGnz9UvpPXhSbsowODwFYMeo3eNcPV4oZLoFfzgoFr/qrJeQEYDXTVlKynggPLp1UAx9aOUn3b/ETscg1Zo/fz//6M3/nMnVzoL6/22c2ZZElQrtGY42lTYAj2dNDCNthtQBS9MBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9F7D497;
	Mon,  5 Jan 2026 02:50:54 -0800 (PST)
Received: from bogus (unknown [10.57.45.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D97C3F6A8;
	Mon,  5 Jan 2026 02:51:00 -0800 (PST)
Date: Mon, 5 Jan 2026 10:50:57 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Petr Malat <oss@malat.biz>
Cc: stable@vger.kernel.org, pierre.gondois@arm.com, wen.yang@linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cacheinfo: Remove of_node_put() for fw_token
Message-ID: <aVuXkUjzIb7BC5vv@bogus>
References: <20260102193457.270660-1-oss@malat.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102193457.270660-1-oss@malat.biz>

On Fri, Jan 02, 2026 at 08:34:57PM +0100, Petr Malat wrote:
> fw_token is used for DT/ACPI systems to identify CPUs sharing caches.
> For DT based systems, fw_token is set to a pointer to a DT node.
> 
> Commit 22def0b492e6 ("arch_topology: Build cacheinfo from primary CPU")
> removed clearing of per_cpu_cacheinfo(cpu), which leads to reference
> underrun in cache_shared_cpu_map_remove() during repeated cpu
> offline/online as the reference is no longer incremented, because
> allocate_cache_info() is now skipped in the online path.
> 
> The same problem existed on upstream but had a different root cause,
> see 2613cc29c572 ("cacheinfo: Remove of_node_put() for fw_token").
> 

Please let us know which stable versions you need this for ? I assume it
is for stable only, but it not clear from the subject.

Or do you want this to be applied only for v6.1.x as 22def0b492e6 exist
in v6.1.x ?

-- 
Regards,
Sudeep

