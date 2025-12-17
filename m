Return-Path: <stable+bounces-202756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A74CCC5EF2
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 04:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FDD33063435
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 03:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC18C182D0;
	Wed, 17 Dec 2025 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OqvrxpDV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7362D2390
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765943392; cv=none; b=sY9e9VMmFAcqffBT2J3EUbruwjEJwU39zzxgzSxsWZC0lGOYUN05heGnf+2S1mn7Qs8fFTDMfQ01Z0fd+EerOU7aWVQDkQQRwRMEhVIBVD7+tmik+A+wzSG036DoiHX/VCGTj7T0WQ8w4V+43EKrdRsWhWllbdy+C/sqGxx6Ppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765943392; c=relaxed/simple;
	bh=pW2QlE6FHidi8nNjbFZRbrCzZPMJ39+70QN3XQQVR5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=TnvXqLX/5chW+MqGM8bpWhmdi28kzVLSIRm65ZS2Ixm7W74Tf5gJgxoioUIkBWV3oo7orS0+BvlgQh6+gGOv7EM7cAxbiCQKQ+CMlY31f3qzsap0cu+ITqlJrlPFcSlQOZaCe5yvU9CbP5t+xcwEQ7KmPK6s+bgqo1lnHBM4wgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OqvrxpDV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH0UcW2027965;
	Wed, 17 Dec 2025 03:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=pW2QlE6FHidi8nNjbFZRbrCzZPMJ
	39+70QN3XQQVR5Y=; b=OqvrxpDVmBDx2fVN4vQ9518XGDNT5sz6WayTeCJdgFO+
	dzw7FW0bv0bfLWPbMgwP4AH1nUGViuHTWGXf+7TLml3PHwxnPKoL2JG49uM0miia
	Etv/fD3QO7mdMTHnx3ny0J1Z0UW7nygsgLLJRITxkstQXm4iAIbN2LXddcvKRoYS
	oCs8XkjVWeH2S+dPEg7BLDYfS5UOd+7EIdwNAWOZcg3pwih8uF9hNcDTcPdg/lCp
	cfFrJ2GIFptfBMEbt1cd1KCeBeB6UvQLgzUioL03J/BiXC9n9oYiX3KOQSeJbLiG
	4dhsMYk2/f0ob9sLn4xFjXOQbwHvqaXYTSM3Qx7IqQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8jv5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 03:49:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BH3nhNW017761;
	Wed, 17 Dec 2025 03:49:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8jv5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 03:49:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH0Xoki005762;
	Wed, 17 Dec 2025 03:49:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgnxubt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 03:49:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BH3ndTr41615740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 03:49:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5D952007C;
	Wed, 17 Dec 2025 03:49:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18D432007B;
	Wed, 17 Dec 2025 03:49:37 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.36.2.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Dec 2025 03:49:36 +0000 (GMT)
Message-ID: <7810b263e0fb16002609fba72321fabd5f0bbc4c.camel@linux.ibm.com>
Subject: Backport 353d7a84c214f18 ("powerpc/64s/radix/kfence: map
 __kfence_pool at page granularity") to stable versions 6.1 and 6.6
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: stable@vger.kernel.org
Cc: ritesh.list@gmail.com, hbathini@linux.ibm.com, mpe@ellerman.id.au,
        aboorvad@linux.ibm.com
Date: Wed, 17 Dec 2025 09:19:35 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX8vs52zsDPeug
 f0xzidz9hM6uKntbJbvpAgVcoIeOUxoOkeXtugDzFUTKnnkWW/z5QZJWpDw70CHr10SgEqAGYCv
 q3XpGv7YaO2VrVVKWaKJFrECtUg+Tg3rR6Ae9V0+5qemaYNrikJPgS09ttZ/d2mWThvsCNeH2uj
 QR0u56iv/ghe5TlIWcUM2GXiABzT0o2MnIojT1U998X50iUpm6wcNGuBCVE+OzPbtpNR2rVImLz
 ouPo3TvryI9Ad6QRryondi112sOp4dqmRgJcaA7I2SW4GnhEdXtyiGAqtOPaqjIvNYYoKF1MFLf
 YO1oPzMuLby1swOYgnXNtmmbXwRiU+YA4qsq26tNf6pwHjBL8jckveO7pECaW3tYHR+1WKMD9Ve
 JuqpSh+j9593k/Koq0CcpMLjzAa44A==
X-Proofpoint-GUID: _H7S4ET8Lbsi1qbwUpetLyObXawp9ZaH
X-Proofpoint-ORIG-GUID: pyBBxJ5qPFxfVQFuOak-LEILM7RH_RjE
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=69422858 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CMVkVpoZhnF4WN8l1R0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018

Hi stable maintainers,

Please consider backporting upstream commit
353d7a84c214f184d5a6b62acdec8b4424159b7c ("powerpc/64s/radix/kfence: map __=
kfence_pool at page granularity")=C2=A0
to the stable 6.1 and 6.6 kernels.

This should be backported because it restores the intended KFENCE behaviour=
 on powerpc64 radix MMU by
limiting page-granular mappings to the KFENCE pool, rather than all system =
memory.


This commit appeared upstream in v6.11-rc1, and fixes an issue introduced b=
y=C2=A0a5edf9815dd7 ("powerpc/64s: Enable KFENCE on book3s64")
but it is not backported to stable versions.

The patch applies cleanly to both 6.1 and 6.6 stable versions.

Thanks,
Aboorva

