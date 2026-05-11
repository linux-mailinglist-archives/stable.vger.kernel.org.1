Return-Path: <stable+bounces-245166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKlPIqKjAWpKhAEAu9opvQ
	(envelope-from <stable+bounces-245166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:38:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E8F50B0E7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8032831D6ADA
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484A33BAD80;
	Mon, 11 May 2026 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LsvbQVya"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769F1D5CE0
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490671; cv=none; b=te2Lk2xn3CaKNTiarTUEnLaEYGjTMZ5OUD1CJLG9hDE44bA97gaYQVcM9EcEoGqM9XQfgUbcL7NP01vUZZmXEbizM4vyKTOVvpDTgTo+ZVpywva1BFsfHvzdewQC8w4lSxryHdhaPNUKdD8derWD7TtTzNjBhRtYeGV7nhfxlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490671; c=relaxed/simple;
	bh=wKVaz+Tjx+03jco4k6j0seW7AUdXaoFh2nzCKCYzspc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyyhZFcMRV9R8D976kfg8T0Ze4MAgoYbLNLvT72TSq9iVrD4qFXuMtsT60d/1Xxx3fQJXP2jvz6Q93OD1iuAWWgOc6aeswgFRyu49/ASoouLvMCvfyAhvG1Rfh8EOiX6mylfnPnl0drRopgdm7fSRxDax4X9geHDgOzNFD1gVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LsvbQVya; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AMspXo4048987
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q/q658
	dmEGZH+mhywEfG8mkZZxhq2EDcRnlm74oeCtg=; b=LsvbQVyaZf82Arnjb7NMN9
	gX8/NmNe0D/y1qFMQvyYSyJb764G7K55zO22jAkH8OhOtKfHhbbYlE8H5+XP/lJ4
	PT9PtBl760jmDiqbfEYEuomihjPZtVM1MMzzl3a7ZKoeKJ7/gmHex/OmtB2T/Xv9
	HPrTuUlC2L0nAoGnOz+BJ+p/C4OBRTJg9ov6w7rZmUkNwuO+zv5j4vw8MFlPT5w9
	Ja/SeAYmKtfcZ+28Y799thpRTp/y9Okd0TqUVf2hwiuaFxnzEbaCNv8zC6NM+cwr
	SkDHTVCgB+5Ulr1KHcd8VIx3phMu5SroAg8RBNL/9QttfNZchF1v1vsIBFhDMHXg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4qft8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:11:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B99M6B028901
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:11:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg4cth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:11:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B9B3Bn51511580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 09:11:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 691392004D;
	Mon, 11 May 2026 09:11:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BDF320049;
	Mon, 11 May 2026 09:11:03 +0000 (GMT)
Received: from [9.52.217.250] (unknown [9.52.217.250])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 09:11:03 +0000 (GMT)
Message-ID: <db4a5413-4844-4336-aa6c-5e7a29bb16ea@linux.ibm.com>
Date: Mon, 11 May 2026 11:11:02 +0200
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
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260508170534.2208812-1-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a019d2c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=G1JSpoSnYN3-DCclj08A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwMCBTYWx0ZWRfX7OlepJddDCGF
 xM8A2FwSi4fF8nehKSiC1vBMC9bJNByM1RD1V4lEhkDY3S7EfcF1eQXphXMt7LTxXwJ0J12nuSS
 cf1m6C2TGAwkEsbK+5tV8r27MBG/nmQrcMw0cYZT3EkpyueZQmHYqLHH48W9wSGxNop4GmEzhgN
 A4B/+Ou6hl1ZmtZ5LGbtmpLLBXxMKSVmDhOtkQ064bmVqVHHwj44zcsQOJphBbXK3AISdKrPH5e
 aLBuaNiSy3juq0945P/FrmMijEbwRHp9/n9htguIMlsgxJrGdrL3JeG4+FrL2OduJTsLQwjXsGB
 o5jZcGoeRk287lwApN5G6RZaaFNa8DOQVZFhYQ/5Yi1kEh679lBgScL0+pDzjdlQ1esBxTHoE95
 h/feGCnK2aVsD5XdNzJKhTxmho6PXnVB/nNZuhJGRxPVBRbuH7zqZa84i8KmRFxdlW6MIDKZcC+
 6YYZR9jv/xqpA/47KJQ==
X-Proofpoint-GUID: lc15r5b-Rv4UUjrB6NWoEFiiKJjga-mB
X-Proofpoint-ORIG-GUID: lc15r5b-Rv4UUjrB6NWoEFiiKJjga-mB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110100
X-Rspamd-Queue-Id: E7E8F50B0E7
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
	TAGGED_FROM(0.00)[bounces-245166-lists,stable=lfdr.de];
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



On 08.05.26 19:05, Nagamani PV wrote:
> afiucv_netdev_event() traverses iucv_sk_list without holding
> iucv_sk_list.lock.

I agree with the analysis and the patch.
Good catch Hidayath and Nagamani!

vvv

> A concurrent socket teardown can unlink and free the socket via
> iucv_sock_kill() while the notifier path is still iterating over
> the list, leading to a possible use-after-free when dereferencing
> the socket.
> 
> Protect the traversal using the existing read-side lock, matching
> the locking pattern already used by other iucv_sk_list traversal
> paths in af_iucv.c.
> 
> Use read_lock()/read_unlock() to remain consistent with existing
> softirq/tasklet-side readers in the same file.
> 

^^^these Paragraphs can be less verbose.
iucv_sk_list.lock is a RW_lock, so it's rather clear that
afiucv_netdev_event() needs to hold it for traversing the list.



Please add KASAN report to be part of commit message.

Just for my information:
Was the KASAN finding triggered by CI-KASAN run? which testcase?
Did you verify your patch with KASAN and the same CI testcase? Probably looping?



> Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
> Cc: stable@vger.kernel.org
> Reported-by: syzbotz+89435e7383b82238dd91@linux.ibm.com
> Closes: https://lnxgwne1.boeblingen.de.ibm.com/linux-ci/syzbot/dashboard/bug?extid=89435e7383b82238dd91

This is an internal website, so we cannot report it upstream.
I am not 100% sure how to handle this case.
Note that Heiko said, it's ok to use Reported-by without Closes, even if checkpatch complains.
(He was referring to Reported-by a person, though).
I would add the KASAN report and remove both tags, if you ask me.


> Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
> 
> ---
> v2:
> - Target net-next (missed in v1 subject)
> ---

As this is a problem fix, it needs to go to net, not net-next.
Don't forget to do BBPF backports once this is upstream!



>  net/iucv/af_iucv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 72dfccd4e3d5..e8a0b55fc55d 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2188,6 +2188,7 @@ static int afiucv_netdev_event(struct notifier_block *this,
>  	switch (event) {
>  	case NETDEV_REBOOT:
>  	case NETDEV_GOING_DOWN:
> +		read_lock(&iucv_sk_list.lock);
>  		sk_for_each(sk, &iucv_sk_list.head) {
>  			iucv = iucv_sk(sk);
>  			if ((iucv->hs_dev == event_dev) &&
> @@ -2198,6 +2199,7 @@ static int afiucv_netdev_event(struct notifier_block *this,
>  				sk->sk_state_change(sk);
>  			}
>  		}
> +		read_unlock(&iucv_sk_list.lock);
>  		break;
>  	case NETDEV_DOWN:
>  	case NETDEV_UNREGISTER:

I agree with the analysis and the patch.

