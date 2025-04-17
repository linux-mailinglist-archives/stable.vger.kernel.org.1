Return-Path: <stable+bounces-133187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAA2A91F0A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197C8447EF9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0286352;
	Thu, 17 Apr 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pwMHx6k2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87817B402
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898450; cv=none; b=SqYEMWOwJvk+ex0/9y5HOkp7sRqGswgfCRJDmVZVo/yz/KXfWzCJ3ZgJh8etTx94UY5IQ/Ge80X2kntWwVrdn3i0jkSTExLICGPCmDOzQDnzQXUSE8OOsUo9yLdihGcJaIk3EIsK5mGjns/ZablSUX8+YwVs4K3L7RAhzl0XxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898450; c=relaxed/simple;
	bh=t1gCWWjjWhSU2YLSYnJzn6sscHYKRgc5I8ZkVrkf5QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyyQJACPSIM5k8+l8G50Uthj3Fj0IRGqUmDyLUzxzt1aNEslzJ5D1Az6+RiZym/MriCk2JYTaPmrBRMhlLOnz0XRNoqooMCVykHf7cKc0kDhJYUOj8cbs7sj2f7rImgtstlR/HWEuWLcQYfadm8kdv7RzZOy1NhrYs6go40TUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pwMHx6k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A574CC4CEE4;
	Thu, 17 Apr 2025 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744898450;
	bh=t1gCWWjjWhSU2YLSYnJzn6sscHYKRgc5I8ZkVrkf5QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwMHx6k2fLLFU+pS5gnqRcptVHTjcOT5ozmk4FU2hO+XLzVA+GNlw/d9gYgJUMkPI
	 VXqMSKzxYkqetEcytc4vcR4UvX8QHtYQOtp7CGIsTg8NtYgd6SqqO8U9LzfpJIgcmp
	 gBk1ETTAirxhjmpcQXwvNK4Nn0iMjr/WLGNL5RRM=
Date: Thu, 17 Apr 2025 16:00:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: cve@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH vulns v2] scripts: Correct kernel tree variable name
Message-ID: <2025041741-chance-monsoon-bf27@gregkh>
References: <20250417134041.376134-1-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417134041.376134-1-zhe.he@windriver.com>

On Thu, Apr 17, 2025 at 09:40:41PM +0800, He Zhe wrote:
> To give corrent hint if users haven't set up stable tree directory.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2: Add commit log
> 

Now applied, thanks.

greg k-h

