Return-Path: <stable+bounces-76005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C331976BD7
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 16:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3379E283C15
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F271B1AD25D;
	Thu, 12 Sep 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DtIR71YN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC837703;
	Thu, 12 Sep 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150900; cv=none; b=AuMQ+9x/JPjjx5bxE1a8kCTLpfRyWRv0EZMKf69EvjFvsnW9CsxPnumGqBrwNLkhgl6PzvCCs/wxhhhNISl8Iv2Qjh3NfXiSDJ7mNBCsb6YC9H4lp3V8x2zZPLvctbiBojWTzGroZSV3vHpsjfgq+oh3j+KkaW09Qb8V6wXjqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150900; c=relaxed/simple;
	bh=XTecsvZnA2wlK2jQQxxrGxxKOc4Q28McTMdBPvRWpjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Etd64mNfi2i1s7elebP9RxphTqwpZwVZLELu4ggJYvUBcdCrrYLJs6Kto3Y0of+IpIu9ewAyK65Ak1RrYAlVpcLqsXIuKOO/2KVye5ovcjeT+pu4uUAUCfvjiIiiz7osImoTgTSWmxY6IoYvowOpASyTiCwoaEB5KjfoapZJpTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DtIR71YN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C6K8m7022678;
	Thu, 12 Sep 2024 14:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	/JkIOX4BO+EUbCRj3c1s2zMiEoiNz6eBpmylaYFVKjc=; b=DtIR71YNytrtdbyz
	Uwf8xk2et7kSCb+LH3UblwzexQz1pDQYyFHzxEXLQlDi0T+bJw11ImoAuQa0GfHS
	928aHaDFeWxYxJXpfpeMQNDwTh3stcPCJK32V3GDjbef5RgOu7J7ADOJ92m44Wdx
	/Pap2EbI+DxQdP69dqIPZykO3JTCrD33EuCW6/yx6Up3c7AOvUZdVdQWen+s6Ihw
	iLaKSP1AMqi4WHaqkKxZQ1XRKXYzTyNb4xi+z4iWp/wfKMnnW5JXBIKKbUwHkIp1
	QEjshfDDH438ryqLN/jqKIcHW7uP4uCDUeNHnClb2bhIa7+C1sO6BMSJxiy2qOtB
	5jTt8A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebam6e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 14:21:30 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CEI9EK025401;
	Thu, 12 Sep 2024 14:21:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebam6du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 14:21:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCNhib010729;
	Thu, 12 Sep 2024 14:21:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41kmb6v2hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 14:21:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48CELQQ154198584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 14:21:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4435D20043;
	Thu, 12 Sep 2024 14:21:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF62F20040;
	Thu, 12 Sep 2024 14:21:25 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.171.81.202])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Sep 2024 14:21:25 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, stable@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] workqueue: Clear worker->pool in the worker thread context
In-Reply-To: <20240912032329.419054-1-jiangshanlai@gmail.com>
References: <20240912032329.419054-1-jiangshanlai@gmail.com>
Date: Thu, 12 Sep 2024 16:21:25 +0200
Message-ID: <87zfod54wq.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DfmBiw9eodo3-BfwvKHhwx_jyEd8zyCC
X-Proofpoint-GUID: 2eCHTCewJDC7tW4gExXttv7s2DLTpcsR
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_03,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409120102

On Thu, Sep 12, 2024 at 11:23 AM +0800, Lai Jiangshan <jiangshanlai@gmail.c=
om> wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> Marc Hartmayer reported:
>         [   23.133876] Unable to handle kernel pointer dereference in vir=
tual kernel address space
>         [   23.133950] Failing address: 0000000000000000 TEID: 0000000000=
000483
>         [   23.133954] Fault in home space mode while using kernel ASCE.
>         [   23.133957] AS:000000001b8f0007 R3:0000000056cf4007 S:00000000=
56cf3800 P:000000000000003d
>         [   23.134207] Oops: 0004 ilc:2 [#1] SMP
> 	(snip)
>         [   23.134516] Call Trace:
>         [   23.134520]  [<0000024e326caf28>] worker_thread+0x48/0x430
>         [   23.134525] ([<0000024e326caf18>] worker_thread+0x38/0x430)
>         [   23.134528]  [<0000024e326d3a3e>] kthread+0x11e/0x130
>         [   23.134533]  [<0000024e3264b0dc>] __ret_from_fork+0x3c/0x60
>         [   23.134536]  [<0000024e333fb37a>] ret_from_fork+0xa/0x38
>         [   23.134552] Last Breaking-Event-Address:
>         [   23.134553]  [<0000024e333f4c04>] mutex_unlock+0x24/0x30
>         [   23.134562] Kernel panic - not syncing: Fatal exception: panic=
_on_oops
>
> With debuging and analysis, worker_thread() accesses to the nullified
> worker->pool when the newly created worker is destroyed before being
> waken-up, in which case worker_thread() can see the result detach_worker()
> reseting worker->pool to NULL at the begining.
>
> Move the code "worker->pool =3D NULL;" out from detach_worker() to fix the
> problem.
>
> worker->pool had been designed to be constant for regular workers and
> changeable for rescuer. To share attaching/detaching code for regular
> and rescuer workers and to avoid worker->pool being accessed inadvertently
> when the worker has been detached, worker->pool is reset to NULL when
> detached no matter the worker is rescuer or not.
>
> To maintain worker->pool being reset after detached, move the code
> "worker->pool =3D NULL;" in the worker thread context after detached.
>
> It is either be in the regular worker thread context after PF_WQ_WORKER
> is cleared or in rescuer worker thread context with wq_pool_attach_mutex
> held. So it is safe to do so.
>
> Cc: Marc Hartmayer <mhartmay@linux.ibm.com>
> Link: https://lore.kernel.org/lkml/87wmjj971b.fsf@linux.ibm.com/
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: f4b7b53c94af ("workqueue: Detach workers directly in idle_cull_fn(=
)")
> Cc: stable@vger.kernel.org # v6.11+
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---

[=E2=80=A6snip=E2=80=A6]

Hi, Lai,

so I tested several things:

1. f4b7b53c94af ("workqueue: Detach workers directly in
   idle_cull_fn()") is the commit that introduced the bug
2. with your fix applied I cannot reproduce the bug

Therefore

Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>

Thanks for the quick fix!

---
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

