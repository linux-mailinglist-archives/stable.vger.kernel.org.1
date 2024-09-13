Return-Path: <stable+bounces-76109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF3E97893C
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 22:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7465CB2421E
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 20:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E70D146A9F;
	Fri, 13 Sep 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HzOfART7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3CBA2E
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257805; cv=none; b=Oi+mVxH12rs8/E+4RRNXnDlomkDg7jFzFZ4AIoy2iLqREKN3wrpRFjA5qiybktcwT68D0c3PQyIbBhdhSBwPzdE3p2sSU5yIXkps33ucdC1txPdKBRO/qp/IwViBFQt4bOXzMkD7uJyVmiBZWBsPgjk2Bvp0XYmnUGRCtezAM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257805; c=relaxed/simple;
	bh=8LLZRYM7c13O9q3MIbGrKIrbhmpC+vGwEWD3lL1NACc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A7SU8ude56MrU2bRWHR5Rio89LMVx52mED+vJKSq9XfsybzSb1ys6Axi1qXzXnmtnemZHVRKCNaRxjAHoxP0pyBSQ2OK9hS9vr7E8mahfHN2gIiAdM1pG29MNYy7DOp813CQN3Bd3YFTJyxj5dRv6bcvuSRwG85d3uNBStYHnTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HzOfART7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ13Y2006355;
	Fri, 13 Sep 2024 20:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=PxqMiw7kuRI7J6
	7JaZIuSwLjfUuCoAV3doY9aR4k7d0=; b=HzOfART7HH48Jne2IaFupNJsKtvyOg
	NHCDNtU4Ml+gE3GQ819A4Yg2ne+vQTYTTP6VBBJ08PCsHz1lUar29NEhIUeTBEnb
	lMD4JqNlGeRSGBwF/2Wa7a6jXEbcz7jCT6geYRJo3tkbaqkJpecvhT76d+S3eVmX
	K5uSDdkhZ+d7VHkGXftCYBBorrGBFrhs5LzMaB9EorU2B3eImXCc4o2aKxzCSYoQ
	qiWO5LkIi2LuWSvcN+c4qJPMgBdxJT8MA27SZ82fhsmy7h5xhRiOG+by1mhgKDoe
	uxm5IFqVCUhcGgVeApbzckx7X3Viroc53FwUyd9Q9kxvyMMgWNEuMDYw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcxks8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:03:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DIXZ7w032388;
	Fri, 13 Sep 2024 20:03:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9ke3sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:03:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DK1HJP017052;
	Fri, 13 Sep 2024 20:03:18 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41gd9ke3c9-1;
	Fri, 13 Sep 2024 20:03:18 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: stable@vger.kernel.org
Cc: gautammenghani201@gmail.com, skhan@linuxfoundation.org,
        usama.anjum@collabora.com, saeed.mirzamohammadi@oracle.com,
        samasth.norway.ananda@oracle.com
Subject: [PATCH 4.19 0/2] kselftest fails to compile on 4.19
Date: Fri, 13 Sep 2024 13:02:38 -0700
Message-ID: <20240913200249.4060165-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=614 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130142
X-Proofpoint-ORIG-GUID: MFdkVJgZv37eszGhrSzSyss-RNocB5QM
X-Proofpoint-GUID: MFdkVJgZv37eszGhrSzSyss-RNocB5QM

In the linux-4.19.y kernel kcmp_test and compaction_test kselftest fails to compile.

kcmp_test.c: In function ‘main’:
kcmp_test.c:92:17: warning: implicit declaration of function ‘ksft_set_plan’ [-Wimplicit-function-declaration]
  92 |         ksft_set_plan(3);
   |
         ^~~~~~~~~~~~~
and

compaction_test.c: In function ‘main’:
compaction_test.c:186:9: warning: implicit declaration of function ‘ksft_set_plan’ [-Wimplicit-function-declaration]
 186 |   ksft_set_plan(1);
   |   ^~~~~~~~~~~~~

The function definition for ksft_set_plan() is introduced by commit
5821ba969511 ("selftests: Add test plan API to kselftest.h and adjust
callers") which is present from linux-5.2.y onwards.

Samasth Norway Ananda (2):
  selftests/vm: remove call to ksft_set_plan()
  selftests/kcmp: remove call to ksft_set_plan()

 tools/testing/selftests/kcmp/kcmp_test.c     | 1 -
 tools/testing/selftests/vm/compaction_test.c | 2 --
 2 files changed, 3 deletions(-)

-- 
2.45.2


