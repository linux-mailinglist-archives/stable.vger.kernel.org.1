Return-Path: <stable+bounces-27534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C784879E1A
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 23:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F31A1C21033
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A5A14375A;
	Tue, 12 Mar 2024 22:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="IWgrNNoL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B82142636
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280977; cv=none; b=iUwV1tJhpvqJtbA3awU6+zXncgOn5papXX35vuGvxByoiIQADGdBzcUMlCRnk6muAq/6rAEBIRHxKcYABSVs+sT3C+zfih+aI+s1BISr7XvAawFf0WLdUYjb25ULZmpqQZtOMYSueIuzBzZ+O+Coz2W+i7Us8hDE0Ythg4IV7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280977; c=relaxed/simple;
	bh=NIpadVgmIMc4eJ5HzL87jmlPi6Cnq8lk4PIKggkREzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l3DLcCMUZ2Xt012P9yY+nU0qrYb0pMdAQd8fQ2yX/S/ocDF5v4q17gyrGoHZ5Gnu8g3xkjbcxGIWmNFcP2KTgdaGVjBoRg11OAqaRo3GvCjzhw7UxZNAmwCpNxv+u6jx4FTLLbJ5fVrRB5C9F64S3lohMPSD7Gj5o9uysG64i3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=IWgrNNoL; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CKsYa2019505;
	Tue, 12 Mar 2024 22:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=uxe6i6hGgOKOpq5leYsB3kltqxDst/MLHuGk9MswOl8=;
 b=IWgrNNoLu+PwkoncOgis8ahHkYiebda1uxWHm4zis4tiTUUZAWJyd46fz0PrczShaIFr
 Cvcr1MkvjzqLG6bqkX1nYx57MX9DmaHZHemPgA8a1IzG/VPp+Sos7THZBfU6FY8S3qAy
 muspVoyVa/zoCSw2EiIcQVcnNH+7dHycFoHyjTpqW8Wv8/3iCI7FExo7o3tlRYVq5x0Y
 DRXxBNguS1e/2XKLyXcqEExTgDeEWeQx+4oqLqWfNZ6JQ7e3pb5bD9Pvc2Bj7w2KmX01
 elHbZSzdNVbORouhsSBF1Htke4OOI/Gn1SyXN8JYife1N8vUcIXkytaqRUFd3oqZ3BG9 sQ== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3wtrp4v1ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 22:02:29 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id DCBF113046;
	Tue, 12 Mar 2024 22:02:20 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 9AF0980ACA7;
	Tue, 12 Mar 2024 22:02:08 +0000 (UTC)
Date: Tue, 12 Mar 2024 17:02:06 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Pavin Joseph <me@pavinjoseph.com>, Simon Horman <horms@verge.net.au>,
        kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Eric Hagberg <ehagberg@gmail.com>,
        dave.hansen@linux.intel.com, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Message-ID: <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
X-Proofpoint-GUID: Swfg6-ue_4c6zP5JebHYUhn-0M5yfpKJ
X-Proofpoint-ORIG-GUID: Swfg6-ue_4c6zP5JebHYUhn-0M5yfpKJ
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
 definitions=2024-03-12_13,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1011 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120168

[*really* added kexec maintainers this time.]

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

