Return-Path: <stable+bounces-202701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AADCC37A7
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 829B13053B02
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BCA330664;
	Tue, 16 Dec 2025 13:19:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36D7330640
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891159; cv=none; b=LBNPJ3CFiSzYELVl0wZrEIK/ZVfdZHeVLq6DW8x3pdhBcx1wWvSARChXaoIJAtD7mj2PqKbfbFJipyIQWigXc2QNXpkOIIXCMvfLp7dOXm3KHpdUhZ+E+nIb3LFKjMP1kigWz+A0Jb94UlnB/JlEZtjSecl2QNjTNn78VS7wxGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891159; c=relaxed/simple;
	bh=SQZAJgkIxkSDWeWxrPK7yeMoVrvrUkmRvaj0VrUsgwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCnyPC8wnp6dzkCDWQWRkAwGdwXzEoVjlhwQQttEheliMIXfXCTmC38Cg7j97Et7vmtS0MBAyNmiXtm848xWwiZ6ny8vElr+zhUaTukhPEyhQRArqViUfbnA4UIPKUenYXP9/WsLKRJ0rz3Cem2dQbH8koN1gCBD+nLQe53WmRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFF5DFEC;
	Tue, 16 Dec 2025 05:19:09 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA5643F73B;
	Tue, 16 Dec 2025 05:19:15 -0800 (PST)
Date: Tue, 16 Dec 2025 13:19:12 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Amitai Gottlieb <amitaig@hailo.ai>
Cc: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<amitaigottlieb@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v2] [STABLE ONLY] firmware: arm_scmi: Fix unused
 notifier-block in unregister
Message-ID: <20251216-funny-gopher-of-hurricane-d276d0@sudeepholla>
References: <20251216115009.30573-1-amitaig@hailo.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216115009.30573-1-amitaig@hailo.ai>

On Tue, Dec 16, 2025 at 01:50:09PM +0200, Amitai Gottlieb wrote:
> In scmi_devm_notifier_unregister(), the notifier-block argument was ignored
> and never passed to devres_release(). As a result, the function always
> returned -ENOENT and failed to unregister the notifier.
> 
> Drivers that depend on this helper for teardown could therefore hit
> unexpected failures, including kernel panics.
> 
> Commit 264a2c520628 ("firmware: arm_scmi: Simplify scmi_devm_notifier_unregister")
> removed the faulty code path during refactoring and hence this fix is not
> required upstream.
> 
> Cc: <stable@vger.kernel.org> # 5.15.x, 6.1.x, and 6.6.x
> Fixes: 5ad3d1cf7d34 ("firmware: arm_scmi: Introduce new devres notification ops")
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

You missed again to add my reviewed-by tag. Anyways here it is. No need
to repost for that.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

