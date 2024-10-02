Return-Path: <stable+bounces-80554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649EF98DE61
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285592822CF
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650841CFEA3;
	Wed,  2 Oct 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AgcnX01I"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18E1D0426
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881612; cv=none; b=eWbZcYgqXmrVOTBLvcoC9/E5L0fky67Ya15JVkA0V6kuhZzax+Xs/UpKGM+C55uRTthZ0Aj1nLQ+c/WhACcjSHScUz4xIlzmofmkXsEYYDZ42lP5zQxXVZQ5lUNp5SYUxzfqEwZvrTpN1/f7v4EfpoiK+NqmqQ8BxfU2WGSqZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881612; c=relaxed/simple;
	bh=siBJaIU5Nc4qgnUvmYIn4FFF4G4G7s/F/D/6Z3AdLwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YrdA9+J4XJhVGdF2Iw9/bK7LKH4PXFcO2pAKlGivGmHfV94Om2NmZgsdptL1uiccy/4AIwBTHWz4tN8mPVtcfUqQaAX8FW+8RhhCSF2tSWeRghGDi3HW3U4gIaYuEdrHnDwxsG8KTPO3BJ5n+wrjA0LOu9T6hIe4nvx8OV5UxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AgcnX01I; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd46p025609;
	Wed, 2 Oct 2024 15:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=F
	v4cZciKaW9hxb+smnzTDoCy6bntTvQ4wPVGoKaLCAE=; b=AgcnX01IU6TNiDUQR
	5UJOfUG0wm4HtcfvJJn9kj38M4zDlDMLPqMcvY1qTJ05hFy6EQ33wud5WuQjmrvI
	oG/qoeeQKSNGX4V3m7UTeS67QNj+bR8LpFWjs/z2GRyKWSwtVlWgCct9rqiSizuG
	8M/ZybcYwrUOa6gxSTMZRKpy6mvlwisbHQFnSzMvYeIetdyBRVL6NhH5gjpjHhT2
	00AB+YyAOrcqejnm7x5fSiLVyKcofzexiiYgnixJ8m/UbkiBhKYZPVcpmh19mfr7
	cmxsEYLiTYOUKtK5HLm8QsvFhCKuJI2IcKc00lg/Im/P1SblLN540wy6gEZgcSlz
	BsXxg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9ucss7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492Er2lw017460;
	Wed, 2 Oct 2024 15:06:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888y098-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:39 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492F1lZI012831;
	Wed, 2 Oct 2024 15:06:38 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888xyse-4;
	Wed, 02 Oct 2024 15:06:38 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 03/15] Bluetooth: hci_sock: Fix not validating setsockopt user input
Date: Wed,  2 Oct 2024 17:05:54 +0200
Message-Id: <20241002150606.11385-4-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020109
X-Proofpoint-GUID: 6h_-YWUBNkV0t508rZUKIEIOuf0HVAsf
X-Proofpoint-ORIG-GUID: 6h_-YWUBNkV0t508rZUKIEIOuf0HVAsf

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit b2186061d6043d6345a97100460363e990af0d46 ]

Check user input length before copying data.

Fixes: 09572fca7223 ("Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
(cherry picked from commit b2186061d6043d6345a97100460363e990af0d46)
[Vegard: CVE-2024-35963; no conflicts]
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 net/bluetooth/hci_sock.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 3d904ca92e9e8..69c2ba1e843eb 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1943,10 +1943,9 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case HCI_DATA_DIR:
-		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			hci_pi(sk)->cmsg_mask |= HCI_CMSG_DIR;
@@ -1955,10 +1954,9 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 		break;
 
 	case HCI_TIME_STAMP:
-		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			hci_pi(sk)->cmsg_mask |= HCI_CMSG_TSTAMP;
@@ -1976,11 +1974,9 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 			uf.event_mask[1] = *((u32 *) f->event_mask + 1);
 		}
 
-		len = min_t(unsigned int, len, sizeof(uf));
-		if (copy_from_sockptr(&uf, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&uf, sizeof(uf), optval, len);
+		if (err)
 			break;
-		}
 
 		if (!capable(CAP_NET_RAW)) {
 			uf.type_mask &= hci_sec_filter.type_mask;
@@ -2039,10 +2035,9 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 			goto done;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		if (err)
 			break;
-		}
 
 		hci_pi(sk)->mtu = opt;
 		break;
-- 
2.34.1


