Return-Path: <stable+bounces-62809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02213941384
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2607283D6F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439541A08A0;
	Tue, 30 Jul 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmYSzJ1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A61465A7;
	Tue, 30 Jul 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347306; cv=none; b=f6js/PXNcJOYejkPaVOWtgY09YmhoPmSm6zfTVDDfEXDbwcOjrPbeOtNK/fzJZNmlA1825eyN/xOQhKt/SsIAU2u45Y0lM2ZdNsxBb/TLks9Bx/rq3AN3g4dBdnFdUu4njVq95HenOf8p5R3R1EFlbrmXGvh0g9WTkRq6M5F+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347306; c=relaxed/simple;
	bh=he9J58vS8pkfcV4kvaKODB0LsCUqw+V9kr+mja/L7pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jclfkmvG/5u54N03pJopx9aoJPnI4ZJ1CaEWp4c/k9Cik+dnBiT+UmMKW3N30WANtBXgEIH9O/Ktp+nzsgITDaP3WFUoX+0JJtObR1bx5/z846SO8+2JHJbCc75R/AnRBGXbF1PVhDtsPnipHPNBqko4AK+Cd+0haATEe4QDaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmYSzJ1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F394FC32782;
	Tue, 30 Jul 2024 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347305;
	bh=he9J58vS8pkfcV4kvaKODB0LsCUqw+V9kr+mja/L7pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmYSzJ1JX3hyU8vVXsCLiv7jplGEOlO7z+lwnGsnz89uC+dboHgCDi9JCgwyuad4k
	 UKRtFYj6fxbpmC4/GrstdbMAcFcowyJ9zdAyo32nshvQZoypuK90yYsHBbSLeexTvz
	 YcNVTQ43ULl8hjBi0d3/vmk+AgGTv4a0i7QeX2w4=
Date: Tue, 30 Jul 2024 15:48:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Erpeng Xu <xuerpeng@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, hildawu@realtek.com,
	wangyuli@uniontech.com, jagan@edgeble.ai, marcel@holtmann.org,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, guanwentao@uniontech.com,
	luiz.von.dentz@intel.com
Subject: Re: [PATCH 6.6 1/3] Bluetooth: Add device 13d3:3572 IMC Networks
 Bluetooth Radio
Message-ID: <2024073015-calibrate-badge-32dd@gregkh>
References: <F2FCAA7252DFAEDC+20240729032444.15274-1-xuerpeng@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2FCAA7252DFAEDC+20240729032444.15274-1-xuerpeng@uniontech.com>

On Mon, Jul 29, 2024 at 11:22:52AM +0800, Erpeng Xu wrote:
> From: Jagan Teki <jagan@edgeble.ai>
> 
> commit c3df5671c937a21b8e6cf4798bf6450f12cb3a98 upstream

Not a valid git id :(

