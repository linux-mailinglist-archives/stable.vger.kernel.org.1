Return-Path: <stable+bounces-25948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9618706BB
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 17:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D7A1F2153F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5379B4CB36;
	Mon,  4 Mar 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="kI85SnPM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900B4D595
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568953; cv=none; b=kqqOn6qlOm0Efxp2bB534onOrtYkR+u8sBZOrp6BIjkVGvIQzFVee8gm6QL2ESvjAIVYoahOZPKg2k7Am8C8nivJbXzQ0njoE14zjVjlnvgJ5D/kxWxulTu0m3cVantzyzqoYjIbYPSeRSsxns8ItXF46Xcttm7lG6X33QOVPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568953; c=relaxed/simple;
	bh=76RSLLNMJXqoycoCvWjqw9JFVKzRErP3ckyQpEA9WXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVWmJusqLO4I+4jnsPd5aUVEzOEPZ8OciOLSvBAVXVa88k92cPUWeeSrShgtLX2A49QLlm/W/9K84cEDqMqDQRsZSqIDLIBUAWAENE5AniJM4gZOTiWAuPFOMLJMSijhvCwmndmPKPEVv3K+gcDgrL5twFI2VzSkx4e0v8xgXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=kI85SnPM; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424EWJJl015891;
	Mon, 4 Mar 2024 16:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=/cJqAd0M+vSwxU0c4OzETTinjHcmf9rPnD50ESY2xCs=;
 b=kI85SnPM79weW92/Z16oltWUhkA77l1YteeAlYJK2FuZgzIBdUmU3Fnn5JVAn798VG6c
 FVZbs4wSkltTwOj4/FS8lfOAYnTO4EqQMmX4FVghYm9LACYiK3WfrnW9ZURLvR3nLgGJ
 RfeB4ii0oIVSq7p4/Uy5JTpiwFxq4NnaPI/2fId8Hv+xhzoxyN4W8YBOGNxVCd7bvq/M
 OFArd4S3DKNNYubi03NP9S2T7qcNrDmxg0NVD3uuZ3x9aavWUUQ76Lfw7Dqt+8xDPoIw
 oxnqIcxDj10jFgg2Qqc1ahJXDN+KrXUDztJv6swXGxnnrbXDXCeGZmxvLAJ28JRA00En cQ== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3wneaeu104-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 16:15:33 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 5DE31130AB;
	Mon,  4 Mar 2024 16:15:32 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 57915800EF6;
	Mon,  4 Mar 2024 16:15:31 +0000 (UTC)
Date: Mon, 4 Mar 2024 10:15:29 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Pavin Joseph <me@pavinjoseph.com>
Cc: Steve Wahl <steve.wahl@hpe.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Message-ID: <ZeXzoTjki+1WR258@swahl-home.5wahls.com>
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
 <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
 <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
 <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
 <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
 <ZeO9n6oqXosX1I6C@swahl-home.5wahls.com>
 <f264a320-3e0d-49b6-962b-e9a741dcdf00@pavinjoseph.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f264a320-3e0d-49b6-962b-e9a741dcdf00@pavinjoseph.com>
X-Proofpoint-ORIG-GUID: JVAHZmODXutakwm_r6kL30WYrh-39Z8Q
X-Proofpoint-GUID: JVAHZmODXutakwm_r6kL30WYrh-39Z8Q
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_11,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040123

On Sun, Mar 03, 2024 at 12:02:31PM +0530, Pavin Joseph wrote:
> On 3/3/24 05:30, Steve Wahl wrote:
> >
> > The machines I work on are large, though.  Can you give specifics on
> > exactly how you are performing your kexec, and what hardware you are
> > using when you hit this (especially memory size)?  Have you made any
> > special arrangements for the size of memory reserved for kexec on your
> > system?
> 
> Hi Steve, I'm using a mainstream Lenovo laptop with an AMD APU (Ryzen 3
> 5300U), this is my secondary/testing machine using which I've built the
> kernels and performed the git bisection. I've attached the relevant journal
> logs and inxi output.

Hi, Pavin,

Thanks for the extra information.  I have skimmed it, and will
continue to read more thoroughly.

There's a chance you may be running out of the memory reserved for the
kexec kernel.  If you have the time to try adding the command line
option "nogbpages" to a kernel that's working for you to see if that
breaks it in a similar way or not, that would be valuable information.

Explanation: My patch can require additional memory for the identity
map, should be worst case an extra 4K per GiB mapped.  The nogbpages
option always does what my patch only does sometimes, including
requiring this extra memory.  

My next steps are to read through your logs more closely, and load
OpenSUSE somewhere to see if I can replicate your problem.

Thanks again,

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise

