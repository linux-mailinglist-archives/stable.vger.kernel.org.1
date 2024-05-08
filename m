Return-Path: <stable+bounces-43442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0EF8BF636
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 08:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162661F23A7B
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 06:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35726182B3;
	Wed,  8 May 2024 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vh1PdP00"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9371863C
	for <stable@vger.kernel.org>; Wed,  8 May 2024 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149548; cv=none; b=Ja6zVOIMx4t/BnS5Cx/I6/UCr267WJ+onNwPmGnygVss5zH2+PwwNXn6iXf2SGC8ZUiVNCfJxgLzk755eKv6L+CUxEUqYBevrbwHx8pH1AJY7tOluC4iMjWz5eDRdCFowiMLOcyZ2HI0CG7fwAO5Bpl8Oz99UiSHj9ZoXFsJYuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149548; c=relaxed/simple;
	bh=0yTnDzRzl6YMEDAYdK4MzUFIs1RryobdwGldopgZgrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrMF3lQeyu0VL9/iFxtcNq6/MdJNq7r211bLrKJ7mvHEKhFJmNVZUX69Q9/56Vq4MtsscTtbSpLN0pg5WfRlqXD/oEd5hQs2+MJ3TF6Zv0Oe9i5P/OT8Ya7G+nJVuqj/OnI45Pe5KDYegqdvHIlVmF/ZVHPDUF/HXaKWdZx8vlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vh1PdP00; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 8 May 2024 06:25:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715149544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cX9UDFEcMUiOwQWR3+txM6O/c7psSYzDc8seRaVOFUA=;
	b=Vh1PdP00Hz0dsjoJ8XSe+qAtpu16Gl/4TaRhsPZ3AnqRi04QNU82oEK7OXqFZH7NOcVwXg
	7Ua/e5i8KWFXYzf9bVHTz+fHUkVvEm217ZgRHX9ISZtqa/oPPeSwyVV/0Sc2h1xdGJSLkt
	wLnhCNlaP/Y6fwqO9DMHaKu4KWAfCwQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, pbonzini@redhat.com,
	shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 18/52] KVM: selftests: Add test for uaccesses
 to non-existent vgic-v2 CPUIF
Message-ID: <Zjsa4yeD_EmV7TgP@linux.dev>
References: <20240507230800.392128-1-sashal@kernel.org>
 <20240507230800.392128-18-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507230800.392128-18-sashal@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi,

On Tue, May 07, 2024 at 07:06:44PM -0400, Sasha Levin wrote:
> From: Oliver Upton <oliver.upton@linux.dev>
> 
> [ Upstream commit 160933e330f4c5a13931d725a4d952a4b9aefa71 ]

Can you please drop this and pick up the bugfix instead?

6ddb4f372fc6 ("KVM: arm64: vgic-v2: Check for non-NULL vCPU in vgic_v2_parse_attr()")

-- 
Thanks,
Oliver

