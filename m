Return-Path: <stable+bounces-104034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FAC9F0C6F
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875F4287AC7
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2094B1DFDBC;
	Fri, 13 Dec 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="mdwwy2yW"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A631DFDA1
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093433; cv=none; b=dhOyAGvq+aQVW/fwMvATfuy7UZoAPOOz50K5TNHUWO5mif5V0tYjBxAjw555+VPsLwrme9NJ5sl3+QLG7dfcyUqs9Vz/hwupHnvTAcdFi9SHyw+YZeAJ9CRs1FN1Y86xq3q5+8Onvl1XEJE8jvUU3xRYr+5DdtHGZPzFy4hscv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093433; c=relaxed/simple;
	bh=dnJUPgJetVPeBE4JE53LxUTGSRU2xUwI3phkEKWRKt8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aMd0+wjI/eMXDmP0HOoQstYTsYZEdLQAdgQ+HTi684Q9RssjVFZ6TghBisQ7NSYibGOIAXXOhj1G1/Mz9IBouI/DGByYXUp8Kts7Tflv1Q2DyZMueZdZZ4RGfEaoJvcnvHwHIBqpOP0cXEsWmk5NC/g84IqX1ueyNSF+RXkrXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=mdwwy2yW; arc=none smtp.client-ip=17.58.23.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734093431;
	bh=tBmdorHexJDbaVxxT3/6hbHf9p9VMgVpSp+5k/9BvGE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=mdwwy2yWI5YhrnHr6H1JXbORHwkGPn/M8cU0dudU4/Zt45e/IxG8aY3ruIw6F/02q
	 67xsGC1ngT+UcSFJUcFrzJuvtUxre59pgwEEYmH8+VbHD2uosJs5SP3bfAF0RZVp/c
	 oKP6C/736DhZNOCVLhay3vrF6tCDj6HF9ldrcfVrJ/zhYk9BJncdTQ3yVJDdC5WNr0
	 rkG6e1Qf8cwdhNBpmsQQUkYxtjU8N0pNthrcTjG60t6ileqsAfafx/xhUN6Cft5tA2
	 jSgoWt4I4Bm9dN5066Pp5vD54EtdhRbn2fuWohD3rPDExm83rj3RckryXg8kEz2G0m
	 1i9QVdL4t68eA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 9105B2793FFE;
	Fri, 13 Dec 2024 12:37:03 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v6 0/6] phy: core: Fix bugs for several APIs and simplify
 an API
Date: Fri, 13 Dec 2024 20:36:40 +0800
Message-Id: <20241213-phy_core_fix-v6-0-40ae28f5015a@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFgqXGcC/3XOTW7CMBAF4Ksgr3Hlv9gxq94DVSgej4kXJKlDo
 yKUu3dg0xBg+Ub63psrG7FkHNluc2UFpzzmvqNgtxsGbdMdkedImSmhjBRK8KG9HKAveEj5l6N
 uoq1i8HVyjMhQkM73uv0X5TaP575c7u2TvF3fFE2SCy5cLaxKLjZOfn7/ZMgdfEB/YreqSS25W
 XFFPIEAq2NIkPQz1wuu1+uauPTBO9AIXrpnbv45za+4IW6SsEb7ZGV48Xy15HbFK+LeOWkrhaG
 u4ZHP8/wHutYp7KYBAAA=
X-Change-ID: 20241020-phy_core_fix-e3ad65db98f7
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Lee Jones <lee@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Johan Hovold <johan@kernel.org>, Zijun Hu <zijun_hu@icloud.com>, 
 stable@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Johan Hovold <johan+linaro@kernel.org>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: -4iegzmlDL25f_xl1g4tkTrbg6ED_ZbF
X-Proofpoint-GUID: -4iegzmlDL25f_xl1g4tkTrbg6ED_ZbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_05,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=461 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412130089
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
Changes in v6:
- Use non-error path solution for patch 6/6.
- Remove stable tag for both patch 2/6 and 3/6.
- Link to v5: https://lore.kernel.org/r/20241106-phy_core_fix-v5-0-9771652eb88c@quicinc.com

Changes in v5:
- s/Fixed/Fix s/case/cause for commit message based on Johan's reminder
- Remove unrelated change about code style for patch 4/6 suggested by Johan
- Link to v4: https://lore.kernel.org/r/20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com

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

 drivers/phy/phy-core.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)
---
base-commit: 9d23e48654620fdccfcc74cc2cef04eaf7353d07
change-id: 20241020-phy_core_fix-e3ad65db98f7

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


