Return-Path: <stable+bounces-100553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C92F9EC6C4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5461675B4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16D1D8DEA;
	Wed, 11 Dec 2024 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sz2XtYO5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB81D6DB6
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904945; cv=none; b=jvUBOeT4Jtd4oGD+jcf35eZs2NmdXbhNuKjAc5i4DR9sOnd26bU3r4o7JVMfAeOmlOsTkzd65YjXZqgaoB0ZRlYsNYg0zeDtebLx5pkF7LPXkgL0eBhR61KpFV5aZ9MC5o6HWFIKWbErRz9NofbgqdXtHAWVXRYlOoT+U8UizlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904945; c=relaxed/simple;
	bh=m2f4m4xbCme+yyX3ZmXYBYJBhLSHYI19qZUwuq6EIrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGYhPwdMXnPrFcnonStBa3ZcNTYyK1MC+fttt1nYnPAyxznMBGS7wn/NQkT7GE/PXue9GzvnwUePzhfjdkA0o6lpuz76+VBJYu1P//VMabFSvih+CtIQFSguNxTTDIpjmNY8O58mOoKKqeVogZsQsQjyqynZj2NAkNr5sz/AzyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sz2XtYO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC3CC4CEEB;
	Wed, 11 Dec 2024 08:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904944;
	bh=m2f4m4xbCme+yyX3ZmXYBYJBhLSHYI19qZUwuq6EIrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sz2XtYO5RDWEGa2dWfKBJZr4KwlGkzUKkahiXwIFTrkRcy/LsHVGTZ7GyXGN40P0i
	 t5geCy4EZ9At88ezn6/zT4qSHTyVuwh7DgDRhPVJMGGt5FtUJi7EqXBXHDAluwv4kM
	 v3Uzs33fG1+jQ6Qmaf7U5v5GAarnvvXgNB2jcZSc=
Date: Wed, 11 Dec 2024 09:15:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: rand.sec96@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent()
Message-ID: <2024121104-tweak-recess-1971@gregkh>
References: <20241206093256.939765-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206093256.939765-1-jianqi.ren.cn@windriver.com>

On Fri, Dec 06, 2024 at 05:32:56PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Rand Deeb <rand.sec96@gmail.com>
> 
> [ Upstream commit 789c17185fb0f39560496c2beab9b57ce1d0cbe7 ]

Please cc: all relevant people on backports.

