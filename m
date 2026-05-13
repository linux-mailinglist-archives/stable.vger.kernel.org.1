Return-Path: <stable+bounces-246785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJcYHqY2BGoqFgIAu9opvQ
	(envelope-from <stable+bounces-246785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:30:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB6452FADC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F413009B03
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703C38AC78;
	Wed, 13 May 2026 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="emxQHV4W"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D39399368
	for <stable@vger.kernel.org>; Wed, 13 May 2026 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660973; cv=none; b=sip5eewWyo5pjFHJJI+QLsYeY4AyVpC6KFQHFp+LChYXBsle0S+7414Bc6OWMpT1/G0maQdK1U9Dtv3kM3nWpKt4QXPh9ki9LxFBUx4Vk0ugH+xErY1lbmRXnvt1KTH4wxaGpck4JtNL40JzG8SWuKAOnWs6OxOyRkImekD4KlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660973; c=relaxed/simple;
	bh=p4AvgJKPdvsKwZpaz06KxtGMxPTnEBc59ccrVD4SBp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSgEOoQweqvlD63pGYPDIQkRsEbugzC5uboN34ilG7vp4rWw3FcXqg1sjL/0+2sUosTVKVek8541dIEiM2aWNPOAJ3loBVCMJnCXm1bBxLYmE6d94ldAZxGasE6OonEn0tomVhMNDQwucrPIlMkcbTxYXj7ctRrlSS9LuCdflGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=emxQHV4W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D0t4or3185878
	for <stable@vger.kernel.org>; Wed, 13 May 2026 08:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aH63dj
	+i+OPRq3NtvOAWLuvWNpKijnF6gR7J3vuz4Cw=; b=emxQHV4WB8R4tMwI+u83Wn
	4TDIyM7HL/QI0IDlbb6FAeQdd6g/MG/pPEgNmrq2A/Vr6LUATq9XW2mpOrTeUD10
	uhJAc3OEsSZkDw0908wzxpeByCQNYo7igdg8LUiUUzLAbp/ywYvNPLv7R5B1zG1v
	CKRnEoKEBfYMJFIIcUuwAD4qZ3nl1OOfQhvMyt4BIP85j88eEyPjAkn/6WMh7TUs
	IWdU+K0kACdZkbyS0ztRKycrm5qItU7UONApSSY/a+iNYr4Nj91V4RclcDVQaW+x
	NKkI7/Hv1aoyohOyKjcTv3WJKsPVEIctNPsQIM2ZQaNHvDvxdWXtpbMS/xQmuDeA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5etuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 13 May 2026 08:29:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D8Ob4F032657
	for <stable@vger.kernel.org>; Wed, 13 May 2026 08:29:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgpwwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 13 May 2026 08:29:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D8TPXH49873314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 08:29:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54FAF2004D;
	Wed, 13 May 2026 08:29:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E274D20043;
	Wed, 13 May 2026 08:29:24 +0000 (GMT)
Received: from [9.111.205.243] (unknown [9.111.205.243])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 08:29:24 +0000 (GMT)
Message-ID: <a4abf54e-0b4a-4bb0-b752-bf9dc38a913a@linux.ibm.com>
Date: Wed, 13 May 2026 10:29:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] net/iucv: fix UAF in afiucv_netdev_event()
To: Nagamani PV <nagamani@linux.ibm.com>, aswin@linux.ibm.com,
        sidraya@linux.ibm.com, hidayath@linux.ibm.com, pasic@linux.ibm.com,
        mjambigi@linux.ibm.com, dk@linux.ibm.com, twinkler@linux.ibm.com,
        jaka@linux.ibm.com, wenjia@linux.ibm.com, gbayer@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com
Cc: stable@vger.kernel.org, syzbotz+89435e7383b82238dd91@linux.ibm.com
References: <20260508170534.2208812-1-nagamani@linux.ibm.com>
 <db4a5413-4844-4336-aa6c-5e7a29bb16ea@linux.ibm.com>
 <2efe3303-32cb-4e91-93db-9e78848c642f@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <2efe3303-32cb-4e91-93db-9e78848c642f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a04366b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Qq43EEmGwKnI1f7h4L8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PEigcI_uIJwf7OV5b1fVCho6F6pfiunb
X-Proofpoint-GUID: PEigcI_uIJwf7OV5b1fVCho6F6pfiunb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4MiBTYWx0ZWRfXxqL3zu4/DQ/h
 J6cS2NkIBfyADhjGfKWZ+eSPcpsUpTh2FbcedlH3ue1J5EmpLpHzsUgEuY9JSqwIfNDxT2kcgYh
 Wk3rseHxyLxy5R5K0sFlmKyehwVf9llToUNsmKQx7GkPIXqRjWSXXX0EWxrCjq1zQ0zhRq2X7gh
 VHnYZTO5W0NMgvMZo0sBsaoSormUcZmZh97rJBBEDyIxNH/C3co4CT4xBgBX1kiXyQEi9JlnDaf
 c5RW/srHgWqxitiCymt/qB8ynSY0CBT+xqxdlUUugDYjNq/91p5/1f5nYkzGK6kNWFUfA9cRotp
 qCKsSB6ybyll/CIdUAL00B/MEEHOMePHwOEh3759uS7abgzwHJKR7fvAMflL0bMIXhSVkfSdyLl
 yKhfpBh1d/0zQJlWAX3+PCxGFXFDpu1BHNfuCfqDTLRBJ1EGakGJ4O8wHDdrpILKXDccx5wItkg
 VgXiSKQPwmhgUFGGh5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130082
X-Rspamd-Queue-Id: CEB6452FADC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246785-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,89435e7383b82238dd91];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 11.05.26 15:38, Nagamani PV wrote:
> 
> 
> On 11/05/26 2:41 PM, Alexandra Winter wrote:
>>
>>
>> On 08.05.26 19:05, Nagamani PV wrote:

>>> Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: syzbotz+89435e7383b82238dd91@linux.ibm.com
>>> Closes: https://lnxgwne1.boeblingen.de.ibm.com/linux-ci/syzbot/dashboard/bug?extid=89435e7383b82238dd91
>>
>> This is an internal website, so we cannot report it upstream.
>> I am not 100% sure how to handle this case.
>> Note that Heiko said, it's ok to use Reported-by without Closes, even if checkpatch complains.
>> (He was referring to Reported-by a person, though).
>> I would add the KASAN report and remove both tags, if you ask me.
>>
>>
[...]
>> I agree with the analysis and the patch.
> Hi Alexandra,
> Thanks for the detailed review.
> I’ll simplify the commit message to be less verbose, include a relevant excerpt of the syzbot KASAN report, and remove the internal dashboard link. I’ll keep the Reported-by: syzbot… tag and drop Closes: as suggested. 

I don't see the benefit in keeping the Reported-by, I don't think our local syszbot reacts to that. But no strong feelings.


The fix will be targeted to net, not net‑next.
> Regarding KASAN: the issue was detected by a syzbot CI run with KASAN enabled. The report does not provide a standalone reproducer or named testcase. I did not rerun the original CI workload, as no reproducer is available; the fix is based on analysis of the reported race and the syzbot KASAN trace.

Now that you understand the path to the UAF, can't you reproduce the KASAN warning yourself?
Can't you write a bash script (tela tc?) that triggers this? Probably by looping instructions for some amount of time.
Then run this script against the fixed debug kernel, to see that there are no other gaps in that area.
(Later you can decide whether it makes sense to add this to CI)

