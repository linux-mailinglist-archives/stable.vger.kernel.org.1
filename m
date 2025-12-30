Return-Path: <stable+bounces-204289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15529CEAA05
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 21:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 153353024D67
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D62299AAC;
	Tue, 30 Dec 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lxb9Gd1d"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435422DBF78;
	Tue, 30 Dec 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126995; cv=none; b=UCTN2ZDnZVnUs5wqmSdb0ErIHzOS72b009NEopRqMeZfxpuUT3WQOM7YWCnZgAAX5YIwDetEbO3g65YhHxIE8nb8Fbn+CPsz2/x16Irfnapxic5WyIxnPgPCj065+S0HdHy/bGu+kh2mWLwjVx89xND5Ir9YmbPOgaPTi2h4CZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126995; c=relaxed/simple;
	bh=qVhEw7r6+h13FHNlG3fbsQ7l+xg158th8n/3hxgUY+M=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=MiRprob6GpUsMXOfKL7QjBkXlGI2Kn5/vma88vlV/zi2GgJqFzscwUZs1jcnF+ky97eY8nP9+knOGHua5qabcWkV9urCtm2g57x0YY1FjeS0aC84cI5nBquOtCa+9oVNRJpJB1nqnEsNlEBDStKszOrB5/VXVadEdAvhUfIW7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lxb9Gd1d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BUB7pET001746;
	Tue, 30 Dec 2025 20:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o1x3Zo
	bknJV1AGL7pBlCU90gmME5c6Zg8O6fl7Ow2sk=; b=Lxb9Gd1d2vSKYPmyjj45wp
	KNaEE2JJScltyTpXLHziqGu3d64ZUo3+/f8h8lgFG6OX7XLDrOTOUbz6wcDepF8R
	+r/Ck+xCoUJLI+fz/cLNLCRwZ/dtFYxiIYR+kv7kf4SYhnBpc4DW18uGTAkFzRqa
	nHFVmCbJn9/VMFsQR+PUyA3SNaDSWwl1ooag0Y3/cONb/M+NB+32VfArJFZK2uto
	wiQWhwbF0IBrsRJa+mBmuDfU4w2FIOsQPsr9czyLlOfABhyRJFpzB8a5xPcUTCCV
	5Xq7ym5UOCjC1Zuryra4aVxf1PoE/0i+3yDJgt+RJEpHBB4Iuo0rkwvNTu4WeZlQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba74u58ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 20:35:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BUKZsoQ004082;
	Tue, 30 Dec 2025 20:35:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba74u58ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 20:35:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BUJ0NJA012847;
	Tue, 30 Dec 2025 20:35:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4basssuth5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 20:35:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BUKZq6724707762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 20:35:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26C2E58058;
	Tue, 30 Dec 2025 20:35:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5F6658057;
	Tue, 30 Dec 2025 20:35:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.14.46])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Dec 2025 20:35:50 +0000 (GMT)
Message-ID: <29879a797996a14547c1274c45a4e7b824ab95d3.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] ima: Add ima_validate_range() for previous
 kernel IMA buffer
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
In-Reply-To: <20251229081523.622515-2-harshit.m.mogalapalli@oracle.com>
References: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
	 <20251229081523.622515-2-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Dec 2025 15:35:50 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: waATqpdTwZIoCRN7iD1mqXx0j3ZaZVXP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE4MiBTYWx0ZWRfX7m8Ak9TfMvdF
 kHpGf8wLoEnGqjPWuW9W75khE7c5O0rs8MsrCQkPdIHeIYmU4r4gmlXvzEhYvcIo+MxoKz2XpLb
 6SH3VgL5ou/03MQA0YEGXhyp8ZgUafAjT2nVraLxtAGAN1TrubLZtml3eTiM4jPZ0+OnMmkUVbX
 yNAXBiB7B58BTVaZvsO7n3hPZXBFTlnYcxSpfrQPFPBDYCCYq+t9LZab7iHn5Tpzlh5805VYMpm
 N7ORSod7Qm9g9LKvIzzo/CQmlDDIRbIG08fBjDuoxK67j5JUc+6Vxh2mldwaeQP3k8Yb9EeAvV3
 ZNSK2j3+ES5n0uQMZBksX8/JHOTsbJlbkmljLXSYuKwj4CD7w6XV1K06rk0dfbHH3+RLMZpY/L2
 OBr0jsR3Ue9uTRUP2wVQBeRnd2cjrpPSQNkXj9Deytvug/72xPaeHogdzSBbGo4MW4h68mXFQi3
 yFqPKyClfWxn+zcbhBA==
X-Authority-Analysis: v=2.4 cv=AN8t5o3d c=1 sm=1 tr=0 ts=695437aa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=i_rEbNLS2gNQOS-lV44A:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 0v-ueOVDUDvI9LEJziQSSfAjTNUZklzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_03,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300182

Hi Harshit,

The subject line could be written at a higher level.  Perhaps base it on th=
e
ima_validate_range() function comment "verify a physical buffer lies in
addressable RAM" (e.g. ima: verify the previous kernel's IMA buffer lies in
addressable RAM).=20

On Mon, 2025-12-29 at 00:15 -0800, Harshit Mogalapalli wrote:
> When the second-stage kernel is booted with a limiting command line
> (e.g. "mem=3D<size>"), the IMA measurement buffer handed over from the
> previous kernel may fall outside the addressable RAM of the new kernel.
> Accessing such a buffer can fault during early restore.
>=20
> Introduce a small generic helper, ima_validate_range(), which verifies
> that a physical [start, end] range for the previous-kernel IMA buffer
> lies within addressable memory:
> 	- On x86, use pfn_range_is_mapped().
> 	- On OF based architectures, use page_is_ram().
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

--=20
thanks,

Mimi

