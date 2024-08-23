Return-Path: <stable+bounces-69918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9560D95C21D
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 02:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FA3B246A2
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0FC1FA3;
	Fri, 23 Aug 2024 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CM8/L7yq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E115BB;
	Fri, 23 Aug 2024 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372051; cv=none; b=VT+cbDyjcNaUFveh/ATQy4laLC/KJDYe+p3u9IruG8rF/4N9qae9THvshsdWhTgk+pXR2l02Ui4IV6KfKN2HL8GAswYIwOzeeRlxqj8zctDmj7k48svTftKDO9o5lx8sg1ZxlnoRxjvivDi8LRma6ht1itfpRgEnRD0CZDxZEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372051; c=relaxed/simple;
	bh=iDmaBG6z6YoiKpM23bepku69gBSFtObY8NshOuaeQkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqStKmRVNeVcvm5tPZJBle+lSu+QTq3mRLyKh1PU0L7aeC0iBsXHti4ZviAtAIP0jjqYPoKmycHKGalvPEKlWFiiF9ARt9THG0QfwaQVtfpOk305wlCfDGw2UZC4WJW7ZJe5j/ushyMCTFR7n+F2oRfXVQW5xQacR7kKF+gnm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CM8/L7yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0590CC4AF0B;
	Fri, 23 Aug 2024 00:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724372051;
	bh=iDmaBG6z6YoiKpM23bepku69gBSFtObY8NshOuaeQkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CM8/L7yqOFfhSsrSWhEx/MMfSAX7/RreTVztlmHG0BBxmbI+PZ1WVhquBzTYGbLea
	 n8oZhMj2lE6CWgvUsMIidO82t1FfXjCVdmSnYLDcvLCtDlg/Oi7XC/BSPWEjQ3tmU3
	 pG99JxaKgrDX/E1wFoDqDeUC+TElnP1KmSvLWxnU=
Date: Fri, 23 Aug 2024 08:14:08 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
Message-ID: <2024082315-capably-broiler-b4e6@gregkh>
References: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>

On Fri, Aug 23, 2024 at 07:46:09AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> An uninitialized variable @data.have_async may be used as analyzed
> by the following inline comments:
> 
> static int __device_attach(struct device *dev, bool allow_async)
> {
> 	// if @allow_async is true.
> 
> 	...
> 	struct device_attach_data data = {
> 		.dev = dev,
> 		.check_async = allow_async,
> 		.want_async = false,
> 	};
> 	// @data.have_async is not initialized.

As Dmitry said, this is incorrect, please fix your broken code analysis
tool, it is obviously not working properly :(

thanks,

greg k-h

