Return-Path: <stable+bounces-204299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F680CEAED0
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 00:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D543013E8D
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 23:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C05246781;
	Tue, 30 Dec 2025 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IM/oRkAC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFB3A1E6E;
	Tue, 30 Dec 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767138335; cv=none; b=qI3D+us9BiAuhqk+1ZgQ9QN7ktPAXFPSEVHrXRvhwUHzdOTD6KTSXXL4lX/yNoRfaO0D6aVVq0IqXYiACM+SmYrIS3s+RYFBVTl4Q/NiBvkG82eaEbQwZ99LJlnIthtThdgO42KmPePCweL6lNcBHm810AAGsN5yW8D9s8xIrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767138335; c=relaxed/simple;
	bh=QMBUdlXDKkchPVAs7Ow4vcyLh72TJwzttwvyboiQR7g=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=VbCuV4iF/xi1qibNpU1BXKz4sUrTUBvVRDAhRFsmddcLjXX+5HRQRVVOmzlGEDYbmvsIqJhoE4pTb1KR1Ytl8yqNHYjJ4UbmVydqoomKpi8nYBAES+wNGTViS4ITygawgS9aHnVj7F0qPD502vzd6C1mQc697xSYURkEKrBg3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IM/oRkAC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BUD7r7l032696;
	Tue, 30 Dec 2025 23:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y5d+/r
	QgjKDFkAaZOQfs10C5BxM3Nrst9vpTgEn1Mjk=; b=IM/oRkACQrUOpid2O2ns/W
	bhIAz86bSC5FS0jZYb7Fi3Ze8X3OdMGUsBHDXQ3aetaFmshYoe3AJdch7oT4J6yw
	W67hos9KaUrqYie6ry6DoqZ5sFkvB5+5vVwbddjdGJ9DWQDswnRnKV8AmI9AliIx
	GIt6bt3PC7LfvAZ4MbyuX4vsT2tG3R6GbxJoT3isjjNFWW47Ktx6JK1o7jXo5qKP
	eQI2j18VVQukrXKjNe1ohRmGPiLiC/pbh5lINXrcRYaqZTlBCgD4O9nW33S8wd69
	C7efJ4/R6UbarHJslwTS33ChHYpdCnKs7ZNQvohnfmfb8VZAfI5NFGfgn2YBR16A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bb46xhyuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 23:45:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BUNj6q6006847;
	Tue, 30 Dec 2025 23:45:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bb46xhyu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 23:45:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BUL4R5S003112;
	Tue, 30 Dec 2025 23:45:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bavg1uyx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 23:45:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BUNj4Bq40829488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 23:45:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A5035805A;
	Tue, 30 Dec 2025 23:45:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96EC558056;
	Tue, 30 Dec 2025 23:45:02 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.14.46])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Dec 2025 23:45:02 +0000 (GMT)
Message-ID: <a5fbf391731b04b5cea5aa2202f375986ea90991.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] x86/kexec: Add a sanity check on previous
 kernel's ima kexec buffer
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
In-Reply-To: <20251229081523.622515-4-harshit.m.mogalapalli@oracle.com>
References: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
	 <20251229081523.622515-4-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Dec 2025 18:45:02 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIwOCBTYWx0ZWRfX3Y3/2ueBILU7
 X5bcz9TWWhGrhn040fiERI62AM43V3yDBoqS/XAfUO5Cay5QLXUgdlVzA5VuMEuxLYs0aVYvKac
 qTSYPWG6HiIV+dJxEqH4MMN7R9PiFRGViZwHIzLWS9CYsd0rPFuoH7UHHlh/MYeIjV8TqovsYKY
 YqZTheYZy2CHOuMfkIPUKlF00WYPAvlOEAhDuSVviQL8cH6eoNfKlGgkH+MI59MyuyH6Gqd1HXv
 xpbT5BnJ2SBl1MPF6HsLXcg7lmN8quQJsxYkqsKuz1C0/T7fz2FXV3Yg+R+5ix5a7P4gnP4ABt5
 Qd/exaYNOYvTueBjAHt9V59adsxggnfWbacZxUoTVg7gwHpq2YU/U9pis6iMzpIbO+u5rf+B1D7
 QPl5Dc41c8yJRmA09cGqslPawtBdOG14vPXUeOPvZ9GZNnkVO7BHzaP1QfnNHKJ0HBa37mSy6BF
 dwNac+A+iD2Y3se+YcQ==
X-Proofpoint-ORIG-GUID: Olu-nHAbwbWVLblu2emWCToZ1qd3NVE4
X-Authority-Analysis: v=2.4 cv=L7AQguT8 c=1 sm=1 tr=0 ts=69546402 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=NpcRbR0aspp2ts8fkesA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3Dw_R9YRQN8ukdyEP66fsJHWxIpF-kgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300208

On Mon, 2025-12-29 at 00:15 -0800, Harshit Mogalapalli wrote:
> When the second-stage kernel is booted via kexec with a limiting command
> line such as "mem=3D<size>", the physical range that contains the carried
> over IMA measurement list may fall outside the truncated RAM leading to
> a kernel panic.
>=20
>     BUG: unable to handle page fault for address: ffff97793ff47000
>     RIP: ima_restore_measurement_list+0xdc/0x45a
>     #PF: error_code(0x0000) =E2=80=93 not-present page
>=20
> Other architectures already validate the range with page_is_ram(), as
> done in commit cbf9c4b9617b ("of: check previous kernel's
> ima-kexec-buffer against memory bounds") do a similar check on x86.
>=20
> Without carrying the measurement list across kexec, the attestation
> would fail.
>=20
> Cc: stable@vger.kernel.org
> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kex=
ec")
> Reported-by: Paul Webb <paul.x.webb@oracle.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> V1-> V2: Added a line about carrying measure list across kexec based on
> suggestion from Mimi Zohar. Made use to the new generic helper
> [Suggestion from Borislav]

Thanks, Harshit.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


