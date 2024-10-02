Return-Path: <stable+bounces-80555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4598DE6D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3CAB28807
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB71D0792;
	Wed,  2 Oct 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QADBWvk5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246B1D014A
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881620; cv=none; b=V9te227FaZBMTiJwT17TP2jc7WNWY5nZmGjTnTua9RSiykX4hqL5hI/DzCr0O9HwF/5n6MfgW5C//FR7ANo6dSpuzJ1o4Vfrz1S9qJU1oSHwku7JrX8QOaPrHNdxpwJQuYHOSY614mJ8HLZBZQBabaONlfzpZEm6aA/7mACUljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881620; c=relaxed/simple;
	bh=XrwlWeNI78go6xh3nJDpH8lxzFJNagk80F9Bdh/Eqls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cn4Zhd84rUAcgDvK5q21uMGa+ln3dWq2ImA9tic0fQ4LkPZnlKl3MinBTLMEr16MKO4x2uDymVu1XZRbpXZ+1QbIPSDdxX1dJr7xzfqnxCkGySgG57iZ53IUa7zPUEXTiocqcRiETnoJi739l2vNtBkov7BsRymezcD6kVlmrNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QADBWvk5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd4Ur011625;
	Wed, 2 Oct 2024 15:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=e
	RsyE80CLkIP8kqa9r3Sp+xqAIBF5dlfczOBcKg69Y0=; b=QADBWvk5wtOwA/VoV
	nlkZ684TDsth9+tEwc0068o9rcFftiOlPR+DtIiioDjthIy0oae7Gc7N+4hJxeOw
	in+OdCK8wTHvUJAEyq63dy/PM3GZwScK8eMPPfANvvIVSlizwzgU4uuVopx6gzYp
	E4ALe6QaOO8EHK4cEveCdCXpBg0EHsfuZy5VSxqCr6XP/ibGl+wElt0uJ9pXYHIo
	BCMc17SDVyqwJe8Gamm2oU66Tsuila21kQY6A38JHDl05xl0SmEfPCs8gKQy3ctN
	BteJo9YWCXPTp3ODlqIYM36BlTS48WN6zU7L1bIf+R0zr82cK7SfLq6jq3OTk44e
	pmyuA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k39p5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492Dmn1M017489;
	Wed, 2 Oct 2024 15:06:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888y0d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:44 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492F1lZK012831;
	Wed, 2 Oct 2024 15:06:43 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888xyse-5;
	Wed, 02 Oct 2024 15:06:43 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 04/15] Bluetooth: ISO: Fix not validating setsockopt user input
Date: Wed,  2 Oct 2024 17:05:55 +0200
Message-Id: <20241002150606.11385-5-vegard.nossum@oracle.com>
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
X-Proofpoint-GUID: fTCpCdZl0uGtFRKzsU89zjrQDWLSGce7
X-Proofpoint-ORIG-GUID: fTCpCdZl0uGtFRKzsU89zjrQDWLSGce7

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 9e8742cdfc4b0e65266bb4a901a19462bda9285e ]

Check user input length before copying data.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Fixes: 0731c5ab4d51 ("Bluetooth: ISO: Add support for BT_PKT_STATUS")
Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
(cherry picked from commit 9e8742cdfc4b0e65266bb4a901a19462bda9285e)
[Vegard: CVE-2024-35964; no conflicts.]
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 net/bluetooth/iso.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3ccba592f7349..c46d123c30e14 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1349,7 +1349,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int err = 0;
 	struct bt_iso_qos qos = default_qos;
 	u32 opt;
 
@@ -1364,10 +1364,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
@@ -1376,10 +1375,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
@@ -1394,17 +1392,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		len = min_t(unsigned int, sizeof(qos), optlen);
-
-		if (copy_from_sockptr(&qos, optval, len)) {
-			err = -EFAULT;
-			break;
-		}
-
-		if (len == sizeof(qos.ucast) && !check_ucast_qos(&qos)) {
-			err = -EINVAL;
+		err = bt_copy_from_sockptr(&qos, sizeof(qos), optval, optlen);
+		if (err)
 			break;
-		}
 
 		iso_pi(sk)->qos = qos;
 		iso_pi(sk)->qos_user_set = true;
@@ -1419,18 +1409,16 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		if (optlen > sizeof(iso_pi(sk)->base)) {
-			err = -EOVERFLOW;
+			err = -EINVAL;
 			break;
 		}
 
-		len = min_t(unsigned int, sizeof(iso_pi(sk)->base), optlen);
-
-		if (copy_from_sockptr(iso_pi(sk)->base, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(iso_pi(sk)->base, optlen, optval,
+					   optlen);
+		if (err)
 			break;
-		}
 
-		iso_pi(sk)->base_len = len;
+		iso_pi(sk)->base_len = optlen;
 
 		break;
 
-- 
2.34.1


