Return-Path: <stable+bounces-87936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9F9AD12D
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B9B1C21F14
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A731CACF8;
	Wed, 23 Oct 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcpavlIi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD91CACEF
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701587; cv=none; b=mNegSaCbYAU6XBub/umu6I0EEWH+qmGTGFHU7ZNsSy40o8DY5SMxoec9RwvTIZyZ6GWJxiAkPge4Tz5zUmOO7wETpbjqJRkcuqZWb+gOhVUAHkhqlfbYUl1x4Aa3Whgshs/KDfYIyDh34RkG8U0S3axETn84sY2nrpPaVe3arbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701587; c=relaxed/simple;
	bh=xgYde0kYGRiEie8bOJeIGOMdO8PtreNYsoIJWrnKk8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hSxas/gJXZNL63GzoFdTTBPcs9G+aPbV8uTKDeGbdfszq3J/fNeH4WrHlERPQVEMhjdooFROR81HPKmGSJTsOcKvcclob6Jyw+VaF5VHUivwT8jBfDDqp4suoi6N2v60LijZydhFQ5FyVpw/iBaQsEB+wANf7SK5R7kMxueKy9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcpavlIi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729701585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgYde0kYGRiEie8bOJeIGOMdO8PtreNYsoIJWrnKk8g=;
	b=EcpavlIiM4Y/RPEP2HShOtDlojVb0kUhO2bbmy22RupjyTjBzU/5NjlbdMPLE4laIECKmo
	xkG4viahuZyb5sG3SQ+n2GtLJ1Tc7s+CbVeIQ5C1LQCO4sG8jr7t9EpnyahxFxTWp0dvSY
	qLE2SvQePNSrLiE9MD5zDe/AZ22Zvz4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-U57LlSTCPV-hd3mCxhsynQ-1; Wed, 23 Oct 2024 12:39:43 -0400
X-MC-Unique: U57LlSTCPV-hd3mCxhsynQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5eb84cfdc03so4968036eaf.0
        for <stable@vger.kernel.org>; Wed, 23 Oct 2024 09:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729701583; x=1730306383;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgYde0kYGRiEie8bOJeIGOMdO8PtreNYsoIJWrnKk8g=;
        b=tNF/p4W71fsUZI0JlySJ5clNy3OgZ/unFCcwl/eC9DVweYw3FnNWu+ChU9c5RQ1y85
         822OVA5ua2DoGfSQaccQyksfR5E9V4wXcFAQSNn1TKbv6I1H6/vM7Qo7a7Zd5EyXuBoo
         5e0fqohpAXMk3Dyf9yD71szzVcMgWORSZhhD3PaLs5zaPAnHGkcEyj/xx3E9UNFGX7Eb
         0uYnxL/LGt9l0woS6lfNxuIbxWoxuzR2yW9K0KsaczibSiPLErZtlDMx06ED57wdCdXW
         qvkUa8jH/BBV45QBLbAqNkAFJSeNgIE/mTp41fSOTU/mKBRHCnceWjywD5AeWM9yEhUS
         hwvg==
X-Gm-Message-State: AOJu0YysAeqoinIMa03W9fUjx3M4w5PeiAI5BI+H/fiXNxRkzDJ3Of69
	f+01yk3uAZIZ+pvyoVhzAbiwQFcSCV1hx30Y8dt2NNtqQctmd5abZPM2ig7/twQYpw8uPlv0Dm+
	ODMM+dWfCmYdu/jCKSwLcVIDBwMCsjPGFrkdlhbEGNC2yldZIZduNng==
X-Received: by 2002:a05:6358:7301:b0:1b5:a38c:11d1 with SMTP id e5c5f4694b2df-1c3d81b1c55mr215715155d.26.1729701582826;
        Wed, 23 Oct 2024 09:39:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5uJ85hkEz2INCCPDQFtdhJuoP49vMzKxw9NE+7RKWs4MM8KvFHPEu83z6kixqE7MV11l1uA==
X-Received: by 2002:a05:6358:7301:b0:1b5:a38c:11d1 with SMTP id e5c5f4694b2df-1c3d81b1c55mr215712055d.26.1729701582497;
        Wed, 23 Oct 2024 09:39:42 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3d70a6bsm41746811cf.63.2024.10.23.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:39:41 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, ssengar@microsoft.com, srivatsa@csail.mit.edu
Subject: Re: [PATCH] sched/topology: Enable topology_span_sane check only
 for debug builds
In-Reply-To: <1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com>
References: <1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com>
Date: Wed, 23 Oct 2024 18:39:37 +0200
Message-ID: <xhsmhsesmu62e.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 22/10/24 10:57, Saurabh Sengar wrote:
> On a x86 system under test with 1780 CPUs, topology_span_sane() takes
> around 8 seconds cumulatively for all the iterations. It is an expensive
> operation which does the sanity of non-NUMA topology masks.
>
> CPU topology is not something which changes very frequently hence make
> this check optional for the systems where the topology is trusted and
> need faster bootup.
>
> Restrict this to SCHED_DEBUG builds so that this penalty can be avoided
> for the systems who wants to avoid it.
>
> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Please see:
http://lore.kernel.org/r/20241010155111.230674-1-steve.wahl@hpe.com

Also note that most distros ship with CONFIG_SCHED_DEBUG=y, so while I'm
not 100% against it this would at the very least need to be gated behind
e.g. the sched_verbose cmdline argument to be useful.

But before that I'd like the "just run it once" option to be explored
first.


