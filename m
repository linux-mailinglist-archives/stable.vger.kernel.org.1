Return-Path: <stable+bounces-43521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CA8C1E2A
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 08:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE6E283A55
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 06:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5A31E51D;
	Fri, 10 May 2024 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SSlw25eD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TXVjyMoW"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C81361;
	Fri, 10 May 2024 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322948; cv=none; b=QF43W4dXAHRTu0oNm066RCN3KgMfcSMCDsd2Xn1xctC/kfJKJEqr0id2e7NvemBp9hrGgNbFbvVMCRvsOZqQbmvE0QW/oEUZFRV7iuLzDd3ZVPnX0Mpgm+SOrBPMOa5HMQxXIS/G9I7CXHZEJwmVIFq8s9Kw7fCE8WfRTDhVzEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322948; c=relaxed/simple;
	bh=ySOiCZi6wZZeJVGNhwU2ndvXvo/rln8yGH6sP6bFd/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0RRDQWFBb+MgprgyVO93sulXjV5mgqYSNdS+6p0bFy2fabMHydmOtLi8XjgImSRi6aSiD26cVebkJE4kezaY5FWGzeTQVYFcmQUb9I//9P41GCgo3/jz70LgwtYxRRZ+l3+A7havW0t6aRr1VKrOXCNu/b+FF8Us2YFYUMeXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SSlw25eD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TXVjyMoW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 May 2024 08:35:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715322945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiWgwXZNUgYVT1P/WFHirbZXJDsaudwsuRNKyAlK2ok=;
	b=SSlw25eDytsAMiPK9m+dJ2SXFuQcqByVDNzD1tV9nuh39DHN9vqUZt51VWVAskuGNcDESn
	ztmFebpvF8RNYrYZsWuP9EtDWnTUODT2QuYonY7WabufV87j7KNvAmvKclXtbF0xKxV2Qz
	/j6L6m3xKx18AZ9BJcxMTUyIqUFDiG6RDLYw2uEuwSgpfyAf+ntWIhih2nUCzBpfw1WvBL
	GseN1BeiLWd/Q01I4mR5i3fglQHr8GxPq7hwy6TkeLOsZ/6tcN2FfemfzDXFvkJ+Fw+k5t
	j6sH1NAO4gENYO3OaC9tyB8Q4fYCXkm8gUiIbw+eRF4F5YDCYThX5vJ13Drw+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715322945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiWgwXZNUgYVT1P/WFHirbZXJDsaudwsuRNKyAlK2ok=;
	b=TXVjyMoW8j4fu5MdczhZ1yVQwKOcnWrwxFr9fIBQppS3/LsD7p0B95utP1iiHD5tiHBQSb
	v7w2TeqBOZRU1hBg==
From: Nam Cao <namcao@linutronix.de>
To: Joel Granados <j.granados@samsung.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Mike Rapoport <rppt@kernel.org>,
	Andreas Dilger <adilger@dilger.ca>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	linux-riscv@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"ndesaulniers @ google . com" <ndesaulniers@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Changbin Du <changbin.du@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] init: fix allocated page overlapping with PTR_ERR
Message-ID: <20240510063544.cAHy0hF8@linutronix.de>
References: <20240418102943.180510-1-namcao@linutronix.de>
 <CGME20240429125236eucas1p24219f2d332e0267794a2f87dea9f39c4@eucas1p2.samsung.com>
 <20240429125230.s5pbeye24iw5aurz@joelS2.panther.com>
 <20240430073056.bEG4-yk8@linutronix.de>
 <0049995a-07d0-4aaa-abc7-5bfc0dc22ace@ghiti.fr>
 <20240430154238.nu6pebmdlpkxnk7q@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430154238.nu6pebmdlpkxnk7q@joelS2.panther.com>

On Tue, Apr 30, 2024 at 05:42:38PM +0200, Joel Granados wrote:
> On Tue, Apr 30, 2024 at 10:37:59AM +0200, Alexandre Ghiti wrote:
> > The config shows that it is a XIP kernel that comes with its own 
> > limitations (text is limited to 32MB for example), so I'm not surprised 
> > to see those overlaps.
> > 
> > We already discussed the removal of randconfig builds on XIP configs, 
> > but IIRC it is not possible.
> 
> I just tested this going back until "2023-09-20 602bf1830798 (HEAD)
> Merge branch 'for-6.7' into for-next  [Petr Mladek]" and I still saw the
> overlapping errors.
> 
> Is this just something that happens always?

Alex is write that this is due to the 32MB size limit on XIP kernel. This
means build failure happens if too many configurations are enabled and the
kernel gets too large.

I just sent a series to lift the size restriction and fix this build failure:
https://lore.kernel.org/lkml/cover.1715286093.git.namcao@linutronix.de/

Best regards,
Nam

