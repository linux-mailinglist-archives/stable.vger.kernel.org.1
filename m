Return-Path: <stable+bounces-245228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDzjLnfiAWq1lwEAu9opvQ
	(envelope-from <stable+bounces-245228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:06:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2126C50FA9E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E19973009501
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270953F0A88;
	Mon, 11 May 2026 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DT46Shop"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D723F54AB
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508259; cv=none; b=XYd+URhdYq9M3I0BLhQ3Nds59RC4OCk51kKSdLDIsctlGb1K7WNuZZybqgbzO/DsNWrtJHpaj1JwCGasbC5MnbSYkPQqA0NIpXFOL8HTXQ3OLvgYlrLD/58KPq+JxABL0gXujkKoFmxNNvNLwgjyLwcwct+TXOQkHiPSKvQdk9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508259; c=relaxed/simple;
	bh=S+311uJMJYr97xeuLfKyaISZazETY8CLJpyrv6RP1fE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qkCals25gNOlVOu4brjSs5I/1vA1gTEamUeN+V7tgCN5RiZRUy73Md/gw12PildOraLBpRUoaErqKNppLc3LP3CKs5eJzranoGuCvCpm/zSX7KD8dYVhXcFuygJ11oiogxYfNDV/J2zMZgkC6YkVprpNaMUPp+q6DUx4qZQEOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DT46Shop; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B8U3OV2306345
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZesvbD
	NdF3JFEbZpbULJkQ44qhkb9+HZYwJVCsOkiS4=; b=DT46Shops+mncxX0c5OWWp
	Bmj7kFbWNnGTdYuUE7MNu+jPqHbVdpfRHi8kkHqxMsD3easkKsipiQxuJlJPxOXd
	37TREGDuBx79QsK7C+RdY2FcK0gXLE1p8jS0LpsVEVmij2DnELKUxJZ+rdt7bHsv
	fAtRnKqJaNbxPg8zV6bHnP+vVn+nKiyGBM4f/lyzSvK36LNkLTTTGB6gPeiRZiM5
	LMuOY49ERfQ9EQchP0U/ilee/3Y/D568fNIaDkhcDllYVPHlUXPKAOFQ3DPX4VpB
	K3lO+BVT14Nn1hQoLAPObEelWb9r6NDI7+65xLBOkx2hON9XBubFxjDl2Qi7mGRw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4rk78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:04:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BDsQi9003082
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:04:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvwmv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:04:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BE4BkG26673652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 14:04:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EE3720043;
	Mon, 11 May 2026 14:04:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 649FF20040;
	Mon, 11 May 2026 14:04:11 +0000 (GMT)
Received: from [9.52.200.120] (unknown [9.52.200.120])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 14:04:11 +0000 (GMT)
Message-ID: <ce7ac073-62ef-4ca4-b325-eef7c829292d@linux.ibm.com>
Date: Mon, 11 May 2026 16:04:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steffen Maier <maier@linux.ibm.com>
Subject: Re: [PATCH net-next V2] net/iucv: fix UAF in afiucv_netdev_event()
To: Nagamani PV <nagamani@linux.ibm.com>, wintera@linux.ibm.com,
        aswin@linux.ibm.com, sidraya@linux.ibm.com, hidayath@linux.ibm.com,
        pasic@linux.ibm.com, mjambigi@linux.ibm.com, dk@linux.ibm.com,
        twinkler@linux.ibm.com, jaka@linux.ibm.com, wenjia@linux.ibm.com,
        gbayer@linux.ibm.com, linux390-list@tuxmaker.boeblingen.de.ibm.com
Cc: stable@vger.kernel.org, syzbotz+89435e7383b82238dd91@linux.ibm.com
References: <20260508170534.2208812-1-nagamani@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260508170534.2208812-1-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a01e1e1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=VxHW02VjvWZeiVljZOcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1MSBTYWx0ZWRfX56Mq16ZrkZkn
 j32Tl7XL6tyQc9XJgT3qbOXcE4q89c3i6Xz30KIUTdS+7hOoSS9ATbX6s4efU3pcYyAWS0DqU4w
 KAvGsuuY/kqhgkRiCVJbDteTeGVY+wGkSjD5hEX9oCYwmjK7rsVbqkJMITNsJ4dysiOMjlZUJ5T
 KhWLlF7YmkYuqi1FfPdK5udSLuVbEAPEr/RjAG6tYl4/KpQn9AD3FpsKFgHsDFSETKT56BkDmUl
 KmywpZApcR6cmWP9/VHP8s8I79Xm9UNOOgyxSRrFb/3UzwjpJN9d6BjGSv7Gy902KspTVUPG5uL
 HkJOiEgIZXWIJwxgaj+z+g2aQQI0qduIQQyzDShKIQI1CBrrvw0vxNPYzpfnLZKuDZos2QbF5u8
 mRajBRpdj686InMI1bP+xIA4tQpA7ZJDJpr+H3LJpAU4iY2J8TTWfeq6L98nFGapn77cdACJ73q
 pTGYtAPmC9FO71eOkjw==
X-Proofpoint-GUID: Tx3rvXP_F9c3AE4psKfePFvmUHUO2qvZ
X-Proofpoint-ORIG-GUID: Tx3rvXP_F9c3AE4psKfePFvmUHUO2qvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110151
X-Rspamd-Queue-Id: 2126C50FA9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245228-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maier@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,89435e7383b82238dd91];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On 5/8/26 19:05, Nagamani PV wrote:

> Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
> Cc: stable@vger.kernel.org

> Reported-by: syzbotz+89435e7383b82238dd91@linux.ibm.com

Not sure: Is that our IBM-internal syzbot from our Linux on Z project?
Are we allowed to expose this publicly and would someone external even have use 
for links to IBM-internal finding reports?

> Closes: https://lnxgwne1.boeblingen.de.ibm.com/linux-ci/syzbot/dashboard/bug?extid=89435e7383b82238dd91

This looks like an IBM-internal URL, we might not want to expose to the public.
We have one specific tag "Reference-ID" which stays internal and is not sent 
upstream.
Do you plang to remove your "Closes:" before sending upstream?

> Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
> 
> ---
> v2:
> - Target net-next (missed in v1 subject)

-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z and LinuxONE

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschaeftsfuehrung: David Faller
Sitz der Gesellschaft: Ehningen / Registergericht: Amtsgericht Stuttgart, HRB 
243294

