Return-Path: <stable+bounces-28493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A68815AE
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 17:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6BF1F22475
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D3B812;
	Wed, 20 Mar 2024 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmDq/IPS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB6EDB
	for <stable@vger.kernel.org>; Wed, 20 Mar 2024 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952288; cv=none; b=D6QCdAe7ypphDY1Mghfu8JhyGYvTsxW8OmF3f7lAz7i8+VtlWBZc7NjnP12DWnRl1XDZikneQ0Hbx3UX6bHCbAMWXTA6Aj8RYYkliHfdxMTUI8VDnJ1Bg8fKZFcNL007v2QwfAzmBx0EAnTRyl2PldZZ4J1o8hif0ZgDTcL35II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952288; c=relaxed/simple;
	bh=KRlMER8z/E7qMo/BRh3TfvtTvwbghgkCQ/LtBxiVF6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTl8u9HvKwTs7kBDxy1YeypHm8ZucxKJ+TfyDgKmSHUyygxsk5Ua9x4O7c3IYCE5clQydOC5DOrA97vn97VErPSDxDlb06Ph2EyVmMMZtycyjDiCobbdtBzBWfGltCTrDsbhHLbvagUMhxr3tAcolvTUKGhvyeVg14zgzgSnUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmDq/IPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2826EC433C7;
	Wed, 20 Mar 2024 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710952288;
	bh=KRlMER8z/E7qMo/BRh3TfvtTvwbghgkCQ/LtBxiVF6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmDq/IPSsJjxuaooZZE0FPCEfUHrh9j2FSlKMmfxY87/H5gafg5e0SSJR6tRaKdLz
	 yn7VtcIMRhDtM072ddeqYTqe5I95PuG7oOYEgwjvZrx44WdUXyitAVgnPP3ccqblA1
	 IBqgZfFUCmEDA3JnhqioFuW4OfymnrNc2Dt0oeTBeiCVyF9KLzi2UOO8qexhkgXhAW
	 QYZK6GQhZeCrJATPdcqWtbL4LzvyDmYCJhd1qbet/Kh9Icm/XWeeIEUTu/IKD9hqgV
	 zxCxHnZQbN2DOzV7rAjoHWLTHjbYvlruc/69YGVCx7lUzf74Gv9lBJDfUQZXhzIsYn
	 iHNLjtYDya7zw==
Date: Wed, 20 Mar 2024 11:40:08 -0400
From: Sasha Levin <sashal@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jarred White <jarredwhite@linux.microsoft.com>
Subject: Re: [PATCH 5.15.y] ACPI: CPPC: Use access_width over bit_width for
 system memory accesses
Message-ID: <ZfsDWPWr2FIz6eX4@sashalap>
References: <6df99ad6-0402-4dcf-9a1c-7259436768dd@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6df99ad6-0402-4dcf-9a1c-7259436768dd@linux.microsoft.com>

On Tue, Mar 19, 2024 at 09:38:03AM -0700, Easwar Hariharan wrote:
>Hi Greg, Sasha,
>
>commit 2f4a4d63a193be6fd530d180bb13c3592052904c upstream is marked for 5.15+ with CC: stable@vger.kernel.org, but the
>application will fail with a merge conflict due to missing intermediate feature patches. When you apply the patch to 5.15,
>could you take the backport below instead?

Hey Easwar,

Thanks for the early heads-up, but we can only take it after it's been
in a released version (which should happen next week).

-- 
Thanks,
Sasha

