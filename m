Return-Path: <stable+bounces-263163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QyKVJi7CL2rqFwUAu9opvQ
	(envelope-from <stable+bounces-263163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 11:13:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1181A684F03
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 11:13:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=ZOOfULne;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263163-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263163-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A4F7302A7D5
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A436D3C4B60;
	Mon, 15 Jun 2026 09:11:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B0331EBF;
	Mon, 15 Jun 2026 09:11:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514709; cv=none; b=t4YIqY0cAmlysoisIPJCb6OIyj6UT2BH0ek2p2rSH1FxF2sfknCF0W/OdNckzlBvaDYBUehEVdg6+OxekevZUqbcTkI1FXVY5gtPEqneUDSMG7iwjd7Wcmzfoi1PKNUfDyqYufEC+YPwKTfAKHd/bXsnr3qQaKThRhTrIjjCVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514709; c=relaxed/simple;
	bh=RKfj8fYq6z8JhFNDIY6GKDRgM49PIrLL4llrr4ZXSdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2bBlo2qrm9O0U5yFq5Fa4G6eioZLLeUDCsNUceiQm5LVis32GIy8F45pu45EyCBJ3VFcyOOxGgNo5JAGj8WfUgB6Xy+W8HCLleXkCQWbth5VEZcECbi0w9GC2e9obm3fNMyIesbSojqZISWe+h7sESDTib/q8Vjk5ojF5RdKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZOOfULne; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6Ljdm1626769;
	Mon, 15 Jun 2026 09:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TpXbDws8RVvixXGSPi+2oF9XLZdHFwBiCnydIDDSt
	Cg=; b=ZOOfULne9wpZLqDVu6yubgZXMvtq+ifF+V0Xm/rj5bJO+zkZf+Cyt93VH
	BdKDMek0ps6w7nCvX4SARTs15hNJKzIwfsECyZOwxQ9y6T0Hqr5AIO04lFjJ5J1G
	ZyO6IS4a6UShgOwvare2asyq5VoYT7NIlLlywfO6tQccAM/+NgtEB+1ow6MzhDFv
	h6xcBJOvuYOZgKp1Cv3KdhXHXEt2hu0Sq934fNrQmu812jgQ9pO98DZ1G6aZF8B5
	tgWWLm3fo/zhqPYphnAgIppkwW7rvwUqUcAMhDHWHQa0zVrBwMv4pVhLHtHMQt2s
	sVQxfV4aKSoerZsk642mJgujb4NpQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1efyaxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 09:11:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F94ap7024592;
	Mon, 15 Jun 2026 09:11:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg5nv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 09:11:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65F9BSD641746874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 09:11:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C865A20043;
	Mon, 15 Jun 2026 09:11:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A6D220040;
	Mon, 15 Jun 2026 09:11:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.107.79])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 09:11:26 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v5] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
Date: Mon, 15 Jun 2026 14:41:19 +0530
Message-ID: <20260615091120.84169-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX19ooKVJ/AtVg
 Ktl0yVlPGUyt+Ge4WXjUpKHWK+lI3W7LGp+zIxSVljuI1wSdl/EszNK5AZphqRCaJkQRmV3SaOk
 IVpbLuEwMkBNOwWNfSKjWxtZ7EF2n6w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX7Bix1y2AKqk5
 Dj8l5Qd5+mMgG/MlYN9Ve/ehixv4x9+UMKTzYGNZlEG3ntBB//uYvMAebo8gASk93G4lIXiZIkn
 MkQZfGQIP43wy6129wH+1uKSCxBBwcvqWmMd8rRQG11iRQ5y59FS19goC46f31dOAII/csVC6uv
 jIxvaES5YfuLzaIhRECqbjI+qF+FXzhnu/Fn47rel1Gz5w9/Z6pIqYLuytt9WRZdr3SmNS3ESgb
 B5iCN9uRM7YoKOJ4tsacumz1NUiURko80YCnrzr2+TkiwdN82RYYjV02AuzlOQJgTV9c3IJEq8X
 2Era+6wT8aKh770mObdwm7EP5Q0T38Galhzg5tzHQw73DIkdtfRUTNlfHTLNhasBp0Hl8TouQ+9
 GyMfL22rZd6oQg9X2S6Bdcp9DcUVLcmBn0fj0DYF1YsGc6P9tCGVpfPlNfK7xasPNGYsOdvjMNM
 gz4cWVkOh00qxhz9GQQ==
X-Proofpoint-GUID: d6gVcZ4PGAZyCSM5L84TTlwHjLUHdXAd
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a2fc1c5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=bjUGR1ZD7gT2lh1wywYA:9
X-Proofpoint-ORIG-GUID: jMRxZKmIQycq0eusY8QxQoM_wTcVHFW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150092
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263163-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:gautam@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:seanjc@google.com,m:amachhiw@linux.ibm.com,m:harshpb@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gautam@linux.ibm.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gautam@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1181A684F03

Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
cannot be used for KVM guests at all, unless explicitly enabled on
host kernel.

Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
being used.

Cc: stable@vger.kernel.org # v6.13+
Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v4 -> v5:
1. Drop the fixes tag (Ritesh)

v3 -> v4:
1. Reword the patch description (Harsh)

v2 -> v3:
1. Make CONFIG_VPA_PMU as default m so that it can separately disabled
(Sean)

v1 -> v2:
1. Rebased on latest master

 arch/powerpc/platforms/pseries/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index f7052b131a4c..74910ce3a541 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -154,6 +154,7 @@ config HV_PERF_CTRS
 config VPA_PMU
 	tristate "VPA PMU events"
 	depends on KVM_BOOK3S_64_HV && HV_PERF_CTRS
+	default m
 	help
 	  Enable access to the VPA PMU counters via perf. This enables
 	  code that support measurement for KVM on PowerVM(KoP) feature.
-- 
2.54.0


