Return-Path: <stable+bounces-127345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE6CA77F9C
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 17:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85C43A636C
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404E20C473;
	Tue,  1 Apr 2025 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QWYHd+9J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765920C037;
	Tue,  1 Apr 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522761; cv=none; b=b44ot9LWvho+IJxD5pn0wplXcKaej5Yu0EwnU3Kfwr1stI1prg5LhAwVtGih1F+cImKV5YwgT84dke/bWnN5xdbZQk8G91aMpZhk7udiTSYJV3fvFV0K8WxTtKT+j8fWrxwOcYX6x0TasERIgO9/sbLE5yAFRguige6O5V7Pf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522761; c=relaxed/simple;
	bh=Z9eXlRCX0pnPY1pioh4GNb/H6jnJc+kN8THq95HLM/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpOPjgF3i/17gfETAsNUynNBPLfC10m0VahmfBVJJyhyEPDZZveGlFuRvF3euaBAsMiIOTsxIdJnt9DPA0XOkt30BhS5qgX55sUjQjzQmVlRUt4+QvVYJld5czInSEp3J/4ywGxvgMS0zoLI1mToeIKGqwleqgjk+TXqRRZtEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QWYHd+9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E86C4CEE4;
	Tue,  1 Apr 2025 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743522760;
	bh=Z9eXlRCX0pnPY1pioh4GNb/H6jnJc+kN8THq95HLM/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWYHd+9J3qtPLC23Jb2bNMYqwshz5VDAupSMPkmXw0PhC62Ot+Ou8xHDzeCINzKmq
	 R5OgWxta+aAEK56rR5ilGsw8Kt0XEH8GKrP6hNCG/792K0mKNR0rcccAWQIw8uL7s8
	 IPRaSfaWPH+Tv/Gbix6SmRmQCRyfxqx24/OmimWo=
Date: Tue, 1 Apr 2025 16:51:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix potential NULL dereference in mmap handler
Message-ID: <2025040117-flock-narrow-3b19@gregkh>
References: <20250401151859.2842-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401151859.2842-1-vulab@iscas.ac.cn>

On Tue, Apr 01, 2025 at 11:18:59PM +0800, Wentao Liang wrote:
> The kernfs_fop_mmap() invokes the '->mmap' callback without verifying its
> existence. This leads to a NULL pointer dereference when the kernfs node
> does not define the operation, resulting in an invalid memory access.

How can that happen with any in-kernel user of kernfs?  If you try to
mmap any sysfs file today does this trigger?

thanks,

greg k-h

