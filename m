Return-Path: <stable+bounces-89548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED19B9C8E
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 04:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF35A1C2130B
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 03:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCA513C914;
	Sat,  2 Nov 2024 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="BY6bjFZ3"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C634CDD
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730519655; cv=none; b=ClCPjh5uA5m04nR1OMBWuyLrpWr76K7OmU2LpdNavr9/I5VGUEBJRkFuH/pHJNfL7dllqhOvrmeoC3F9DkllGzmk6+xvaYp/RnWP8GqyiNpoWBU0bwP8qp9RBiJLbVsPhLCxjcoNhtEgoWw8fKRAZ9eF+aysyKC6Sro20iLnLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730519655; c=relaxed/simple;
	bh=g6POW7UQm1RCR+ROES5iCPiakiF0ZYX0hUZ0jLALV9Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XmRFKa+jymTWtLutCYDErJWFKUoNNGA7ke/oNJCTbfKFcPrnPH32v4O08y2vRDrGm3ehf3fNm0oGFsgReO8YMDOZdAWkSRGXss9CiDH+uda62QMfq3T6rR3uWBaMSbroZdMqEKWWgYXbXDxlHVbt8Z7YAqeeRnA0EgcE2sC0Tu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=BY6bjFZ3; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730519653;
	bh=xlxxWuHtdUZSNGnMupwcBRSja7uiXJHdtgOzQJyG6DQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=BY6bjFZ3zmF/M8+lLFLPHdb+fs6oo+UZrYmCZTBvAIKa//KXcc9iHFQ06xRTh2KaN
	 lsZQjRkZap8Wh43CWLW3GwvMJjLTQXP2oBSCAtXKvU0fgIexJ5Xz6yJIN7KY2q9oTX
	 FvkowVcZRpQRQWgqiF5yvYrs3ZtzaHL5eZ4Zq7rXFCM7V4cqDwDL6z0YUUGY85akV+
	 dq2Grk4YY5PKMjlVq/RY3SErsjw/zEP9Fho3RUF75RUzJPyW2ZZ78BUFlL8Ww7qrU7
	 AigarVHbeGt3FdkM8RTB1nl8D7Q6b4rk/UgDBgzKx/rBFlfRMn5GE7qU29W0P7CCLG
	 S6AL+tUf6l4rg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id B81F88E0218;
	Sat,  2 Nov 2024 03:54:02 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v4 0/6] phy: core: Fix bugs for several APIs and simplify
 an API
Date: Sat, 02 Nov 2024 11:53:42 +0800
Message-Id: <20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEaiJWcC/3XNTQ6CMBCG4auYrq3pD1Jw5T2MITCdShdSbLWRE
 O5uYYUYl98kzzsjCegtBnLajcRjtMG6Lo1svyPQ1t0NqdVpE8FExplgtG+HCpzHytg3RVnr/Ki
 bsjCKJNJ7TOcld7mm3drwdH5Y6pHP1z+hyCmjTBUsF0bpWvHz42XBdnAAdydzKoo1zzZcJG6AQ
 S51Y8DIXy5XXG6/y8R52ZQKJELJ1TefpukDkR3tpygBAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Lee Jones <lee@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Johan Hovold <johan@kernel.org>, Zijun Hu <zijun_hu@icloud.com>, 
 stable@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: bKDoCi3h4Kfl4oMlH4_7A_7ORU9H-yE3
X-Proofpoint-GUID: bKDoCi3h4Kfl4oMlH4_7A_7ORU9H-yE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_02,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 mlxlogscore=617 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020031
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs for below APIs:

devm_phy_put()
devm_of_phy_provider_unregister()
devm_phy_destroy()
phy_get()
of_phy_get()
devm_phy_get()
devm_of_phy_get()
devm_of_phy_get_by_index()

And simplify below API:

of_phy_simple_xlate().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v4:
- Correct commit message for patch 6/6
- Link to v3: https://lore.kernel.org/r/20241030-phy_core_fix-v3-0-19b97c3ec917@quicinc.com

Changes in v3:
- Correct commit message based on Johan's suggestions for patches 1/6-3/6.
- Use goto label solution suggested by Johan for patch 4/6, also correct
  commit message and remove the inline comment for it.
- Link to v2: https://lore.kernel.org/r/20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com

Changes in v2:
- Correct title, commit message, and inline comments.
- Link to v1: https://lore.kernel.org/r/20241020-phy_core_fix-v1-0-078062f7da71@quicinc.com

---
Zijun Hu (6):
      phy: core: Fix that API devm_phy_put() fails to release the phy
      phy: core: Fix that API devm_of_phy_provider_unregister() fails to unregister the phy provider
      phy: core: Fix that API devm_phy_destroy() fails to destroy the phy
      phy: core: Fix an OF node refcount leakage in _of_phy_get()
      phy: core: Fix an OF node refcount leakage in of_phy_provider_lookup()
      phy: core: Simplify API of_phy_simple_xlate() implementation

 drivers/phy/phy-core.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)
---
base-commit: e70d2677ef4088d59158739d72b67ac36d1b132b
change-id: 20241020-phy_core_fix-e3ad65db98f7

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


