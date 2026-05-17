Return-Path: <stable+bounces-249128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O5vMD7+CWqqvwQAu9opvQ
	(envelope-from <stable+bounces-249128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:43:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2422B562B70
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71295301A730
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85143C98B8;
	Sun, 17 May 2026 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Az7DPPiM"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9323E358;
	Sun, 17 May 2026 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039651; cv=none; b=enVtIfOb5P8fk39lM2YjhGADs5vsN3tI3ubcV0gc2prk2NXZ2kuIBXNojfAMuds0Ztwro5O/4MyRQA4TXk81Q1BpFcClzlaiYFT/LwD+7/DW3eyb+MBEEvBQpeioeMsQ7lnRAEpfkhJ27y0k6IrEraXRPfbiwmKDQPwJ8yAqKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039651; c=relaxed/simple;
	bh=wH6KQElnXmJNot4JdlxGLdVwTdNNy9mi7IeNDGNZDDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNpN7D0xL9gP2udVAXWw8cKB//Cs79c4tKr8EimXfE2GpsKf3Bhr787uroZLNwS6ulb352X2D8rEfBccUkZck4bXNcOC2RP88qyE9M1xPBMsYDSJoONDbiP+qIJTIEnN5wAzjWRbdpE/8VHZgGca+pDHuqPBwRKGd8BMXtOHEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Az7DPPiM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HBuOJo3974750;
	Sun, 17 May 2026 17:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QdWsGgPZ5jZnC7RWqDFsCAd/CZNEz7qUwHdyKk6WX
	F0=; b=Az7DPPiMcSBmuiGhOXXKNmQyB/qxsh3//V8A57MsxxzijA2drRuWv8YZF
	wo8ETdX0svpPXYwvYqsHPL6T1PVyiNwImYQKe5QAKXt3WjO3IEz8tK8UBGwNgseZ
	1UvkCrKDRxhcPb5OlJ6MPRYEtmlHGvqMGolMf0FV1LPluEYgaIzc3FQ7x6SCI9cO
	+NwWzxEPCHWt7iF/q+vwsyxRb1u6PjKafjQ2EncbrUNVlbKl+h46kpfgTqir8nyO
	18OzLULxA5JM8cfaWvgI9Dhcl9j32Y1LAVXA0YF8Xt/pYCnV+HahBtvcVPCzTZw1
	KQZ38hNOSHcIN3LykkJZ4RXzak01A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mcng4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:40:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64HHd7rC021278;
	Sun, 17 May 2026 17:40:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vjj97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:40:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64HHePWm36897172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 May 2026 17:40:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE9F02004E;
	Sun, 17 May 2026 17:40:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E22FB20040;
	Sun, 17 May 2026 17:40:22 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 17 May 2026 17:40:22 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v4 0/5] powerpc/bpf: Add support for verifier selftest
Date: Sun, 17 May 2026 17:40:38 -0400
Message-ID: <20260517214043.12975-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QYIM5TJUb7Ati4bexMi3mbR5wKG_43RZ
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a09fd8e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UrLCjDVe54a93DmA31EA:9
X-Proofpoint-ORIG-GUID: QYIM5TJUb7Ati4bexMi3mbR5wKG_43RZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5MCBTYWx0ZWRfX1EnRNxeyankE
 JpGSI4w4ct0JNE/Jsnk3bQ4Omgi4lmnEOR/S87mRKf8Oh2H/JGvePQ7m+JR4Wcst1mmzKyYh23h
 /yRTyYaeDVVwP7kvppFdmRommAZu/FoLXLAWG5Uiei7+wZ0A4NrOdCosiu3IQU+uZU7HHMBXKLh
 +4yfSc24+KTR1unUyGyErinlYZIOnpA/v489KJgDBkd/m4F0P4zd8RbFggDYZZnwl3QcdZmv4Et
 pvNSm2EwHWFCk3fwEj+PvqFzvung/1wH+2naWlyDrXYxlx2SyeB4LnOjy4C6p4uIrMrZv3YLlGa
 Y10+QyAbpioQEIaZX6ZQVOWX0XHa34pKZtrWEDSxxsDqwWGFeBwoBwSm5SgdL1Jtdg+k/cD0Zvv
 DoNWH53WV9nEuO9+oCsfARkEv+DLcBnTDGqmq82c3ZvSFkSkmh5Rse9NiJl/0t7+hF3UOAxnCTE
 X/cEthHbgYOCovJmeJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170190
X-Rspamd-Queue-Id: 2422B562B70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	DATE_IN_FUTURE(4.00)[3];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249128-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adubey@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

From: Abhishek Dubey <adubey@linux.ibm.com>

The verifier selftest validates JITed instructions by matching expected
disassembly output. The first two patches fix issues in powerpc instruction
disassembly that were causing test flow failures. The fix is common for 
64-bit & 32-bit powerpc. Add support for the powerpc-specific "__powerpc64"
architecture tag in the third patch, enabling proper test filtering in
verifier test files. Introduce verifier testcases for tailcalls on powerpc64
in the final patch.

The first patch in series is fix patch, correcting memory alignment with
8-byte boundary for long branch trampoline address. The subsequent
patches enables verifier selftests on powerpc.

Issue Details:
--------------

    The Long branch stub in the trampoline implementation[1] provides
    flexibility to handles short as well as long branch distance to
    actual trampoline. Whereas, the 8 bytes long dummy_tramp_addr field
    sitting before long branch stub leads to failure when enabling
    verifier based seltest for ppc64.
    
    The verifier selftests require disassembing the final jited image
    to get native instructions. Later the disassembled instruction
    sequence is matched against sequence of instructions provided in
    test-file under __jited() wrapper. The final jited image contains
    Out-of-line stub and Long branch stub as part of epilogue jitting
    for a bpf program. The 8 bytes space for dummy_tramp is sandwiched
    between both above mentioned stubs. These 8 bytes contain memory
    address of dummy trampoline during trampoline invocation which don't
    correspond to any powerpc instructions. So, disassembly fails
    resulting in failure of verifier selftests.
    
    The following code snippet shows the problem with current arrangement
    made for dummy_tramp_addr.
    
    /* Out-of-line stub */
    mflr    r0  
    [b|bl]  tramp
    mtlr    r0 //only with OOL 
    b       bpf_func + 4 
    /* Long branch stub */
    .long   <dummy_tramp_addr>  <---Invalid bytes sequence, disassembly fails
    mflr    r11 
    bcl     20,31,$+4
    mflr    r12 
    ld      r12, -8-SZL(r12)
    mtctr   r12 
    mtlr    r11 //retain ftrace ABI 
    bctr

    Consider test program binary of size 112 bytes:
    0:  00000060 10004de8 00002039 f8ff21f9 81ff21f8 7000e1fb 3000e13b
    28: 3000e13b 2a006038 f8ff7ff8 00000039 7000e1eb 80002138 7843037d
    56: 2000804e a602087c 00000060 a603087c bcffff4b c0341d00 000000c0
    84: a602687d 05009f42 a602887d f0ff8ce9 a603897d a603687d 2004804e

    Disassembly output of above binary for ppc64le:
    pc:0     left:112    00 00 00 60  :  nop
    pc:4     left:108    10 00 4d e8  :  ld 2, 16(13)
    pc:8     left:104    00 00 20 39  :  li 9, 0
    pc:12    left:100    f8 ff 21 f9  :  std 9, -8(1)
    pc:16    left:96     81 ff 21 f8  :  stdu 1, -128(1)
    pc:20    left:92     70 00 e1 fb  :  std 31, 112(1)
    pc:24    left:88     30 00 e1 3b  :  addi 31, 1, 48
    pc:28    left:84     30 00 e1 3b  :  addi 31, 1, 48
    pc:32    left:80     2a 00 60 38  :  li 3, 42
    pc:36    left:76     f8 ff 7f f8  :  std 3, -8(31)
    pc:40    left:72     00 00 00 39  :  li 8, 0
    pc:44    left:68     70 00 e1 eb  :  ld 31, 112(1)
    pc:48    left:64     80 00 21 38  :  addi 1, 1, 128
    pc:52    left:60     78 43 03 7d  :  mr    3, 8
    pc:56    left:56     20 00 80 4e  :  blr
    pc:60    left:52     a6 02 08 7c  :  mflr 0
    pc:64    left:48     00 00 00 60  :  nop
    pc:68    left:44     a6 03 08 7c  :  mtlr 0
    pc:72    left:40     bc ff ff 4b  :  b .-68
    pc:76    left:36     c0 34 1d 00  :
    ...

    Failure log:
    Can't disasm instruction at offset 76: c0 34 1d 00 00 00 00 c0 a6 02 68 7d 05 00 9f 42
    --------------------------------------

    Observation:
    Can't disasm instruction at offset 76 as this address has
    ".long <dummy_tramp_addr>" (0xc0341d00000000c0)
    But valid instructions follow at offset 84 onwards.

    Move the long branch address space to the bottom of the long
    branch stub. This allows uninterrupted disassembly until the
    last 8 bytes. Exclude these last bytes from the overall
    program length to prevent failure in assembly generation.

    Following is disassembler output for same test program with moved down
    dummy_tramp_addr field:
    .....
    .....
    pc:68    left:44     a6 03 08 7c  :  mtlr 0
    pc:72    left:40     bc ff ff 4b  :  b .-68
    pc:76    left:36     a6 02 68 7d  :  mflr 11
    pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
    pc:84    left:28     a6 02 88 7d  :  mflr 12
    pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
    pc:92    left:20     a6 03 89 7d  :  mtctr 12
    pc:96    left:16     a6 03 68 7d  :  mtlr 11
    pc:100   left:12     20 04 80 4e  :  bctr
    pc:104   left:8      c0 34 1d 00  :

    Failure log:
    Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
    ---------------------------------------
    Disassembly logic can truncate at 104, ignoring last 8 bytes.

    Update the dummy_tramp_addr field offset calculation from the end
    of the program to reflect its new location, for bpf_arch_text_poke()
    to update the actual trampoline's address in this field.

    [1] https://lore.kernel.org/all/20241030070850.1361304-18-hbathini@linux.ibm.com

v3->v4:
  Changed logic for emitting alignment NOP

v2->v3:
  Removed fixed NOP from bottom of long branch stub
  Rebased on top of bpf-next

v1->v2:
  Added fix-patch to correct memory alignment in-place
  Moved the optional alignmnet NOP before OOL stub

[v1]: https://lore.kernel.org/bpf/20260225013627.22098-1-adubey@linux.ibm.com
[v2]: https://lore.kernel.org/bpf/20260403004011.44417-1-adubey@linux.ibm.com
[v3]: https://lore.kernel.org/bpf/20260411221413.44304-1-adubey@linux.ibm.com

Abhishek Dubey (5):
  powerpc/bpf: fix alignment of long branch trampoline address
  powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
  selftest/bpf: Fixing powerpc JIT disassembly failure
  selftest/bpf: Enable verifier selftest for powerpc64
  selftest/bpf: Add tailcall verifier selftest for powerpc64

 arch/powerpc/net/bpf_jit.h                    |  4 +-
 arch/powerpc/net/bpf_jit_comp.c               | 60 ++++++++++++----
 arch/powerpc/net/bpf_jit_comp64.c             |  4 +-
 .../selftests/bpf/jit_disasm_helpers.c        | 13 +++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
 .../bpf/progs/verifier_tailcall_jit.c         | 69 +++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  5 ++
 7 files changed, 136 insertions(+), 20 deletions(-)

-- 
2.52.0


