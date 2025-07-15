Return-Path: <stable+bounces-161935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A60B04DB5
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 04:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8480A7AA33C
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 02:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A582C326C;
	Tue, 15 Jul 2025 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lHKxBPz5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590E2C031E
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545460; cv=none; b=eaA3BekEyvtoqB0Ya7ItccEdVm4n6b2Vc1UyN0oQrMkmOewaXrXbCk4gze5C2ZOGUj5EaLFf8Y4hF/gvl2sLAausV0ADDACB3bLthL4E0AejM+++oDqHBbfAwmP0Fm7Ndusyo60uxV68kUke7tY8IJZeYfpbD0tfSH14u9svuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545460; c=relaxed/simple;
	bh=BAnWZhSys1vM4DrenzAiVnvB0Qer5SlezMT+nFoji1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFRb/SCu/1frRAU/trMUMdsolRPO0VES3Yu2kV72RzkFQWFrvdpxl+nESQxTv38wtMc6GYdDdFn6+Uu2rntlLNe3muFkrsrjIf1TrgxudNu+W9zcCOvgTAV5mH07ZbCUhOnnqSzCbBYZXwTPDZhk2QaatBJ9Wkk1udhMwuk4wbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lHKxBPz5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2350fc2591dso47492825ad.1
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 19:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752545458; x=1753150258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpuhbsuubxCetOMWzwzGwJJhOpISY5hDDU9ccIk/iuQ=;
        b=lHKxBPz5aR1hPQCxke5Vtq3NQZkfppdDU7nfYAGryn0WVO1efonIGgO204tKdhrb1T
         Ws8Pzq86X6HInJdsIuycK8nnsy+sOoJM2Aj67eS7cId4ig9GNh+gAYG0FgYi2Efa9ViE
         5QbvUMzHFW6S75jADR62pyJ3lKzgJ7zSkwhglhQRnwIP985f4IY3T0Y7x/y1PyW5+NAw
         r9QfrX3relkGN3sK2460rxBKmQetBEk97LbheMJnbIV/9J2hTfaYrZ8GWv2Z/zOsnzmL
         JjRNvkcfFtO2XiK2TJotoxEm3CQAQr/DOsWcYmXXrcB8x+VRx0zFK4111Gq+E4W1TPOR
         ih/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752545458; x=1753150258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpuhbsuubxCetOMWzwzGwJJhOpISY5hDDU9ccIk/iuQ=;
        b=V6LY0NKkBSO5UUBVk9mwqwJTjLlCCuc4S52UIAfso+ED8Uo6nMZAd2U2Hvo2ehZJZw
         AlAHmWoeikibKGDukmpYBx7X9VfYuHDe41rkfRZms2IygbdlUsAU/LUNGr+6awhv8F2g
         6UBIi/uNUt//rNBaoHkyvtC+wkkv5MlygEcwhINry+V1zLEzg9vQpC6+Mo1LrMjrqx5j
         AbVv/0MVrwSPDgEZsqJ3+NnPT+ek1tnOrpOeJRSsTsVtrXZHxnqsXCD3xl0+tMUn5oeh
         vKHtg1AfOmvken5GsHVNwXrmQ3C3lYDYDket0tjONErXShHagNwGyMhBLgJJyPt1XMpk
         s6jw==
X-Forwarded-Encrypted: i=1; AJvYcCUMOk6fPbPmZmTQQvdweMv/F8RDfupwLYqgXvXkzouWAEBbW9S/2gLC8unHvTZ4Yzo/UEAUib0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wpZkQm5yfSzZY1eYP4aE1k/85GPUUhNXYJdUwa0Awc7u32uU
	JgYwFM7JUFZ52rXEdgAC4JgX5u0hbK5MPiBImhaPULaqeyjEe+2w42XvLA4kGfSDsn8qPCbi0kY
	VfrB7Fw==
X-Gm-Gg: ASbGnctxqsJAqfaoAHzI4Gukw0xNZZHzuk3QL/a5KtVtilie/ykhIlgVFM7PXNm+ekZ
	5UyJA51eeytK0mCvCnF7OPSOokLV+Jupa7F+asUytwJ8fNZqjLEYj7Ja0E9fiQxFcFfDymVQJ0n
	sh3oO70yL0/AbT/7kIOm81UxmKtPa0J7zNqYJhYWKZCtkUKJNMBnaYimiejJ4uSEjwUAWB8J4gq
	Coan6FtO4CaojCazZoxPbUKMhhFbkNxNB9mmwBUacmMolqszyQmbJofBSqTSiOiO1mBR4T8XSmJ
	hFdpG/RxVWa9opKPVmdpANA1ULHT5vdr6N1VxkypbHbBNSjvjeTCIs5rzLflK/UkseeuRIFJ1B8
	X1hfKWSW8DvQo1oDqgAMmUk5t3++umRLptkQy09JNnfo=
X-Google-Smtp-Source: AGHT+IGKPMrK2MPZkOm7LDhOi5AEOAfsDafCHBCi0Oz9JINia78cQmHlKqc7Y0NQXOAuL+9Fb970BQ==
X-Received: by 2002:a17:902:c404:b0:215:6c5f:d142 with SMTP id d9443c01a7336-23e1a49bb24mr23710745ad.20.1752545458431;
        Mon, 14 Jul 2025 19:10:58 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359c68sm98647305ad.213.2025.07.14.19.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 19:10:57 -0700 (PDT)
Date: Tue, 15 Jul 2025 10:10:41 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pu Lehui <pulehui@huawei.com>, stable@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: Re: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
Message-ID: <20250715021041.GA36@bytedance>
References: <20250616070617.GA66@bytedance>
 <2025062344-width-unvisited-a96f@gregkh>
 <20250623115552.GA294@bytedance>
 <2025062316-atrocious-hatchling-0cb9@gregkh>
 <e9fa5e34-eacd-4f35-a250-2da75c9b7df8@huawei.com>
 <20250624035216.GA316@bytedance>
 <2ed4150a-e651-4d10-bada-57bc3895dbe7@huawei.com>
 <2025062458-flask-enviably-20a7@gregkh>
 <20250625093311.GA388@bytedance>
 <2025071246-armhole-salsa-ba8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025071246-armhole-salsa-ba8f@gregkh>

On Sat, Jul 12, 2025 at 03:42:51PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 25, 2025 at 05:33:11PM +0800, Aaron Lu wrote:
> > Thanks Greg.
> > 
> > 5.15 stable tree also has this problem and after applying the above
> > patch to 5.15.185, the problem is also fixed. I appreciate if you can
> > also queue it for 5.15 stable branch, thanks.
> 
> Now applied, thanks.

Good to know this, thanks.

