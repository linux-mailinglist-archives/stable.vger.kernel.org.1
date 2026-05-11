Return-Path: <stable+bounces-245197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCTCJPDRAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:56:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF6750E557
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1562306D973
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E157339BFF4;
	Mon, 11 May 2026 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qgrl0bgs"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC083A1E95
	for <stable@vger.kernel.org>; Mon, 11 May 2026 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503623; cv=none; b=oiZpCulWyjscu+Y0oYd5snXvIwJQ2PUoxUjWKBQg9+tM6nbGTn0jeKBSDWfKEZ0IyeNTDZYoFK+adZlkGJFoQoby93U2S/BXsmPl7PktIL14VAHLZeJf6ffj68nbUTako/PaglmCdFA6+yv6wBjA74iyON3ohJRf+9HxEb8cUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503623; c=relaxed/simple;
	bh=8v98h1umxeJxxw4itTnLm7PtLCnoi0c1iRO9WBKqjkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzNVX0djpQqIKpKK30fsaHkkhBf7jzb2ZqJ8gG9S0WcbLWv4IvYGPrVnQXn3xnTslihqR/R4kPQxazw0f69QrJRdIK8jx55CENL63KIqK2KK6DwYJfzlmOdNeLxyboWR4yTk0PDCoz9S1VMMnoXsHw8IV6WPvOy+fWYzf4l1XeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qgrl0bgs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B8r40k2368922
	for <stable@vger.kernel.org>; Mon, 11 May 2026 12:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cJ3EVk
	l6DraskVPAivBI8d4z/pnih2EwPwlrFptGNeA=; b=Qgrl0bgsVBV2Z1xgpibWnd
	wJPo9CDSDxwHIITFb4+Yfs2ZUcqQBQWJbIoqUhgpAODBQDTHaCMqNRenaPvuK8zX
	mAaxxxNjvg3/SLx+/4owbIi65qTKtu/AlClA3VBS9MykZDWgNt8OcMpPi8BU+BRt
	OlVcTc3Tq/X6XnAF1SBDm9o9YJNxcWaDoiPTFZlifA+yeZNwj+ThP7RWJTL9r8Cu
	DZ/GsqI21MtjKQl39hXWy0fQFYdETiXnCAOUrzklsNb18rSyZnM8+mVjtvrUr0j7
	SpsJ2vAGYhMZ7ZhZA37ayGRUeaHh6UUrcQO5p6ooZFVT1/Ue238oP2yrqF4zCeVg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4r8r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 12:47:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BCdTbE020475
	for <stable@vger.kernel.org>; Mon, 11 May 2026 12:47:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2grh56e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 12:47:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BCkteu52232638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 12:46:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13F5A20049;
	Mon, 11 May 2026 12:46:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 882DC20040;
	Mon, 11 May 2026 12:46:50 +0000 (GMT)
Received: from [9.39.26.74] (unknown [9.39.26.74])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 12:46:50 +0000 (GMT)
Message-ID: <726fd09c-0b08-4da2-a5c5-981f4c4970b4@linux.ibm.com>
Date: Mon, 11 May 2026 18:16:49 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/iucv: fix UAF in afiucv_netdev_event()
To: Heiko Carstens <hca@linux.ibm.com>
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, sidraya@linux.ibm.com,
        hidayath@linux.ibm.com, pasic@linux.ibm.com, mjambigi@linux.ibm.com,
        dk@linux.ibm.com, twinkler@linux.ibm.com, jaka@linux.ibm.com,
        wenjia@linux.ibm.com, gbayer@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com, stable@vger.kernel.org,
        syzbotz+89435e7383b82238dd91@linux.ibm.com
References: <20260508163836.2207648-1-nagamani@linux.ibm.com>
 <20260511090234.9589A54-hca@linux.ibm.com>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <20260511090234.9589A54-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a01cfc5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=GT7X7vSS5ZSHD5DRrRUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0MCBTYWx0ZWRfXyhv97zF/4MyO
 vUOSXXIC6r78mUjHbb14QZzechthUCcybFHO/nanWIN2CiyibMHhlZemG4vvhzscg7ESsIktnia
 vSmkwDc2CS9f+RV8T9IP1cYksop5GrW31HjlbHLAarxXB0MiFMLH/GoaeAsy7OzoCQVQUT7kUa2
 /GffwpEStMLmYDt/7tv3RxTDuaAx5IJD2MPSik/A76bJRLC2OEN0EIXJJNj/sNvf8Do+VJ03oHe
 hFEAQWIM49mXRDOss3PSm0sTulhsBrCMSIcw/YdQBtrl2wxKETZOyT3gTLiWvpzRfbyVH54TVUO
 +4MtEVhuFUGKzkT0nUQqqjkLEmVNMcL7Ee25I/CUapU5CjpIrZNPebZO8w2JCS7yO2jqnyVJRsk
 QPaXSDSqs8t5vkNpH3MvNPwXCHhZ9aOSicek+5+Fwhqs0TfBa86zKo4q8tbVR/QkhSSQrxLvT2o
 k9HzA/3j7NzczSQUqZQ==
X-Proofpoint-GUID: b5D08Md0QymXzh19IG1fGFkTgh22s3Js
X-Proofpoint-ORIG-GUID: b5D08Md0QymXzh19IG1fGFkTgh22s3Js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110140
X-Rspamd-Queue-Id: 0EF6750E557
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245197-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nagamani@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,89435e7383b82238dd91];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 11/05/26 2:32 PM, Heiko Carstens wrote:
> On Fri, May 08, 2026 at 06:38:36PM +0200, Nagamani PV wrote:
>> afiucv_netdev_event() traverses iucv_sk_list without holding
>> iucv_sk_list.lock.
>>
>> A concurrent socket teardown can unlink and free the socket via
>> iucv_sock_kill() while the notifier path is still iterating over
>> the list, leading to a possible use-after-free when dereferencing
>> the socket.
>>
>> Protect the traversal using the existing read-side lock, matching
>> the locking pattern already used by other iucv_sk_list traversal
>> paths in af_iucv.c.
>>
>> Use read_lock()/read_unlock() to remain consistent with existing
>> softirq/tasklet-side readers in the same file.
>>
>> Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
>> Cc: stable@vger.kernel.org
>> Reported-by: syzbotz+89435e7383b82238dd91@linux.ibm.com
>> Closes: https://lnxgwne1.boeblingen.de.ibm.com/linux-ci/syzbot/dashboard/bug?extid=89435e7383b82238dd91
> 
> Please don't add IBM internal references to commit messages. They are
> useless, besides that they will go away rather sooner than later. Better:
> add the _relevant_ parts of the crash output to the commit message, which
> allows people to make verify if this patch is actually fixing what the
> commit message says.
> 
>> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
>> index 72dfccd4e3d5..e8a0b55fc55d 100644
>> --- a/net/iucv/af_iucv.c
>> +++ b/net/iucv/af_iucv.c
>> @@ -2188,6 +2188,7 @@ static int afiucv_netdev_event(struct notifier_block *this,
>>  	switch (event) {
>>  	case NETDEV_REBOOT:
>>  	case NETDEV_GOING_DOWN:
>> +		read_lock(&iucv_sk_list.lock);
>>  		sk_for_each(sk, &iucv_sk_list.head) {
>>  			iucv = iucv_sk(sk);
>>  			if ((iucv->hs_dev == event_dev) &&
> 
> Are you sure that afiucv_netdev_event() is called in either tasklet context
> or with bottom halves disabled? Doesn't look like it to me.
> Read: most likely this should be read_lock_bh() to avoid deadlocks.
> 
> But then again I might be completely wrong, and lockdep says that this code
> is actually correct :)


Thanks Heiko.

You’re right on both points. I’ll drop the IBM-internal reference and add
the relevant KASAN/UAF details directly to the commit message.

Regarding the locking: afiucv_netdev_event() is invoked from the
netdevice notifier chain in process context without bottom halves being
disabled. Since iucv_sk_list is modified under write_lock_bh() and also
accessed from softirq/callback paths, using read_lock_bh() in the
notifier is the correct and safer choice to avoid lock inversion.

Thanks Alexandra as well for confirming. I’ll resend a v2 with these
updates.


