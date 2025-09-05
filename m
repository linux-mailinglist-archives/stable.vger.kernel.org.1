Return-Path: <stable+bounces-177896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE788B464DA
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DE87B2582
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FCA2C326C;
	Fri,  5 Sep 2025 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B/HEtckP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86F2C2ACE
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105077; cv=none; b=lUkuYrVYD7RdMa3uJ5MzhXXhHQaSmeqN2vOuLYgRzuM8BhgTlXZI4Jrp4FqN3maiZhLtY3K5cXQT7j5ffB2gQyoMWoJKyBSHdadl/XbUiXQPLvRPYLRVR+hVPM4YQrcPEcMLHOWLHMK0jGplYmQnAqslP3TAOvmTIkReGGYCPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105077; c=relaxed/simple;
	bh=sDDmkM28WrWb+kMbRXcvlj7UVVrjJHC0+yog5CwK/20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+zktLr3R2tz91Fp+TLAyTVW76iYynCs2iz4uDy6AdYU772VyoZdFgVE0U/lZSBomUep6nthLQAqguSBVusT01Lj8OoqfGsVWJNx/rVEIRVQvCq51jPfckMqASr29nebdMpuUSyi+c5yhF7v5p+tO5kSYIbyGnSAimfIa54EUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B/HEtckP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B073DC4CEF1;
	Fri,  5 Sep 2025 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757105077;
	bh=sDDmkM28WrWb+kMbRXcvlj7UVVrjJHC0+yog5CwK/20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/HEtckPeO8IgdgjuP/dNa3WMSZRF1RQtBSrGeqA9y8WUzvbcPEyy7//rbMVPy2Zr
	 cczEYylFdzIddF96oVPdSRp29zFhzKYztAqSjZaRSxjxvNsVxaG1dfmaI4d6x03xMq
	 vCa9yp9LwMxIBWtFEi9H/CPhPfXj/BHIv6svuSps=
Date: Fri, 5 Sep 2025 22:44:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, bp@alien8.de
Subject: Re: [PATCH v2 5.15.y 2/3] KVM: SVM: Return TSA_SQ_NO and TSA_L1_NO
 bits in __do_cpuid_func()
Message-ID: <2025090527-kelp-vice-8448@gregkh>
References: <20250905200341.2504047-1-boris.ostrovsky@oracle.com>
 <20250905200341.2504047-3-boris.ostrovsky@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905200341.2504047-3-boris.ostrovsky@oracle.com>

On Fri, Sep 05, 2025 at 04:03:40PM -0400, Boris Ostrovsky wrote:
> Return values of TSA_SQ_NO and TSA_L1_NO bits as set in the kvm_cpu_caps.
> 
> This fix is stable-only.

You don't say why :(


