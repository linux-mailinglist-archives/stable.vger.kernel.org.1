Return-Path: <stable+bounces-185932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B7BE249F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3560F4EADD9
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09D0301030;
	Thu, 16 Oct 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vNqpRo9J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4D2DC760
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605552; cv=none; b=OMlYiVgUDKy2BASv/I4zrGbk962Sw6wqHg+dZJSRmVPK8hjdGLG1YAxuAVJRPWNCPPaRsxliE6v8CJufTLBzH3sR8pNEV9cKDYhjgSXytj1xY7hRrXk6TxtjoHdIsr2QlK+jhFR57QbF/NzLcdbX9AkuU4z7pjT1aSe80qq6nCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605552; c=relaxed/simple;
	bh=1vEMBQP+7ziKP3/v0bnEER1hDsaxTKNoc9QSvk16M2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFVnGGp26EHu9BYgyJYCykeN0LBTFKoshwsArM0v1iWCGfDj52UlQjqQB5UKgL/WCLItbJsPYiNTfuVg3isWEHA2GXNYFWrbFFjkv+aa47p3oW9t/am/ddvtEkAjcEO85DojA0Fb1HQgJRzV7QqQgcagiWPiBHVv9TaUXRK7YK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vNqpRo9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D5AC4CEF1;
	Thu, 16 Oct 2025 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605552;
	bh=1vEMBQP+7ziKP3/v0bnEER1hDsaxTKNoc9QSvk16M2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNqpRo9JsEEFo6t7ri833D7SlgfqPVUpa0vWReN8x3KZABIE+0ClPxlhsN+SzX2g0
	 vrFqmM3691397/mR+Gw5XHWvJpwdljHcYjBgjLZ/JRFBfnaQ6xn/5gRd45jmQEYVzF
	 Y/kZJqWeevqoFNETDc3P7oWckAtAyqDP+C+DrDoI=
Date: Thu, 16 Oct 2025 11:05:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] cpuidle: governors: menu: Avoid using invalid
 recent intervals data
Message-ID: <2025101606-galley-panda-297b@gregkh>
References: <20251014130300.2365621-1-senozhatsky@chromium.org>
 <2025101614-shown-handbag-58e3@gregkh>
 <p7j4aihzybksyabenydz634x4whuyjxsmvkhwiqxaor5uhpjz7@3l7kud4aobjf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7j4aihzybksyabenydz634x4whuyjxsmvkhwiqxaor5uhpjz7@3l7kud4aobjf>

On Thu, Oct 16, 2025 at 05:57:36PM +0900, Sergey Senozhatsky wrote:
> On (25/10/16 10:55), Greg KH wrote:
> > On Tue, Oct 14, 2025 at 10:03:00PM +0900, Sergey Senozhatsky wrote:
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > 
> > > [ Upstream commit fa3fa55de0d6177fdcaf6fc254f13cc8f33c3eed ]
> > > 
> > > Marc has reported that commit 85975daeaa4d ("cpuidle: menu: Avoid
> > > discarding useful information") caused the number of wakeup interrupts
> > > to increase on an idle system [1], which was not expected to happen
> > > after merely allowing shallower idle states to be selected by the
> > > governor in some cases.
> > > 
> > > However, on the system in question, all of the idle states deeper than
> > > WFI are rejected by the driver due to a firmware issue [2].  This causes
> > > the governor to only consider the recent interval duriation data
> > > corresponding to attempts to enter WFI that are successful and the
> > > recent invervals table is filled with values lower than the scheduler
> > > tick period.  Consequently, the governor predicts an idle duration
> > > below the scheduler tick period length and avoids stopping the tick
> > > more often which leads to the observed symptom.
> > > 
> > > Address it by modifying the governor to update the recent intervals
> > > table also when entering the previously selected idle state fails, so
> > > it knows that the short idle intervals might have been the minority
> > > had the selected idle states been actually entered every time.
> > > 
> > > Fixes: 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
> > > Link: https://lore.kernel.org/linux-pm/86o6sv6n94.wl-maz@kernel.org/ [1]
> > > Link: https://lore.kernel.org/linux-pm/7ffcb716-9a1b-48c2-aaa4-469d0df7c792@arm.com/ [2]
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > > Tested-by: Marc Zyngier <maz@kernel.org>
> > > Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> > > Link: https://patch.msgid.link/2793874.mvXUDI8C0e@rafael.j.wysocki
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > (cherry picked from commit 7337a6356dffc93194af24ee31023b3578661a5b)
> > 
> > You forgot to sign off on this :(
> 
> Oh,
> Greg, do you want me to resend or can you just add SoB?
> 

No one can add a signed-off-by for someone else, please go read the
document for exactly what that is attesting.

I've queued up a backport I did with a cc: to you on it already, that
should be identical to yours, right?

thanks,

greg k-h

