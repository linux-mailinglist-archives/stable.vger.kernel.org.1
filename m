Return-Path: <stable+bounces-48246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73F88FD6A8
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 21:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F661C251D7
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7931514D9;
	Wed,  5 Jun 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lC1v9PCv"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5C14EC56
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616474; cv=none; b=Gwy82Lcqx7czMHFOvksy/xX/oWBPUJd3Y0+qpqpG1vtSnJyUiJ8Qj2SBtZxY7j7K0n46WozUUZ4s9CW4mUn6pSBHRZbLnIWR8HfjKhXFXEHiwQBGFSGdbvVJe9jCk49GBlywlxD0eBsAQ91ikfQtcz1yXU0lrgxa/2IJ6Y71owY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616474; c=relaxed/simple;
	bh=5ibj/fnmpZiIwzxbzLrcku79RVFzUFCq7Xnrp7YZuP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADq/IA0B1PgCce9rMuDCMm7KyXaaP1ZzP5j+A8BWwlpt/Sz/lsv3SXJkRlhnwAxoB8MZTh17E5X1WVSbIY/Pe5kWKOdaz9bIepSK1anDo9Xo5vDfstSDu4+IRF/BN5iMMfNYBzTd1YYnH47laZhEjnZeSclZMCzL2V14uXiD1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lC1v9PCv; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: maz@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717616466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lxpi+HI6W0ywsNLdUWfFgg8K2OiK948hs+eRJnTEKKE=;
	b=lC1v9PCv2LbPYZLoFgjoWuwM5frZgzicuBp3WDk5/HHIkgm5WN3G4Ac9+Wmshgh1hdN1I/
	Lp/8SGlnm7KOyTAbSbbP5TPMxMenlAGt0ZeMX2xzrU6tpPkYke/d4W5GIFICBmr9+anKkM
	j0beBK4vrbQWlwGysf9vVDmG8k64Z/w=
X-Envelope-To: kvmarm@lists.linux.dev
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: james.morse@arm.com
X-Envelope-To: suzuki.poulose@arm.com
X-Envelope-To: yuzenghui@huawei.com
X-Envelope-To: glider@google.com
X-Envelope-To: stable@vger.kernel.org
Date: Wed, 5 Jun 2024 19:40:59 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, glider@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Disassociate vcpus from redistributor region
 on teardown
Message-ID: <ZmC_S5FZM2pXecSr@linux.dev>
References: <20240605175637.1635653-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605175637.1635653-1-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 05, 2024 at 06:56:37PM +0100, Marc Zyngier wrote:
> When tearing down a redistributor region, make sure we don't have
> any dangling pointer to that region stored in a vcpu.
> 
> Fixes: e5a35635464b ("kvm: arm64: vgic-v3: Introduce vgic_v3_free_redist_region()")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org

Reported-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver

