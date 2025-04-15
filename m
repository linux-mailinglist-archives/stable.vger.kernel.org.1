Return-Path: <stable+bounces-132737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9349BA89E32
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 14:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C654411FB
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5628469B;
	Tue, 15 Apr 2025 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tCRIccV9"
X-Original-To: stable@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster5-host6-snip4-10.eps.apple.com [57.103.66.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9011C6FF5
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720495; cv=none; b=KEIecIPx/HCRHUguYPCs71OQbCunmQzN0Bl6dhaeFrUbyB3pAWwv5pGiI9tUFoCaGIYIdcTp23QJMLPqYtktMXkOCGaaE5bBLjkdsH7z3fsvGcVKGtn8rM8B+CSxHVTE+le5+J+WNSD+YgY17QlXY/mlBlCwTxX0nBvNehlqsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720495; c=relaxed/simple;
	bh=nuqkopAoN0+cSyqxLSqp0fYvmosXYHX5j4WUMF7BKPc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RXBBXvO2Icg4mjM+avLqd9Ti3oOnwf4EatU9yXwCKjqxUiF2q3cYgcMBkDU4YvybncRxtehPURdi7fk0or17HWIswZX/Mw6fawdZiISCEnN1l2BULmtgHrMwuBAQ7zOBaqWJB0NjJGXzqthQFT7+wKrIltzeu84ZXHe6S8kxDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tCRIccV9; arc=none smtp.client-ip=57.103.66.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=vpZUU7X3KJcG9DmlOmJn8NgYD5L7M5AxAF5Ev3NBqhw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=tCRIccV9QpOykH79Lv+lFk/1CIqE+jTyxvhVmNaP+fTqclyBHRVb3muYK+QRUfMFw
	 L6c4LYKOPFv/PtcMpXNnKzkmttQaaVdEe0RuVTrN4l7Lrl0L0GGqSyTe4LpvBBlgcG
	 xS2hZzStjdSaGXLk4yStcP7zjAGIwz1KSX08AQig23QlPmenFVjdkSggu+XANpPQAC
	 USln3yEB2I1OvdlAh2haxj55erKLemlYv5vZherpCSMOfjnhRguXUnqa8Ya8Hj37qi
	 o6LacvaL1fDKSIwboJJP6f9iKhvW8mFPWar513zRUt1Ke1J8TDWjzH6PArW0vdodxD
	 gU1mK2zWgtVPw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id F19F11800413;
	Tue, 15 Apr 2025 12:34:48 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/3] configfs: fix bugs
Date: Tue, 15 Apr 2025 20:34:24 +0800
Message-Id: <20250415-fix_configfs-v2-0-fcd527dd1824@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFBS/mcC/3WMwQ7CIBAFf6XZsxiglFJP/odpTLOFdg+CghJNw
 7+LvXuc9zKzQbKRbIJTs0G0mRIFX0EeGsB18otlNFcGyWXHFTfM0fuKwTtaXGJ6GHrVCt2iVlC
 Ve7T133OXsfJK6RniZ69n8Vv/hLJgnHWTQmMM72bXnx8vQvJ4xHCDsZTyBWDS/rCqAAAA
X-Change-ID: 20250408-fix_configfs-699743163c64
To: Joel Becker <jlbec@evilplan.org>, 
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: MewdRiODxh5n0wb68w9Lv8FrFx8KUekX
X-Proofpoint-GUID: MewdRiODxh5n0wb68w9Lv8FrFx8KUekX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=874
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504150089

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Drop the last patch which seems wrong.
- Link to v1: https://lore.kernel.org/r/20250408-fix_configfs-v1-0-5a4c88805df7@quicinc.com

---
Zijun Hu (3):
      configfs: Delete semicolon from macro type_print() definition
      configfs: Do not override creating attribute file failure in populate_attrs()
      configfs: Correct error value returned by API config_item_set_name()

 fs/configfs/dir.c  | 4 ++--
 fs/configfs/item.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
change-id: 20250408-fix_configfs-699743163c64

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


