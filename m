Return-Path: <stable+bounces-124055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7B1A5CB84
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE387AB4F0
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5643E25FA28;
	Tue, 11 Mar 2025 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="06Xl15Y2"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4D2080D9;
	Tue, 11 Mar 2025 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712622; cv=none; b=RSJUWx6uAol54fKhOW650kbh11cHyMzzzmYK8TLhimsFDuNH1QFyMnwORe1W1Oz4HAht1N0CzKW3mNHU0vst0TAf6pfBUgdt2Gjqp2e2obAG/WUhVhsppDQUZiL/4jmaC1fRwVjjNP+MAxJKzXsiyaA6M/WSG8vgE2b2lEFP6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712622; c=relaxed/simple;
	bh=3lgFxyV0pjLheJdj0WHk3Nfcy0PkOqA8S4AKNvnKn0U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDzR75ZP+hrfBV1WmbDwmm5IAJJFt6pmyj/Z4bbULVRbYflgjxkWMuv+THl4u9RPP0ufSeBA58MvXhYtK4f7+6HwP5LLO6MeemMGuz+E/mkPGm72yc/84YA6Pfn/qHB58zUZzhduPYOqrDEUS8xMeB7sdLCzs0Cmer6qt6Oidzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=06Xl15Y2; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 11 Mar 2025 18:03:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1741712613;
	bh=3lgFxyV0pjLheJdj0WHk3Nfcy0PkOqA8S4AKNvnKn0U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:content-type:date:From:from:
	 in-reply-to:message-id:mime-version:references:reply-to:Sender:
	 Subject:To;
	b=06Xl15Y23CzM+3OGHRaYXELzF/uWpr9JOuln7W44Co+EmJlMFP2RYESWR++/Bnw7u
	 /gMHwloI8jWdXcMhOVsvze/WmEj/ENAQJ1ZXCI4twH7PHC9tnxuwTEQhs6lmLKEIgi
	 Miy+kDPZrRvIIwJBzSOIQFhdsPnm8R+CMy5yY21oYBXuDIzyim2kfs8I7RVcInSQ9e
	 nBp7H7SD1MdCo3YEVj7X0acrh7+kRqGTC0+7vlaZJxH8lR0Pj0yrG8fljBlLERAY1z
	 t/fM/KtSDj89eN3eVecvRGpjJH5a9CQ6FYHJGL/Ly8jXj0Jwj5SDCsYQwTdBV6OfHg
	 eZerMNxrBhPCg==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/269] 6.12.19-rc1 review
Message-ID: <20250311170332.GC2770@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250310170457.700086763@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.19 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.19-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

