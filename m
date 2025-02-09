Return-Path: <stable+bounces-114439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBEDA2DDE0
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 13:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0F81885909
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D75C1DDA0E;
	Sun,  9 Feb 2025 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0slb4y67"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303751D554
	for <stable@vger.kernel.org>; Sun,  9 Feb 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739105980; cv=none; b=SlNzfIERb5itvuZINQsu7TJGrfsEOuwphUTe0CbNGv2HMJQbvewZKdvK7NjanUa4dh5Q8ur6TyTIk9MSSbIjJs1Vuwiuw0RYk3HkayS6+xHGNFutPVHKdl/JszFBw2XLU2jbckoc5PGIwkyvejNx+JFSZksHttLMr9izM9nbYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739105980; c=relaxed/simple;
	bh=1kU1sZzMuDN39khBY4wKUpOqoUCkMd9f0VR12DN/t50=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bD1T8JGKiobEptK/8W8ojInPvCrvzFu0sJ3lMdAlbHLFEkg+dB0wn/Ll06dZ3P/3OpYzHO79eWzK0AXJb32ZXmEZvKy1Eu2SmqLd0G+q2HcYRHgvnyLahLOTYukzC9Bb3z6T+ipmudmaDNHsR+QoMzEh0kmFfUgveh4iySEgTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0slb4y67; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=d6R3PbtXcDjXb9eXv/swOZnYsRfsUPoESYdbJuDQhNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=0slb4y67irtc54K//ntuUDDG++sTlURlxACv9KYRhjP6BSYHBZtJD0d9Ei6oLpUvA
	 xarvObsBfHAKoV/unuFJIwqbsfzo2dm0WGbIReZWtTmMEvfTp9kxa8/7Mltcuve2Ir
	 LK5z+rKqCU2TTdjfPbLXRUQocE+pXtFnPen2E70edJb+xQjFyGmDAkdobqmGisFCXP
	 9XIxKm7Y0/Pfe5vSn8NvVlBKQ4R6IxP0BLU6gQgnK16UuCsAYEQQuCXITclLQ2K+pf
	 3umGOHMDM/CwyyFVieXmiVqi6ccOy3s5ovTaa8u65EzX8YW2ZTswfwVXuzq452ZGPj
	 DLMxIfd2HPntw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 1E15ED00162;
	Sun,  9 Feb 2025 12:59:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/9] of: fix bugs about refcount
Date: Sun, 09 Feb 2025 20:58:53 +0800
Message-Id: <20250209-of_irq_fix-v2-0-93e3a2659aa7@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI2mqGcC/03MQQ7CIBCF4as0sxbDIFVw5T1M0yCCnYWlBSWah
 ruLTUxc/i953wLJRXIJjs0C0WVKFMYaYtOAHcx4c4yutUFwIVFwxYLvKc69pxfbt7pFebHamB3
 UwxRdnVfs3NUeKD1CfK92xu/6Y/Q/k5FxdlDCo0RtlcHT/CRLo93acIeulPIBwGGJhKYAAAA=
X-Change-ID: 20241208-of_irq_fix-659514bc9aa3
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
 Stefan Wiehler <stefan.wiehler@nokia.com>, Tony Lindgren <tony@atomide.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: oJ0BqXZey4KOze1f5_K0mSqOiwcUsW-S
X-Proofpoint-ORIG-GUID: oJ0BqXZey4KOze1f5_K0mSqOiwcUsW-S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-09_05,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=690 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502090115
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix of bugs about refcount.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Add 2 unittest patches + 1 refcount bug fix + 1 refcount comments patch
- Correct titles and commit messages
- Link to v1: https://lore.kernel.org/r/20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com

---
Zijun Hu (9):
      of: unittest: Add a case to test if API of_irq_parse_one() leaks refcount
      of/irq: Fix device node refcount leakage in API of_irq_parse_one()
      of: unittest: Add a case to test if API of_irq_parse_raw() leaks refcount
      of/irq: Fix device node refcount leakage in API of_irq_parse_raw()
      of/irq: Fix device node refcount leakages in of_irq_count()
      of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()
      of/irq: Fix device node refcount leakages in of_irq_init()
      of/irq: Add comments about refcount for API of_irq_find_parent()
      of: resolver: Fix device node refcount leakage in of_resolve_phandles()

 drivers/of/irq.c                               | 34 ++++++++++---
 drivers/of/resolver.c                          |  2 +
 drivers/of/unittest-data/tests-interrupts.dtsi | 13 +++++
 drivers/of/unittest.c                          | 67 ++++++++++++++++++++++++++
 4 files changed, 110 insertions(+), 6 deletions(-)
---
base-commit: 40fc0083a9dbcf2e81b1506274cb541f84d022ed
change-id: 20241208-of_irq_fix-659514bc9aa3

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


