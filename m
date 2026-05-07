Return-Path: <stable+bounces-244565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Px2M9qI/GleRAAAu9opvQ
	(envelope-from <stable+bounces-244565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 14:43:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C324E856A
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 14:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DED9C300A4DD
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B723CAE76;
	Thu,  7 May 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jNyuEDGM"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D38372B3D
	for <stable@vger.kernel.org>; Thu,  7 May 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157782; cv=none; b=nQ2w1+mSKGN4toaeXq2HQ3uRVKi+rj3bB0znB5mMnMsOCNv8IlNIN68Li4DKDthQy4hDIQORKtBQb3y72M9SverkRq1dJMtglMyIGAIZbSIDCZTR8sCgXpAPMR6ErkjZGg02fU5W9oGO3Rdrbshzq8gU4svcIPiMxh6LxlPrP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157782; c=relaxed/simple;
	bh=5hGBTPRBq1OHtBUTE/0fBkDYTAVALRnKXaoyvIZjK2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqlZsy0ktHLhIsuBJ8emUu91TZHUbV67U2dAj//mAiEYZj4Z8KrK0ZQ7A4GCaF9Gh0YtoMHKiK6XRGWqiUGYo96y/3XToYUNna5OuePEsWKIPEL55T1JY9tXNFHrmuZ19ccPbrPafAnnZoo73M4Wvzr8eA3Y/mITZNCltg5aFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jNyuEDGM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646MfWrr3947342;
	Thu, 7 May 2026 12:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=/xPEXgR1wYhPWrkyh41aIVmu1exu9
	g2d8YybGFnVo4A=; b=jNyuEDGMBKEfOYOF9bXtJnxBnjIzxIqT54bs8njJXQjGI
	pRNbwDo55TVp5a2IhjbL+qpxoLc/0TB5LtXGQ0MIk5xu0ESbZHKsAe4D2gIFNyy9
	IhmjMgT3Gca7mZ9m+FOCioiT5+NVAeXfax8SMBd1vFpKEudKFUTcLMjko0nWdLV7
	/KR1YVCWwHQSNH+t+9tLgh7J2brJa2HoBhQA7ThxSQxfQMSID4R03rEOLW+B8jaJ
	SnVWCWtCuUtrsmwG2E97volAhqyco8A1fNfc7PyhWiFRmM0t9GaF6Wbcd5OtyOgx
	ZWf/+edY03KlhVhqBsQJYfMlZrBz4WEThhEuXWP8Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9eq0s9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 12:42:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 647CaOsr015557;
	Thu, 7 May 2026 12:42:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx59504rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 12:42:58 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 647CgwGs037123;
	Thu, 7 May 2026 12:42:58 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dx59504rk-1;
	Thu, 07 May 2026 12:42:58 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org, axboe@kernel.dk
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 7.0.y,6.18.y 0/2] Backport io_uring commit to affected
Date: Thu,  7 May 2026 05:42:51 -0700
Message-ID: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=794
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605070126
X-Proofpoint-ORIG-GUID: mCvUpmxf_yBHfIuoGEyOj499kZN0cBeA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEyNyBTYWx0ZWRfX3dMtlG/gYEgm
 DeTnAXeyaZANGtGUDOby8/oGesF4j72/8WkloqldlFagyRqFwyHBMRZVfEm6ax+LyXeiVCasSPC
 +1hqY7TA5Fm1/d9nchddDcmEeCR6EGXxjaH/1ScecMcEnHWuqfx/bkr+IbBMFAP14s1xZdZnXSR
 33naY6hwgEn2yHY30HJ1k1pExlVZoMXeHHyMGCMP58Db47BYiuvlrtpxE814+wSsRhZ4Kkz4DLS
 62Ranglz+OXzQ/tjvwrpw/4gtszDtNIgXJv++H1a7WonrmjjkW6gq93XwQMkc2HGooUIYoXW1JA
 lKxu4c/keyJnh6o5tAq41NzBqHFvh6++m7YDvvtMrlCTFT08og2GJgBRe2qlNbsebSPVy6bz9nL
 OFGTHuaV3g6eyLzBbHBWq41GIuaVguBzVh3XY8W8vxuxcyHo5HgrWyTOLH0cy9lhfo6KYyU/V/q
 cgr9NShFVYcyGoZ0D5w==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=69fc88d3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=7ptRusiltMfdJ20PqAUA:9
X-Proofpoint-GUID: mCvUpmxf_yBHfIuoGEyOj499kZN0cBeA
X-Rspamd-Queue-Id: 64C324E856A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244565-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi Jens and stable maintainers,

The intent of this series is to backport commit: 770594e78c39
("io_uring/zcrx: warn on freelist violations") to 6.18.y and 7.0.y.

This above commit likely is fixing commit: 34a3e60821ab ("io_uring/zcrx:
implement zerocopy receive pp memory provider") in 6.18.y and 7.0.y.

Pulled in a prerequisite to cleanly apply the fix. Only build tested.

Please review.

Thanks,
Harshit

Pavel Begunkov (2):
  io_uring/zcrx: use guards for locking
  io_uring/zcrx: warn on freelist violations

 io_uring/zcrx.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.50.1


