Return-Path: <stable+bounces-40738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4138AF494
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD2DB235F8
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A613D530;
	Tue, 23 Apr 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tpDtTTfm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6A1E898
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890909; cv=none; b=gc5aDm7wHRV/9LBnLIa4J9OuE+pSXVb64AFj9lN8ymvjhp08tVR732tuy611Py+ooKvuqho7A08VQG2S9ock/o95u3yv44rtmwR2omguzM+IbQ76CJeJNxRVmKT963vnrx+a58uRkmXfm4R2C9eUPKyZBbucRbm8V9xiJaAjBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890909; c=relaxed/simple;
	bh=Y36ddm1t2Wo04JM7d16CXUxvcGBuPTr0nWK4gbVA3sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpntvbQWXJt92i7TU6s1Rd3lkTQ/uKuaTGA9Pfj9p9enInEl4Ew4ny+NPY6eQTCT1ek9bHClg4ow5xnL/2WOz/7YhIjrn/jWdoA8T6To+aOnOQQXGiyFhWD9or1dW0QV8ChR3zWveXRZBnmn4+//x8tEiNTIqqGQ9WU23IIASzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tpDtTTfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF6AC2BD10;
	Tue, 23 Apr 2024 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713890909;
	bh=Y36ddm1t2Wo04JM7d16CXUxvcGBuPTr0nWK4gbVA3sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpDtTTfmsqgEXdQccDrMVIE/UxIEGyfMY/0M5VcIXQTdZ+aYiIYvausMo4sKMvWrb
	 2pWG+asFawEiFHnCgHoswwPO7TGX+Fhc66dXdnQ6rwrEGCQhpBg4FYw3Iy+Y9PHg/V
	 lfeFEq2aWCh4ZprBjSnum3Y7m2E/GQrIXliy9sqA=
Date: Tue, 23 Apr 2024 09:48:19 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: tom.zanussi@linux.intel.com, stable@vger.kernel.org
Subject: Re:
Message-ID: <2024042313-relapse-confirm-dc7a@gregkh>
References: <20240419154658.4015260-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419154658.4015260-1-dongtai.guo@linux.dev>

On Fri, Apr 19, 2024 at 11:46:56PM +0800, George Guo wrote:
> Subject: [PATCH 4.19.y v6 0/2] Double-free bug discovery on testing trigger-field-variable-support.tc
> 
> 1) About v4-0001-tracing-Remove-hist-trigger-synth_var_refs.patch:
> 
> The reason I am backporting this patch is that no one found the double-free bug
> at that time, then later the code was removed on upstream, but
> 4.19-stable has the bug.

Both now queued up, thanks

greg k-h

