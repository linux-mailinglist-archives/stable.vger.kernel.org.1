Return-Path: <stable+bounces-151471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C6AACE622
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 23:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158F63A901E
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC21E1DF2;
	Wed,  4 Jun 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="N2S6WXXq"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7F1E47AD
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072171; cv=none; b=d52jr+6XVb3VV3d1AqW8tvnfzV5g5lepgazPUONUqyIJsuTAXtrBmtgEex5BBpeozyK4NvI86rtmKFguuFzs66W2S2LtNuwXcbxx84cNeHLjiokW51sUg3ACynqceEooApaMGJuGxINpx8QVbNehgTjslbMUk/3HiLnRf4yn0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072171; c=relaxed/simple;
	bh=2SwoQaA9d9553yjNgGkPlmIqRjZns8Pzz4Wv1Hbo4RU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nNKKMMeBSnLQqAohifCG0XVEN4Czjjh8hH8selgCe4j9nWt96q3mSgioul6C2qg4ng9bRa6OdjqVpGWlguN8d3QkfQP68qxd9S5uVQ+5oDYQTDRCrvuu/6h2tPufh2cY5ZLeVfUIeNW+pVMUDBgoB07hmtRyalSS6W6SKBKuFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=N2S6WXXq; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <19a68e9f-584c-4d9e-aace-c3764725aa0a@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1749072166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZWI3Ym45MiKR73NKXRFp1d7/vePEqitj8L7OL8vkkY=;
	b=N2S6WXXqDqp/oSJcl690LhDK7UdVD180QZV5BmVXne4G2eEwzMRVhR7VwTtvedv/RdairX
	Mro6xNTQHrAHA5rW08FZYUnPyu9m48LFBwMVujVnrc/REtywFmDEH4RgZ51InOFmj3js/K
	pYWcnkgVD/RFOtV4BNc5YUmQVaHBmYEw37wd77d1VfmDUkGpAwh1OKeRf8BtEwwnWZmKXq
	oDeMvAgm+OiDiF0w+VkV31wB/mCy+gaGpygDxBjd62VkgdYBrmYuLsSSaZllPYaRWhgCYJ
	fM0U1MLo/y7HxAZgjz0d1yefYn9jkQBWB/oPG3X7iAMxXKH5AWxUM+kzfcAGUg==
Date: Wed, 4 Jun 2025 23:22:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Compiler Error] 5.10.238 - Werror=incompatible-pointer-types
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <3af41509-a243-4b64-8c49-af7263be22ef@manjaro.org>
Content-Language: en-US
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <3af41509-a243-4b64-8c49-af7263be22ef@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 6/4/25 21:12, Philip Müller wrote:
> I see the following compiler error with:
> 
> 2025-06-04T18:53:58.6366470Z   CC      net/core/skmsg.o
> 2025-06-04T18:53:58.7689837Z   CC [M]  sound/pci/ca0106/ca0106_proc.o
> 2025-06-04T18:53:58.9485675Z drivers/video/fbdev/core/dummyblit.c: In 
> function ‘fbcon_set_dummyops’:
> 2025-06-04T18:53:58.9488404Z drivers/video/fbdev/core/dummyblit.c:78:20: 
> error: assignment to ‘void (*)(struct vc_data *, struct fb_info *, int, 
> int,  int,  int,  int,  int)’ from incompatible pointer type ‘void (*) 
> (struct vc_data *, struct fb_info *, int,  int,  int,  int)’ [- 
> Werror=incompatible-pointer-types]
> 2025-06-04T18:53:58.9490536Z    78 |         ops->clear = dummy_clear;
> 2025-06-04T18:53:58.9491362Z       |                    ^
> 2025-06-04T18:53:58.9492571Z drivers/video/fbdev/core/dummyblit.c:33:13: 
> note: ‘dummy_clear’ declared here
> 2025-06-04T18:53:58.9494125Z    33 | static void dummy_clear(struct 
> vc_data *vc, struct fb_info *info, int sy,
> 2025-06-04T18:53:58.9495247Z       |             ^~~~~~~~~~~
> 2025-06-04T18:53:59.0185422Z cc1: some warnings being treated as errors
> 2025-06-04T18:53:59.0229239Z make[4]: *** [scripts/Makefile.build:286: 
> drivers/video/fbdev/core/dummyblit.o] Error 1
> 2025-06-04T18:53:59.0235041Z make[3]: *** [scripts/Makefile.build:503: 
> drivers/video/fbdev/core] Error 2
> 2025-06-04T18:53:59.0243143Z make[2]: *** [scripts/Makefile.build:503: 
> drivers/video/fbdev] Error 2
> 2025-06-04T18:53:59.0257657Z make[1]: *** [scripts/Makefile.build:503: 
> drivers/video] Error 2
> 2025-06-04T18:53:59.0262623Z make: *** [Makefile:1852: drivers] Error 2
> 
> Full build log attached;

Same happens with 5.15.185 and 6.1.141 as well.

-- 
Best, Philip

