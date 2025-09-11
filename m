Return-Path: <stable+bounces-179258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97F3B53258
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 14:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD677B74B0
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E76321F5A;
	Thu, 11 Sep 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="04ujhs6L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554323218A8
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594030; cv=none; b=ZFTTNklQfjSz0ZX/YQEEd6lKCBeCSI2S9nEtn4L9VyWv+2BI4fJY2gEAJbogD9F9CK+xxDy5zN6+D/IsMtpny7ETXw89kK/m3enOY84nqVs6JS1JD9AVtuNK651m78GZIdpbCI8sJpCXvlx6oP+IwDBwA/q+ZTzuJ8CCbRHj3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594030; c=relaxed/simple;
	bh=+zZDoU3RMVfY7CmmHvEQ+55FKorNCfzqosyGDwrK99g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8MDRfvSawJ376fm86U5+mutOD/wL8VRe/8L8aocTQJcnHR/I/4FCVbw1GA+MVSUbXIhR0+6AqKw/RUASzfyKHKRmXMOfsp2A893T4TohdlgXonPqz1kDUbctSlKPczP3bllBjVJRil58QNn6g2PD/DdyNV+7QQIYWUo7WqmMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=04ujhs6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E5DC4CEF0;
	Thu, 11 Sep 2025 12:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757594029;
	bh=+zZDoU3RMVfY7CmmHvEQ+55FKorNCfzqosyGDwrK99g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=04ujhs6L6oeC3C29iSP0XkrTznQLFRB6bW/nOT5IDOdUpni8rf+O7KusGXbj2TiP+
	 8X5+WSviExTP7CoEcSnJPN/n+8saeASRxoyb/11ofC6p2JQ+OgXCgPtqmF3z+zz85Q
	 n/t7RKEGetHTghb5V5GpuuLegK1ELsVFjzIk6Qrg=
Date: Thu, 11 Sep 2025 14:33:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, bp@alien8.de
Subject: Re: [PATCH v3 5.15.y 1/3] KVM: x86: Move open-coded CPUID leaf
 0x80000021 EAX bit propagation code
Message-ID: <2025091158-cloak-murky-d3bd@gregkh>
References: <20250910002826.3010884-1-boris.ostrovsky@oracle.com>
 <20250910002826.3010884-2-boris.ostrovsky@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910002826.3010884-2-boris.ostrovsky@oracle.com>

On Tue, Sep 09, 2025 at 08:28:24PM -0400, Boris Ostrovsky wrote:
> From: Kim Phillips <kim.phillips@amd.com>
> 
> Commit c35ac8c4bf600ee23bacb20f863aa7830efb23fb upstream

This isn't in 6.1.y, so backporting it only to 5.15.y feels "odd" and
will trigger our scripts trying to figure out why.

Why is only needed here?  Things were fixed differently in 6.1.y, or is
6.1.y not affected here?

thanks,

greg k-h

