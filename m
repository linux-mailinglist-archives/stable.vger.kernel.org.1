Return-Path: <stable+bounces-86492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9BD9A0925
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 14:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FC01F219AF
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A223F207207;
	Wed, 16 Oct 2024 12:17:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56A206953;
	Wed, 16 Oct 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081066; cv=none; b=H1htrlBjCW4oDd0NVRGSDBdFlq5YTnyxOwVi+UBDCc/6CLFtTl5ZeywWVVSLwzy3y1cH/VJkoIsZDzfsMCIP/qJfKVHG/nxW95Wf0N3oXCVzNnJwO9F13uAOWGZFIIUujsIPV4iaYXcqFymXySqfYXWBG2yDWm2e71wbosDULEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081066; c=relaxed/simple;
	bh=bO5v/NOUlppeLzNBHzyNKSewCI43HW1yo0iNqORVgFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C92FGixe4ri9Rzw3TSzzO4LAXNL8ztRiMjzcNNuL8St5Z2a+RN7pt/IEBMt+hXUGTHsQ2VILizaYDlG04etsnc/GQpDSvOUTyoeHiIcxhx5VJzBA2SCfiAjamQVdo/U3bIl8JQyi6OAELZ89cx1qkNtdhjJ9mCZaNMy0hB2sOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 49GCH8xc019277;
	Wed, 16 Oct 2024 14:17:08 +0200
Date: Wed, 16 Oct 2024 14:17:08 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc/stdlib: fix getenv() with empty environment
Message-ID: <Zw+uxLIklMHSSxTu@1wt.eu>
References: <20241016-nolibc-getenv-v1-1-8bc11abd486d@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016-nolibc-getenv-v1-1-8bc11abd486d@linutronix.de>

Hi Thomas!

On Wed, Oct 16, 2024 at 01:14:51PM +0200, Thomas Weißschuh wrote:
> The environ pointer itself is never NULL, this is guaranteed by crt.h.
> However if the environment is empty, environ will point to a NULL
> pointer.

Good point, however from what I'm seeing on glibc, if the user sets
environ to NULL, getenv() safely reports NULL and doesn't crash. I
don't know what the spec says about environ being NULL, though. I
just tested on freebsd to compare and also get a NULL in this case
as well. So I'd be tempted by keeping the check.

>  	int idx, i;
>  
> -	if (environ) {
> +	if (*environ) {
>  		for (idx = 0; environ[idx]; idx++) {
>  			for (i = 0; name[i] && name[i] == environ[idx][i];)
>  				i++;

However as a quick note, if we decide we don't care about environ being
NULL, and since this is essentially a cleanup, why not even get rid of
the whole "if" condition, since the loop takes care of it ?

FWIW I tested glibc with this:

  #include <stdlib.h>


  int main(int argc, char **argv)
  {
        extern char **environ;

        environ=NULL;
        return getenv("HOME") == NULL;
  }

Cheers,
Willy

