Return-Path: <stable+bounces-26996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0255873B24
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 16:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D80F1C21729
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E3E1350EB;
	Wed,  6 Mar 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ZYvgsqte"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34B3134CFA
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740230; cv=none; b=TZHzq+KpodCgdbBNMFaXxJaspas2utRlE0p1VQe1sYK9tGlMrf1HV8uyZs8Xvs71LT0yPbF/paD/LoqaTuYvzMPwQRHrAps5wViCa3fNinPCSsUYA9Jr/ZX867ftwFFZUnQQTiLJpJbSymfyZhZ0+4DQd8xlzMC/Z4DzkG84oUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740230; c=relaxed/simple;
	bh=AeFKNDyufYQljwBUeIgK+otzg9MkS4iRGuHBpBsgW6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfaGyeTuNa6dMcvyAswcysebDENqhncvgzkLM+PacnJbusAQYHhE8STJtpUr4Iaik0n8l2sHL0vDGqKWFhAiRiULGFZZit/C89HloxKami7BJEJDOUY1bT4K1JgKYkCtbX2m+RWcVEYPIp43U0Ot/X6xswyPdeGG/D/9FPG472M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ZYvgsqte; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426CNQTs018137;
	Wed, 6 Mar 2024 15:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=wZcH8M55Q0s2R7amk7YA8kSGmRiMypgeUF+SkoZdp4s=;
 b=ZYvgsqteqBzePo8tIBj4locYQtc2xFvasiYABC4OJ44bSLuzhMz97w/DE5F3LiAsFw5c
 epfiJziMg/kEQnJVqetD0/S3Rnb+4OYNbVhQtUkyVUmOsTE/t8ReJ7KREZdpTflwOOZK
 SuZgLQdA4EeFt5MY1m3AH0a+WbbHJ1rv+qPudKamDL0y0XeeRslEqn3ABjMtM9hG/cuw
 BS4rl8qGFa6TOWrnbeagDUDHQENEwjIWnWxvXdvOmeqBOINAGsCFxOQufOE/w9GIFnx5
 wDv1w3MZR8LRXzd1IDJ+TETUT5Xg+GD/EEqZ+qdwgD+JChQUzLPE86rrSclxWxBIdKgT ig== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3wprembp47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:50:11 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E5EEA8059F3;
	Wed,  6 Mar 2024 15:50:10 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 343C68013A7;
	Wed,  6 Mar 2024 15:50:09 +0000 (UTC)
Date: Wed, 6 Mar 2024 09:50:06 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Pavin Joseph <me@pavinjoseph.com>
Cc: Steve Wahl <steve.wahl@hpe.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
        Eric Hagberg <ehagberg@gmail.com>
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Message-ID: <ZeiQrugG6Pfdb4KW@swahl-home.5wahls.com>
References: <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
 <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
 <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
 <ZeO9n6oqXosX1I6C@swahl-home.5wahls.com>
 <f264a320-3e0d-49b6-962b-e9a741dcdf00@pavinjoseph.com>
 <ZeXzoTjki+1WR258@swahl-home.5wahls.com>
 <fe72c912-f1a0-4a53-88ab-b85e8c3f7bd9@pavinjoseph.com>
 <Zec5Ubr7G9NbnIyq@swahl-home.5wahls.com>
 <294c28ba-25c2-4db4-9dea-616ed1e2ea30@pavinjoseph.com>
 <69698702-ae58-4bf8-b8fb-ff4a36c3df77@pavinjoseph.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69698702-ae58-4bf8-b8fb-ff4a36c3df77@pavinjoseph.com>
X-Proofpoint-GUID: lK0Ow8SRBUPSg9LYII5-CnuK5CQNjWDF
X-Proofpoint-ORIG-GUID: lK0Ow8SRBUPSg9LYII5-CnuK5CQNjWDF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060127

Pavin, thanks.

For my part, I've loaded OpenSUSE on two different systems but have
not succeeded in replicating your problem. I am still working on that.

The systems I have in hand to test this with are Intel, not AMD.  Eric
Hagberg's report (thanks, Eric!) of seeing it on a PowerEdge R6615
(which also appears to be AMD) suggests to me that AMD systems might
have something different, like a different set of commonly included
devices on the motherboard, that affects what regions are included in
the identity map and makes us trip up here.  I will look harder at the
logs Pavin supplied to see if I can glean any differences, and maybe
see if I can locate an AMD system.

--> Steve Wahl


On Wed, Mar 06, 2024 at 08:39:38AM +0530, Pavin Joseph wrote:
> Hello everyone,
> 
> I tried optimizing the new stable kernel 6.7.8 for space but that did not
> resolve the issue.
> 
> pavin@suse-laptop:~> du -s /usr/lib/modules/6.7.8-local/vmlinuz
> 10496	/usr/lib/modules/6.7.8-local/vmlinuz
> pavin@suse-laptop:~> du -s /usr/lib/modules/6.7.6-1-default/vmlinuz
> 14012	/usr/lib/modules/6.7.6-1-default/vmlinuz
> 
> Kind regards,
> Pavin Joseph.
> 
> On 3/6/24 01:28, Pavin Joseph wrote:
> > On 3/5/24 20:55, Steve Wahl wrote:
> > > In the meantime, if you want to try
> > > figuring out how to increase the memory allocated for kexec kernel
> > > purposes, that might correct the problem.
> > 
> > I tried all the options and variations possible in kexec. Don't know how
> > useful this is but it seems there's a hard limit imposed by kexec on the
> > size of the kernel image, irrespective of the format.
> > 
> > pavin@suse-laptop:~> sudo /usr/sbin/kexec --debug --kexec-syscall-auto
> > --load '/usr/lib/modules/6.7.6-1-default/vmlinux'
> > --initrd='/boot/initrd-6.7.6-1-default'
> > --append='root=/dev/mapper/suse-system crashkernel=341M,high
> > crashkernel=72M,low security=apparmor mitigations=auto'
> > Try gzip decompression.
> > Invalid memory segment 0x1000000 - 0x2c60fff
> > pavin@suse-laptop:~> file /usr/lib/modules/6.7.6-1-default/vmlinux
> > /usr/lib/modules/6.7.6-1-default/vmlinux: ELF 64-bit LSB executable,
> > x86-64, version 1 (SYSV), statically linked,
> > BuildID[sha1]=cd9816be5099dbe04750b2583fe34462de6dcdca, not stripped
> > 
> > Kind regards,
> > Pavin Joseph.

-- 
Steve Wahl, Hewlett Packard Enterprise

