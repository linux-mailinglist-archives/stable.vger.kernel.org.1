Return-Path: <stable+bounces-204300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD5CEAED6
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 00:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF5E6300B6BC
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 23:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6E2246781;
	Tue, 30 Dec 2025 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k38XA3e4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A11289811;
	Tue, 30 Dec 2025 23:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767138367; cv=none; b=WefSSc3EThbJ55Hj9DbJ20+IDQbv6MWKXtE4OIY3RxvBx9Mdmx/5Gwyr7qIT0wjzOpmsQjkKfZar9jf7cqX9tAEU7tBtvtP3YdW6dp3rN6HXWCh/C0H4g7bKU0LnjLNd+lLRXxj7abzRfn0Uoqeo8Xp5WjxZSmS/JkQYLGPnAvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767138367; c=relaxed/simple;
	bh=eJUBX+G1fq1wkSWbCNhNDi8mkMdcOr4W2KOSEFAJ0nw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PvJLprqQolKYs8XkGZ91yOZsPFVb9bCK2ryZFjueDpBpsKy5d0LG1mlYjhhupirNplLEFsVv/TGbXBsCDlidt07Da3s/CcxkVzWhkpIgbFoxBHwBLUMkn/RYQ1D4CNI632rL507lxqCjjdKmIixvrqCLcEt24iJvEnWj/Jvtiy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k38XA3e4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BUL0kai017682;
	Tue, 30 Dec 2025 23:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eJUBX+
	G1fq1wkSWbCNhNDi8mkMdcOr4W2KOSEFAJ0nw=; b=k38XA3e4TC9JAslKYHwH6a
	065kYSN/hV76ZdnG9uVUoTRamZpazWqEzEpNN3zsOB9JJn7M8xPUKpuy8XyiD+MW
	5y3NscRb2eKnjlF9Xx76P810N+rkELksocsshw0DfUpspeI5zJuiIN2VenI5eb/R
	IxcyKAQE70+WwCydkJTbknx5ypasFZNEwsPldOZlSwYR1SV57xoG0lJyG6yYxQQm
	ubGZeIqDQ9ZEXAZp9O3qzFtHHzRHfB8hz40mCIW7zxHNbbqKj1qUHIxiBLVOBgL1
	z688JNWxTq8Bwf8vbImi/cbsnMJZz68cLXF8IKV0S+1gkJgRuYUm9ZZtxKuqZUpQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73vv5np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 23:45:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BUNjHSI026049;
	Tue, 30 Dec 2025 23:45:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73vv5nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 23:45:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BUJS1Bx026013;
	Tue, 30 Dec 2025 23:45:16 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4batsnc8ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 23:45:16 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BUNixio21693108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 23:44:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F0C058056;
	Tue, 30 Dec 2025 23:45:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 489DB58045;
	Tue, 30 Dec 2025 23:45:14 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.14.46])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Dec 2025 23:45:14 +0000 (GMT)
Message-ID: <c4f5fa22f113405edb5f751d6a3ed37d725d1da9.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] of/kexec: refactor ima_get_kexec_buffer() to
 use ima_validate_range()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: akpm@linux-foundation.org, ardb@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, graf@amazon.com,
        guoweikang.kernel@gmail.com, henry.willard@oracle.com, hpa@zytor.com,
        jbohac@suse.cz, joel.granados@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, noodles@fb.com, paul.x.webb@oracle.com,
        rppt@kernel.org, sohil.mehta@intel.com, sourabhjain@linux.ibm.com,
        stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
        yifei.l.liu@oracle.com
In-Reply-To: <20251229081523.622515-3-harshit.m.mogalapalli@oracle.com>
References: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
	 <20251229081523.622515-3-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Dec 2025 18:45:13 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bU__oe7XqrtILbnd9Dlk_X2gcJTMKroQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIwNCBTYWx0ZWRfXyDCrak14bqJU
 vnDhTT79fjl3J2DxvxhfYNiZpAnuZdPp6Hy7fua+/yeE3v6aFGHHTgbhyF2DsgQ68PFuHTPAu/o
 U4K2t4/TFAonOA0JSBVImhjvdLpfXjbDsDVyPZSqRqTT5G1H4XNZhvcJX5iPcPoN71XWsmBrVDv
 cBErrooDh3Qla0qn+lBGShx4wlfYMbiqBZVSDMhGHNSPjEPzlINL7Zl/46K/76HKIFQljS7oHDc
 80/Pb1E5zy/cXEM2QUAJ8K5cNyDqCRDEZf2h2Lc3hGM/siS9smJkwSx3UCiVUXizWfei+gNlKwz
 MuEoe8rGe9sPrFH6Pm+F5o9mQKMIYLK0x5ALips2p7RgAcIvc8u8BOyT46PSJkA46XMcfE0H9ZK
 azky0mnywCT/mDDOuJmEHF6LxkLaBA17hajwXR1IN8fT09Oy3zfs1kBZY6FeyLTWNOydrTVmj49
 3Z87VjSP7Mn/JJW8tgQ==
X-Authority-Analysis: v=2.4 cv=fobRpV4f c=1 sm=1 tr=0 ts=6954640e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=R84PgEUWa9ETKOdZjJAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4dhW2jhCL4rNs-o0B3wWF1NQTUjuxzFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300204

On Mon, 2025-12-29 at 00:15 -0800, Harshit Mogalapalli wrote:
> Refactor the OF/DT ima_get_kexec_buffer() to use a generic helper to
> validate the address range. No functional change intended.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

