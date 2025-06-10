Return-Path: <stable+bounces-152358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E9DAD4719
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 01:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1C0189C698
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 23:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8046426E705;
	Tue, 10 Jun 2025 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RFqSyY8f"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DAA2D5401
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599634; cv=none; b=iWs7hlu/+L9K9blUvI50VkOmTQqmhV0x/2ACUcKt7WnAQILra5sNfAjyhi76kPe2WXVux97xKbFjXqLGdbuPcU+JwqSkdFHbGI0JMT/JddMyn2DpviP0to3qN+LEOcUHXq0suUt8bVqSRXSaT6wr+Xh4wm1ZMwD8UhUCWhYAzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599634; c=relaxed/simple;
	bh=6vckUp+Ok3JEU/Knk7dl/VOmFciN9e9ZubmqaN3/LtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Flm2htBBjshNR40aYmJqtSsFnWIfCcd3QrN8cjfFNB6aSmxlrVndS/Y2T0DBl7ybVALoFMlWMkg2bQ+2zz6u9w0hlnzdCOFq3F4k7x4NIrfnCgIf3vPA0LMLZ5dErdFCzTZDHN/wgi9cZrhb9mwifhiH8uEhUHUJLqnZAGgeAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RFqSyY8f; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ALtZxf016764
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=DQ0qXxcCW2pfQnkFfTEoCoLpKExlk
	HsVGSHkdWqfU3g=; b=RFqSyY8foFzarw0YhpT5RWq2dqzfNHZvfWQyKcAL5ylbi
	JjtLE2hhHQZqjwKpodQAfcMIk4uTdy2FgYqwDXRAqMPp+lPml1pl//Qb/A3dUim+
	6/JsfAcnL9kLyB0TMay+QSK3L3TTQqCxb5VG3KcBg051BX/qb6HvVFfE0DNXQWrZ
	n1m+ognC7DiKGcDTbDyIUZMeMXwTBqNeEoIQ5Q/a2YCnlFLrqoiprr4Ri+E57Xs7
	MNXxGHGQvfR+W8K6pDMGwdorjtM6NeBzqHr3EjhOUIVacPXJM5mtVCaGsO7A8FEm
	cKIkCN+SqInT7fR6okXBoGQaDQIO5feZtYRkkNfKg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf59cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:53:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AMibGZ032028
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:53:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9dhph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:53:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55ANrnPm037306
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 23:53:49 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 474bv9dhp5-1;
	Tue, 10 Jun 2025 23:53:49 +0000
From: Larry Bassel <larry.bassel@oracle.com>
To: stable@vger.kernel.org
Cc: chuck.lever@oracle.com
Subject: [PATCH 5.4.y] NFSD: Fix ia_size underflow
Date: Tue, 10 Jun 2025 16:53:21 -0700
Message-ID: <20250610235321.3021295-1-larry.bassel@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_11,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100198
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=6848c58f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=dcWaFEJkZI6S8C1ZOI4A:9
X-Proofpoint-GUID: ccntBpr_CbQboxBzimYyTDo0RpjEVQVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE5OCBTYWx0ZWRfX4rsMWng9GPAr QUyLfcv34JG8BOb0tivAI8iIPw4kY+TQjuWNn1b4loljxvSs0Np1EoWe9Nt+JAfyvGzO7GWeqI5 YswUKlaoycLLahpZ13D2KLP+06J+gnHMYUay+lpXqKpNCsBUxooSAnD+InS1L/ESFbEReFZLS+L
 zx91zjzkXSjImO6OIMyyBj1k2pxfgxKPppD/5E6iewZHrnWDtMJVPa+0b00ltGBNHQAPYjaRYuD aLWp3sVlwcu9jqHtDNNqm+1OfGuNYkBhhVEGP4vgxawj9wBJfLJQbCZr4rxe5qt5kdtsHgOxHPX C0nlJmbqTnj+sqvBypD8FX4vK/z/uYbeGj4QhuymkrQD7ljJ0pBHsv3AZ3r+kQfJ8LCnc0FMimg
 AouCO+Wtz1wuADSogwMoqtdyejL1/qkzh7NEyoz6wHQf9Ivd7opQJ/Jz12kkGpznBTDmjRDs
X-Proofpoint-ORIG-GUID: ccntBpr_CbQboxBzimYyTDo0RpjEVQVM

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit e6faac3f58c7c4176b66f63def17a34232a17b0e ]

iattr::ia_size is a loff_t, which is a signed 64-bit type. NFSv3 and
NFSv4 both define file size as an unsigned 64-bit type. Thus there
is a range of valid file size values an NFS client can send that is
already larger than Linux can handle.

Currently decode_fattr4() dumps a full u64 value into ia_size. If
that value happens to be larger than S64_MAX, then ia_size
underflows. I'm about to fix up the NFSv3 behavior as well, so let's
catch the underflow in the common code path: nfsd_setattr().

Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
(cherry picked from commit e6faac3f58c7c4176b66f63def17a34232a17b0e)
[Larry: backport to 5.4.y. Minor conflict resolved due to missing commit 2f221d6f7b88
attr: handle idmapped mounts]
Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 fs/nfsd/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6aa968bee0ce..bee4fdf6e239 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -448,6 +448,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 			.ia_size	= iap->ia_size,
 		};
 
+		host_err = -EFBIG;
+		if (iap->ia_size < 0)
+			goto out_unlock;
+
 		host_err = notify_change(dentry, &size_attr, NULL);
 		if (host_err)
 			goto out_unlock;
-- 
2.46.0


