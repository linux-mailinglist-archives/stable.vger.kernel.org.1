Return-Path: <stable+bounces-33797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570E48929DD
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D486B21526
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69693BA30;
	Sat, 30 Mar 2024 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j++FapQ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267772CA5
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789435; cv=none; b=CU+qwhA2BBQc96I4nIP7pwiE9jxuGaGcLwspVb0+O20ZA/l2P1am4/Jh+6vvlS9Sp4sF6QD+9bDvqFjx1FaWv3NrIEXDfpVABEu25+u2xvcb7f/VgTkOsGBM23qRkLuNGfcuDI74+pEuDB518WdZRN01V8l8lBju+xDirdDwJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789435; c=relaxed/simple;
	bh=eaDs+p7GNvj7s2YCJKDVEwWnRhPO3JHurcNXnJn5YD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrUgsOyjLIMoI85SFiC8Wk6xqw6zb44vn6509nl4XVc4m20sV9J8mKA6584jpc2gtu2hbxLhxzxJR+gY99LmTC5wLasAZ5tGpohr6VR277t16NoOBOrW4fU2FA/BcKtwaSiAFZKgYt9ktYIM5Yn8X4cHY8rzmaPVMNrvQVJ2+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j++FapQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AB3C433F1;
	Sat, 30 Mar 2024 09:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711789434;
	bh=eaDs+p7GNvj7s2YCJKDVEwWnRhPO3JHurcNXnJn5YD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j++FapQ2ocST+qhBif9ilJzkhctupAuTCbxLakZzfyWIKuxHhuE+q2iAHBmZDBOcv
	 4GOD1Xc59XZLEG/RLyYAZ6RYcaHsVFdI6uQd80LfEYUdztZ26swmOTlQYu9G6pb2z5
	 2swdJfv/POmGV0VTNdmLYuxy7AZIzXQCHshPGhAc=
Date: Sat, 30 Mar 2024 10:03:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: stable@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH -stable-6.1 resend 1/4] x86/coco: Export cc_vendor
Message-ID: <2024033040-linguist-spore-d281@gregkh>
References: <20240329181800.619169-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329181800.619169-5-ardb+git@google.com>

On Fri, Mar 29, 2024 at 07:18:01PM +0100, Ard Biesheuvel wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> [ Commit 3d91c537296794d5d0773f61abbe7b63f2f132d8 upstream ]
> 
> It will be used in different checks in future changes. Export it directly
> and provide accessor functions and stubs so this can be used in general
> code when CONFIG_ARCH_HAS_CC_PLATFORM is not set.
> 
> No functional changes.
> 
> [ tglx: Add accessor functions ]
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20230318115634.9392-2-bp@alien8.de
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/coco/core.c        | 13 ++++-------
>  arch/x86/include/asm/coco.h | 23 +++++++++++++++++---
>  2 files changed, 24 insertions(+), 12 deletions(-)

All now queued up, thanks.

greg k-h

