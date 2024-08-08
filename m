Return-Path: <stable+bounces-66063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9535F94C0D8
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDC6B27369
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15418DF99;
	Thu,  8 Aug 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="2xhBvQ1B"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76815C8D1;
	Thu,  8 Aug 2024 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130414; cv=none; b=D76ZOoDtiS9mRYFpglFYRcPhvmB839qQiYYJCw8/JJXOjVqYTlYXpQ0HIhbNMyBF39RHvUII28K7+AoBe5X1RfVn9JcLVpVFc2rcTGiqAL+Vd4wmLo6cX7vXGyxRWyKY6St4mAHBbhcPmXZqtSL4s+Zv8XMmMOlG2BqH7ez+IYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130414; c=relaxed/simple;
	bh=hNa4B/hL22QgWZp6hWQZ7Qe86Zu1q4zoaYB/hMOvkW0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAFRJUVSQfR4WwcZmUCxE+1fJKpzdV5ilALVWmW8uSyPEPTEJ2QwIB7EcNcnVNKuTDHsDu9egjshTXCahCMN5m8cGgaLKl8sl6Ck6Ecrtd1euXBwJJOVaP/Hpo+rFeT44kb8EnivfEkSBq4CVoSoBXCWOM6RZDfO0QEYggl54G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=2xhBvQ1B; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Thu, 8 Aug 2024 17:10:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1723129835;
	bh=hNa4B/hL22QgWZp6hWQZ7Qe86Zu1q4zoaYB/hMOvkW0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=2xhBvQ1BwZuKJbjcS7yAHgtVVk+tC4bJ7ivp2HkG45C0ztgEdlMVTuexV/NuDds8i
	 xAyD4fh5LyTo/lf7Ez3BTDjCPvKw8/YXI+ysRP+YoA1ZR2P3NCQIR224VAC5GJ8D0B
	 b/nY7/TRfDav1gsv1LGyTDOGe61OA+J0JR1T1B+LuAbqxAdJYsDR29GdkjVAcN12/A
	 kfLJL/Pm4ZLHwxSS6vJp2+X0oUczllhrRGaOK7FXIA8l0ecWJ899Uoj0oyL9Oy4OmP
	 +egLhXP2uwR7gw+V3vZyFnAG4D3OsRACXVmW9q+oB7LfhgBUFb/wkKVMSvdjloCmkX
	 NOqXoCtyx5W+g==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
Message-ID: <20240808151034.GA2417@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240807150020.790615758@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.10.4 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 14:59:54 +0000.
> Anything received after that time might be too late.

Hi Greg

6.10.4-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

