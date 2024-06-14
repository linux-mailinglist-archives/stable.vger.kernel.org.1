Return-Path: <stable+bounces-52163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACBC9086AB
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 10:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D91FB20C19
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C814884B;
	Fri, 14 Jun 2024 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FjKRjeO/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2042813A863
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354751; cv=none; b=EFWAVZM9thysdxs8nWVslCSEUkRANqqCDLPHV4trkxElhDJJbfbquYwh5vnOCJ6AoWvbkk/bgxZPSwYraD/C/jCaRZdzPK9y3UGQvsV/uv9uQP73RDD2AhJFfhCkVc8aRcML8SR3Ox0qgFczEDev/opWQEd9xvjkpvI/gZsCUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354751; c=relaxed/simple;
	bh=GKdxUhUXcDfYN3jYPCUX/pOROt6SaxRLTeslIUh2VrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bi/jWePEJUF7W2FUXwzk2JkXdSB2Fk/IWs2hqkWQoJ6hlWrdW8sQQlybM3aV+vXTolKiazUxklVnFIAIXd0vF/bUbOj9i50P3V8EytIRQ4e1s5j2M5TVttbEhDsshi9pva2JUrjhCuES0Hoq5F4jfhxVSJi10i6K9fc8Q9nFNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FjKRjeO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D355C2BD10;
	Fri, 14 Jun 2024 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718354750;
	bh=GKdxUhUXcDfYN3jYPCUX/pOROt6SaxRLTeslIUh2VrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjKRjeO/WPyO7cpdvMcjMHK8Ko20hHPMj03iXXYsncckVkJjXyEinIoNaXPVHN1yU
	 /LRAqeGJFOErqLHh7tU/0hnVMS/qqaoL+oAn8f44q3nliKrXr0Tc0EkRcvqFpUwbny
	 LtunLNuq/5Mq9/GxQyIkp5GnpdSdrwCI/brDszXQ=
Date: Fri, 14 Jun 2024 10:45:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Please backport 2d43cc701b96 to v6.9 and v6.6
Message-ID: <2024061411-hypertext-saline-afb4@gregkh>
References: <87wmmsnelx.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmmsnelx.fsf@mail.lhotse>

On Fri, Jun 14, 2024 at 05:54:50PM +1000, Michael Ellerman wrote:
> Hi stable team,
> 
> Can you please backport:
>   2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with GCC 13/14")
> 
> To v6.9 and v6.6.
> 
> It was marked for backporting, but hasn't been picked up AFAICS. I'm not
> sure if it clashed with the asm_goto_output changes or something. But it
> backports cleanly to the current stable branches.

It's still in my "to get to queue" along with about 150+ other patches
that were tagged for stable inclusion.  It's in good company, I'll get
to it after this current round of -rc releases is out.

thanks,

greg k-h

