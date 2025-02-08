Return-Path: <stable+bounces-114403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32321A2D81C
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 19:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFEB3A735B
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1BA1F3B89;
	Sat,  8 Feb 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S6hP4Ofg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A56241134;
	Sat,  8 Feb 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739040942; cv=none; b=JwysHw5ojSuTmyOI47wO7DEMCzZ2hfGnzrYcWohpRs5wS9AtHn2+NZPUbK8pVX/4GmXijnuIOFE+ud/PgBBYzksPBzEJRiEhk8P2Pc82SvIDkBHEhWJIfo/Sn7pptOmX5PkJrZImfygjAec+oCdZdmob4WYJVnR1cbh5JePmYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739040942; c=relaxed/simple;
	bh=HKqV33l+kZ2z72IScOQG7xAkwT/BPdByY+o4H9NCoz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+oqcIp2Ev2PzieDMguXcdrc07FY3N7JH9MW9A9GxHG4uLtsCbAjbdBT/clHf9GRFwiit4yoFNlfj0LbqdW6K4F5d5gDK54aE/fOKpkMaSWVyEK9JF+iBwVsO5qFKOk/M940BXc2YMzEdWHYSWwA3r/+ncSj+krTCfG8RTLi0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S6hP4Ofg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518He2Dp014983;
	Sat, 8 Feb 2025 18:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=vdo7MFKxncptUF+do3OtQBEpYKXq0
	WHLoGEcRo2k7Uo=; b=S6hP4OfgK0SmL6/2E6vbz32bJPcImPI54cfeBauHxXuTD
	NO5iQNvg1Ow3lXxTcMjnBWdlz9JxRwllc935BuPJ4LpEKUqfKPnSO1SxQb4GNgBS
	nyFV7DKm08RtZRAbZQv9+5v2Bratp9CFt+nTNY4apoxW5jWzvIZjq1sXbcMQrHZo
	9giIVgQ3XFhFlMomARE6kCiYqzPp+E1vNxvfy8RdJyuqXnvNDqP4V0pP1Nz7gOAN
	HNmudY6/wXNBUGf8NAbfElJytwBI9nLElgT5qKti0ebV3dxt2iy9l/pCAdkWTGPz
	RABJevcfcyEt3NA/nZyaQEd3YDnSvZdm+wXTDdIhQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sq0ebr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 18:55:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 518FDOB0002035;
	Sat, 8 Feb 2025 18:55:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq601sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 18:55:27 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 518ItR0G019946;
	Sat, 8 Feb 2025 18:55:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44nwq601ru-1;
	Sat, 08 Feb 2025 18:55:27 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        jiri@resnulli.us, liuhangbin@gmail.com, kuba@kernel.org,
        netdev@vger.kernel.org, stfomichev@gmail.com, shannon.nelson@amd.com,
        darren.kenny@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 0/2] Fix rtnetlink.sh kselftest failures in stable
Date: Sat,  8 Feb 2025 10:55:19 -0800
Message-ID: <20250208185521.2998155-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502080160
X-Proofpoint-ORIG-GUID: b3yfw6qaANX7p5e0dLlsrrs_OiQXzSDw
X-Proofpoint-GUID: b3yfw6qaANX7p5e0dLlsrrs_OiQXzSDw

This is reproducible on on stable kernels after the backport of commit:
2cf567f421db ("netdevsim: copy addresses for both in and out paths") to
stable kernels.

Using a single cover letter for all stable kernels but will send
separate patches for each stable kernel

Which kselftests are particularly failing:

2c2
< sa[0] tx ipaddr=0x00000000 00000000 00000000 047ba8c0
---
> sa[0] tx ipaddr=0x00000000 00000000 00000000 00000000
FAIL: ipsec_offload incorrect driver data
FAIL: ipsec_offload

 813         # does driver have correct offload info
 814         diff $sysfsf - << EOF
 815 SA count=2 tx=3
 816 sa[0] tx ipaddr=0x00000000 00000000 00000000 00000000
 817 sa[0]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 818 sa[0]    key=0x34333231 38373635 32313039 36353433
 819 sa[1] rx ipaddr=0x00000000 00000000 00000000 037ba8c0
 820 sa[1]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 821 sa[1]    key=0x34333231 38373635 32313039 36353433
 822 EOF
 823         if [ $? -ne 0 ] ; then
 824                 echo "FAIL: ipsec_offload incorrect driver data"
 825                 check_err 1
 826         fi
 827

This part of check throws errors and the rtnetlink.sh fails on ipsec_offload.

Reason is that the after the below patch:

commit 2cf567f421dbfe7e53b7e5ddee9400da10efb75d
Author: Hangbin Liu <liuhangbin@gmail.com>
Date:   Thu Oct 10 04:00:26 2024 +0000

    netdevsim: copy addresses for both in and out paths
   
    [ Upstream commit 2cf567f421dbfe7e53b7e5ddee9400da10efb75d ]
   
    The current code only copies the address for the in path, leaving the out
    path address set to 0. This patch corrects the issue by copying the addresses
    for both the in and out paths. Before this patch:
   
      # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
      SA count=2 tx=20
      sa[0] tx ipaddr=0.0.0.0
      sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
      sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
      sa[1] rx ipaddr=192.168.0.1
      sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
      sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
   
    After this patch:
   
      = cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
      SA count=2 tx=20
      sa[0] tx ipaddr=192.168.0.2
      sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
      sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
      sa[1] rx ipaddr=192.168.0.1
      sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
      sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
   
    Fixes: 7699353da875 ("netdevsim: add ipsec offload testing")


tx ip address is not 0.0.0.0 anymore, it is was 0.0.0.0 before above patch.

So this commit: 3ec920bb978c ("selftests: rtnetlink: update netdevsim
ipsec output format") which is not backported to stable kernels tries to
address rtneltlink.sh fixing.

fixes the change in handling tx ip address as well, so far so good!

but when I apply this script fix it doesn't pass yet:

2c2
< sa[0] tx ipaddr=0x00000000 00000000 00000000 047ba8c0
---
> sa[0] tx ipaddr=192.168.123.4
5c5
< sa[1] rx ipaddr=0x00000000 00000000 00000000 037ba8c0
---
> sa[1] rx ipaddr=192.168.123.3
FAIL: ipsec_offload incorrect driver data

So it clearly suggest that addresses are not properly handled, IPSec addresses
are printed in hexadecimal format, but the script expects it in more readable
format, that hinted me whats missing, and that commit is:

commit c71bc6da6198a6d88df86094f1052bb581951d65
Author: Hangbin Liu <liuhangbin@gmail.com>
Date:   Thu Oct 10 04:00:25 2024 +0000

    netdevsim: print human readable IP address
    
    Currently, IPSec addresses are printed in hexadecimal format, which is
    not user-friendly. e.g.
    
      # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
      SA count=2 tx=20
      sa[0] rx ipaddr=0x00000000 00000000 00000000 0100a8c0
      sa[0]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
      sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
      sa[1] tx ipaddr=0x00000000 00000000 00000000 00000000
      sa[1]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
      sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
    
    This patch updates the code to print the IPSec address in a human-readable
    format for easier debug. e.g.
    
     # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
     SA count=4 tx=40
     sa[0] tx ipaddr=0.0.0.0
     sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
     sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
     sa[1] rx ipaddr=192.168.0.1
     sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
     sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
     sa[2] tx ipaddr=::
     sa[2]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
     sa[2]    key=0x3167608a ca4f1397 43565909 941fa627
     sa[3] rx ipaddr=2000::1
     sa[3]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
     sa[3]    key=0x3167608a ca4f1397 43565909 941fa627

Solution:
========

Backport both the commits commit: c71bc6da6198 ("netdevsim: print human
readable IP address") and script fixup commit: 3ec920bb978c ("selftests:
rtnetlink: update netdevsim ipsec output format") to all stable kernels
which have commit: 2cf567f421db ("netdevsim: copy addresses for both in
and out paths") in them.

Another clue to say this is right way to do this is that these above
three patches did go as patchset into net/ [1].

I am sending patches for all stable trees differently, however I am
using same cover letter.

Tested all stable kernels after patching. This failure is no more
reproducible.

Thanks,
Harshit

[1] https://lore.kernel.org/all/172868703973.3018281.2970275743967117794.git-patchwork-notify@kernel.org/


Hangbin Liu (2):
  netdevsim: print human readable IP address
  selftests: rtnetlink: update netdevsim ipsec output format

 drivers/net/netdevsim/ipsec.c            | 12 ++++++++----
 tools/testing/selftests/net/rtnetlink.sh |  4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.46.0


