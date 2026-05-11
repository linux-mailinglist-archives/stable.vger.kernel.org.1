Return-Path: <stable+bounces-245163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jlcaKAaiAWpKhAEAu9opvQ
	(envelope-from <stable+bounces-245163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:31:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD950AEE6
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 421A731C108D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01643CB2FD;
	Mon, 11 May 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IJChbYQE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4787C3C9EF4
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490165; cv=none; b=ZEuoKp7YlJGhDTvbZ879v5BsysVbFXuxXABHdXvbtww2XMz92EIwr6xwnbyAF6q5BBGLPy8PlctUJWvzqetl/gybZbXvUpohd3hQ8QH7hR0IAtcadxwCnHHqssXD6sFkTB7WOag08URgd8XZSEdJ6QEoVYD2zpW6E21lWPSnj5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490165; c=relaxed/simple;
	bh=zEZP75XPd/YoLbSlWW0XatmQT26M+uswfT92oMLubcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqPJUjTLHRZFCg2iCEP2vD99sJBUVZRh3AMatwQ3GUK3MT7aZndqPdlB97bxdFcY3npGxCMN/VEb50o9Gc2mlx78Ph5sibOzO/FcaV7TeeKObrWSidAa8Wvmz8hxiw9taiDfycHy4TJafBBmxAlte9F4MX/5kXiYUiYRoGmFzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IJChbYQE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ALHPNI225566
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bQap3EDX68k5DCsi6umqb8wLKbDxa6
	PGSdNemXix4Fs=; b=IJChbYQEaYfnPgZ2iVxfB8UmOPcuFEtekmzzXD6vTkigbW
	5p7Ngyv2s/UJAJQVkXrZd+ZiU04FtsP1YAEe6Wm8xZjrt1f7Do7KiqnuN39bHjHL
	wvHb+a+S/9Qblr3mgSOdz7zr9ufKUIbGgiUVf1pI0Gu/Y5C418aK0T+K2l0o5m+R
	eQoLTh7kjQ4FDnd7mylUse9ABi0JqAG22/vGJ9OVGGIOUe3dfC1KTpWatvA9zQl8
	2NjhR3VHctOLqNvunrFp7nzPO8eYGG7ysFfPgSBv/gYHNObuhgoZDbvNHmJvtQzj
	jxaJG5QSbVnLNmLvjBkyE0shgI+FDEYo+jFCONDw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhq6cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:02:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B8sOYx027369
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:02:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hxy4939-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:02:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B92bld32833884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 09:02:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A70020043;
	Mon, 11 May 2026 09:02:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B0F32004B;
	Mon, 11 May 2026 09:02:36 +0000 (GMT)
Received: from osiris (unknown [9.111.59.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 May 2026 09:02:36 +0000 (GMT)
Date: Mon, 11 May 2026 11:02:34 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Nagamani PV <nagamani@linux.ibm.com>
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, sidraya@linux.ibm.com,
        hidayath@linux.ibm.com, pasic@linux.ibm.com, mjambigi@linux.ibm.com,
        dk@linux.ibm.com, twinkler@linux.ibm.com, jaka@linux.ibm.com,
        wenjia@linux.ibm.com, gbayer@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com, stable@vger.kernel.org,
        syzbotz+89435e7383b82238dd91@linux.ibm.com
Subject: Re: [PATCH] net/iucv: fix UAF in afiucv_netdev_event()
Message-ID: <20260511090234.9589A54-hca@linux.ibm.com>
References: <20260508163836.2207648-1-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508163836.2207648-1-nagamani@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a019b33 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=mT4ECi18_2jB0PnJKWoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: fULaFmjbGxUVeD9ucn5PMOQBPLfqZTnj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA5NCBTYWx0ZWRfXzfrZXUBJ7+ef
 7NNrd42KiA9hJmO6ywuEqd0E30JdwLfl6N90C0HNGr/D5A/qpdoFPr/u51QuEFQA3qHLZrdBm0z
 Ifg2LyASwXeRQB2ZmNuuqZCQQdKJDAje5WLNP2i/CI+gjaSKhr0L9SK4+7LRQfhv6s6JI709OXv
 A96unBQ+8Rb4FrxTNEGRJRBOOkT0MDFon1ooFddhgtcrOyf/xOgrl5FnfIdYytlMHZv/RdK7yYj
 UEKIRYceE714le0Z5PnH/zakVfHpBE209B/LRWI2j6t3CNV4WYgZRQXP5R2cJDC8vDwmCVeU4Zj
 21kWEndoEEqi4gMyBkUi/ECGldygvAXzDlZG1IXZt4hsRTAIcnHTDgEcnmTs742vLIp3nqfFVAv
 XCaq1YB7eKAG7Q/adFRFNROqeiAGHhyyG2DA3jzqMWrx0u21Ee0JCSjUvevfelP9MSW37bNUhBc
 y8SoYeHFuSXKXXvhpJw==
X-Proofpoint-GUID: fULaFmjbGxUVeD9ucn5PMOQBPLfqZTnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110094
X-Rspamd-Queue-Id: 02AD950AEE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245163-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,89435e7383b82238dd91];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 06:38:36PM +0200, Nagamani PV wrote:
> afiucv_netdev_event() traverses iucv_sk_list without holding
> iucv_sk_list.lock.
> 
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
> Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
> Cc: stable@vger.kernel.org
> Reported-by: syzbotz+89435e7383b82238dd91@linux.ibm.com
> Closes: https://lnxgwne1.boeblingen.de.ibm.com/linux-ci/syzbot/dashboard/bug?extid=89435e7383b82238dd91

Please don't add IBM internal references to commit messages. They are
useless, besides that they will go away rather sooner than later. Better:
add the _relevant_ parts of the crash output to the commit message, which
allows people to make verify if this patch is actually fixing what the
commit message says.

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

Are you sure that afiucv_netdev_event() is called in either tasklet context
or with bottom halves disabled? Doesn't look like it to me.
Read: most likely this should be read_lock_bh() to avoid deadlocks.

But then again I might be completely wrong, and lockdep says that this code
is actually correct :)

