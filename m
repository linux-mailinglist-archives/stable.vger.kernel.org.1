Return-Path: <stable+bounces-69924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B0295C2F1
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 03:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5541F2280D
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006217721;
	Fri, 23 Aug 2024 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dvg7xdAK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71AA934
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377536; cv=none; b=Hp9UuIVBw0U93zi8OT/xc9QJYsfk5XxKSyivEYCyBXWc1TkVuPdDnhP1R34l1M9mc7kRVGdxmzg84jZcggEt3ByR9UeHElS0kJw4BzIZ99bpMbXlP8OvD2hTXydd61rG91VEKHyIWDhwDv6VaWJaIrI8L8dygm1E5Ti3xViWgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377536; c=relaxed/simple;
	bh=JMJWIvFK0mgjv4lzisDegaI3W7yRwGISwX6U342F4nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7HppSUUd0TEfr+oRiZr+YlEQmJk1jyjvw5D4FglFCbaovEBlUnmJ+vXLykgd+4gv4pN+clkp7xkOcmOYGUgsLeSds2qrNQPLTlv4+0GwxQ62X6XxE3CAmFOrqYYsnwdha44Ua1Seln/g0jQf92T2V+UPOuv9wHJnEkCiVSCr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dvg7xdAK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N0BYso014713;
	Fri, 23 Aug 2024 01:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=L
	iRfE3WAGjHKeRQWZi/3e1NjtY3U5hZ85YkA7X240wE=; b=dvg7xdAKmFo7JrC/m
	Lq48PH++rZiNfciAWwoHYU2tw+7kUH/7pW8B1WHuG2KJpA1Jsm3hKT21a6ZUiBlY
	y8BwS98juoTqcTCEcAysj0+WmvlZfmk5J5a+70Sik9H+5JP6T5ATB7ad7sC1ekCF
	opSMAf37Iw/V+YwCSHMaLggjWlYlIdIdBoN6Wh56DWEru0CE7TetkUA/g+pt9YP+
	DoF8faNLdcpT+HWlvlFx3uY7QY7/fVc9ZgZBHiujX6B5X60TITPASewmHcN50Qcp
	a2TvHqa63x2vT4pGizE7MPMlGCXtIxaWTwDA6Mz7mYhJ2oI8KZqJ3r/8771SFqfz
	LWNhQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gkcrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 01:45:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47N0YEcX012191;
	Fri, 23 Aug 2024 01:45:15 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 416g0e9gb3-1;
	Fri, 23 Aug 2024 01:45:15 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: maxtram95@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        gregkh@linuxfoundation.org, john.fastabend@gmail.com,
        maxim@isovalent.com, sashal@kernel.org, stable@vger.kernel.org
Subject: BPF selftest failed to build
Date: Thu, 22 Aug 2024 18:45:14 -0700
Message-ID: <20240823014514.3622865-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711184323.2355017-2-maxtram95@gmail.com>
References: <20240711184323.2355017-2-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_01,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230009
X-Proofpoint-ORIG-GUID: 84vaS5JaquI_V4VUzaydlv9c0HukKbGa
X-Proofpoint-GUID: 84vaS5JaquI_V4VUzaydlv9c0HukKbGa

Hi All,

We found BPF sefltest fail to build with following error:

08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:1: error: unknown type name '__failure'
08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
08-09 20:39:59 DBG: |output|: ^
08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:17: error: expected parameter declarator
08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
08-09 20:39:59 DBG: |output|:                 ^
08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:17: error: expected ')'
08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:16: note: to match this '('
08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
08-09 20:39:59 DBG: |output|:                ^
08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:52: error: expected ';' after top level declarator
08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
08-09 20:39:59 DBG: |output|:                                                    ^
08-09 20:39:59 DBG: |output|:                                                    ;
08-09 20:39:59 DBG: |output|: 4 errors generated.
08-09 20:39:59 DBG: |output|: make: *** [Makefile:470: /root/oltf/work/linux-bpf-qa/tools/testing/selftests/bpf/test_global_func10.o] Error 1
08-09 20:39:59 DBG: |output|: make: *** Waiting for unfinished jobs....

It happens from the commit e30bc19a9ee8("bpf: Allow reads from uninit stack"). We did a further look, '__failure' is defined in tools/testing/selftests/bpf/progs/bpf_misc.h, and was 1st introduced in commit 537c3f66eac1("selftests/bpf: add generic BPF program tester-loader") which is not backported to linux-5.15.y.

So we may need to revert the patch, or fix it.

Kind regards,
Sherry 

