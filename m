Return-Path: <stable+bounces-15480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C023A838700
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 06:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C89B23D11
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 05:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377462582;
	Tue, 23 Jan 2024 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhh7efoP"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B45228
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 05:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988939; cv=none; b=CFm1JsSs/ikdM6xXFfMewmoLAnrEr+OG2JXNXI81G0VmT5y5uLoutaM8mgAXrI5XkmiwbfrgiKdc4nIR8JeVzDgehwduY471uByyl/YKvn9bDUaUDp+usPG2sD7nas5Xk/xFJ7eZu1BJ/QuecYvMW1W6V0JfvoelGsBUPrmvuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988939; c=relaxed/simple;
	bh=gLx3F7uRySGSTVVmcT3q6Jip2M/d1Wv4mYeuPB+hl5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rzuw7xKDLT7LiVfJUo/eFKyU11DULK6NvViwzkkdBkMadxm1QHcAQBCu+pwLyJuSFaiMNGVk4zqm6w00GudtOH+btieBX1vj28fu+o1IPvox6p8LfOQV+/fjmZiguCzY1/MpKuq2AJNBhAN/3Ov+d1LuNlPaCZfI1AqH5Xcgx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhh7efoP; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68183d4e403so23659806d6.1
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 21:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705988936; x=1706593736; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JmnrA3mt9VqgxnwpT1hiIsZlc/X5kVa0LSfpaoPtx4=;
        b=lhh7efoPLdTaCNWmrP3B+CXJGHBtVQG9j7lNHCKraWvRHmhaKOZJT71RG7mtQnEwvq
         M8mGYCoT7rpslaKKrifob+MLWrWVv9+T/h31pISjZw/dp7oqdLqsdKrNGNYyVDoE9+DU
         BsjQy5fizpMKbprchH7h5HD7TyIRcyFdrGMXbQSg+h3rH99MBtvYaG1NhUpeQAuYy4BZ
         Ea7dbPBSi3St+kDy9cuNkUaVm0sPFhd5eUbHZ0C1a1U6mDNsn/mptXXp/Mq2d+blTyUe
         4eJ7tBQo6jaed5WZbygqczyYqxb+6YREkzFFUevRSxqP//emNJ/lXCGssG1QlQ/gxzWG
         Z2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705988936; x=1706593736;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JmnrA3mt9VqgxnwpT1hiIsZlc/X5kVa0LSfpaoPtx4=;
        b=NnMincbufRvd3z80zEBI8+vDzhpECtsRAIqFZSKccxCf9ZEEV5F0guvfiTRk/mVs8x
         LhXDZ3h4gGczjkL+aXzsdWS7Yn/V5N54Gjjg3/k2Qy+iZwsOrOaQQxBWdXkkGHNcfSHx
         GF16G08xZBcwvVTZL8+broQY/NT5oZNUUs/wVVgbPV9zyBSEt5Is8z0MQVhTFVMLVixx
         pfylTZgT+389xlSxVyo3LgP9jg4B1su/hRPR6b2zMnXBbq/MEB8JIaDOPMCQ0orBoVX8
         Rj6PW5FnCQd6BveTagf+r6X3EjQz3oBoYyt3uU4Kduri/+CxX8FBpNNznJ170K6V7OtP
         AJ8A==
X-Gm-Message-State: AOJu0Yw9mDl5b/nxWkyhlHjmPQBmYES+fQ6KtB1IShAJcXnCiMIivln9
	4Np7yYxADQ876waLN646rD5BpeVd1i7n9a+bM3LejJsLXu82/CFA87/CNc/o
X-Google-Smtp-Source: AGHT+IHgjRwVcSNNzoM/9EfhwjpfNiwtOZF6z8k+TNHzp8RGfMJn6DRHN46BMPSHE+SisvbKp7JNSQ==
X-Received: by 2002:ad4:5bac:0:b0:686:8ffe:1278 with SMTP id 12-20020ad45bac000000b006868ffe1278mr455995qvq.4.1705988936564;
        Mon, 22 Jan 2024 21:48:56 -0800 (PST)
Received: from squish.no-ip.biz ([181.214.165.16])
        by smtp.gmail.com with ESMTPSA id mu6-20020a056214328600b0068602f8966esm2728921qvb.111.2024.01.22.21.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 21:48:56 -0800 (PST)
Received: by squish.no-ip.biz (Postfix, from userid 1000)
	id BF2EFAA0B8; Tue, 23 Jan 2024 00:48:54 -0500 (EST)
Date: Tue, 23 Jan 2024 00:48:54 -0500
From: Paul Thompson <set48035@gmail.com>
To: regressions@lists.linux.dev
Cc: stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.6.10+ and 6.7+ kernels lock up early in init.
Message-ID: <Za9TRtSjubbX0bVu@squish.home.loc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Now I feel stupid or like Im losing it, but I went back and grepped
for the CONFIG_FILE_LOCKING in my old Configs, and it was turned on in all
but 6.6.9. So, somehow I turned that off *after I built 6.6.9? Argh. I just
built 6.6.4 with it unset and that locked up too.
	Sorry if this is just noise, though one would have hoped the failure
was less severe...

Paul


