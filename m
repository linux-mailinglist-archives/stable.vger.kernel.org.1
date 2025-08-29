Return-Path: <stable+bounces-176730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A40B3C42B
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 23:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD857BDBF0
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F7734A31E;
	Fri, 29 Aug 2025 21:13:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1462287515;
	Fri, 29 Aug 2025 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502024; cv=none; b=B3HZRbKa0zy/VtK0mEbpE8qmYw60Bz45syGkXY381mMiMdT683LHDItgB3EcmlYUxTdIk2h1jQocuvJtRADTaoafwJuQhsWFh+T6GO1Gpt3xhnyNbvYt1v9vFTAD/2zHEzRGLW7iTqJGkGAiK2jBtfT0bd2amNa853mpw7hKrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502024; c=relaxed/simple;
	bh=Tc4drYHBoMjuZpIcjYkn+NMHMZlzv10UeHR79b/H3qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GScvUdQullKUSVxZyMdMGqmT1uQ9jdyVMaMK/NU9M8mEcAcywABN3X0HtzxI1+Vvc8lJllIA5VSbreqFtOxwvdd3iZRWyIREM2LuGPBcBKGe6pPZcUBFusX6zMRTfbOGflxPvw51QhwK3lY+Xjf83mvFESlRX0KE/4xeIeAvVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87DE51BA8;
	Fri, 29 Aug 2025 14:13:33 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBAF63F738;
	Fri, 29 Aug 2025 14:13:39 -0700 (PDT)
Date: Fri, 29 Aug 2025 22:13:29 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: quirk: fix write to string constant
Message-ID: <aLIX-XAYE--byaue@pluto>
References: <20250829132152.28218-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829132152.28218-1-johan@kernel.org>

On Fri, Aug 29, 2025 at 03:21:52PM +0200, Johan Hovold wrote:
> The quirk version range is typically a string constant and must not be
> modified (e.g. as it may be stored in read-only memory):
> 
> 	Unable to handle kernel write to read-only memory at virtual
> 	address ffffc036d998a947
> 
> Fix the range parsing so that it operates on a copy of the version range
> string, and mark all the quirk strings as const to reduce the risk of
> introducing similar future issues.

Hi,

indeed when implementing this I was a bit doubtful about the in-place
overwrite approach that I used during the ranges parsing...but since
each quirk was indeed initialized once and its range parsed once, it
seemed fair to use the string itself as a sort of scratch area while
parsing it into integers and avoid the local copy...just I haven't
considered the possibility that such strings could be stored in a RO
segment...and I got no error on my setup....

Anyway, good catch, it is certainly better to operate on a copy.

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

