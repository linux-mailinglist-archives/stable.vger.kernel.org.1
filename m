Return-Path: <stable+bounces-27515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B08879CA6
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 21:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E503284411
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 20:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2DF14290A;
	Tue, 12 Mar 2024 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="WibrX5wU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1F14265A;
	Tue, 12 Mar 2024 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274210; cv=none; b=RwO7YCgAdp6dSWoj3qS5jrmeBUCma8na4NFVGI5jx+K2WmGWg9wunuH4bkjkGei9jlTy9fr/o82wZGAbSCdwWnCFuzBmJdTEhGTJcf5o9dJ2kNSt1fmu2HAdes1RadqhURQ0cxalcTk5bLpkBvAtXVFaYy0EKxQDMKXLy0jmT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274210; c=relaxed/simple;
	bh=afb+J2W1RZOvBUpT1q1VDqOla0v+GNPldfNpGi6NmXU=;
	h=Date:From:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aMmy1ERej9XCxdmVm3d+WajoAITDaNCvSN6fA1hckcUTZQOe6Ahxu9TJ6nVJWsh/mTWD9snD2oFlzCaNSQhV1xemgzMXb6EX9txalWTDbTAwUW4IHeePR3psH9QBDXf9XuSIYLbFx3J6HJT7UBFAJL7oxYtp60x0FXyafxs7/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=WibrX5wU; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CJgFuw001162;
	Tue, 12 Mar 2024 20:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=VnYb1j2+6PuZRCVUgTvKkrGm5+N4Va1AiIS3ecX1k3M=;
 b=WibrX5wUkkHVo8AAWxqnzQVTR7yngJpCe0/XkzX8o7+84/ZRZj8w+8L+TRBI5KN0k5ly
 1rGwndPXKQJs4evW1/TV3fk1xzwEFy2CV/xJ3a/2RVPZPwcEzsHgCR3m5+daZP5MLCMx
 j0/8bnra9B91SBT3GtE14VkTbIb7o1S4uu2L6zXX4hjyS4hi8/YWHhFkR9QE4HuT0/bM
 lk7+Jhrb2+2BKkQarKCTMEjJopHUtfqgjCJh68vxuwijioOOOEJo/2llrvpGp8beaWiK
 LZvu50cCnBtKAnKm/i6F44A5pC+4SYoHfcA1mZKzXKmjek9kwjqpE6VXzkKu+Y1n8Cmf Ig== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3wts7su02b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 20:09:59 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id CFADB12E9C;
	Tue, 12 Mar 2024 20:09:58 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 37928800EF7;
	Tue, 12 Mar 2024 20:09:57 +0000 (UTC)
Date: Tue, 12 Mar 2024 15:09:55 -0500
From: Steve Wahl <steve.wahl@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Eric Hagberg <ehagberg@gmail.com>,
        dave.hansen@linux.intel.com, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Message-ID: <ZfC2k66jb8CcupYm@swahl-home.5wahls.com>
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
X-Proofpoint-GUID: jkORMdzEPtbMJn1k3DXDtW93TkvInsdf
X-Proofpoint-ORIG-GUID: jkORMdzEPtbMJn1k3DXDtW93TkvInsdf
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_12,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120154

[Added kexec maintainers]

Full thread starts here:
https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/

On Wed, Mar 13, 2024 at 12:12:31AM +0530, Pavin Joseph wrote:
> On 3/12/24 20:43, Steve Wahl wrote:
> > But I don't want to introduce a new command line parameter if the
> > actual problem can be understood and fixed.  The question is how much
> > time do I have to persue a direct fix before some other action needs
> > to be taken?
> 
> Perhaps the kexec maintainers [0] can be made aware of this and you could
> coordinate with them on a potential fix?
> 
> Currently maintained by
> P:      Simon Horman
> M:      horms@verge.net.au
> L:      kexec@lists.infradead.org

Probably a good idea to add kexec people to the list, so I've added
them to this email.

Everyone, my recent patch to the kernel that changed identity mapping:

7143c5f4cf2073193 x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

... has broken kexec on a few machines.  The symptom is they do a full
BIOS reboot instead of a kexec of the new kernel.  Seems to be limited
to AMD processors, but it's not all AMD processors, probably just some
characteristic that they happen to share.

The same machines that are broken by my patch, are also broken in
previous kernels if you add "nogbpages" to the kernel command line
(which makes the identity map bigger, "nogbpages" doing for all parts
of the identity map what my patch does only for some parts of it).

I'm still hoping to find a machine I can reproduce this on to try and
debug it myself.

If any of you have any assistance or advice to offer, it would be most
welcome!

> I hope the root cause can be fixed instead of patching it over with a flag
> to suppress the problem, but I don't know how regressions are handled here.

That would be my preference as well.

Thanks,

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise

