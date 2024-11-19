Return-Path: <stable+bounces-94052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5413D9D2DA2
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 19:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B8AB283BC
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F221D12EA;
	Tue, 19 Nov 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="iYP9FDvV"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061901CF7C7;
	Tue, 19 Nov 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037639; cv=none; b=AhUqb1d+6IT92QK2FN0vJ3CgjYDI8Ru9M4BIXuUB6bD4ZpvSoyxT75SF+JjaBrXhhEmLD/Lm3nyn46XHFdudBKABrr6fPQT85OK+znTs+7kzBTATcmjRl4hko9w1SeFMNIE1YQjc6o+BhUqvMQsN/lBdGd/5z7S8qNzCzO1gpI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037639; c=relaxed/simple;
	bh=n5OF541z6I7dZSO/K2wsviY2nGkMexoAFafWQJlQzns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O161oWIPE7O8f4suEIUBN7TGToluQGu0agGDcgypgOs1/EyUvqO45meErwVX9IdFc5ACdHkBbu90aWBclCxGX3Wwaxv0hsHzv9zUSc5Gv7bqlfhxJAfiM0aTQGLZyjiyVagZrPTtY6RkNMuds80vA397C0O+LfW9I/bb+uRh3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=iYP9FDvV; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJH8xEp020317;
	Tue, 19 Nov 2024 17:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=g8DUNKrQIsDGZ27NMhyzRt/rsg
	ZtYjMNjR/Yjh5419A=; b=iYP9FDvVdveTjIw8GgFRXBKXqHegYn2+pMACO7h3oe
	HKdBMM9HJxUEkgBYiPB5/fslV2TS21ZIiJcuZKh6AQoN/0seDLqY6bP4wNlAzKcf
	8OR2nB9pqya4GX70OkTJqURY5w82Za0gdrHbTM3lsADaEg2sXfbX0vTpfLPIe2Z5
	8v/CfFcRwgTqyFCYj+izRJgFABpckzsgcH0+Rmf3jbeUSruLuIBO8umjX5ulcNLv
	U79dW0I2IdWXtTv6u9BAZEVxUImWnjdxqbAEYg63Wfjy/Hw1o9UruLJTjkcCu9T3
	Wh25udelXA2ChHGYeRPChP+34SbWtLiTH91Ch/s3CW/g==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 430xts8837-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 17:33:21 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id A76562BADE;
	Tue, 19 Nov 2024 17:33:17 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 0855A8005D0;
	Tue, 19 Nov 2024 17:33:13 +0000 (UTC)
Date: Tue, 19 Nov 2024 11:33:11 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org,
        ssengar@microsoft.com, srivatsa@csail.mit.edu
Subject: Re: [PATCH v2] sched/topology: Enable topology_span_sane check only
 for debug builds
Message-ID: <ZzzL1xmZIgUCNSFQ@swahl-home.5wahls.com>
References: <1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com>
 <1e4c0bda-380e-5aba-984f-2a48debd7562@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e4c0bda-380e-5aba-984f-2a48debd7562@amd.com>
X-Proofpoint-GUID: _V3jG_16kYQAczU2fuyp8oMD1p06Su4R
X-Proofpoint-ORIG-GUID: _V3jG_16kYQAczU2fuyp8oMD1p06Su4R
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=584 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190130

On Tue, Nov 19, 2024 at 11:54:57AM +0530, K Prateek Nayak wrote:
> (+ Steve)
> 
> Hello Saurabh,
> On 11/18/2024 3:09 PM, Saurabh Sengar wrote:
> > On a x86 system under test with 1780 CPUs, topology_span_sane() takes
> > around 8 seconds cumulatively for all the iterations. It is an expensive
> > operation which does the sanity of non-NUMA topology masks.
> 
> Steve too was optimizing this path. I believe his latest version can be
> found at:
> https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/

Yes, Saurabh, I'd be very interested in whether my current patch
relieves your situation.

Thanks,

--> Steve Wahl


-- 
Steve Wahl, Hewlett Packard Enterprise

