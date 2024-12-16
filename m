Return-Path: <stable+bounces-104299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41EF9F278A
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 01:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD69F164F5C
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 00:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51439475;
	Mon, 16 Dec 2024 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hR+Jg7ae"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4034C7C
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734309668; cv=none; b=Ej/f+02SxdfZ5i4v/DJsjf8cGjXXHpkQlZwB9IcH4ZjKH2lauHEmCNw4c4HZgtsXzcIrx+XR7JoVoyIvLme2zVofEHZ3aWYr7BvhNJi8aMgnG1/MLDMJbh1tNSHnJZu48AtV6oCFRE739YhQMaG0ryrGhbM7PK2pvZ2gTCYs1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734309668; c=relaxed/simple;
	bh=Q2WEVmJjtO06NQXKQ/QF+LbKD/YAKir7x2lSe4k9LAw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K8TBOxX/uRvS3UkiflfyAS0GW/mu378nD1V/M7ayl8KCAQVwzoSmFeRPZmHrC8WiwhiLFYho3EgLOjqKJ7OiY4uWEdiDTzvSlEncbPaxh0FYt4vjzxVc+UWxz8OjHMwo3G8Qmh37F6nBzKJS+IDl+9i564lexlHG6G8Du9pchQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hR+Jg7ae; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734309667;
	bh=mnKl4Jo94xI28vK15IjabapoAkpAPwGHr4v96pxxogo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=hR+Jg7aeLxP+1/qOtZ7OpZBtWfeV+SK2B7wa+TPV4oQm5qbgNZKZITfuqilrQ4lqL
	 ermYSL2COJMu+l3nyvc2R12Bo7OB2/2SDF378m6OWyDFA69O0aLMWX7X6oObnWh98h
	 GXNcOEUzwJb85VxywUh6MQRCBliSer6Df5Slpt+LeMVmPAZZS6PBM2K6Wf8O7JmRim
	 C5p+KGpafndIQbyRljj/063Eq56XdQERpRLAIT10f4j4VfM2nnyLJQ0fUDSWJwW4bF
	 IQhrjYSnf1ke3KBW/jjP7gm/oBL9Ce85aCWZj67ktG8n7OP4rgrUfEnNjKXVbLBp6w
	 82t8iVRsr3EZw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id BABCDD00165;
	Mon, 16 Dec 2024 00:41:02 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/7] of: fix bugs and improve codes
Date: Mon, 16 Dec 2024 08:40:39 +0800
Message-Id: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAd3X2cC/23MwQ7CIAzG8VdZOIspsKHz5HsYY6B02oNDYS4a4
 7tb9erx+zf9PVWlwlTVpnmqQjNXzqMMu2gUnsJ4JM1JtrJgW2PB6zwcMBc6DHzXCR1YE8C3Zq3
 k41JI8lfb7WWfuE65PL74bD71vzMbDYLZNaXOR0K3vd4YecQl5rPav350IamVp5+vYqik5X7ma
 dPAsMLgB9+7riVA11sXo4DY2wSEIbapg+BIsNcbGqW8D/QAAAA=
X-Change-ID: 20241206-of_core_fix-dc3021a06418
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: fq2x0xFawmaHHMiAzjSzuTeegTNTecS3
X-Proofpoint-ORIG-GUID: fq2x0xFawmaHHMiAzjSzuTeegTNTecS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-15_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=615 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412160002
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs and improve codes for drivers/of/*.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Drop applied/conflict/TBD patches.
- Correct based on Rob's comments.
- Link to v1: https://lore.kernel.org/r/20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com

---
Zijun Hu (7):
      of: Fix API of_find_node_opts_by_path() finding OF device node failure
      of: unittest: Add a test case for API of_find_node_opts_by_path()
      of: Correct child specifier used as input of the 2nd nexus node
      of: Exchange implementation between of_property_present() and of_property_read_bool()
      of: Fix available buffer size calculating error in API of_device_uevent_modalias()
      of: Fix potential wrong MODALIAS uevent value
      of: Do not expose of_alias_scan() and correct its comments

 drivers/of/base.c       |  13 +++---
 drivers/of/device.c     |  33 +++++++---------
 drivers/of/module.c     | 103 +++++++++++++++++++++++++++++-------------------
 drivers/of/of_private.h |   2 +
 drivers/of/pdt.c        |   2 +
 drivers/of/unittest.c   |   9 +++++
 include/linux/of.h      |  29 +++++++-------
 7 files changed, 109 insertions(+), 82 deletions(-)
---
base-commit: 0f7ca6f69354e0c3923bbc28c92d0ecab4d50a3e
change-id: 20241206-of_core_fix-dc3021a06418

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


