Return-Path: <stable+bounces-114137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D09A2ADAE
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89613AA420
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4223716E;
	Thu,  6 Feb 2025 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="NpgVwRp6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45A323716D;
	Thu,  6 Feb 2025 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738859141; cv=none; b=e6Md8Wy1YdQ0UAA+WW90iKGYSw3vWO1k23UI/ya3erYUaSTBfALdHtNqTyYIouPAl6j6JopMAO8/SSA+c30u9bJHJon6LBIYZ7dgLrkATzgSXUkifpLznAuBtYZfnyJ9l4nO8eI5gr7dFAIe7zG0BCuvBMJ6m45bDMMtH0uuwOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738859141; c=relaxed/simple;
	bh=4uqqJDB/ASXenA6nnqZ12gew3Hu5FHhd7UoYp33CQDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEN/htlSivc895t7KZ5gUdu77/mrj9gXRqx0k8sXKlxLYFz25exJPQ1vYk+nkW1r/5fg0gsfgCH+IAvZB4KQlOf3x4szCYvFCSGmj8GGG9uW5yhVq2abzEADi5m6pvmJZ+OJy6LgG7JFd1CV/5UZu+p6z0uZuf4AD8PBaADDtO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=NpgVwRp6; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516FT0UU013307;
	Thu, 6 Feb 2025 15:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=lVu6Q0uwocQaTsZq0ZI2bsWEks
	bNWiitC2dNwQ1UD58=; b=NpgVwRp6phTqNU2j66HgQBfuiRUWQQbCLj3lu3iZ+t
	YUeAq3ORuX7iNwGiyUKFEcTxmOYoH5Nfm3V9P4RvYcGGA+oKxKJpnkyLxbZCbnyH
	zmOFtBKp6kw/1Zp3TUgELosoXtrhq8yleuWXjRSGdXlhXj6n7n0bMW9GGVhm30N5
	GhKRndEmMv8RSeV0az4DBCd2Dlah10FNcWU8haWbp9oo1Sm4Th89V27LHOqfi3ah
	HiUkk4vS3XXm69WUKSALUUwaxYlZENjkR7b8QQDt0jEXeuVi8Kpypvw4swnddrjQ
	IkKoCIN9nrrpKwZvZBnqBJHvGC4XXQTzIsIe14/iIUeQ==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 44myrx80ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 15:30:28 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 4A2E5801AC8;
	Thu,  6 Feb 2025 15:30:26 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 0629E80FDCB;
	Thu,  6 Feb 2025 15:30:20 +0000 (UTC)
Date: Thu, 6 Feb 2025 09:30:18 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Naman Jain <namjain@linux.microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        srivatsa@csail.mit.edu, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
Message-ID: <Z6TVirifoG1c6TgX@swahl-home.5wahls.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <20250205095506.GB7145@noisy.programming.kicks-ass.net>
 <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>
 <20250205101600.GC7145@noisy.programming.kicks-ass.net>
 <e0774ea1-27ac-4aa1-9a96-5e27aa8328e6@amd.com>
 <xhsmhed0bjdum.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhed0bjdum.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Proofpoint-GUID: mXK11XOH6znOrAJAuKKgKjL0OH5ZmHH6
X-Proofpoint-ORIG-GUID: mXK11XOH6znOrAJAuKKgKjL0OH5ZmHH6
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=428
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502060126

On Thu, Feb 06, 2025 at 04:24:17PM +0100, Valentin Schneider wrote:
> 
> If/when possible I prefer to have sanity checks run unconditionally, as
> long as they don't noticeably impact runtime. Unfortunately this does show
> up in the boot time, though Steve had a promising improvement for that.

Just to let you know, I had other tasks interrupt me, but I'm back to
looking at this and you should see a new version from me within the
next few days.

Thanks,

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

