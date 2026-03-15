Return-Path: <stable+bounces-225460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPCiHzsvtmnL+QAAu9opvQ
	(envelope-from <stable+bounces-225460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 05:02:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477528FE24
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 05:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C5CC303E682
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 04:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB941F4176;
	Sun, 15 Mar 2026 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UofzqzwQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3E1A6833
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 04:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773547318; cv=none; b=IA2yWoxhm9Hn4wCtTg+JlcXiESjlOATyGFvRz+sWey1vEHLOx6rGW7GX41eq5jO12Lv82MFK1a7iaWEBqUosL8Ck/4vuCYrnFuwAaUCxTtlAA0CnJgJdFzGDbdy8btL2rQhlZN7A+Q9BQdxMT46UcUp4fZ2fY1Ld5zhcG5+9icM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773547318; c=relaxed/simple;
	bh=zsdjG+dysJ2t9fMc7MvqEgAdyle+FxpQUI4droBsN+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUmt9e7NEUjJGrdm6ahfoCY19yp7cmzcNAG+XG91HIT+R2xJPJq2elY6+E7uS5MnHaw+BLJvKaJYK9mpFxfCsbdLXdZu+Y1p7Knwesqni+DzPAr+CCrU8LhSKVBcNPTEJzfscLmYW6wQLZoqOwzPE1hvGrPEV2Wuoiv49/LVE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UofzqzwQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62F3TK542985157;
	Sun, 15 Mar 2026 04:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NRnY2/
	LgEE/zccs/dGs41ukenTXTHCNJi6tHwKdmXio=; b=UofzqzwQyTEFrikbJrSX/J
	S0Ma1Rr21eFWoqP1XZiLvZww9ni4Cdz5fRfnUm8j+zJhLtNDPaKsnmdwH48ZL6em
	BwalEvOmOWnBMJND/t6yCSJbLOwvn0IM6++5NLOYeKSg+E/63r6gtRX34a3EH3U3
	xboiW3x+qPBKoxk46rWKicEUl4eQvCOoA0cqoM0DXgeNuQ/FA3i/U0yUwt09YajU
	PdjKbkvkW95FbfHVl/yZFN69ylRPX4Yp0J77cYsPRGQ7oplgEoQ+qtQZ4NgsDJv2
	h6YafqC/uVsvVzw1/qXGQEqdzBscb7Qs1KchVL+RE+hv75Hr4oOBce6LPZ+qsoPg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybru27r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 04:01:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62F3FLmY028465;
	Sun, 15 Mar 2026 04:01:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1030a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 04:01:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62F41ZeF17170718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Mar 2026 04:01:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FFC32007A;
	Sun, 15 Mar 2026 04:01:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E02452004D;
	Sun, 15 Mar 2026 04:01:31 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.97.251])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Mar 2026 04:01:31 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        Nilay Shroff <nilay@linux.ibm.com>
Cc: nicolinc@nvidia.com, joerg.roedel@amd.com, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, sbhat@linux.ibm.com, stable@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] powerpc/iommu: fix lockdep warning during PCI enumeration
Date: Sun, 15 Mar 2026 09:31:30 +0530
Message-ID: <177354720786.2367911.17952918247021806252.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310082129.3630996-1-nilay@linux.ibm.com>
References: <20260310082129.3630996-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b62f24 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=p2E9MDjRwVkQTcis9DIA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: bz3SaqE8W-VABnYB_T9OgHu8MYirWbeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDAyNiBTYWx0ZWRfX3ccoNrIK6Up/
 wpkWoN7U4gzxlU+pac+gYQ+MUgxN/b2oQCjKUDJXog8b40N6+UdW14GT+cmMvnuKcSnCzyUJ/33
 uxnSL9nyrOIDkCzlBgfjstHU9ogxzC8dXy81mlGESnu7uy6iMEn7zI3VTOEoE7yRjL45b0lOUsR
 3WSbIkB663aNLu/KSWspqGVnEYYVDKKDqXNTPzsvBEfB2syrwf3GeUqRqQgBII+UZNM84SFL9Q8
 RxK24izTCJp0wqM+FA5qxd6WJaNh2/ABed23+ekZTSvVx/Q8U5o9iAwATmRkF9MGtkNTM7yhXfY
 4I+lWcaI8BeIE8aNSjdUpIk/YRKbo8PWFcl8TZ6NVf6bVU8ZszP6BMYIAD+HewsfJULi75FUALP
 M8G9xgkdRkH/7zEjXLpeGyBODrWpU0IPJfxTcjl0E21uyiEbXrrPW63tJSncjd9hpNFISGoXfFh
 pYFX43zqy3JDdB8t0TQ==
X-Proofpoint-GUID: bz3SaqE8W-VABnYB_T9OgHu8MYirWbeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603150026
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225460-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[maddy@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2477528FE24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 13:51:24 +0530, Nilay Shroff wrote:
> Commit a75b2be249d6 ("iommu: Add iommu_driver_get_domain_for_dev()
> helper") introduced iommu_driver_get_domain_for_dev() for driver
> code paths that hold iommu_group->mutex while attaching a device
> to an IOMMU domain.
> 
> The same commit also added a lockdep assertion in
> iommu_get_domain_for_dev() to ensure that callers do not hold
> iommu_group->mutex when invoking it.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/iommu: fix lockdep warning during PCI enumeration
      https://git.kernel.org/powerpc/c/82f73ef9c41e0623e0a8bdce4fa44a7237709f0c

cheers

