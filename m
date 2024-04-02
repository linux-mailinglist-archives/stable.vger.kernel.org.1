Return-Path: <stable+bounces-35628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5342B895A85
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C391F223F3
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 17:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BEE15990F;
	Tue,  2 Apr 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="YJ9XlS73"
X-Original-To: stable@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878B129E78
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078303; cv=pass; b=kcBgrFHx+z0MiFwUjyIwgs0SYqAhBgeJKhU36N2Gwzj6WfyUdP7TRcigUjNHsbGgKPE0Z2bDcxEl6oV58SN5+1yU2/TbcBtYv8CggoUBYG+oNJPLCiN3LfrLZ8a+PRq9dKMV1oU3WzM8iYfR5O1qHEckkQA7CNXAFNAen6Y/qWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078303; c=relaxed/simple;
	bh=LHoJRIV32/MQppd8SJNTftmfwtdHGhBmGQIk+Eaa7wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxe6mdyvRtJnfqqRNiQXk5wCmQ7wK/D/0aw1krAU9uxkYV6KJdJAD0hBsGP7bFH/tqq/sKjAREPTD+B3Z4KK3HF4aztluVMfC62h7MgUfiUVYlLz1Ix/wYOVfXJyaD8OmlkxpoSJPYY2S9uI54iIx/Hlt1DgKVz9sp1yBbYxBMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=YJ9XlS73; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-140-31-nat.elisa-mobile.fi [85.76.140.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8F2f5KTsz49Psw;
	Tue,  2 Apr 2024 20:18:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712078298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wpEkQ4uaqAmccT7n62vg/EKg4B1k8sNx6O56b1CN10=;
	b=YJ9XlS73tPLWUm6wZXYz1SeiSwStM/6jPjYX1+zlJjuA1Jjpy426Rc8x22//yQ7haWZtPn
	BI+VmcJupW7hl2mxtWKuxVU1GAZx7swoLVXn+DeYDaCeriBMHrKs3vFk/N6WhIjwxERSdY
	1AKEPrUe/gdKffW88f0ZvBqBLFaribr/36TnhV3f7IEfB8qnKQCGvVHfuNio1Co6FtwCDC
	FciB7ba3R2xFDMfp5Y6q8AYmDOoGu8LQwEYxI70aBk8lTru8+6Xobp2ZTN2da7WROy1lsM
	eeEit+dVkuxQyIwVgDZLm/Dg2y26uNxbkHrPoTPzqptTG1REOWDPY7t1/0xGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712078298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wpEkQ4uaqAmccT7n62vg/EKg4B1k8sNx6O56b1CN10=;
	b=e+Ww9ottyH/V8OphmgVjlu8EsFR2KLflrbH53SJC6Bixu1kz3dzBuKdqMWo/UbLRMIwF/6
	gIwNEq6a1VYOatZDJeyfYK6ZWxKq/akpLaxhJNPeuSfIfBUAx+5BNl7hMuw1z5F7Qp8zVD
	SDz7aeCWOf6q40fHTlDrF0szrdHy68GzSFGP7ZwGJCXZF7qpS6LRYufnJMzoxWoJ/F2Rqg
	sRi1cGgtwSe7mNF7/VDnMgNcgroE0PXQEhhlNOehCIyNovl5ZX9pSkCbSDtfb6HC7uaUQc
	BBmCDju49wOwPjjf+x3FdhPr/3LbCDhhyenp79GUQsWECST5Hs3r8345e7+Tiw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712078298; a=rsa-sha256;
	cv=none;
	b=g9BFABEgvE0Ky4KpHbVdOy8ekgPPt63uH8+tLkOcABzH2EYu+vxcs76UGFhzErXGKnmkB5
	QJfL/xE5gSMKjBQ19xT5HDynorPDXpMbtgGvE20erAR11XzokgRzI28HbgReUH2AtOao/y
	ysuSuqoNRJphP/+VPS/OI0WjRpkWqBATCmlTL/oVXTtJFrgq7s53G5QjCqKm3Z3uXgCwe7
	c7suJSqv3w3rJub3u1FLnyPTtyo6y0ERp/9Bf6VbsLMBrpaT/oC6J0RQKdcqv37y6g3aoO
	mW9xIhiZTnsQed0PX6fgZE4SBSyYJNChtuCOlvGnbKOcXrslX9XHbiyPoT3vmQ==
Date: Tue, 2 Apr 2024 20:18:17 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Re: Request to cherry-pick a patch for v5.15 (locking/rwsem: Disable
 preemption while trying for rwsem lock)
Message-ID: <20240402171817.GB91663@darkstar.musicnaut.iki.fi>
References: <20240401215445.GA91663@darkstar.musicnaut.iki.fi>
 <2024040214-unhinge-espresso-0a66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040214-unhinge-espresso-0a66@gregkh>

Hi,

On Tue, Apr 02, 2024 at 07:13:56AM +0200, Greg KH wrote:
> On Tue, Apr 02, 2024 at 12:54:45AM +0300, Aaro Koskinen wrote:
> > Dear stable team,
> > 
> > Would you please cherry-pick the following patch into v5.15 stable:
> > 
> >   locking/rwsem: Disable preemption while trying for rwsem lock
> > 
> >   commit 48dfb5d2560d36fb16c7d430c229d1604ea7d185
> 
> Why?  What does it fix?  Why is it needed there?  And why not cc: any of
> the people and maintainers involved in it?

The original thread included all parties:
https://lore.kernel.org/lkml/b92644e5-529b-4403-aba7-d316262cc8ac@redhat.com/#r

Anyway, I will repost this request to that thread with details that
you requested, so that it gets properly archived.

A.

> > Earlier discussion:
> > 
> >   https://marc.info/?l=linux-kernel&m=170965048500766&w=2
> 
> Please use lore.kernel.org for mailing list archive links.
> 
> thanks,
> 
> greg k-h

