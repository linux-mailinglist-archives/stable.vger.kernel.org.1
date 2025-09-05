Return-Path: <stable+bounces-177779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0968B44CEA
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 06:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EC87A521B
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 04:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E41C5489;
	Fri,  5 Sep 2025 04:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qn379iC+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD61524F
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757048094; cv=none; b=W2+Xvk3wovRNg3SbCdfHa4Ygy8GeHxA6QAOXAiW4Y7q2O5JAEEakSotzirdY/b5fq+C/sD5wTx7G3ZzmuBwy5uZdK0TqFTx+RqaH4zLPVCCLlnhMC0juhpHQvjwpzs/qCWO5D2G6H5w/UzsV4hSesOoHfvkGIh0RFfxRrVVbvak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757048094; c=relaxed/simple;
	bh=bYZcXibkL8oV3xSc7sTXxD4oUn7Tq+EJbDESgldCo3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZfgyfV/0FgYCIwBmv549H3NgAwc7l2b2q9IS4hZ3l6zGCQ6EAfH75xVl/nzVq5aZkEg/anUwXfSlYXQ8XXP463lybjHKXSEdF5GuFd6fvTRlzrj/pJcnlYH8JctejJBg86XTUcGCGoRCHRspM1QH4W7nFc76gXK5RZ3Q7o2ZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qn379iC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F45C4CEF1;
	Fri,  5 Sep 2025 04:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757048093;
	bh=bYZcXibkL8oV3xSc7sTXxD4oUn7Tq+EJbDESgldCo3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qn379iC+IkUWVML7dCRGdGr4WYqEkMRzaPGI/WSasjETybnlbRQaJNwOAQQjvhqMp
	 a94Sn15YCVf0N2YdtTsbwKjbiv5MTrvwObVpbFSnbjY3EWir7n3yESAoMFFrwnNNPQ
	 AQvPymDWXTEHZGgNSAPp6dgV44urwEt5Xfm+VRhM=
Date: Fri, 5 Sep 2025 06:54:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH] Revert "drm/amdgpu: Add more checks to PSP mailbox"
Message-ID: <2025090522-negligent-starless-d683@gregkh>
References: <20250904220457.473940-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904220457.473940-1-alexander.deucher@amd.com>

On Thu, Sep 04, 2025 at 06:04:57PM -0400, Alex Deucher wrote:
> This reverts commit 165a69a87d6bde85cac2c051fa6da611ca4524f6.
> 
> This commit is not applicable for stable kernels and
> results in the driver failing to load on some chips on
> kernel 6.16.x.  Revert from 6.16.x.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org # 6.16.x

What is special about 6.16.y that causes this to fail, but yet it works
in 6.17-rc?

thanks,

greg k-h

