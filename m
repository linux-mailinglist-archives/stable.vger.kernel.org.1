Return-Path: <stable+bounces-230201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHxPG5XGwmn/lgQAu9opvQ
	(envelope-from <stable+bounces-230201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:15:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9595319DC5
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E10B1301A7EB
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3DB3A16BD;
	Tue, 24 Mar 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UUNcZotw"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FEC37BE6F;
	Tue, 24 Mar 2026 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372059; cv=none; b=uPsb1uyfND+pJeGjA8gsbkU1dbU6swC+HFbmTTWqxJxsOrDcUxtvU6E6qRGCKXkroBi5/wC93aUGuwZxKeE4RRlrpSs178W0SchMZWUTUs6plzM7aJqlpDx6d7OSwJ1QTIuVKJCeHvuiVZMFjZnNlh/FFnmb2HAWpmAJPuCjK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372059; c=relaxed/simple;
	bh=AGYlylnlSsCLS69ApRan4I8w6WUxlpyQvLSi84VbGf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUrqnB1mwlKErFBQ+WPsSo+X3fRp1uTrLesaA2pfwmfpZqBOD707xBN9GQSjY9wvsBwrrIw3hO5QsDilgpz+XiynKSCbRbqe6Dp2VPgwCTrdRBlUj7XEZT1ZRPVGmuB3GPsIhbwI99qo9EudFgmGFRs8TrI3lnUs1bOgIxoLDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UUNcZotw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O5eHsp4120967;
	Tue, 24 Mar 2026 17:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=uxTqQzn37zq82dyIWyZSBRTBU/irP5Ew+hiSH8++MUU=; b=UUNcZotwXPtc
	ul+XeZcsT7JRizh2OYlz1VafGDPFo/Dxsk9zEhNyu3PS6UvCytB7Ar3c0lhlWwRp
	OE9RbIYV4MMdISKN2+mTbBqZ2b2WhpI+NCke1JLGKWRvWgY3CrTtChF1Qu+4wKI/
	wsz/VmQ43hLKVhcm3PWOKSODLSQdLNh8I4tuQuM9T5VVqc54JUe+PNVbiXRatwtg
	fknIbXtoaAt9HQV3/tr498UH1Tipl3Qi4JRDvGe9G58lTlBpB4wfNzUj78glwPN3
	xeSS4eqFMWduZPWtsG4zfT3b4gw4cisTdi21m7Sse6yHscOva9uNDfyEk39UedfU
	hVPZUqs7Eg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9vr67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:07:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OFVmZ9005996;
	Tue, 24 Mar 2026 17:07:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yk23e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:07:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OH7BIa45089256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:07:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FCB72004B;
	Tue, 24 Mar 2026 17:07:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08D1820043;
	Tue, 24 Mar 2026 17:07:11 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Mar 2026 17:07:10 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1w55Di-000000094zn-2xqM;
	Tue, 24 Mar 2026 18:07:10 +0100
Date: Tue, 24 Mar 2026 18:07:10 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: schnelle@linux.ibm.com, alifm@linux.ibm.com, bhelgaas@google.com,
        dtatulea@nvidia.com, helgaas@kernel.org,
        intel-xe@lists.freedesktop.org, ionut_n2001@yahoo.com,
        julianr@linux.ibm.com, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux@roeck-us.net, lkml@mageta.org,
        lukas@wunner.de, mani@kernel.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        sebott@linux.ibm.com, stable@vger.kernel.org, sunlightlinux@gmail.com
Subject: Re: [PATCH v10 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA
 deadlock
Message-ID: <20260324170710.GA252856@p1gen4-pw042f0m>
References: <f17b03652a84be73c1d3a2cfea8a016dab99f8e0.camel@linux.ibm.com>
 <20260319202755.16081-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319202755.16081-1-ionut.nechita@windriver.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: rY4fF4ZcHAzawRmmUo057d8sT-U_YyZN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzMCBTYWx0ZWRfX1bWxugcuXBai
 E41K0wNRWoRBPEiVTuTOhEcE9wVlKL2/pg7193xc+rvSLYJkzqmW/aWJOa9cJ6M3xg9f6ugz3Y8
 u/j8L3kR/WTS46CsN2edHYoYJqzfn0t+Fb3zLtJKeeAyBFsaULTSbiMivaO1RX4mBjcF9Qk9kYG
 X0Z7zKsKJEd7wfqQUX9ZSFJs25xlX0S/Fsb1xe8ZbK3Qui5eu0lbNhvUesSrfamVhX8iw3fuN5X
 v5qFrhW9hrqJ3qumA1RI7x3VSow1TjBqe533/xJ7aINrIrX+Q/MPdY6twziEVwCGR+Q/AyDgkJD
 HhjqUL2gIikTP3Im1q/B0NexVz5m1WugfjpQRsp3BJL9mV9ac0/m8bLUPxq83/sIeVR2mTEyzcj
 JteAZwhkTB7tOv1ttyFiOA6y3KmEIjov1bPb7iFCfBvMVjCkz7tip6xNKtvupQ4+X+ocDLmsixh
 gqBhsA8J+six0MJcb6w==
X-Proofpoint-GUID: mayWfXcezXzQ0RCPJmiJH_6HnV5S1zrz
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c2c4c6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=x-Aaag0WYKWWV6Rne_cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240130
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230201-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,google.com,nvidia.com,kernel.org,lists.freedesktop.org,yahoo.com,vger.kernel.org,roeck-us.net,mageta.org,wunner.de,intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bblock@linux.ibm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9595319DC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:27:55PM +0200, Ionut Nechita (Wind River) wrote:
> On Thu, 19 Mar 2026 13:31:39 +0100, Niklas Schnelle wrote:
> > For your awareness, I saw that this series has some findings on
> > Google's new Sashiko AI reviewing tool[0]. At a quick glance the
> > findings seem like at least reasonable concerns to me. I'm still
> > looking at this independently also of course.
> 
--8<--
> 3) TOCTOU Race Condition / Lock Window Vulnerability
>    — a driver can rebind between device_release_driver() and
>      pci_stop_and_remove_bus_device_locked()
> 
>    This is theoretically valid but practically impossible. The
>    window is a few instructions wide. For this race to trigger:
> 
>    a) device_remove_file_self() has already removed the "remove"
>       sysfs attribute, signaling the device is being torn down
>    b) a bind_store or udev probe would need to fire in exactly
>       that window
>    c) the newly bound driver's probe() would need to call
>       pci_enable_sriov() and block on pci_rescan_remove_lock
> 
>    This is the same pattern used elsewhere in the kernel (e.g.,
>    the existing remove_store already had no synchronization between
>    device_remove_file_self() and pci_stop_and_remove_bus_device_locked()
>    — the patch just adds one more call in between).
> 
>    If this is a real concern, it would need to be addressed as a
>    separate improvement, not as a blocker for this fix.

I haven't had time to fully review all this yet, but one quick comment: after
the first idea to unbind the device driver I also realized we could have a
race here between unbinding, and then possibly re-binding. We could probably
prevent that by marking the device as dead:

+	if (val && device_remove_file_self(dev, attr)) {
+		device_lock(dev);
+		kill_device(dev);
+		device_unlock(dev);

This doesn't modify the reference count or anything, but only sets the private
member of the `struct device` `dead` to true. This can't be undone using the
device core's public API, and once set, a device can not be bound to a new
device-driver.

This should prevent any such race AFAICS. The unbind is protected by the
device-mutex, so once the flag is set, and the unbind is done, this device
will stay unbound.

It's not really "pretty" though.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

