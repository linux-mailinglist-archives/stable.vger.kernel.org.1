Return-Path: <stable+bounces-172333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790B5B31255
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 10:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42353A1C24
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E77216E26;
	Fri, 22 Aug 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iwI7Ysoa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88C5393DE7;
	Fri, 22 Aug 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852735; cv=none; b=TYrYK+oXTzn1h78Q48RSHnTPb7r2QVD2aJ4Cv1cwFf1WKGgYOR6k4ZpgVPqpuI57LLj2aiM8XRwK9vjsQ2GeJlHZJUlie39PPK6cGTnHlduMvLX8DuLfeFO5elLYzojasA13jQBdcdhfiv0Gn6PhYxKYquO4keDZebbsScef6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852735; c=relaxed/simple;
	bh=T6wd6N9d6U7AOOxunQGKThliNBwE+69zrHPxWg2csj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxvObDtFd26/gGhB0US49EoRW6k3xvCFDvkg1OJar2OkXkGwrk4oZqTAAJeW9aIvS7IigrJrHVRmx6y+kUoLUMmerLhJ7uDUfLIyTzPz0bHCD3+9+XqxddKBH1LI+R3DoeynIo8xwCERu1Nrgtwbe/YN7E4AqLGC+0ELy7sMXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iwI7Ysoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093FAC4CEF1;
	Fri, 22 Aug 2025 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755852734;
	bh=T6wd6N9d6U7AOOxunQGKThliNBwE+69zrHPxWg2csj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwI7Ysoa9tYquF7OogSsnVrKE9cQb7A2MATYLdK6LigFArzlHQ2AA4XQVDAPNSPTT
	 o4LYwkO5phCRK6cWXt/Dz9KoPwE/bHgld55CGk05Voa2C6LbKHWFhqNazfCKwf1Ix2
	 4F9FrJSUxa6E1b8MQfyUxg6vbfpBsc88Oabov6vQ=
Date: Fri, 22 Aug 2025 10:52:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, prarit@redhat.com,
	rui.y.wang@intel.com, x86@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6.6 1/2] x86/irq: Factor out handler invocation from
 common_interrupt()
Message-ID: <2025082206-wieldable-backlit-4438@gregkh>
References: <20250821131228.1094633-1-ruanjinjie@huawei.com>
 <20250821131228.1094633-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821131228.1094633-2-ruanjinjie@huawei.com>

On Thu, Aug 21, 2025 at 01:12:27PM +0000, Jinjie Ruan wrote:
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> Prepare for calling external interrupt handlers directly from the posted
> MSI demultiplexing loop. Extract the common code from common_interrupt() to
> avoid code duplication.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20240423174114.526704-8-jacob.jun.pan@linux.intel.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/x86/kernel/irq.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

