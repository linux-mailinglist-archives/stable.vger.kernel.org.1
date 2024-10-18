Return-Path: <stable+bounces-86838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A09A4122
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 16:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7C6B22EB5
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC11EE007;
	Fri, 18 Oct 2024 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C28kwozJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964B18C322
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261646; cv=none; b=eg28bA7s0G+O/PNPBc9OOaXR5hI+64ObOZm4CvZyVMB8ZVf/CT0BZJyq7vz5/dDoBdSufCatYKXnRX8qgu5jMItqUurB7VK6lpFeiFHNMr22L1aQe7dktXIPVLjFMSsH7yjA88C6HkLEes0XqmxZV+zi2mKbp2rnSi3VMXgpYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261646; c=relaxed/simple;
	bh=2uZQnJ0Ekltv+Bjx1HadNwVV1KSjZY95WZ3aJIxoESo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr6Ttedf1v3FJow1hG25tMqzzT8Ytz+dFAPFkCCZ2/z8jOT76oRgQpXQO4/V/PUCt9t/MDVqM2nNbNb7FAv27ZZN6ToujkfL6hCc8+vTAPovziZ/zOf4YrhO1Rkh8h4QBoUwC++Pjo62Um6p+MjIWxFNbbSyETVVVYqsxF0qeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C28kwozJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405EBC4CEC3;
	Fri, 18 Oct 2024 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729261645;
	bh=2uZQnJ0Ekltv+Bjx1HadNwVV1KSjZY95WZ3aJIxoESo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C28kwozJgg6XFdd4gn+U81PQuliM3R7nyawpKICFjrd4u4vhvjiHUsHbm9wPYFQ8z
	 qpMmN9e4shSQOT1F46WLIkfeGyrF5/2kYD2CRnK3dxzWy5cpAfcJoLs17qGx3o3lk7
	 NuNNj1wshxvTLJlBGXKQiilvobZbsSzfqWqHJak8=
Date: Fri, 18 Oct 2024 16:27:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10] drm/amdkfd: don't allow mapping the MMIO HDP page
 with large pages
Message-ID: <2024101804-lantern-eskimo-06d4@gregkh>
References: <20241018135428.1422904-1-zhe.he@windriver.com>
 <20241018135428.1422904-4-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018135428.1422904-4-zhe.he@windriver.com>

On Fri, Oct 18, 2024 at 09:54:27PM +0800, He Zhe wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> commit be4a2a81b6b90d1a47eaeaace4cc8e2cb57b96c7 upstream.

This is already in the 5.10.225 kernel release, why do you want to
backport it again?

confused,

greg k-h

