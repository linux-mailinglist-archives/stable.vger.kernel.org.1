Return-Path: <stable+bounces-256642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFFcBFShGWq7xwgAu9opvQ
	(envelope-from <stable+bounces-256642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:23:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBCF603757
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C97673112D0E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8633A9EB;
	Fri, 29 May 2026 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sIsK/TYT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88C2E7381;
	Fri, 29 May 2026 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063867; cv=none; b=Kz2aSzeJpknxbyPDVD2dQ7jyqjpPnXm+Yla/y9qyrwiMuyP7fSAO9HC6BRGPnni8trEA6iScf+lvQcjdtHnj+CUr+nmzw2Fr53mhn4s7m7QxlrZq0za3vPRrHxOVfkDc0wsWgrBMATkN6LUAwava5M2r+PJH2XbI1uLbnbXkrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063867; c=relaxed/simple;
	bh=XVlQg+/h1vSCThb7iGl0DNWVJafcEcVn1hfKtGhR6fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jsJAM4/9k80BoUMDwNnr9izeu3jAmUvKxjwkAG5+y/TZILNQM14pJCIsBCEI4BxeY91i2tMBNttCuq4P+UYc0sc0o9y5yZZmXZGtKOvbqeLA1HvaHWbB57ewKuARb20NanUvYUQWSCYzR30SY4Fp2UK56KDOg64Ia7X2P77AL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sIsK/TYT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TBbKvt2418177;
	Fri, 29 May 2026 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=lgbPAz26tAknd8qvQW4f5tYMn929446gN9YHMUjWj
	Bo=; b=sIsK/TYTDQMJxAxZBAMk2kex5MjQs7rkSE64xvqdl1mzTXSeJjbNMetQd
	dZbgWcR5BQRk42CqES8yuA0FTPmWCQw3EwCKLHe4zne237mRbVWWiS8OIj4gsaoj
	JcwjgyPEI1P+a/E2gMMz4HO7YUlh6tVFw4Ag7lKMKedsbxGxSrKR3v3n2bBqQjM3
	Me1OWozm/io/iyTm+sGc4/bsH41AAqeE75UH2eRYIUo0+aqf1/6Ssb9FFE6aM+8W
	Poua5Z/0ft+DHDDn6ED7R8DcwHF8nuh/kZ4XXuFKXaKIJYh9fBu2Y4hkokUU/S+3
	sfG/j8L+lAm33p7KWPgczh/4WPy+A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884s56g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:10:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TE96w3027125;
	Fri, 29 May 2026 14:10:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbdyfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:10:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TEAniJ34013510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 14:10:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B4E22004D;
	Fri, 29 May 2026 14:10:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 380FA20040;
	Fri, 29 May 2026 14:10:47 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 14:10:47 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, atrajeev@linux.ibm.com,
        harshpb@linux.ibm.com, stable@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH v3] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
Date: Fri, 29 May 2026 19:40:31 +0530
Message-ID: <20260529141032.69559-1-gautam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a199e6e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=dkYHUGA-BDwxkZPz_lEA:9
X-Proofpoint-ORIG-GUID: IMJAOJv4ObE1BMRJRflC2YmpI8lFl0Jw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0MSBTYWx0ZWRfX187YlHsiJbUL
 5JokN0h1VxwZTTP0zHyy90T5xWG7jmq/yvy1AUjB6vp8oPllUvjF6XPX5DtF+m53v+W/1fVTOdt
 Pjqx4paNguhLlnlZW+cdADtv1ZNtsHGRbxBVrdWxtGnOQR2P7rQeqa/u0jmDvCytTbDFWje6YOh
 fJZ6HrSgQH9OTOh/BeZW830EmIJReitfQrS+QTA+jGkBoOmwKhu0/J4DpK1EdSfvlsyeYhG8hCY
 9asjw+8+aoKLX95CIFrj66LHqQpfNovF2oWZYj53RgIYUQxHDffL2rZ9iQLK8dG9sh5ajCOyi72
 vAIGTGH1TivlYLlSIVKjl/6DO4I59YYMAeuP4ZozAjrEgGeZx82Zyx42tg95V4BxhQ7TsuV+/PE
 0+RLtSsZckU21WSzgdUeYWDmO3ykzzM5nhs+q0U9xUZ6jREaxUGlVfa/ypm+xuy0phI0KksFPdc
 1VNYrfot/SoircqqkQg==
X-Proofpoint-GUID: lRQ20GSOgXYU8galxn3fTwmrFCsIs-OK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290141
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256642-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gautam@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7DBCF603757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, CONFIG_VPA_PMU is not enabled any of the configs, and
consequently cannot be used for KVM guests at all.

Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
being used.

Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")
Cc: stable@vger.kernel.org # v6.13+
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
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
2.53.0


