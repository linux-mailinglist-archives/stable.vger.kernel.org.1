Return-Path: <stable+bounces-203478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6BACE63A0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 09:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC48F302C210
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C226325487B;
	Mon, 29 Dec 2025 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XCvQarJ4"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A1272816;
	Mon, 29 Dec 2025 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766996175; cv=none; b=SCqpFyFCoI9345dIOcBs1M2mxhzTpQLDKIUCkxL9T1BmDPdYyE1lHmYizqc5w6t6zPj5/dVtCkroBHEoEk2RE2o2IjCxaaOvRl4zx/56C9i77ImhONQ4qUeE+AjzIXZvyheYgjM5hgmfgIOwTrLoBbPIDJs/q2tXFbeLE+nKstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766996175; c=relaxed/simple;
	bh=9ZduNwZ+omaEBjtCeAXYhwvVzjVkzYilzCGPayUO9RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UkSmLrpxd80sCnQ9ntKBI+gTO1Tpy4VxzHKGZwGcPjLfEExwtK3EHYLUCbT62qsJQMGdMTHEDNwvWLyMEkLOrW/r/4k7QNXEd4HLHSQzyjlvIk9rF3QvpvwIMfn7A+RFcumuRdao9fqxMzRG0xURNyFcin6CVUJLyXr8XeekUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XCvQarJ4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT3phjx886579;
	Mon, 29 Dec 2025 08:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=rU68r5WPCKy1om1U
	TsjlsN7hjz4pEfCD61n3SxIc5Os=; b=XCvQarJ4HkHyLGSn/dPU/ZY7ltbdEo34
	wDlXuLWnfLg7qoc9FHlvvCTE2RsHrv/paas0KOTzp9eKtAeTz69XLc70/pQlkjw+
	vURTq/B6CaThNma+tvQksdx0XCdxPnVX4UcrHRaizXn1H+QFthCtWn6cnEohvR9Q
	If/piFT75jGPQKdipb8qUPPEPbgt0MHssvZ3EmOBCRhM0fmljslleM4qHMPTIA1T
	6GnRWCKw+bDJSe8udpX5DwquwOCz6BmyDlJZ2f5idWfIV82/aeLaFwZngbAWz2Tm
	075FJL8ODW8FoDE+obqaasQD0pQQaaakQydHiiC42/qYAqEGAF9wvQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba80psauq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 08:15:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BT5UF9d037951;
	Mon, 29 Dec 2025 08:15:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w6xkdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 08:15:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BT8FRef007295;
	Mon, 29 Dec 2025 08:15:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5w6xkd1-1;
	Mon, 29 Dec 2025 08:15:27 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: zohar@linux.ibm.com
Cc: akpm@linux-foundation.org, ardb@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, graf@amazon.com,
        guoweikang.kernel@gmail.com, harshit.m.mogalapalli@oracle.com,
        henry.willard@oracle.com, hpa@zytor.com, jbohac@suse.cz,
        joel.granados@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, noodles@fb.com, paul.x.webb@oracle.com,
        rppt@kernel.org, sohil.mehta@intel.com, sourabhjain@linux.ibm.com,
        stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
        yifei.l.liu@oracle.com
Subject: [PATCH v2 0/3] Address page fault in ima_restore_measurement_list()
Date: Mon, 29 Dec 2025 00:15:20 -0800
Message-ID: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512290075
X-Proofpoint-ORIG-GUID: Jnw6qnw_bayp5PmH6Ip0ACiXY9zYrUT-
X-Proofpoint-GUID: Jnw6qnw_bayp5PmH6Ip0ACiXY9zYrUT-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA3NiBTYWx0ZWRfXzueUKIo739sc
 Hi138Bwjfirdwb5vOg3c7Wor6+fgHeHGbNodRecRy9i0gmqwV5inQvvfwcoCx+f7D8DjCCCUjZh
 U35fk6HU3DZtWBh+XTPhGVcxMDLpSHmARaaikygC5ZtP4lhXHPh1iWQBtvTEtC4YtN81W1/pjP7
 JnMjsCDTfj8fdn/Z53MRZ562Qy2CSpXqjnR+6WMD3IPELimPLkHQ1tERxdU7dH+CwY3NpGewS/x
 6Ie3xPMKdx1DfJ2Ls+7+J+gjsRmqJ+7Fweiyjwv1Tww0Doej5nYFkPZt4DkWOw/trLaR8P2os5V
 rB1yd9KseLux+tsJDrku0NsjLmOjsMEzsy95h8cAtzPRZyP31p2Dca/7e2SSfVPTuOCklMygjWh
 yE71GAq50Exb+3bN+nqNyQdgZRE+XCqv9hDydifbIIHIG9IFV2JqeaItqky3XU1p3Xj2eMsQDOK
 PfnkI85RhJMS1cTlblw==
X-Authority-Analysis: v=2.4 cv=RY2dyltv c=1 sm=1 tr=0 ts=695238a1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=o_HryE7LVYY9I7Eu9FsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10

On x86_64:
When the second-stage kernel is booted via kexec with a limiting command
line such as "mem=<size>" we observe a pafe fault that happens.

    BUG: unable to handle page fault for address: ffff97793ff47000
    RIP: ima_restore_measurement_list+0xdc/0x45a
    #PF: error_code(0x0000) – not-present page

This happens on x86_64 only, as this is already fixed in aarch64 in
commit: cbf9c4b9617b ("of: check previous kernel's ima-kexec-buffer
against memory bounds")

V1: https://lore.kernel.org/all/20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com/

V1 attempted to do a similar sanity check in x86_64. Borislav suggested
to add a generic helper ima_validate_range() which could then be used
for both OF based and x86_64.

Testing information:
--------------------
On x86_64: With latest 6.19-rc2 based, we could reproduce the issue, and
patched kernel works fine. (with mem=8G on a 16G memory machine)

Thanks for the reviews on V1.

V1 -> V2: 
 - Patch 1: Add a generic helper "ima_validate_range()"
 - Patch 2: Use this new helper in drivers/of/kexec.c -> No functional
   change.
 - Patch 3: Fix the page fault by doing sanity check with
   "ima_validate_range()"

Thanks,
Harshit

Harshit Mogalapalli (3):
  ima: Add ima_validate_range() for previous kernel IMA buffer
  of/kexec: refactor ima_get_kexec_buffer() to use ima_validate_range()
  x86/kexec: Add a sanity check on previous kernel's ima kexec buffer

 arch/x86/kernel/setup.c            |  6 +++++
 drivers/of/kexec.c                 | 15 +++----------
 include/linux/ima.h                |  1 +
 security/integrity/ima/ima_kexec.c | 35 ++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 12 deletions(-)

-- 
2.50.1


