Return-Path: <stable+bounces-118463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B06FA3DF94
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CC9188AC5A
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8241820C034;
	Thu, 20 Feb 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="yvj5EW8o"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84D1FCFF0;
	Thu, 20 Feb 2025 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067053; cv=none; b=R0Bp7YELADcv0wd9qnvGrpPwzWHA1rfMLspMCndWgRmJGeOtDoPUScxe8+8eApJw3qB5xMbOVJ2yJXEsZuptKaHPVXUzHFS2UJCDM0j8oEXdVo9E6kuwh4Uy6Ex3/dJUGKQKLXo4z8W9jK381bnkio80G77bUb0AwRc/jYEDlSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067053; c=relaxed/simple;
	bh=rqvc5Lpusddu/sScms8O9psnr3Xsrp0WPw6l14Wbgds=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH99Vd6a7ub17jJ64zZ+tMi1S62d0GA+37Dg5gUbVFOIQehF2Lu5kbLGUR8OXGmmuBa7XgzL4vRB03Pkt89xapHj7UnyHj6k7BDt7WQH0MhtcUuZUFyacPnNPMUObyBIu5tyzuNEe0ZwlfH9VHRHYIMdSInlJtTQrJQxrmmoxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=yvj5EW8o; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Thu, 20 Feb 2025 16:57:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1740067044;
	bh=rqvc5Lpusddu/sScms8O9psnr3Xsrp0WPw6l14Wbgds=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=yvj5EW8ob3f2voDw19SYWiNBYtZCeXnB4abOb0N6Q1bMqWKmVYshqDmaYKhWmgyHU
	 ilsnJuPlRWZzXvQ0fnijexVazydlUdVsIllX3F4Yl+sjEm1UOs3XCjDJ4ZuF1G7CP9
	 jdltrL4fZhrUUbxWXljfY4ZZMFuHUq0toljRLo7xEKG+CVJ9cUo1cN5kdb2pz4JDo8
	 aE8aPiYdIErT48fSc4iTBxoodzV9RlDSqGsT3coOGKT7PCCfJAtrpfmWo5tVzBxvss
	 rYabAqeH0OyQXgxLfsfTfSdVgwGV5UlAI93z40IIwc3WqngSIn1yFkqJaj4vbVmjkK
	 /2gh5OKzJKFKg==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/225] 6.12.16-rc2 review
Message-ID: <20250220155723.GA26478@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220104454.293283301@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220104454.293283301@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.16 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.16-rc2 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

