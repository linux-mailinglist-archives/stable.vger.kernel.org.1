Return-Path: <stable+bounces-273571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BSRmGcp+VGqKmgMAu9opvQ
	(envelope-from <stable+bounces-273571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 07:59:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E55747654
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 07:59:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=flOktqwq;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273571-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273571-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4142E30099AC
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 05:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723A235F5F7;
	Mon, 13 Jul 2026 05:59:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD162750FB
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 05:59:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922374; cv=none; b=AN8OLQ6JpHlSnGmlV0GHZuoIH1Pe1qtewZDzfLINbd75IsJJ3dvt6oDIhmtLqytkP2jNrSHfNyKAntLtH2+fjyIXfvYDOZ8YctAiKLENj3hBS84nRvBzKTO6QgbLpxT9a2Q+qJvUNsJGRHzl8mxY5/ZagyPQwnq9dakfH1+mmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922374; c=relaxed/simple;
	bh=MBy2QSmiJrt2HCgohTrgmq6jz1DWn5uE7Uj1V+WeRkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNthlksJ4H1BUBV4h4tGwtYx/eJwg7Mvkynm9JBdiJiXZPudVeoMJypxBXi7LiyohD0NbYpL3Vk243Mq5fSfPqgMdmx+mbo3dxYBNGAaCUCWaQt9e9qwhmLPpKGfLfoKPLG7LfyT0MMTsOjhbmS4g2mG8AbFjQW1V+dYVHRSAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=flOktqwq; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3Boa51283829;
	Mon, 13 Jul 2026 05:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NQGmSL
	jz8OekUiFBHyJb/1zvyn7NuBWdUzEly6xuVG0=; b=flOktqwqRvX0qFJyNVk98Y
	xd3fEf6b33kBVxUGVARSF4dIPIq93UZsAr/Mvgu1/5lr8vbV+GMJtFma+/+1jG3G
	OsPN5V7P4VRzXULLgUJHSpfgE7wsSWhvjrYojPnlMQaDjTru5TwDRwbuBrO/SdxV
	ITiTiSPQgPixMsw2BG+rB1/jWGLin9ioGMX9WBzFDLer7YhY55ni4LwkmyboL6FX
	RmvnfGIqRc7lQrv3PYqs6jKmy8WFzuCC6n2tuRj70rON3lYQXRN3VIrY+Ci1RuWH
	JyTL5qxsFGf1KbnSeHVDJV26MDTQaMTQZVU3w/RA+AteMxFLYdGgYJhFgtPXtfPw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fber86vj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 05:59:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D5nfsZ006359;
	Mon, 13 Jul 2026 05:59:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jm9ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 05:59:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D5xHBp30081552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 05:59:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93FE20049;
	Mon, 13 Jul 2026 05:59:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30C9220040;
	Mon, 13 Jul 2026 05:59:14 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 05:59:13 +0000 (GMT)
Message-ID: <91e04278-aa90-4cbc-aeb4-f4663bf1f058@linux.ibm.com>
Date: Mon, 13 Jul 2026 11:29:12 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] powerpc/crash: protect kdump from active watchdogs
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
 <mrvvv515.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <mrvvv515.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1NyBTYWx0ZWRfX10ZIAYzDAvYb
 4FQRuFa1dtTCxN57HqagOPTecHS+e7Da/EWiNSMeDMuIDk9YfdTK1SozvacakSb5Q1Va+o/k6zF
 8uYZD/9/O4pRUh3kxhAAfm42EGk5s5KbvLK46dqQ4MHYv85UMfk09uEp8Aj9EKCltRO0OOWF1du
 Qf8bBbsnFe0bmWEsU6d8z1fcfMvkOtAFuLpc1sviN2sZg9GFIoNLSw8AAA2LpsXskGp5DFBLw+Q
 wkK5yUstT/iSZattuJ2/rHidi+CW7/XH41JE/eZv2GLKLvHTkwsDgDb1iz66b/b5izZGBfoxm6J
 Ksyxj+ERycxB31C24jQklA8O2W7BVMhDxEdkfArnJt8K5xSQZcYHDysf7oAozM2agN6BJf/mwS2
 8ToEtOWKJzWkR57jLw3xMDX39L5u6gRzC27kCatba5VauMJRSxW5YwfsTao3eo6d4pF3iZWpRB+
 zu5lWKRz71DKhEJ0AfQ==
X-Proofpoint-ORIG-GUID: QNfa4UZDELKHg7oMWgpF1vxmwACJTdHP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1NyBTYWx0ZWRfX4L6Q+dce14RH
 oOdP44hwBfDqBrXBJhyqHCeiwjadzZm6aIdpNZtTLQDqs/pAykP9pT3NSKlReAS4NUDjuIjzJr5
 xhH2ifBdx0J8LY+i6OaRVa2pnS//uVQ=
X-Authority-Analysis: v=2.4 cv=TpzWQjXh c=1 sm=1 tr=0 ts=6a547eba cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=mxXqI5Gt1W863cXGw_MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: souf_10N6rLF5rpALs4ycEFTec1Hipmu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130057
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273571-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au];
	FORGED_SENDER(0.00)[sourabhjain@linux.ibm.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:ritesh.list@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:shivangu@linux.ibm.com,m:hbathini@linux.ibm.com,m:mahesh@linux.ibm.com,m:adityag@linux.ibm.com,m:venkat88@linux.ibm.com,m:stable@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.ibm.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sourabhjain@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5E55747654



On 13/07/26 10:51, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> Changelog:
>> ==========
>>
>> v2:
>>   - Move H_WATCHDOG definitions to a common header for shared use
>>     across pseries code. 1/3
>>   - Added a new patch to handle pseries watchdog device registration
>>     failure. 2/3
>>   - Stop active watchdogs in crash hanlder. 3/3 Ritesh
>>   - Add suggested-by tag 1/3 & 3/3
>
> Reviewed the changes and mostly looks good with some minor nits added to
> the individual patches.
>
> Small request -
> Could you please also update test results with v3 in your changelog
> (since you mentioned we are able to reproduce the issue easily with your
> test code).

I tested this fix with the program I shared in cover letter. The watchdog
was successfully stopped even when H_WATCHDOG is called form crash
handler.  I will share my test details in v3 cover letter also.

>
>
> aah one other thing I just noticed since you are ccing stable and you
> added a Fixes tag in patch-3.
> Patch-3 alone cannot be easily backported now due to patch-1 and
> patch-2. There must be a way to define the dependencies if you are
> looking for backporting the fix patch to stable tree, please check that
> and follow that accordingly in v3.

I thought about that as well, but since they are part of the same patch 
series,
I assumed they would be picked together. However, I don't think that 
will work
in all cases.

I checked the older commits and noticed that a backport note was added. 
I think
we can do the same for the fix patch. I'll add a note indicating that the
following patches should be backported first:

powerpc/pseries: Move H_WATCHDOG definitions to a common header
powerpc/pseries: Handle and log pseries-wdt registration failures

Since these patches are not upstream yet, I'll refer to them by their 
commit titles.

Does that look good to you?

- Sourabh Jain

