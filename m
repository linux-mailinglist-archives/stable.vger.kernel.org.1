Return-Path: <stable+bounces-119547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489BAA4496B
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 19:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555A63A650B
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2919AD86;
	Tue, 25 Feb 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="dKOfbqQB"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978891891AA;
	Tue, 25 Feb 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506340; cv=none; b=UjXAvn4eZPvUmrexhj84xGSE1lp2+y1/g9MKWQ22VugfPAqwcQ++9W5LlKKxoOQMyR/gP8TwKocGKu/7mfEt6nU3IoERnCvxAhKHlMZJZ0vIbw3S44JWU+FR1nBl/a4TaQvCAsgyt5HC7dvRztyr0EQLi3SlJd6BE6k7GExNBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506340; c=relaxed/simple;
	bh=y40fTClVqSkkllf6kxBAHLmw12Tbp7DEQ0R0nVDvfKk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+WxTtG04VBORTwA9vwtHJcWdH8tCTTY1j8TY1Wzj4YqiR3j3WB1Iog3lAQNabLfL+QVkyPjWsY55taHOCmtOwf6vRGfm6MZrt2QmrlfuKrqw02/OXHglfQ4imHjC6brWTwoV6lUP/Jdf0kVuV2+8bqZl4xkkerw5u5b00Tns+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=dKOfbqQB; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 25 Feb 2025 18:58:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1740506330;
	bh=y40fTClVqSkkllf6kxBAHLmw12Tbp7DEQ0R0nVDvfKk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=dKOfbqQBEpT+1uSMkyWQMka/Uc4Iqdm1M8yRtiPLNro6s7w5YEu2etfdBV4gYUQ2K
	 gl1D9VRJb8Prv1V5j3TQOVZ4BQKgV7yHwYcy02QhiHIlL7icsgOLZf2OTbZNXUn4v6
	 ktFs1nSCTU0uHMN/j9dN4kmDVQL2zHmlMVSKG65x7Pg8F/B+wHVygPxqBneQRmbEOS
	 1NL/AXz1WbFwdBlgs7qVXV8p2RwS48T99FZDoW3O95xdjLqd+Qr8inzJdHpwonQ2qn
	 8/O4T5LVWxuaBkkBbfwQ2JH1CtDobvgOeahLk2QlwRt2/p4azGwiQNyCOCuiX7tubG
	 Oa2/I5K5fw87Q==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/153] 6.12.17-rc2 review
Message-ID: <20250225175850.GA2770@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250225064751.133174920@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225064751.133174920@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.17 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Feb 2025 06:47:31 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.17-rc2 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

