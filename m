Return-Path: <stable+bounces-50174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13790435E
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 20:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FB32867BB
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEADB54720;
	Tue, 11 Jun 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdRVe9iW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FC4F5F9;
	Tue, 11 Jun 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129800; cv=none; b=n7j2Ve/WLwpMok+hXuNPcVuT1Qt82sbke38y21JM0KjgtIj3/WLl9LHbZ7MsalavyR8tZZPE7KxyqfCMwrn3gba9XL5WdJUqHEUTTg1kBDRq7EZ8qxMEdfDcHs8GZyWQvhdQG6gPCXkwHiTjjRMMOyO6vmorKE3Le7n1gFg2IhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129800; c=relaxed/simple;
	bh=negaQ/p+8fqZUjRXlmaCtcM1w1qY4k12PHGOfjjOEjc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdEIYPPTst+o/o5SEJIhvCDzr5WS263tyNAzvtEBUoDv2qCOkQ/j8oLkt1ojiwVk0EhUq7dbn2uX/zS8BVEGWj87GHKQyuzz6H7oTyzRVmUDKN7j0Srgf9nVBYCqy0kd8Fbs1WD2XYr6pJGiWGxBUdeQginET51q34X5SP69FpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdRVe9iW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52961b77655so6545155e87.2;
        Tue, 11 Jun 2024 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718129797; x=1718734597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtI1lbTsgVOULKjRJR67YoxzveH1+C7OsnELRZ7Iie4=;
        b=MdRVe9iWiOkNvpQBqi8YLVT4mdLf1GfGmck9JyfkNx/10CAv72sit3ro2efYnyMNZx
         jTiN4mtD0Ez7PTkDSw9wTiCC+UwWMTV7IU3pAU9MxLbC+RJHMB+01CoG4jrhUO7fzN9G
         qfHeEVbcRiD8r+ngaj97ynSaYRmb9ijedNJ7fB5slavvhtZ0MsjCIw6I8gX5gycvKZu9
         eEwKqEiTV3VeX0fczfTExSRAL//gnKcTIcc5U2/8MdAY0nAUoKycsCRzvNa/qNx1MV5J
         UfuYWuLiLAvbN5E5bA8t5N35I5SeeY2XHc8hqUhWRXfAhF+yUR/eBnQlr5eMOLc4JWol
         kPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718129797; x=1718734597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtI1lbTsgVOULKjRJR67YoxzveH1+C7OsnELRZ7Iie4=;
        b=F3ErGad3FDZ9OrD1Yv5JpeBLTDqJyClLBd/pdUzeffpRW55iBwnb4aFarT4FAR0XaJ
         wXFfminQXqxaen8VdlCmYAYRGLZBcXMpnL8mypbV4QxL9fJ8GnyJxUS9kia8aDT0OMR7
         rFj8+b2R4vFHXkE5X3QtDtehyONd1rclb1eMDhw7ylklJgWmwfgEaHn/zhy+w6/dJdVM
         a/R+fzdC1faFlmiGXzlZSEqndnkkdkfQjl93aUXkedk8nNZWlpk9e3kGojnWB1/NWE3j
         p7OvA+U5OoqxYCh1HtaQcxHqtAPSzI8kRCganD5RFgIrUTQDRcJOccHF7TH8UL4vh1Dy
         WU5w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2bXruaEKy13g2YnnRAPb13p0z5i+kNtjF5IbU12Cy/2lQvFrikfZJtYm1NEaSVRYvYIaahwqMpTNqEbwnDnx2Gcy+7nquK0EnIVNlzLzaWnM7fwUmPaEWJWS+vsL7qqzjzAl
X-Gm-Message-State: AOJu0YySOkcIsylbJ3bDyyquRIwFXYlComBaHtRimt16b88a7FR+xK+h
	tN306IMiS+ZSzOWpiHg4gxb/FECtTfH5fODdc4G0stsLsFW6N+u+
X-Google-Smtp-Source: AGHT+IE3kIR4oIWOtR2uu9NQ6KUNP1rrWOPn4O1UFuBvCoPt7OCj8NMv26WIc3U9S+N4+tQX7M05Zw==
X-Received: by 2002:a19:2d19:0:b0:52c:8c5b:b7d8 with SMTP id 2adb3069b0e04-52c8c5bb9d5mr3324453e87.30.1718129795674;
        Tue, 11 Jun 2024 11:16:35 -0700 (PDT)
Received: from pc636 (host-90-233-193-23.mobileonline.telia.com. [90.233.193.23])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c85accab0sm1334842e87.106.2024.06.11.11.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:16:35 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 11 Jun 2024 20:16:32 +0200
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	steve.kang@unisoc.com
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZmiUgPDjzI32Cqr9@pc636>
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
 <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
 <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>

>
> Sorry to bother you again. Are there any other comments or new patch
> on this which block some test cases of ANDROID that only accept ACKed
> one on its tree.
> 
I have just returned from vacation. Give me some time to review your
patch. Meanwhile, do you have a reproducer? So i would like to see how
i can trigger an issue that is in question.

Thanks!

--
Uladzislau Rezki

