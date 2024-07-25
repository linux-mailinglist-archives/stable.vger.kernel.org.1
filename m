Return-Path: <stable+bounces-61798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8493CACE
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 00:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841301C21F0F
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778341428E4;
	Thu, 25 Jul 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3uJtd5x"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109B17E9
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946120; cv=none; b=Pvfz+lb84wiF5wKGNQqTj74fMkIQTakXJzywWvVu1q//hrvwNxUZ7Dq2H+w6Rk5jV5lj8KZBiOYCrp5U3ZGN/HnJLP7NAhebWgK9O9Fwmuy7PsApZbl82BoMr1GNqjNGI/RlfqikCMf3I5+3IRDxqStRoPtwqb3wEAyln1YHDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946120; c=relaxed/simple;
	bh=e3QtoGAhKBBmMhj47JDionvHjW/apkWJ7Za+hWvi5KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROKPwpU0Nc9FqGlK8GpEpWKJK9Ni4Yi16s+F5jFjtJ7LbcPY9+M3KyxhU3kBU1NX6+IGMG9bCn6mLf5sAB6IR/rSuwRV9e4pPq8GVl4ZkBwtgTm3iPKWxmWrkMcyUHl3Egjt4SJTEyRiJFS6qJBYEFwItSYhaNuT8J1F0uBg9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3uJtd5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721946117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/KmYr3jbfKPlvOHElaBkUrO4ia1UgbTouR26iyDyNM=;
	b=H3uJtd5xw/SvSf40wQdsRztGu16REUxpH+b8WoKBZQ51dg/Ym7/eOYx/oHDG3FqWB50mrk
	n1+Rkz/QChkeIXhRbQsO/UJHhdvoxRxQYJF9PPoN/IvkqaKQPa0UURGvRo8vAuD2l8vaDM
	z0saDYsH6uXCEE5qJcMKDJ6ORc3lCuc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-P3pCV0svOsG5IpdnZicJhg-1; Thu, 25 Jul 2024 18:21:56 -0400
X-MC-Unique: P3pCV0svOsG5IpdnZicJhg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b993657236so680496d6.0
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 15:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721946115; x=1722550915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/KmYr3jbfKPlvOHElaBkUrO4ia1UgbTouR26iyDyNM=;
        b=Y0TW4cwxl14VxuLgL+h0kMlh/jGEhHKCggvFJGFe59Ux7s6T/YFzF4oLQ/5U70/37C
         o/BM55NYRaVwHGPmahmQ/mk74vwRSd7IgFQDNxxuAZVvOoVEWT4+szw0OVg+Ei4irMYm
         aYY4GFluJb+XqU0Lv9ptx7vtuEObA8cQyx1P4UicO9Xtr2B4gPs4TilTI9IMRlxYtYh+
         jBYweV1vzboomZ997Oc1o2knLeK8ZtJOrrTSR+MewbdN/140+Z+cuqG/BqOdkCeUO8v5
         rhuMicql8is4Er627oA2HSx2Wk9a61vlxNyDS4oZRd/JghfSKxlYF5hFyjYrVAdYmed+
         Z83g==
X-Forwarded-Encrypted: i=1; AJvYcCWZQwCPikT2YwIPTK/2Hbax7RQYjKX1ga49pf0VjS3Xwgl/JuMsz4rPf6JN203SIJ1v2jzbwNBzfzi+TI97rYa3aHWZTMKd
X-Gm-Message-State: AOJu0Yz65wd3zAQ1oDYgUEemT/wsCdu7IZsJ8awfU8XncNFyDc57Cpdm
	2V59+bjS/riiNsh7OuCRX1IY5t7QCtX68RAZqqB5DIcLM6Qt7RHOuFQx6oiSwg32MDerdRNin9L
	5X4oeVwcY2BYiDyP1HrNyPYqEeY1kbpwphe7XYl4NxKDV89aohSMduQ==
X-Received: by 2002:a05:6214:cc6:b0:6b7:a4dc:e24a with SMTP id 6a1803df08f44-6bb4088c657mr43849276d6.54.1721946115681;
        Thu, 25 Jul 2024 15:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07I6M5sZysuSbSiY1fNxwueDCqDxgZ2yyxKjAhplt3Bd7CWYx3uTZ4M/qfs37U5MR3g6jXg==
X-Received: by 2002:a05:6214:cc6:b0:6b7:a4dc:e24a with SMTP id 6a1803df08f44-6bb4088c657mr43849116d6.54.1721946115407;
        Thu, 25 Jul 2024 15:21:55 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f925dc1sm10943676d6.65.2024.07.25.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 15:21:55 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:21:52 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <vj6vtjphpmqv6hcblaalr2m4bwjujjwvom6ca4bjdzcmgazyaa@436unrb2lav7>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724065048.285838-1-s-vadapalli@ti.com>

On Wed, Jul 24, 2024 at 12:20:48PM GMT, Siddharth Vadapalli wrote:
> Since the configuration of Legacy Interrupts (INTx) is not supported, set
> the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
>   of_irq_parse_pci: failed with rc=-22
> due to the absence of Legacy Interrupts in the device-tree.
> 
> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Tested-by: Andrew Halaney <ahalaney@redhat.com>

Thanks for the quick work and follow through on the patch, I appreciate
it! I would not have come to this solution myself, I was definitely off
in the weeds when debugging :P


