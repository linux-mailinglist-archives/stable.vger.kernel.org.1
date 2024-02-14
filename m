Return-Path: <stable+bounces-20217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360CF855471
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 21:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684F11C21354
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 20:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A413DBBC;
	Wed, 14 Feb 2024 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aSGvgHdB"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B013DB88
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707944310; cv=none; b=K9QHuqJQbO3P1nitRpFTcDADVAr4aZBudCDocVltgOAE4sD2Ps7HutR0Plh7tUAJMbu6BWLgVMRXXBI+HfwQvnJsSp7CPjZ6W0KpN2kgEL7bA2ZgmXfxTfhVKdwxdtiHod6zHRDIu23rPREPbCbsT62nrPjErvX9odK754SfyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707944310; c=relaxed/simple;
	bh=XQj8poqrg4+CfO5snNegLfdzlb6jX7sbVrbQUXh9Bv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGY1tS2oItNKUj0cXWu6rhJnSzdg/LAKCpb9dwlIIR6GNwqHK4fn/SXGGB9azb5IUDM8/Fc6wfXHewSkPZULb1Tu2p2XjYQ3xWDY7xsUdDmA0S7H2sHu39mL6jgcQgy1AceSe0hS2q1sxVSeUhOWP0nt44vZyLB65nvYML8eEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aSGvgHdB; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 12:58:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707944306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ7qxsgvekArPpn3g43oSJoyx4+B3LXb9434aIWbmSc=;
	b=aSGvgHdBczCTABLRPiix5khxX8WLiPNatU8bn9sZZLpBSXxJna9ftCOa2ZGZy1BKnWG2ep
	5NJY6K4lNBc+PfA1DLtYBm0Zh7J7mrtEGONm1UEYEoiWLvhQATu2r/85aA441cfA5z6+UH
	MPabeqy+u1MzQYXgzxCRFaF8s5EgzL4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM
 Neoverse N2 errata
Message-ID: <Zc0pbaa0mnQta-mw@linux.dev>
References: <20240214175522.2457857-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214175522.2457857-1-eahariha@linux.microsoft.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 05:55:18PM +0000, Easwar Hariharan wrote:
> Add the MIDR value of Microsoft Azure Cobalt 100, which is a Microsoft
> implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and therefore
> suffers from all the same errata.
> 
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver

