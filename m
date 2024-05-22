Return-Path: <stable+bounces-45583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9718CC44F
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1261F2134A
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172661CD35;
	Wed, 22 May 2024 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bqGP1Xjt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5E128EA
	for <stable@vger.kernel.org>; Wed, 22 May 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392736; cv=none; b=qbZOwLLB6fAHfwFSr09HJoa+l6/3R0GtZIzv+PV9ppb4tMuLz74+ccWT8BA1swh90woyNPFOrM7wj42mA27fMLPeUpl5X0TOWZuYYpLfdWnQEhc8zD2cxHBY9xuRwqg4lPXatcayGQetrTt5RG4xg5Vb+3/JDB9iukGu7nx3GLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392736; c=relaxed/simple;
	bh=SkwK+qpMy/c01qmKRjbfDCT1a8fvUTAw0R5ObmyCNks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvw2QGghiYCkgXvPTqSXDm+dy68m4wVg+CineyRYKCnESCTswozevdUnvuzD40FeCzzWu78qIKsTE3ot6qGJyGie5Assck3wSfLBRUjXz2+k6HVEXht0Lls50b/eX0OLB59yo7E+EWyimSlnMlj/rXoNvT8CbncI+HP967k8yl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bqGP1Xjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E76C2BBFC;
	Wed, 22 May 2024 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716392736;
	bh=SkwK+qpMy/c01qmKRjbfDCT1a8fvUTAw0R5ObmyCNks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqGP1Xjt61irZzmo01P+db4y0JGMf+kwMZ0xem7RB+yJJWI3fJEX2ytiMINT39q8G
	 EeL4+0YCeoz+8adNrS92sBvOKFGwSL2M+zOiimYLEjYArtc1SIvajgZMhdlABKWaYJ
	 URb2vUVi9cTQJ3GwRAOSGECUCnY7IGANVTvRnK7Q=
Date: Wed, 22 May 2024 17:45:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Manthey, Norbert" <nmanthey@amazon.de>
Subject: Re: Backport request
Message-ID: <2024052223-mortally-covenant-d28b@gregkh>
References: <927F3175-7810-467F-A015-13B446248548@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927F3175-7810-467F-A015-13B446248548@amazon.de>

On Thu, May 16, 2024 at 10:16:15AM +0000, Hemdan, Hagar Gamal Halim wrote:
> Hi,
> 
> Please backport commit:
> 
> ecfe9a015d3e ("pinctrl: core: handle radix_tree_insert() errors in pinctrl_register_one_pin()")
> 
> to stable trees 5.4.y, 5.10.y, 5.15.y, 6.1.y. This commit fixes error handling of radix_tree_insert().
> 
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.

Now picked up, thanks.

greg k-h

