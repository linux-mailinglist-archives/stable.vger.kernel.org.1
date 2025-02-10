Return-Path: <stable+bounces-114500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527C2A2E85A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 10:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F1D7A46B8
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 09:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B271C5F1B;
	Mon, 10 Feb 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpIAlVyL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434B02E628
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181311; cv=none; b=kmVLPnWeuW3nOJpWTMpEeW/N2+9suui0vH+z//p09fi34HYux30f/8sUDpmoWSp2yb7pEb1UE5rNukkl3+ED5Gxxj7ybeKXaSN/bFOrZv1fYAoHrBt62Dn8LSY2q5RIi4rCECF8rkBbRvbIQmqYG4sWQ+2DhV5rbbo/Mu0mNUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181311; c=relaxed/simple;
	bh=WnwaiUKed+7bA61mNNHwBp/N200H3X+Tbh6tQUzyvyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XS+fx6s3JSLGIlkN4mkSswb70NSn/E3nAYkyQ9ufi1sqgjoJKtL+LWMgz/Yl6FKmwIX8NEaYN5XwUSQ2QB/2wSD3lWLayth1SBGm0kU03f4Ec4UjJe2VxBDEFhJUewwayjtVTZqoI3BQgf7Nsst2BOUlweUlKwAuqFRIFfl6GKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpIAlVyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318FEC4CED1;
	Mon, 10 Feb 2025 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739181310;
	bh=WnwaiUKed+7bA61mNNHwBp/N200H3X+Tbh6tQUzyvyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpIAlVyLxy3c9u6u8bG34qvRhaUOg/Y5wQF1joNaD649NmxdrJXJt3D2V/cJtSoHe
	 wHmfat59IooX2cRT3yatV6Mzsg8h0pQyKgj2iSnTOBf4tYr0hv3gnngIRX2XnajDqe
	 KM3CS8q7Et9yfMHOLuo8QcUtjAAXD19rKI+d6cG0=
Date: Mon, 10 Feb 2025 10:55:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: andrii@kernel.org, ast@kernel.org, bruno.vernay@se.com,
	stable@vger.kernel.org, xukuohai@huawei.com
Subject: Re: [PATCH v2 6.1] bpf: Prevent tail call between progs attached to
 different hooks
Message-ID: <2025021027-repaying-purveyor-9744@gregkh>
References: <2025012138-quarrel-uneaten-83da@gregkh>
 <20250210094407.209620-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210094407.209620-1-hsimeliere.opensource@witekio.com>

On Mon, Feb 10, 2025 at 10:44:07AM +0100, hsimeliere.opensource@witekio.com wrote:
> This patch is needed to correct CVE-2024-50063

What patch?  I see no context here :(

> https://nvd.nist.gov/vuln/detail/CVE-2024-50063

Never link to nvd, their "enhancements" are provably wrong and hurtful
to the kernel ecosystem.  Always just refer to cve.org records or better
yet, our own announcements.

That being said, why do you feel this commit is really needed in those
older kernels other than just trying to meet a "check box" requirement
somewhere?

thanks,

greg k-h

