Return-Path: <stable+bounces-185807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B514CBDE56D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1968E3579F7
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 11:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13823233EF;
	Wed, 15 Oct 2025 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcP0LiJT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7B2C028E
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529129; cv=none; b=swPkyAio5facryZAR682IOxLZhTZiOS8nVB8M1s/CSa2GrQFvtnpp4nN+4StjK1xliBrFO2Buf1Q2pR7uRPiinR5jqKoUNHz02xyTXuKZE4K+GJ6xika2Ra3eVVMHHLhChVBh9o8sp5WiWv4RrO3+Qq+W9LrFq+di/qjSzfhbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529129; c=relaxed/simple;
	bh=C+fUmygZgWDPVlTd9fhtHxLEbc0UkGPOIkWRbGE3PCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkzAhFp2BnHwd6CaU2AqFG7cm5aGNkIg72jI6JVojKRVyVboQ0ZoegD2xdkDa+2BDny2AENP9Ha4BW0FgVbyDVyYo6j7uPZfPwvsjOMvdTSBxdAIG+ZV+X/kbHtCdeo4EqH/973PpsYrQ3udWC+sZGeJhjTwzicrJ/s2LnG0CAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcP0LiJT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760529125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODJk05V7SoMlUuxQdA+kawSNJMOd5HI5bDkXGyTXt0c=;
	b=QcP0LiJTOyW0bbW8acQR72TEcblBv2QTf1H10U+P9qs9GLjlPYyng6Yzkz4vBZsCXgu0tj
	czWWuWzIZkzJZ5EiaqaELTKfa4V1IuzGxOY/0s6pFAP/TZW9AzGT82qBFaZy45MSEHn37k
	4nbDuVTagitNv5Ztfnr97urPp/AOPLA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-AfwHSx9tMvardKbm26Mm5w-1; Wed, 15 Oct 2025 07:52:04 -0400
X-MC-Unique: AfwHSx9tMvardKbm26Mm5w-1
X-Mimecast-MFC-AGG-ID: AfwHSx9tMvardKbm26Mm5w_1760529124
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78e50889f83so400644396d6.1
        for <stable@vger.kernel.org>; Wed, 15 Oct 2025 04:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529124; x=1761133924;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODJk05V7SoMlUuxQdA+kawSNJMOd5HI5bDkXGyTXt0c=;
        b=gMUzFeDEmhktT+souJ1oUGDeM00ImHajxsiPzmNOrF/w1JeAr1jw6IYnIOTj/oTbqW
         Bp3BV3LFUQZXX42qGMnIwxjZEEW3XZWNA56pJPAj0WhcPBbf+CNzbX8/8HhWu6RKhGog
         Gm7vubqyp2w0cdYNDPByYwTdjQyacquvB0RpWkhj/jlIqFdo78lVeFiopQsJ7inupm3f
         N/7Nyyw14C9BGrlPO+Zk14b1da7KksnkinPQ3ZHFV1TdAlM4RKAaR+oGw9IMEL/aN4eS
         Jcq4E0eJup0fVYGYsrO4q8g/g56l4ZZ6xnEgj9ydlcBxL7iqrfb1xPfAbyZ18VrutjyW
         LBcg==
X-Forwarded-Encrypted: i=1; AJvYcCWkG5kAJIYTsLJShCr1e91npG+NCjMaz0JjyioexuOErjwZycI6mKI9sa2HSK4rd7inVbO/r1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YymtBiZX2QOOIaUEmCic622BHnu9cDn69Sb3xp5HP7BQwcmrj3A
	u+OVEJ2Pdso52m3cRergn0TayC3+dhE+i7lOiZUMkdJrN67QTDN+6O5vgXWCSeK5m+PLYfCTnXx
	hWba/e9ClMM2jferEgJTtaPSS9Axoz3QdjU4hc4Ku9D3EAjrJIKjB+681UQ==
X-Gm-Gg: ASbGncuIEaeOU+99uCssCj++E82LlIHwfZZtsqjIR1YtJrtDk1pZ/WF88eePiaLJHNw
	jCdPM7uYfbO0OMb0Sj4oUiqM2E+mMyE2KqKHB7VdOk9gM8U/pBSiaK0dvHgy8+gucflYD8fMDT1
	gvEDNnxgPPEzex1z2mJH2NZrj1eapY4gK4mh3/hm4K2DS4Do4RMqn72XLHEzfa3r2eCSjWBFk6N
	WKFTdmyQBbGm7XZef9wGEtF9QwhEoQPsZ43i/moSn6YZzXptU1f5xJLbgnaVd/jysTEjEK8eiBD
	vpa8BQpuHBxwL1CF5b09W+3APQnpJhmGthjGIz4jISc9grvvoRBwZMQjDYMMQaTla7CM9dT6eAv
	NopQOLLDg0ybO1qDhf7dIZmjo+HDTkQA=
X-Received: by 2002:ad4:5aa4:0:b0:7a3:b6ab:6f2 with SMTP id 6a1803df08f44-87b2ef6f5f5mr435123786d6.63.1760529123809;
        Wed, 15 Oct 2025 04:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHciI45rIpK/9xRv0T7MZA7oj7dUL8u5UMRTnG+gcBNElSmdluoXorUAhhiBXsuEnWRFIoRSA==
X-Received: by 2002:ad4:5aa4:0:b0:7a3:b6ab:6f2 with SMTP id 6a1803df08f44-87b2ef6f5f5mr435123326d6.63.1760529123237;
        Wed, 15 Oct 2025 04:52:03 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0121c18dsm16662196d6.22.2025.10.15.04.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 04:52:02 -0700 (PDT)
Date: Wed, 15 Oct 2025 07:52:00 -0400
From: Brian Masney <bmasney@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, stable@vger.kernel.org
Subject: Re: Patch "clk: at91: peripheral: fix return value" has been added
 to the 6.17-stable tree
Message-ID: <aO-K4FRm0KFhNLL9@redhat.com>
References: <20251015113603.1333854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015113603.1333854-1-sashal@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Sasha,

On Wed, Oct 15, 2025 at 07:36:02AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     clk: at91: peripheral: fix return value
> 
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      clk-at91-peripheral-fix-return-value.patch
> and it can be found in the queue-6.17 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit cbddc84a11e6112835fced8f7266d9810efc52f3
> Author: Brian Masney <bmasney@redhat.com>
> Date:   Mon Aug 11 11:17:53 2025 -0400
> 
>     clk: at91: peripheral: fix return value
>     
>     [ Upstream commit 47b13635dabc14f1c2fdcaa5468b47ddadbdd1b5 ]
>     
>     determine_rate() is expected to return an error code, or 0 on success.
>     clk_sam9x5_peripheral_determine_rate() has a branch that returns the
>     parent rate on a certain case. This is the behavior of round_rate(),
>     so let's go ahead and fix this by setting req->rate.
>     
>     Fixes: b4c115c76184f ("clk: at91: clk-peripheral: add support for changeable parent rate")
>     Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>     Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>     Signed-off-by: Brian Masney <bmasney@redhat.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

Please don't backport any of my round_rate() to determine_rate()
migrations to the stable kernels. I have maybe close to 200 of these
patches for various clk drivers, and stable can stay on round_rate().
There's no functional change.

Stephen mentioned this work on his pull to Linus about how this is all
prerequisite work to get to the real task of improving the clk rate
setting process.
https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org/

Thanks,

Brian


