Return-Path: <stable+bounces-126769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD3A71D2A
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FB97A9928
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF3723BCF3;
	Wed, 26 Mar 2025 17:32:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441823AE82;
	Wed, 26 Mar 2025 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010347; cv=none; b=UDVrRC1QP3tOTEYvfQXofqh+XPqQ/NG2j9Wcd98ZiZeil5FDxm2CPD/MBjVmNOJ+cf4SXqhiDaz53lMlBv8njPJJHnvvA1G2sZBaVaJxkFEOJO4CEQng3J+bu3nVwaDsCLuU6JdJJfR66RtWRfk7fWNwcHq+RwWJxcaQStu3jcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010347; c=relaxed/simple;
	bh=ZSyBGoPDGOMWowXYUxCdlbsD7rbcHZ3pre26mEqakvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poRXvdIs4329fi3ztWZf2TKx1LvmiKiBCiCZNF+y4D/S4h467nI0QEU/h7tsF/asgXeiCXkBMqLwSm6u/mJN+MsnYEqXHjpDJtzjaCPTuEzIZ9nqvac+VazwFWGW2qnfGYqQGlSCVoqXGW++75ySx4cWDwf6lRvxnjMcmn1t54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7BC11424;
	Wed, 26 Mar 2025 10:32:29 -0700 (PDT)
Received: from [10.57.66.235] (unknown [10.57.66.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93E8E3F58B;
	Wed, 26 Mar 2025 10:32:22 -0700 (PDT)
Message-ID: <8df29f21-fe0d-4784-84cc-4e20ce19c4bd@arm.com>
Date: Wed, 26 Mar 2025 17:32:00 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: mops: Do not dereference src reg for a set
 operation
To: Keir Fraser <keirf@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250326110448.3792396-1-keirf@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@arm.com>
In-Reply-To: <20250326110448.3792396-1-keirf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2025 11:04, Keir Fraser wrote:
> The source register is not used for SET* and reading it can result in
> a UBSAN out-of-bounds array access error, specifically when the MOPS
> exception is taken from a SET* sequence with XZR (reg 31) as the
> source. Architecturally this is the only case where a src/dst/size
> field in the ESR can be reported as 31.
> 
> Prior to 2de451a329cf662b the code in do_el0_mops() was benign as the
> use of pt_regs_read_reg() prevented the out-of-bounds access.
> 
> Fixes: 2de451a329cf662b ("KVM: arm64: Add handler for MOPS exceptions")
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: stable@vger.kernel.org
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Keir Fraser <keirf@google.com>

FWIW,

Reviewed-by: Kristina Martšenko <kristina.martsenko@arm.com>

Thanks,
Kristina


