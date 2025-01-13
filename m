Return-Path: <stable+bounces-108449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AF8A0BA2D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B793A2446
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AC122CA13;
	Mon, 13 Jan 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="SJk5acOl"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD422CA1C
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779431; cv=none; b=pHq5s17tY4HArcHpZ9JiVH6QKBQSOhWe2Eh3KglZTWilDgr+RDyO7xOOqg2B4YoghFxIBNa8RqkUeg7+1IE3X4e9CoOVzwB+18a9xfV0zeqH7z+VUZhG+Tcclwwx7vSQ7IRhE/Yx0RTuo4Rh27klHucTlg5CcHFUzHNp7dgTcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779431; c=relaxed/simple;
	bh=VM0o4p0zSd4bVJ30pRgmtaMDXPlEtGS7nimk5GPXd/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XjNV/uRFuaDOpftJRGyY8TwnxBj/1NLguG1BxMk/oHqmg8edyd7Kel+m2nggHC7bg/G6ISO1vypfz1J8ym7LkAQAeN4/FJUHSiHFG+3FVJx7dfzrIx+YsVvQTiSt2nBDXXK23UDSt32XU52+f8P/hxwLYc2hORBKKkwkxJaaPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=SJk5acOl; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736779429;
	bh=ajfpfvFLNkTlOGVGuLGACU1esDm5ZgHfXktoapNPqIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=SJk5acOlbJiiRGZGuSN7hOm9PBkX4GF51OpuLewWanFp07ndOM7kytItwlBWC63Tx
	 1i9oWZxd50DtqoJ9O+RlEuEirej6CsIcZDeYGJ3RJ+sF98l9j2pHNzjNy0MQ1wW13B
	 uzubuzS7fmSs1IwI+b7pY7wFKwXzEWi+M6S2Jd4XMnuGh0MJmCk1irib2Vy8prNYA/
	 cmM2oqg/foX+fH6cyvAEtlEEpJ2PiXQZDqvrpuSgPYcK7Eq6izdAjaBVbGvbmMrEOz
	 CAFX1KiBvkQ15C9ZiGPmvt0eFO9rSPugEZiK0AHGrXf4zouMVe9RXv/SvpNNkoeVT8
	 JSJQd+kJ6UqTg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id A9352CC6B16;
	Mon, 13 Jan 2025 14:43:42 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 13 Jan 2025 22:43:23 +0800
Subject: [PATCH v3] Bluetooth: qca: Fix poor RF performance for WCN6855
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-wcn6855_fix-v3-1-eeb8b0e19ef4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIomhWcC/03MQQ6CMBCF4auYWVvTaR0CrryHIQSHVmZh0VYRQ
 7i7hZXL/yXvmyG5KC7BaTdDdKMkGUIOu98B9224OSVdbjDakEa06sOhKIkaL5PStuDW+JaIKsi
 PR3R53rRLnbuX9Brid8NHXNfVOSJioSa0qfnHRqNQsS7ZVGVH/urPz7ewBD7wcId6WZYfS+/kV
 a0AAAA=
X-Change-ID: 20250113-wcn6855_fix-036ca2fa5559
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Steev Klimaszewski <steev@kali.org>
Cc: Bjorn Andersson <bjorande@quicinc.com>, 
 "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>, 
 Cheng Jiang <quic_chejiang@quicinc.com>, Johan Hovold <johan@kernel.org>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, Zijun Hu <zijun_hu@icloud.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: V3N0bx5LYFVmMyZP58jLBfK1_r8b6N55
X-Proofpoint-GUID: V3N0bx5LYFVmMyZP58jLBfK1_r8b6N55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501130123
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For WCN6855, board ID specific NVM needs to be downloaded once board ID
is available, but the default NVM is always downloaded currently.

The wrong NVM causes poor RF performance, and effects user experience
for several types of laptop with WCN6855 on the market.

Fix by downloading board ID specific NVM if board ID is available.

Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
Cc: stable@vger.kernel.org # 6.4
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v3:
- Rework over tip of bluetooth-next tree.
- Remove both Reviewed-by and Tested-by tags.
- Link to v2: https://lore.kernel.org/r/20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com

Changes in v2:
- Correct subject and commit message
- Temporarily add nvm fallback logic to speed up backport.
- Add fix/stable tags as suggested by Luiz and Johan
- Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com
---
 drivers/bluetooth/btqca.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index a6b53d1f23dbd4666b93e10635f5f154f38d80a5..cdf09d9a9ad27c080f27c5fe8d61d76085e1fd2c 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -909,8 +909,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/msnv%02x.bin", rom_ver);
 			break;
 		case QCA_WCN6855:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hpnv%02x.bin", rom_ver);
+			qca_read_fw_board_id(hdev, &boardid);
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+						  "hpnv", soc_type, ver, rom_ver, boardid);
 			break;
 		case QCA_WCN7850:
 			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),

---
base-commit: a723753d039fd9a6c5998340ac65f4d9e2966ba8
change-id: 20250113-wcn6855_fix-036ca2fa5559

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


