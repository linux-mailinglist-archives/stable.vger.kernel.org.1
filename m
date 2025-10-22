Return-Path: <stable+bounces-188884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B541CBFA087
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AD644FF0A6
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79212E040C;
	Wed, 22 Oct 2025 05:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R0PqgFbX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B12DF155;
	Wed, 22 Oct 2025 05:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761109878; cv=none; b=giOptG5M9BsZgtZbXINwSwO4sdIeAM1Xf+sR5F5vckfvE27b1krrDg+kOHZRn57zuK6KYsZSnAolZDC1D1jajdu7vIdxoBKL8TELibZQ0gcjAeOukOwz1XkLXiq+WN8+b33i/NMzmhNB/5DohzdQNCfA1L7BS/XTkDB1ujnaYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761109878; c=relaxed/simple;
	bh=HePjcY4qZLOl4GibzWey//O4YmTvcuyAyYHVuZRmKJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neTWZJbRfHcsMhxqUF+WfIhQnJdlje5JQ95Vroux2dO/ELgf1xCykgzg7Kd2gM1rsu/yKroUtBIviGo9aTIiMlJ6klzQN4LP4fWu6C1vRWX2s7On2VvyeDJOEUgYMVbtNmJhSklcwoOS/CX9b/GwpmN0IZXb5MrHiNJ5jQQYL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R0PqgFbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FDCC4CEF7;
	Wed, 22 Oct 2025 05:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761109877;
	bh=HePjcY4qZLOl4GibzWey//O4YmTvcuyAyYHVuZRmKJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0PqgFbXkAAv+2Ti9kJMVJp9KNGOwLPz5gH87/2uQVYyXaX8tj9+tm/CTt8SVqawT
	 6etHEeYe+7Qdx7YXxunUUCnta6mhzMZkR+sP0nierHNSVFmBBzMZQnPF/5Q8pFyJ9O
	 2woQ9nwnD68ve3FT95hQWDIO6Q3Msx2CPRfnyYLE=
Date: Wed, 22 Oct 2025 07:11:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] Documentation: process: Also mention Sasha Levin as
 stable tree maintainer
Message-ID: <2025102207-retread-barstool-8916@gregkh>
References: <20251022034336.22839-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022034336.22839-1-bagasdotme@gmail.com>

On Wed, Oct 22, 2025 at 10:43:35AM +0700, Bagas Sanjaya wrote:
> Sasha has also maintaining stable branch in conjunction with Greg
> since cb5d21946d2a2f ("MAINTAINERS: Add Sasha as a stable branch
> maintainer"). Mention him in 2.Process.rst.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

