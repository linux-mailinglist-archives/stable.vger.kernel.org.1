Return-Path: <stable+bounces-16056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44683E8E9
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 02:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B99128A3AB
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A68D612E;
	Sat, 27 Jan 2024 01:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ia70ie0J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1054436
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 01:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318255; cv=none; b=GYOaFgV6uRYReMbp1STQoislDpxDo24YrLU/nN29xYq/F1yuljiuiwfDdXS0EWC6lqAG46msD2BGZWZe5b+h+xj//mqqCdBjC2mrJix2QxNL/NLPJk7bh2LRJ7ofwnNkRyXZRdbdd4in3cX/PcdDlUtjVISOeohFNsRHSTXM8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318255; c=relaxed/simple;
	bh=1PIaQcqOF1eKm5lVbMh65cmjSnTROuZ9Y0Mb5+MAzN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBE9RyxKippS8+r0KnsiD6gmU4kh0Ws+ZcRoTXxE7VhVDnM0oXLR+COReylVDefF5EHV+OrloE5qJNuUyVEWC+LwKafwwlDgY6j8JWzQSIgN/lM1kQPtaYYCtxRnwRmgmnMdFAqD4xzd1YOxzguFkbmRDvc7ZF1sT7n2nJ8D0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ia70ie0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23218C433F1;
	Sat, 27 Jan 2024 01:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706318255;
	bh=1PIaQcqOF1eKm5lVbMh65cmjSnTROuZ9Y0Mb5+MAzN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ia70ie0JulSn64Zs6rqgpDyp/4+ojNUPJzQk64W9MQaHe5w0NOBJejzdBkZNIpMDV
	 ibXNctwYQux+xtoItpI4tMLuZc7s33AMo3Ib8ZWwvg2biz4yETsfnk3+2qwnFDGUG9
	 IoUd0mOTCfV6aeYXZojRUOV7Zr0A/SqsFeVoj4co=
Date: Fri, 26 Jan 2024 17:17:28 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: stable@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 4.19] x86/CPU/AMD: Fix disabling XSAVES on AMD family
 0x17 due to erratum
Message-ID: <2024012618-daredevil-envious-342a@gregkh>
References: <d4d6dd5ccb846f128740685ecaeed4f0e9ad13fe.1706205932.git.maciej.szmigiero@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d6dd5ccb846f128740685ecaeed4f0e9ad13fe.1706205932.git.maciej.szmigiero@oracle.com>

On Thu, Jan 25, 2024 at 07:06:54PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> The stable kernel version backport of the patch disabling XSAVES on AMD
> Zen family 0x17 applied this change to the wrong function (init_amd_k6()),
> one which isn't called for Zen CPUs.
> 
> Move the erratum to the init_amd_zn() function instead.
> 
> Add an explicit family 0x17 check to the erratum so nothing will break if
> someone naively makes this kernel version call init_amd_zn() also for
> family 0x19 in the future (as the current upstream code does).
> 
> Fixes: f028a7db9824 ("x86/CPU/AMD: Disable XSAVES on AMD family 0x17")
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 

Both fixes now queued up, thanks.

greg k-h

