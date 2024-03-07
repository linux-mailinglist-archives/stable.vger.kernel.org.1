Return-Path: <stable+bounces-27093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F20875433
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AD81C22E90
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3386E7AE43;
	Thu,  7 Mar 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="cWmRyH6B"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F20347A2
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829223; cv=none; b=B9DWiy2DdodTAl9m6lZuGR8alzdHQ1cRtEzG8CWejQz+ANb9Dyl4g4aXx69if2vUUums0stY3mA58gFpY1iCtErdR04pN321TQZfWLzamEnWHgf16NFncMCilEvwVGFkJdGkGYNNIi5wbc6ajnyq7JPO/m9Z3cLzhxtoeg8EcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829223; c=relaxed/simple;
	bh=U1Z2tkgu2fMFZPvl/6LixoDhnirrzlLfHlKIU+w4m7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qla9uU6SWRKX7+P4wD277stWv3H3c8aZP58qworBDNj0AxUI0y/EiBREImpfrrt3oGpLn+IU/fQ4fWy5bJ+UMoswU+542NQy/BjQ28CgvkuvGkeQAzkuDw3uzl2FAtUZimiBTUSKRi4R/VnscU4ZTPkjG+5evc3pb3ZyBxUJ1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=cWmRyH6B; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427Fw8c9012311;
	Thu, 7 Mar 2024 16:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=L+bCcgjNV0jP4EzKldKfLGA3rqj+8jsnx29Ys9iDLZI=;
 b=cWmRyH6B8yGij9Dr6YP9Apm9sIVZbNgXj4G8qZKYSxOxx6LvfiMi6zkv3920BO4zl+yk
 21Ux3h4KjmuPE+beRI3KVkC29Q4a8mX8JYiRgO/UVArP2Z2Ee7m3F9jdodT85w5bu2H/
 qz9yZQmZ6sS0nBhlkHrdT0xGuArLgH8gLbS3l9uAWyQ+fa8dZOm0Zl6C+JQoqind9OQS
 RXzrsMw993ApJkgQl5zf/4CgVp4rZHvZb3XFy2SHfP5hrC/JlvtkjJAqqxgTFGMARzka
 egmVOAN232vzbUQtfMQjQM6bHeXQrl68eEl/ymn+tvLaqpg1DNpJLACB5QoFXnkMDK43 HQ== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3wqbduas3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 16:33:22 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 589F78005DB;
	Thu,  7 Mar 2024 16:33:22 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 814B7800EDF;
	Thu,  7 Mar 2024 16:33:18 +0000 (UTC)
Date: Thu, 7 Mar 2024 10:33:16 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Eric Hagberg <ehagberg@gmail.com>
Cc: me@pavinjoseph.com, dave.hansen@linux.intel.com,
        regressions@lists.linux.dev, stable@vger.kernel.org,
        steve.wahl@hpe.com
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Message-ID: <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
X-Proofpoint-ORIG-GUID: Hg7j_6QEM8L5-LDw6zgw6LXXVpDDmMQU
X-Proofpoint-GUID: Hg7j_6QEM8L5-LDw6zgw6LXXVpDDmMQU
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxlogscore=926
 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403070113

On Tue, Mar 05, 2024 at 05:39:32AM -0500, Eric Hagberg wrote:
> To add another datapoint to this - I've seen the same problem on Dell
> PowerEdge R6615 servers... but no others.
> 
> The problem also crept into the 6.1.79 kernel with the commit
> mentioned earlier, and is fixed by reverting that commit. Adding
> nogbpages to the kernel command line can cause the failure to
> reproduce on that hardware as well.

Eric,

What Linux Distribution are you running on that machine?  My guess
would be that this is not distro related; if you are running something
quite different from Pavin that would confirm this.

I found an AMD based system to try to reproduce this on. The 6.7.7
kernel doesn't seem to have a problem in the machine's existing RHEL
environment.  I think it's likely that this system's hardware doesn't
have the characteristics that bring this problem to the surface.  But
I will be trying OpenSUSE Tumbleweed on it if I can.

Thanks,

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

