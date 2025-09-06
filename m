Return-Path: <stable+bounces-178001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA84B47726
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 22:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFD71B26445
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F21F1306;
	Sat,  6 Sep 2025 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQAc0i2R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FB1DDE9
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757191299; cv=none; b=f2iCOvK54vsUJ5X7xbp/woMLIVngzzPYOP8ZjEAqCrDbCoiDsSLpWt/m7VEtdSNdJX+/HjRhqULWCITmQQCdZQM38gLhJj0S8TyDtLBeHHpY9bWLDRC02QLiUkYkbUBxjgMWortSO6RzCCc6u0p8UdaE1SD6jwsNmOQnLrqnMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757191299; c=relaxed/simple;
	bh=HYXij2guy8d1fFTi09AUrhLBZF1G7gQtnoXtE/mOM1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upAr1y2Cf3mdHkaAvDGSuZPo1o5nNZMAUCeKtsW/RVAtFmY+narr8LUgCfl3Ci3qnWQnxDqRhNWkDc5IeJG5vYW5q097k3Ti796ZgXzz5sP/ffJ1PNYvivNk1R9F3L9gqxdzv3g+ditbMDecWqZn/5Mc0+maja7QrSNjMLwA/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQAc0i2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F36C4CEE7;
	Sat,  6 Sep 2025 20:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757191299;
	bh=HYXij2guy8d1fFTi09AUrhLBZF1G7gQtnoXtE/mOM1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQAc0i2RMxzu55HptXlYCAD2DiunuZpy+vIStZfkC+q9pA7XSTx0mnw2QovL6OzW1
	 SbnWbDNrT18Es+y3qYJL3VcOfCtGs4UgH944Y+Q/bqbi766R/lu9As/5KWUXwx91DR
	 MvL25L1hK3oEgKULLs4JGum5A3R0YnKRgIp7uwK0=
Date: Sat, 6 Sep 2025 07:51:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, bp@alien8.de
Subject: Re: [PATCH v2 5.15.y 2/3] KVM: SVM: Return TSA_SQ_NO and TSA_L1_NO
 bits in __do_cpuid_func()
Message-ID: <2025090608-fester-puzzle-a1d7@gregkh>
References: <20250905200341.2504047-1-boris.ostrovsky@oracle.com>
 <20250905200341.2504047-3-boris.ostrovsky@oracle.com>
 <2025090527-kelp-vice-8448@gregkh>
 <f7a6897f-6960-4b77-9fe5-9ea0a95d2104@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a6897f-6960-4b77-9fe5-9ea0a95d2104@oracle.com>

On Fri, Sep 05, 2025 at 04:55:32PM -0400, Boris Ostrovsky wrote:
> 
> 
> On 9/5/25 4:44 PM, Greg KH wrote:
> > On Fri, Sep 05, 2025 at 04:03:40PM -0400, Boris Ostrovsky wrote:
> > > Return values of TSA_SQ_NO and TSA_L1_NO bits as set in the kvm_cpu_caps.
> > > 
> > > This fix is stable-only.
> > 
> > You don't say why :(
> > 
> 
> I added Fixes tag there. Do you want me to say explicitly that c334ae4a545a
> (which is 5.15.y commit) forgot to do it?

Yes please.

thanks,

greg k-h

