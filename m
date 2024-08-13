Return-Path: <stable+bounces-67458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D7950293
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405901F21BB8
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD907197531;
	Tue, 13 Aug 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vj5w6X5m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6F5208AD
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545544; cv=none; b=sfXWQyP4t91toFUlhLEe3fmccNNl/qNVJtvxfrc1MiNyl0a+M93S6MDHo5usNF5R2TuaFT832J2UG4ebpFRMLjV+gWZvLhTuBbEkTEA5qPcaAxbuokNQtZO1ygihioHFPquwC3F+yXa53gQ3VsP8VIvUdtbuHnEJt74Rh1czbhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545544; c=relaxed/simple;
	bh=wb+unWryVybcFlg7YZOuMIPAt3nEztfdMyengOI+pRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7tmnTzTAq0F0ID93sbOPOvNBExeukpeciaKX0i6SqGXBeOSavzKXhpzCLmbVvFLxZsXinW2kqN0OCc+cDDTkBlJL8o0WXW2m/+DpigiqoZtJ6hFmSYwnA/5lpVK6DMjgsDL+S2Vr2NgbYZ+Y7yOUkUTQdU6hdw9cJuL7ctIdBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vj5w6X5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBB3C4AF09;
	Tue, 13 Aug 2024 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723545543;
	bh=wb+unWryVybcFlg7YZOuMIPAt3nEztfdMyengOI+pRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vj5w6X5mXoIUjrVyO5HicDP/++02IIZDNA04w00s59nFDWE8l2bc9EJ7KNqS1ipP4
	 KPPimXb6dLNFFbnr2PLaj/AcOE+RcgSEH34UBVYDBQ20I18H56+QTccj9/dWZ7s7JA
	 FxhCRgqSVPmeJ1clGxtSNrVhQ6Q4kaYkokI+iJfg=
Date: Tue, 13 Aug 2024 12:39:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: kuba@kernel.org, stable@vger.kernel.org, davem@davemloft.net,
	horms@kernel.org, lee@kernel.org, sashal@kernel.org,
	sd@queasysnail.net, sec@valis.email, liam.merwick@oracle.com,
	vegard.nossum@oracle.com, dan.carpenter@linaro.org
Subject: Re: [PATCH 5.15.y] tls: fix race between tx work scheduling and
 socket close
Message-ID: <2024081352-reiterate-decoy-30b2@gregkh>
References: <20240307091420.1c09dd0e@kernel.org>
 <20240802113931.2501476-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802113931.2501476-1-harshit.m.mogalapalli@oracle.com>

On Fri, Aug 02, 2024 at 04:39:31AM -0700, Harshit Mogalapalli wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> commit e01e3934a1b2d122919f73bc6ddbe1cdafc4bbdb upstream.
> 
> Similarly to previous commit, the submitting thread (recvmsg/sendmsg)
> may exit as soon as the async crypto handler calls complete().
> Reorder scheduling the work before calling complete().
> This seems more logical in the first place, as it's
> the inverse order of what the submitting thread will do.
> 
> Reported-by: valis <sec@valis.email>
> Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [Lee: Fixed merge-conflict in Stable branches linux-6.1.y and older]
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [Harshit: bp to 5.15.y, minor conflict resolutin due to missing commit:
> 8ae187386420 ("tls: Only use data field in crypto completion function")
> in 5.15.y]
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is a fix for CVE-2024-26585, minor conflict resolution involved
> Ran the tls self tests: 
> 
> ok 183 tls.13_chacha.shutdown_reuse
> # PASSED: 183 / 183 tests passed.
> # Totals: pass:183 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
>  net/tls/tls_sw.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Now queued up, thanks.

greg k-h

