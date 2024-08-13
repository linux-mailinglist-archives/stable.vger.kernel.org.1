Return-Path: <stable+bounces-67416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC5794FD1F
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 07:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E32280FA4
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 05:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D09219F3;
	Tue, 13 Aug 2024 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LG9GHIwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49772261D;
	Tue, 13 Aug 2024 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723526048; cv=none; b=euQppDBePJrxlq9d0ThyUnhhI5aP0sUwAP6Gc8aVilKEItMM8b3BNSWIosoRISEAeLzbRdNKbyAUWWIn2dhPcMOX4o52A/2VSQs5mNrR9YzrCTE9kW+X1CWjxXk5EIDkVGMJkhj02zMlDkJJ5ndml7wYjLytfZKEhfhd1W3l/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723526048; c=relaxed/simple;
	bh=VShyZtWO+Mfwh+7GhcuW9kE6yHwTk+tzCdlsYo6JH4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0gtWvDVqgpe3SHXTH71imz7k03lX4cKYtahL64NgmkN35OBrg5kqnnWhbQ2nlJCjYltaqe0Zv+WUmimbUqThyLNMTGUvvnasIKaRSrX+FqVmPRs4lvwQ7ffhc74CYaXobxNaI+iBA0qcsZP62RBIlozmktqu4Iuur1/z0bzsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LG9GHIwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BB8C4AF0B;
	Tue, 13 Aug 2024 05:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723526047;
	bh=VShyZtWO+Mfwh+7GhcuW9kE6yHwTk+tzCdlsYo6JH4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LG9GHIwmwPa8eTvAz1eVCVuP2Pzg2ZLpMXAvADAniXa4SWchuzBo9o22njvBa3fAm
	 wwD/weN/pXgV5UiBVGpWnkjAZRYYjhxt7SfU9bnUkbxaZhFevNUs1rU11bMpJ+TIB7
	 KX7uNGhRoqhQvbButebbmthX0Nd9feYouqdehGMY=
Date: Tue, 13 Aug 2024 07:14:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: levymitchell0@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3] x86/fpu: Avoid writing LBR bit to IA32_XSS unless
 supported
Message-ID: <2024081339-duchess-demeanor-171a@gregkh>
References: <20240812-xsave-lbr-fix-v3-1-95bac1bf62f4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812-xsave-lbr-fix-v3-1-95bac1bf62f4@gmail.com>

On Mon, Aug 12, 2024 at 01:44:12PM -0700, Mitchell Levy via B4 Relay wrote:
> Fixes: f0dccc9da4c0 ("x86/fpu/xstate: Support dynamic supervisor feature for LBR")
> Cc: stable@vger.kernel.org
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>

Please remove the blank lines here.

thanks,

greg k-h

