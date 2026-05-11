Return-Path: <stable+bounces-245220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPAANRndAWptlgEAu9opvQ
	(envelope-from <stable+bounces-245220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:43:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB650F323
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EECF5306D5F0
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957E53E92B6;
	Mon, 11 May 2026 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZpjmXR0k"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3D381B13
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506735; cv=none; b=Q/54ElfKuZ4u/MwiiO3MdBMb/3/oazarHyawJ7ZaScBeG/irjPs7HMaYYWJHW3V2zH6wsKvg7yys60v7pp3u2VZwvk9pSd/gerM7tPAONhSin9zUTsssvFjtUe451YYgoi6Gowt1Oy4J2/P/h4kbVVG8F33cw4bYZY5LabuRLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506735; c=relaxed/simple;
	bh=IUdZ29X6/RCbhQeGyUkygcwNyAbXRT05L72uGFyyvJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFeYzjRm58BqOllFy2b1vQDHnUw43tvgTl1Mq96c6icFSK8y8zXM9BRkg7YG2G/6zUWfc2seTBNy3XFY5vOizLHoZQ8zjSuvX7zv2LyWuWB5d5UDf0X+e7dWAw+kJJjkcDQSch/dx9AtHtTdmmC6R7fInkWB1DNntMpbazOLluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZpjmXR0k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B1I6AR1346977
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HcGEtS
	7Gsq7lYFeNbfaXHBkNNmnEPtvSFLg0rzLQMbk=; b=ZpjmXR0khhegX6Rtp6R6WW
	rYt4c/xSe3mYzs8oLuheGafXF5K6NxQU/MQVqOdULRtvOEvoyYMvVA4pOauR2eNp
	JnMx3Ma8lSs8QmM0k0mTKsXA36PG4GnQQfP6FLteteJAb5IgpzyB3O8KV5cZ/hIW
	CFurlK4DS33c87VRaaTMSa+m9HM5gCLncfGtZjfAxhhwS7dFpQxpofqe32TIfXVN
	/SDEU0aW0dP3xNb0lqS7iEYGmCbouM/+w6vkjIIeZ7DPu3tQEWPFub3ldc+nMNjF
	3sc/sRULwXLmhWyfw8iv8zlbqQf/3f/DTSS2ZrAoCZoxJzAsVPGfl4JZ8wC9Yjmg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve70h84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:38:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BDR2mY005603
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:38:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2grh5cfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:38:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BDck6Q31785406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 13:38:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0E32004D;
	Mon, 11 May 2026 13:38:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B59B120040;
	Mon, 11 May 2026 13:38:42 +0000 (GMT)
Received: from [9.39.26.74] (unknown [9.39.26.74])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 13:38:42 +0000 (GMT)
Message-ID: <2efe3303-32cb-4e91-93db-9e78848c642f@linux.ibm.com>
Date: Mon, 11 May 2026 19:08:41 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] net/iucv: fix UAF in afiucv_netdev_event()
To: Alexandra Winter <wintera@linux.ibm.com>, aswin@linux.ibm.com,
        sidraya@linux.ibm.com, hidayath@linux.ibm.com, pasic@linux.ibm.com,
        mjambigi@linux.ibm.com, dk@linux.ibm.com, twinkler@linux.ibm.com,
        jaka@linux.ibm.com, wenjia@linux.ibm.com, gbayer@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com
Cc: stable@vger.kernel.org, syzbotz+89435e7383b82238dd91@linux.ibm.com
References: <20260508170534.2208812-1-nagamani@linux.ibm.com>
 <db4a5413-4844-4336-aa6c-5e7a29bb16ea@linux.ibm.com>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <db4a5413-4844-4336-aa6c-5e7a29bb16ea@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1MSBTYWx0ZWRfXytJSfbrsu2u2
 +klqizcLQibRCMhvDur6jW9zPWKoLU159U80RFqPuYye3y5cnl4z9qs4wZkaE/zQXy9hb9Q4jCC
 q8VbwP1jK79WwHb6/Q4TfrMSxkBvwWf3w6SP+q+MR7JmdjoqNROZyvcZZVSmabQq+6Q3Om1L0bl
 UTVrMnAd0msJhB8kzY33hKwJPMBYW6VazLlSCFmHVzU2PitNffHsBUjJRjfVIOAmCn/29J5fWoz
 U3rpPFM5GcXGXT1Z/zKEPeWXbHbtuqRJx4djKkR105cqHtM6m4gksSv0IQsVkN3rE+ePkpXXs9y
 CXIcNdO+jQ07qhWuzpuoq8FyXFEXtGPlUD6zCFHdH6+msZcGtkOkKkKAL/ynSnqXHYTCcf7br6t
 rhP38LOxVC8Yth61XON54NvUzjNa6i2we4VscEEYf3EU0TXWXcPyK2124XA113YSHNLrD4GKjIG
 xHf7I7TqTwjRhlNL5WA==
X-Proofpoint-GUID: _Tu1iaR5y98smwjg8amHPx2EPWk4k4ml
X-Proofpoint-ORIG-GUID: _Tu1iaR5y98smwjg8amHPx2EPWk4k4ml
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=6a01dbed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ENyHu9UbGtwdtwANqRcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110151
X-Rspamd-Queue-Id: 92DB650F323
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245220-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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



On 11/05/26 2:41 PM, Alexandra Winter wrote:
> 
> 
> On 08.05.26 19:05, Nagamani PV wrote:
>> afiucv_netdev_event() traverses iucv_sk_list without holding
>> iucv_sk_list.lock.
> 
> I agree with the analysis and the patch.
> Good catch Hidayath and Nagamani!
> 
> vvv
> 
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
> 
> ^^^these Paragraphs can be less verbose.
> iucv_sk_list.lock is a RW_lock, so it's rather clear that
> afiucv_netdev_event() needs to hold it for traversing the list.
> 
> 
> 
> Please add KASAN report to be part of commit message.
> 
> Just for my information:
> Was the KASAN finding triggered by CI-KASAN run? which testcase?
> Did you verify your patch with KASAN and the same CI testcase? Probably looping?
> 
> 
> 
>> Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
>> Cc: stable@vger.kernel.org
>> Reported-by: syzbotz+89435e7383b82238dd91@linux.ibm.com
>> Closes: https://lnxgwne1.boeblingen.de.ibm.com/linux-ci/syzbot/dashboard/bug?extid=89435e7383b82238dd91
> 
> This is an internal website, so we cannot report it upstream.
> I am not 100% sure how to handle this case.
> Note that Heiko said, it's ok to use Reported-by without Closes, even if checkpatch complains.
> (He was referring to Reported-by a person, though).
> I would add the KASAN report and remove both tags, if you ask me.
> 
> 
>> Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
>> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
>>
>> ---
>> v2:
>> - Target net-next (missed in v1 subject)
>> ---
> 
> As this is a problem fix, it needs to go to net, not net-next.
> Don't forget to do BBPF backports once this is upstream!
> 
> 
> 
>>  net/iucv/af_iucv.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
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
>> @@ -2198,6 +2199,7 @@ static int afiucv_netdev_event(struct notifier_block *this,
>>  				sk->sk_state_change(sk);
>>  			}
>>  		}
>> +		read_unlock(&iucv_sk_list.lock);
>>  		break;
>>  	case NETDEV_DOWN:
>>  	case NETDEV_UNREGISTER:
> 
> I agree with the analysis and the patch.
Hi Alexandra,
Thanks for the detailed review.
I’ll simplify the commit message to be less verbose, include a relevant excerpt of the syzbot KASAN report, and remove the internal dashboard link. I’ll keep the Reported-by: syzbot… tag and drop Closes: as suggested. The fix will be targeted to net, not net‑next.
Regarding KASAN: the issue was detected by a syzbot CI run with KASAN enabled. The report does not provide a standalone reproducer or named testcase. I did not rerun the original CI workload, as no reproducer is available; the fix is based on analysis of the reported race and the syzbot KASAN trace.
Following the discussion with Heiko and your later confirmation, I’ll use read_lock_bh() / read_unlock_bh() in the notifier path to keep the locking symmetric with existing write_lock_bh() users.
I’ll resend an updated v2 addressing the above.
Thanks,
Nagamani

