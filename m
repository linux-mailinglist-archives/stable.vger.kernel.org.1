Return-Path: <stable+bounces-230601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJteIEs/xmm7HgUAu9opvQ
	(envelope-from <stable+bounces-230601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:26:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FBA340EF1
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D8FE30125A9
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E44036CDEC;
	Fri, 27 Mar 2026 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DjjN3TTq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763541C72
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600004; cv=none; b=uxUvMs92wUibfstGeKr/tgj74WUu17vLqTynbKj3s/FN9qr9Ec0KliUP178z+ThcFbYDAMTVzKwVe+TOPauCH2/mGMyLygWWKQ+iVwy2W2yZzveR2hNOgxOOkobFmUvwf6bRbjgDMzl8xZQsyVPXd9JaKzUx95dmuOhAcVq/XeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600004; c=relaxed/simple;
	bh=lSV+tHV7PYrSAldRZppHpHCR+LL/08BY2GDEGohEdOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZV6DYRM25SEZctaojNoSv3NFo8SRa91mXEIcy2Ix6ESSafD9s3YEf7aiio9rpitjYqrhMJhoAxE2G1iKIAENuyDT6UOSxma5B/7vRaunsfd0VYoeyWeUwUqVyXRwm+2mna9j2t+z2j5pTjq3CeIQmS9+knSqN3iD9tokyWY13Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DjjN3TTq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6wJJi1750645;
	Fri, 27 Mar 2026 08:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Lta4DJByxtzBgldAOn+Vi0rzhYGjnPQ+d2y
	ZkCCW5XY=; b=DjjN3TTqKLLFabyyVsj3sT7n1j5h3XQxSKFGCjlRcFf+8ChZsZZ
	7ujG8+TEZGXyuRnzsVRAMuJidFmG3K3GBDd/XbVPjOYRumO0T9KhlT5yo7UvE9pv
	Bl58TLiIJM3K6qfQ/oc/rf5jVcJhzMetP4Kn67R9Ha9lIme01SZVsaqqiD2R/jeE
	tttaX6wFPUxeZKYpooWZ9RevABCZRlGwqbhmzlISJwzpfzqHrkADsurkuMdPHC/j
	jirOqeU/qnVQ7pwsLg6l7B6d/ZSn4PLU0Jxdg8wEWEtO7Yq8At/2h+Hp5zbBzSB9
	e4IM9UCzO2GgrobeLySdnTtptQvGolXhVWA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5mn10eh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 08:26:30 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R8QSVm007941;
	Fri, 27 Mar 2026 08:26:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4d1mdnfgve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 08:26:28 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62R8QSF1007935;
	Fri, 27 Mar 2026 08:26:28 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 62R8QRiG007933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 08:26:28 +0000
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id B1C375D0; Fri, 27 Mar 2026 16:26:26 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: shuai.zhang@oss.qualcomm.com
Cc: Shuai Zhang <quic_shuaz@quicinc.com>, stable@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4] Bluetooth: hci_qca: Convert timeout from jiffies to ms
Date: Fri, 27 Mar 2026 16:26:25 +0800
Message-Id: <20260327082625.1396062-1-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA2MSBTYWx0ZWRfX4le9F228WRUO
 KexYY2deUkSdlN2yRfiap5Qmt/dzAdHBe92ghIlLWxRNAktMhkLTKUyeWIXAWbrN0lqXjeVeiQN
 rqFs83HZCST+Bt9pcUg33HWOzWtu8ikhbL2JBb4/5fctZ/Tuo3Ofn/tuZbW7itcaFMhExCJ8XjM
 M64Bf35I2JN3AwoCGYnYTejhP9D//hK/Uy9DCGoPyabYbx8Fhd1l9Ly8Nxxc6IdQSyJ/zdn420G
 V/SLaauZSolA1tH1X5UTt/3dAJuF5T3zb4hdM8p09VVQpn7EOChLOPH6LzX43tuyGH+/BXL5GHW
 8t0uxtzZ9aStpdR0JAwki+j0ZP/b+KXcrzvgwCTmDOgVCrXEprLYY11Hdr2AjUuCKziw77eQ8aR
 vF6FL3mWLLz4Q9wCzi5WqZJ1IftYyQPh9MTGiRmFkhHerHohMuQ0jR9c5+ylkgy8ePnE6HI2Cf3
 NDlAh7bpIa5LSzGQDMw==
X-Authority-Analysis: v=2.4 cv=CcwFJbrl c=1 sm=1 tr=0 ts=69c63f37 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=q0_3MJgwEqFQxuOEDBgA:9 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: VphzOk7DquiWR3kxYAOIIIZGAyLRnmxV
X-Proofpoint-GUID: VphzOk7DquiWR3kxYAOIIIZGAyLRnmxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270061
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230601-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[shuai.zhang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,mpg.de:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 86FBA340EF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shuai Zhang <quic_shuaz@quicinc.com>

Since the timer uses jiffies as its unit rather than ms, the timeout value
must be converted from ms to jiffies when configuring the timer. Otherwise,
the intended 8s timeout is incorrectly set to approximately 33s.

Cc: stable@vger.kernel.org
Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump during SSR")
Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes v4:
- add review-by signoff
- Link to v3
  https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/

Changes v3:
- add Fixes tag
- Link to v2
  https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/

Changes v2:
- Split timeout conversion into a separate patch.
- Clarified commit messages and added test case description.
- Link to v1
  https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
 
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 228a754a9..d66af13ab 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1607,7 +1607,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
 	struct qca_data *qca = hu->priv;
 
 	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
-			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
+			    TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
 
 	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 }
-- 
2.34.1


