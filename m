Return-Path: <stable+bounces-217778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PZxJtRpnGlnGAQAu9opvQ
	(envelope-from <stable+bounces-217778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 15:53:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1152017843B
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 15:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE0E7304117F
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B5244692;
	Mon, 23 Feb 2026 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VReme7aL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3623909F;
	Mon, 23 Feb 2026 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858385; cv=none; b=DWi/GI7IjQu07k4f5jFtW4nUe6RN4UEXAcmgxV5RQalptuVTrbx22ahs33huNchRmy6dEfkuVyvpymCv+OKJCTWs5E822o9/bFEEagu6yfaphqq3PcmTX6I3bHEeDMhwnLWUwidAmtL3miQzylOnYPJge/bAN40gAyvUYx2vztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858385; c=relaxed/simple;
	bh=dfrwWMnLPjZjB2P6toSFpppq/+Zw607TR8A6AxpIeJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5QZE5eYQ+HKJBkQ/v9MowOdCN8dYiMk2QY54auqtucYKRgtyh2Ipm7MvMKbqCsa8WWWzG60E9840i2n6bpsQv7lgGwUETVPA3s7QoJnJuA5821g46l9qyzwbKskxns0MgMSR+vQBP8ve5POLLP4fb6FpJ5+T8r2e+MwUyAeB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VReme7aL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMjLnE2654887;
	Mon, 23 Feb 2026 14:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OwvN+9
	S3jF1v4nZPBQsGYYFFKJdYkb+CGdaQqbai8U8=; b=VReme7aLR9H4QNgJVkJM9N
	gUpeelX0XExT5TmOJ6XPEYIrSW1dEQf7Cut3ypPpRe7NpMxHyiFXUuTYW9CSWqU0
	37cCzULLl20mYXAeHHNpcYr4KPi7LIFG1SyuJ6fCYl0l++e0RqUQ5ic/qAERc40V
	GSDidEBMAbjNq06qN3Bc2yA+VMBoURsYoE3BA2u2uqdcCT7D0OdzOokd9zqW1j6I
	7afl+4XyBzxImInCOq34WZqkQSkoQdec+mQZ5G3Lfruhm/ZI4FGj9Rp3I6/QcqhL
	I1h8wePKnkCNCIUGGwA7DDXnKPz/37ZmG7DH0OrdZH0agQwvyl9CNJy0ZKGqpHLA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqqjue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 14:53:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NC1RI9003821;
	Mon, 23 Feb 2026 14:53:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jmy46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 14:53:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NEqvPa53543266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 14:52:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C79020043;
	Mon, 23 Feb 2026 14:52:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0914620040;
	Mon, 23 Feb 2026 14:52:57 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.111.87.188])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 23 Feb 2026 14:52:56 +0000 (GMT)
Date: Mon, 23 Feb 2026 15:52:55 +0100
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Patch "s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP"
 has been added to the 6.1-stable tree
Message-ID: <20260223155255.41342222@thinkpad-T15>
In-Reply-To: <20260222235114.1339059-1-sashal@kernel.org>
References: <20260222235114.1339059-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fO-mq18CAoL5tkeVQY6PoIQj_IlyO9DX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEyNiBTYWx0ZWRfX5SZLR418r+Re
 rzm4BGolz//TeGQuMaI056/SrpJjzKOj53oBb/deUMmmneI5SmTsshh8Bt9aGg89pdeMBjO+Ys7
 Knk/93o9frkNXLysGCph6VpaCYwNZmkP5TP17ug8fxjP9FsX1J+w2rYYSFidKcvu/Hj8O8mY+lN
 kXq0J8KFXMGc47I3gYOEJAE2ffhre4j1L2EF+CbF4qLXK/0k6Xw7oHc9nW8qPUALMJD6OgtcUD3
 HJYQf6EJ83+KcG5Wv/IPHcT60eaL3H9FNfuqymAP3LOus5gKDdRJ5/FP4DthYEWe/Az0jiO47bp
 APiNuXEkJy0NgyakJj/dBRICd6Jfy74vBqwSPgLWfNm8yC0dTetpBVsoqd/7zwdw03WAV7Kzr1K
 oRn1NcKQf5gt+AA6X5MfGfrz86YC1M/68RHamIYJCjrFF+qtmwcMHcjrraRCqWIOoRyS8m1/amp
 CXa90QmKfMgSA+hYRKQ==
X-Proofpoint-GUID: fO-mq18CAoL5tkeVQY6PoIQj_IlyO9DX
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699c69ce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=uKtpUWve3L976CWnQ48A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230126
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217778-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerald.schaefer@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1152017843B
X-Rspamd-Action: no action

On Sun, 22 Feb 2026 18:51:14 -0500
Sasha Levin <sashal@kernel.org> wrote:

> This is a note to let you know that I've just added the patch titled
> 
>     s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      s390-select-arch_want_hugetlb_page_optimize_vmemmap.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please don't add this to any stable tree. This feature is broken on s390,
and it recently was removed upstream via commit 64e2f60f355e ("s390:
Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP"), which also had a Cc: stable
and Fixes: 00a34d5a99c0.

So we'd rather want commit 64e2f60f355e added to stable v6.2+, than
adding the original commit 00a34d5a99c0 to older trees.

Thanks,
Gerald

