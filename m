Return-Path: <stable+bounces-245168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJeyMkukAWpKhAEAu9opvQ
	(envelope-from <stable+bounces-245168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:41:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312850B1E8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841D2301D68A
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118DA3382F7;
	Mon, 11 May 2026 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QwHtDB8H"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3863BA236
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490889; cv=none; b=QaIlOvswgkkeINV/oVsJI1pvQ/LOymIKtr784rFhdaKoTIKuKf+rZ6eywMgyw0WZdR+wjuU5bqhdsRyiTd1AubB1fJZJQKA8E7Jz/+CEaITHROlfP2G208gA6EtQFPUi4KNFt0r31ixFHy2Puir5RGw9HwWW10sXu9hL9poDij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490889; c=relaxed/simple;
	bh=lnt6v2FGPEF1cMdzQtkkpZp5nYlCRU7ww+jXFOGj8uw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aSsLN3RqpxdeVahVPtviWCKYLwtBQGN/iAX+DvY7ccYLcBnqPPETthF3AWjgBxCykCcsEAP6+xlg1fsmGuYMtk9laoiEVrvktftFAS9VTwljG9UgVRkpX3UrcQ3bD7uwceM2Gqn4nAiEFlPGLlQ7o04UmGPw/XgX4zux9blSdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QwHtDB8H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B5J9Rd2454484
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0kFcRf
	twvxaBGprxELhN71twl69DprGpjPJb9Rs1STY=; b=QwHtDB8HvBdp1PL0Y73lOo
	kMExdRxzBkySd/fX0iS1IniFMjfah88/qBoWvGHxLY50GwwMy6JpU/phk5o4I3yy
	r2wx44r3cEEA0f0bO34g87MG4Xc/Q1tmkgxj8pDUyWrCxRwI1itcQFF3EIXm3dDD
	/MT6M6r0LrxbNqbhyVsJu+Ks44TCq/yvqqP33NC90Aqk0rrN8RmwlZ+zBdXNJqnT
	zldmDpBk4ir4AZ18KcDXDkUOJ8ZVZRmN9gHLewEybYVepfJJTFoYkuO/WP7RyTPk
	h2bLMtnYF0DU4MTyYk4ZKrpasF2cEmbv8an9NHwHICN933XKbbMiYjMvwCSF/iJg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdq3cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:14:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B99UQU013474
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:14:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hxy4af6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:14:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B9EgFY51184078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 09:14:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED69820049;
	Mon, 11 May 2026 09:14:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B254320040;
	Mon, 11 May 2026 09:14:41 +0000 (GMT)
Received: from [9.52.217.250] (unknown [9.52.217.250])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 09:14:41 +0000 (GMT)
Message-ID: <9c08d526-e909-4c17-be0b-7fe99f43a007@linux.ibm.com>
Date: Mon, 11 May 2026 11:14:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] net/iucv: fix UAF in afiucv_netdev_event()
From: Alexandra Winter <wintera@linux.ibm.com>
To: Nagamani PV <nagamani@linux.ibm.com>, aswin@linux.ibm.com,
        sidraya@linux.ibm.com, hidayath@linux.ibm.com, pasic@linux.ibm.com,
        mjambigi@linux.ibm.com, dk@linux.ibm.com, twinkler@linux.ibm.com,
        jaka@linux.ibm.com, wenjia@linux.ibm.com, gbayer@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com
Cc: stable@vger.kernel.org
References: <20260508170534.2208812-1-nagamani@linux.ibm.com>
 <db4a5413-4844-4336-aa6c-5e7a29bb16ea@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <db4a5413-4844-4336-aa6c-5e7a29bb16ea@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=6a019e07 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=W844_UNMq2zY5BL7vcgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wak7-Jkk0bAA6IuURBLMbVAwTY8SZ6Yi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwMCBTYWx0ZWRfX/joXIZve0Tib
 OaB82228nrZoOytAuS6BCC+oqmnFQRRNUWBmVOomav1M+VyPu7fBhkufLZwf+cr3478QMiuIAXF
 mE7whHIJBQILdMLnd5mzdZQBwJF0OPAe8e0sZ0xGiU3GoPGtwFdf5TJKLlIUGD9ai5YC/jZ5ciQ
 i6HUr1Hlf6gA/ThMtDL38wsNNiXcXyWQaKzC3AGN8epTvJ71j0jaCz8VBg1CmfWmQbEnDhpAMBU
 ofanvNqmlCEzkAu88p5fordD5bmbjiPyDBMkRDKGZvccpjyeAaAxYFYlSbcyRI9JoiWVrTV8cOO
 YWUB1XKwTLRyjtXME0X6a0+jH7MY5vAjlsXreuv6dxhmGLhAslJwEzm9yX0DVDbrjSl/5xKrZFH
 bAQGmHdfj2s5mQD0zWWhdi79rrSlsfzeimNuwvI78Kp6v/c/Qu8zPNK9J7MRUe4CHyGRecYCfXm
 eWli8PuEWrwWgdvpRDQ==
X-Proofpoint-ORIG-GUID: wak7-Jkk0bAA6IuURBLMbVAwTY8SZ6Yi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110100
X-Rspamd-Queue-Id: 3312850B1E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-245168-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

stable@vger.kernel.org: Please ignore this is still in internal review!!

IBMers: be careful when replying to this mail, Thunderbird automatically added stable@vger.kernel.org
because of the Cc: tag !!
We should not add this tag, while patches are still in internal review.



On 11.05.26 11:11, Alexandra Winter wrote:
> 
> 
> On 08.05.26 19:05, Nagamani PV wrote:
[...]
>> Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
>> Cc: stable@vger.kernel.org
[..]

