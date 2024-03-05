Return-Path: <stable+bounces-26800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CFB8722AA
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 16:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFED287255
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4701272BF;
	Tue,  5 Mar 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="d0BLrSxJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D41272A2
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652326; cv=none; b=aBOHLR2GWaKokF5nzNEMluzER7Cn7GDslbEsEzZkghixgstL4WH7IS3Ww6dtr5EDDRtACpns/Hzd2Wkjxu7vhl+aH/TAMSIr3cjt145eGFvXQrX9G/iewIX46bxv7J+CDy2UYj5oTEof1aMBAHjZsSRbWPWbxb5XN39LVDZ3gB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652326; c=relaxed/simple;
	bh=q7EQj5T0Are7t8oh5ebCVYH/j+VAIo2h2q8OFWU/E5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9W4PdwSM84qR3XF2khis9bVqk2vZfpLAO244s0Drf2UPvaq7DWfSYk5xqqTDuM/thKxoJ/FJkerGLJDsWO5ZpQ9DdIlFAm9+ODKmJ9Skvgirp4VLfqdgTcrYAKGzozFMiS/F+2lrkwpFImOGjUjsdihbzA2lfTboSa20R9noCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=d0BLrSxJ; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425F5fdV005466;
	Tue, 5 Mar 2024 15:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=6rKM/hQsKq/kpwMcC1BQSxxYUcrxG6XXX0yEkHvLLjo=;
 b=d0BLrSxJ10ynJKPbK55DTmAIMIM2Nl3ikwLuK14oWwxzs2uj/1Yoqh5MGciY7mvof9lK
 nz/lvrfLSly8pWq8KBHEoM422PS51GmRN9bPij6zcf2zkezkrDK4VXGS/GVj+lXghx8p
 3fXULq8+SynaeuPP1xWvZYqV8qmWxenDPDI4HJZsoRyiBjbzb51pW00I8XfnRcsugfZF
 qUxCJ4jHwIeCC47n3yih5n+7l7eEaQ51b2dd+uYG7E4SgBW5/oUjbEDTekQA3piEDf5g
 i4q4ZMhx/Lm49/CqCdoaaCAsSrU07HboWq0lH/dPjgBDRyLvv+kjQGN0/dAt3IRrRICP mw== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3wp4j2sma3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 15:25:10 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 66C1D27644;
	Tue,  5 Mar 2024 15:25:09 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id B3BB9801FD5;
	Tue,  5 Mar 2024 15:25:07 +0000 (UTC)
Date: Tue, 5 Mar 2024 09:25:05 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Pavin Joseph <me@pavinjoseph.com>
Cc: Steve Wahl <steve.wahl@hpe.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Message-ID: <Zec5Ubr7G9NbnIyq@swahl-home.5wahls.com>
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
 <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
 <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
 <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
 <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
 <ZeO9n6oqXosX1I6C@swahl-home.5wahls.com>
 <f264a320-3e0d-49b6-962b-e9a741dcdf00@pavinjoseph.com>
 <ZeXzoTjki+1WR258@swahl-home.5wahls.com>
 <fe72c912-f1a0-4a53-88ab-b85e8c3f7bd9@pavinjoseph.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe72c912-f1a0-4a53-88ab-b85e8c3f7bd9@pavinjoseph.com>
X-Proofpoint-ORIG-GUID: sHk-IgT3tMDLQNZhnheyDRQYM9YqSXC2
X-Proofpoint-GUID: sHk-IgT3tMDLQNZhnheyDRQYM9YqSXC2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403050122

[Oops; previously sent this to Pavin only when I ment to copy everyone.]

On Mon, Mar 04, 2024 at 11:18:49PM +0530, Pavin Joseph wrote:
> On 3/4/24 21:45, Steve Wahl wrote
> > There's a chance you may be running out of the memory reserved for the
> > kexec kernel.  If you have the time to try adding the command line
> > option "nogbpages" to a kernel that's working for you to see if that
> > breaks it in a similar way or not, that would be valuable information.
> 
> I tried it and it breaks working kernels (6.7.4).

Thank you.  That's good news, it means I'm thinking on the right
track.

I'm still on the way to getting a system installed with OpenSUSE to
try and replicate your problem.  In the meantime, if you want to try
figuring out how to increase the memory allocated for kexec kernel
purposes, that might correct the problem.

> > My next steps are to read through your logs more closely, and load
> > OpenSUSE somewhere to see if I can replicate your problem.
> 
> I wasn't able to reproduce the issue inside a VM (virt-manager, QEMU/KVM).

Also good to know, as that was a possibility I was considering trying.

The number of regions created in the identity map as you're kexecing
is fairly system dependent, it's been a couple of months since I
looked through the callers, but as I recall it might even include
regions that are in tables passed in by the BIOS.  So, it varies from
system to system, and a VM is probably going to be much simpler
compared to real hardware.

Thanks.

--> Steve Wahl
-- 
Steve Wahl, Hewlett Packard Enterprise

