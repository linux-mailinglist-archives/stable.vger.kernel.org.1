Return-Path: <stable+bounces-92776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C249C56D7
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5FD283D90
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AEC2309A3;
	Tue, 12 Nov 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qroCbawh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6DB230996;
	Tue, 12 Nov 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411819; cv=none; b=ozVO5TQU1UNhoar+yWHX7JiEDSQFjxqoRHXWqw3GyVqmuYdFcfUoknlwCk9hBdScj2it7RVDSjoGGYEfUrUiKhGc4WCu+XB8sEn1zqGNdzZahy0P73COZdLA5SnI7ZJkYZAWEHjCNQX0pYEwVw6GkkoA2ucxslfDQAzZE5nlxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411819; c=relaxed/simple;
	bh=XoJgW+LcOAR9J10RgEMWkbjwd6Wl1yPZDJ5TlOBDh4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftljMxbb3U4C+aOm1WyzNU66DtF4OGPN6rI7RRRXE+S0d7TjJgE1Lq3ZwN/s8RO3C5fer4x4lUAdeGkKmD5LBsN68qK1WSKUcGxsvTbZf98m+mmx4ilkJr2eRhCsht9WMzvnbiFxP6czs98wccRHBf8S1rnnI/F1FY4dpU3XW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qroCbawh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399E9C4CECD;
	Tue, 12 Nov 2024 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731411817;
	bh=XoJgW+LcOAR9J10RgEMWkbjwd6Wl1yPZDJ5TlOBDh4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qroCbawhlONSfyslRcHkauBBNGFxkCgqylBsCTetmKC5HTpVEeuWQTVqCBKeRVpAo
	 eeoTc388NndSdla5rbdWmOes9p0JKfJrk5gnhtFa/MK22AX3fY2grzPjSUip+nUMUR
	 R1tlLPADglKH1VlF1qft8aDxxqvpZQJ7VJwmB740=
Date: Tue, 12 Nov 2024 12:43:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] driver core: class: Fix wild pointer dereference in
 API class_dev_iter_next()
Message-ID: <2024111205-countable-clamor-d0c7@gregkh>
References: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
 <20241105-class_fix-v1-1-80866f9994a5@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-class_fix-v1-1-80866f9994a5@quicinc.com>

On Tue, Nov 05, 2024 at 08:20:22AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> class_dev_iter_init(struct class_dev_iter *iter, struct class *class, ...)
> has return type void, but it does not initialize its output parameter @iter
> when suffers class_to_subsys(@class) error, so caller can not detect the
> error and call API class_dev_iter_next(@iter) which will dereference wild
> pointers of @iter's members as shown by below typical usage:
> 
> // @iter's members are wild pointers
> struct class_dev_iter iter;
> 
> // No change in @iter when the error happens.
> class_dev_iter_init(&iter, ...);
> 
> // dereference these wild member pointers here.
> while (dev = class_dev_iter_next(&iter)) { ... }.
> 
> Actually, all callers of the API have such usage pattern in kernel tree.
> Fix by memset() @iter in API *_init() and error checking @iter in *_next().
> 
> Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
> Cc: stable@vger.kernel.org

There is no in-kernel broken users of this from what I can tell, right?
Otherwise things would have blown up by now, so why is this needed in
stable kernels?

thanks,

greg k-h

