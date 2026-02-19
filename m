Return-Path: <stable+bounces-217410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EPPNmbilmnkqQIAu9opvQ
	(envelope-from <stable+bounces-217410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:13:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8052115DA82
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B7243034676
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21803320CAD;
	Thu, 19 Feb 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KVjyiEKN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E231D371;
	Thu, 19 Feb 2026 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496016; cv=none; b=B/2RN3FplP68tqo120UR7BYboQyec0aYbJEUVP0FrmAmRONqw1+dzlQ4ZT2YxIQ5rRzvAlH8Ej6bwH17Y1zk+AVHgGTAWq74LAm2XumnLVnNu7g/t7luR7osGTAV3IXQIlvYfwCrJ5fhjP8LxhtCyx3W24LQBVJvsmOrfSdEDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496016; c=relaxed/simple;
	bh=j0KfkI2Gqc8zK8JcjklAnpl9d+MMvHQH61JLoJSrofE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WqPwkFNMtC4PaHiTU1B5yOQe/RjE6vPqV0age4d3r3XgX6CMi+/e9FvhEmBJeC6UjE/YebhgzEOoHbEiOmLNxUbjFvya8/VAIszo5oR77vMS5ImXdNl5gNGYXtJNZeoThEFJY+IEY9TCAFpKbEEfNXQpxms/pLC4//54+DwV+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KVjyiEKN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J593FL1053264;
	Thu, 19 Feb 2026 10:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=WWChY8vwyEgKjbUv
	ikoOGv1dFjpM7YayBNgQjpy6WyE=; b=KVjyiEKNbQrEvRad9hfC1zL4iHvfLiOs
	hea52J+k4GHhOavJCeSGrdj1mktXk/Wm5QybNi+wwCJVXTBzZn36aSA1XtjkQwV2
	9sErJGh+tMlFmgP/qviWtfrm9PLOuoEO6U04tKzkEt/ItN0Ph9KoHt9ZMT89R1zn
	6m4mDoIhtFW6j9L1f3g58ZAWHyn2nwnejhMoULRGpiSSay2ahKA0oWuI5QlUjVUU
	OSkzpvjCfdvo4hr9IJeJ4nZyoRTboOct/aMuXqA0zDEFlVL3dOtsPyZr4X2ZEeyb
	QAtar87KBrp89TuFn2ry8SkXrBUFf58XnGKzURlXcfWxZB0hh4a2nQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0473st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J9wHKg033224;
	Thu, 19 Feb 2026 10:13:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228uet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADULi037324;
	Thu, 19 Feb 2026 10:13:31 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-1;
	Thu, 19 Feb 2026 10:13:30 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: kevin.brodsky@arm.com, linux-kselftest@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 00/14] Address pkey self test failures.
Date: Thu, 19 Feb 2026 02:13:04 -0800
Message-ID: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602190094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX29KknNIpAby/
 EzrSTMLakwIZMnv5zumby4YDeLTYBKLhyeCRG3UB4kvuZSg3W0vBnqXfebGmAktkKaTjtNkhzy7
 8pagHzXUUwEHtcRy/SMr2ynO9d3wVQbhwKBRg6MsZ8VOjbbXGMJfMjFtWdT8qP2oVCULkPWDS9B
 OMVELGSNGm9T4HsRwydfRzAtB/YcnHUEpvf+KH+8qEIsFdV1WFi1Re/Kxd6g2Dp4pl861o4ANAT
 FYjjNrqRUIHi60SieNzJ1JoJX6mvrvEbxEw1CS1VuF2R5xyaN7U/XNFFP/os86juqOoSe8Bhvab
 w3XaYTkViVEUsEiVouuTTHjGiC5dBtgurrBc+1S3DbYzNk3N2OA+JOt4OFYhjc1SHImmMzbTHOh
 jChPwTmesktc3W6c+9zXPnc5SWS0XcSvuNQEqnQXAftM2CNWmNtrA7aPskoZMHHhlW1ad20/Acf
 //fnCbmRqi+FG1GTfeQ==
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=6996e24c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=V5d1VTPOmP4a1uZCHD0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uxAfflSoJH8rDJe1w7MONXPxCqsICCgL
X-Proofpoint-ORIG-GUID: uxAfflSoJH8rDJe1w7MONXPxCqsICCgL
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217410-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8052115DA82
X-Rspamd-Action: no action

Hi stable maintainers,

When pkey_sighandler_tests_64 is run on machines with CPUs that don't
support pkeys, instead of skipping the tests return SIGILL(illegal
instruction).

# gdb  ./pkey_sighandler_tests_64

(gdb) info registers rip
rip            0x402779            0x402779 <thread_segv_with_pkey0_disabled+9>
(gdb) disassemble /r $rip-8,$rip+8
Dump of assembler code from 0x402771 to 0x402781:
   0x0000000000402771 <thread_segv_with_pkey0_disabled+1>:	c9                 	leave
   0x0000000000402772 <thread_segv_with_pkey0_disabled+2>:	b8 55 55 55 55     	mov    $0x55555555,%eax
   0x0000000000402777 <thread_segv_with_pkey0_disabled+7>:	89 ca              	mov    %ecx,%edx
=> 0x0000000000402779 <thread_segv_with_pkey0_disabled+9>:	0f 01 ef           	wrpkru
   0x000000000040277c <thread_segv_with_pkey0_disabled+12>:	0f 01 ee           	rdpkru
   0x000000000040277f <thread_segv_with_pkey0_disabled+15>:	3d 55 55 55 55     	cmp

Tests result in:

./pkey_sighandler_tests_64
TAP version 13
1..5
Illegal instruction (core dumped)

This is because 6.12.y commit: 1c6b1d4889d7 ("selftests/mm: skip
pkey_sighandler_tests if support is missing") like upstream and
backporting that needed few prerequsites, during this process I have
seen a few build warnings, so also included patches that help fix these
build warnings in the selftests.

All are clean cherry-picks. After patching the selftests the test is
correctly skipped. These additional backports cleansup the code and
avoids the need for conflict resolution and might help future backports.

After these backports.

# ./pkey_sighandler_tests_64
TAP version 13
1..5
ok 2 # SKIP pkeys not supported
# Planned tests != run tests (5 != 1)
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

And these build warnings are also cleaned up.
====

write_to_hugetlbfs.c: In function ‘main’:
write_to_hugetlbfs.c:92:25: warning: ‘strncpy’ specified bound 256 equals destination size [-Wstringop-truncation]
   92 |                         strncpy(path, optarg, sizeof(path));
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mremap_test.c: In function ‘run_mremap_test_case.constprop’:
mremap_test.c:530:50: warning: ‘dest_preamble_addr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  530 |                 if (((char *) dest_preamble_addr)[d] != rand_addr[d]) {
      |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
mremap_test.c:387:45: note: ‘dest_preamble_addr’ was declared here
  387 |         void *addr, *src_addr, *dest_addr, *dest_preamble_addr;
      |                                             ^~~~~~~~~~~~~~~~~~
ksm_tests.c: In function ‘main’:
ksm_tests.c:947:16: warning: ‘ret’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  947 |         return ret;
      |                ^~~
uffd-unit-tests.c: In function ‘uffd_move_test_common.constprop’:
uffd-unit-tests.c:1196:26: warning: ‘orig_area_dst’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 1196 |                 area_dst = orig_area_dst;
      |                 ~~~~~~~~~^~~~~~~~~~~~~~~
uffd-unit-tests.c:1195:26: warning: ‘orig_area_src’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 1195 |                 area_src = orig_area_src;
      |                 ~~~~~~~~~^~~~~~~~~~~~~~~
====


All the upstream commits are present in 6.14-rc1+, so 6.12.y stable
branch only needs these, newer stable branches are already patched.

Please review, thanks!

Regards,
Harshit

Kevin Brodsky (14):
  selftests/mm: fix condition in uffd_move_test_common()
  selftests/mm: fix -Wmaybe-uninitialized warnings
  selftests/mm: fix strncpy() length
  selftests/mm: Define PKEY_UNRESTRICTED for pkey_sighandler_tests
  selftests/mm: Use generic pkey register manipulation
  selftests/mm: fix -Warray-bounds warnings in pkey_sighandler_tests
  selftests/mm: remove unused pkey helpers
  selftests/mm: define types using typedef in pkey-helpers.h
  selftests/mm: ensure pkey-*.h define inline functions only
  selftests/mm: remove empty pkey helper definition
  selftests/mm: ensure non-global pkey symbols are marked static
  selftests/mm: use sys_pkey helpers consistently
  selftests/mm: rename pkey register macro
  selftests/mm: skip pkey_sighandler_tests if support is missing

 tools/testing/selftests/mm/Makefile           |   4 +
 tools/testing/selftests/mm/ksm_tests.c        |   2 +-
 tools/testing/selftests/mm/mremap_test.c      |   2 +-
 tools/testing/selftests/mm/pkey-arm64.h       |   7 +-
 tools/testing/selftests/mm/pkey-helpers.h     |  68 ++----
 tools/testing/selftests/mm/pkey-powerpc.h     |   4 +-
 tools/testing/selftests/mm/pkey-x86.h         |   8 +-
 .../selftests/mm/pkey_sighandler_tests.c      |  81 +++++--
 tools/testing/selftests/mm/pkey_util.c        |  40 ++++
 tools/testing/selftests/mm/protection_keys.c  | 212 +++++++-----------
 tools/testing/selftests/mm/soft-dirty.c       |   2 +-
 tools/testing/selftests/mm/uffd-unit-tests.c  |   4 +-
 .../testing/selftests/mm/write_to_hugetlbfs.c |   2 +-
 13 files changed, 216 insertions(+), 220 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_util.c

-- 
2.47.3


