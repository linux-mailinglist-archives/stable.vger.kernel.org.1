Return-Path: <stable+bounces-108113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27999A07750
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 14:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63BC1889775
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93A21883B;
	Thu,  9 Jan 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="sl9cNCej"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B03F207A06
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429283; cv=none; b=Rzn+18Bue+gUf2DVeAGjEjJ2ja8PXiNRayWj3qv6RVnm9pRbbuQr6lj5Dbsqwi2ipVHTSMuSgqfxf6GrqfDPjObhcTULxwQE01nW0UpMhb/S5lh7Q4VBBPB61plNnE6UWCqPBt1EqqgZiZqNPvSacqs7HPQrr1FqubHsDDiVyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429283; c=relaxed/simple;
	bh=mvqkOdzClnnNyXusQ16u+hfuUvogWlyFhmHmqXdxS7A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KFNL76nNrUeKIHz71B1wUhtpQN+DGlEh3TddqEKjiZDq7mCOU8SrrejAqo16z+QQzQNhgTV8PXLIkz2foUmJjw5i4xaegOVU1Lz6JIAYPB/FJXa+aopCb4zmOfF5hX55lY08Z4MtGz3DT/RQ5GQaSXNb/eLAdPd6oK9ZuH1GSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=sl9cNCej; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736429281;
	bh=aJwMoxg/sJNcCG/DKy4alAAOv/xsnOvnlyIIhl7o82A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=sl9cNCejw/lfz7+2mWT3/frAkOx0T2zzZuMDv0+mRhzIflI4Xn9AdXNUzFEL4xeiM
	 bv81bJoUzMIUbjEJgDoFrZRPF3ZgxaH1l7QFiznEBtdimh9LvBhBJRtT/3HPVlAtWa
	 UMm/bx3FKwPBndM8S3/dwadxShwsarEy2mdBhj4xeqNSYMhFcpoFjFJVYTBYMQjw+v
	 s/mRwibkoRgKfNGaJ3aLlmnXNVcAbfB1XUg34/8MsSHwjizRAWuUb/L8zL+C2z+35b
	 14CNYHuRMsJQw/TJu4Mvq8DsmHXOFw/hsAGxbXS1vKTp5Bx7VGJf+HnVygwsPdeI8d
	 cMSWMgJB7EXhA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 4B17234BAA11;
	Thu,  9 Jan 2025 13:27:55 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v4 00/14] of: fix bugs and improve codes
Date: Thu, 09 Jan 2025 21:26:51 +0800
Message-Id: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvOf2cC/22QS24CMRBEr4K8zkR2+zOerHIPFCG73Q5eME7sY
 ZQIcfc0sIGIZVXrPan6JDq1Ql28bU6i0Vp6qTMH87IRuA/zJw0lcRYgwSiQbqh5h7XRLpefIaG
 WoIJ0RnnBxFcjrq+27QfnfelLbb9X+aou7XPPqgbJMvCUrIuE+v37WLDM+Ir1IC6mFe5o9Y8Gp
 slN0WcnU3BPaH1Pj4+0ZlpHNFMA8jGFR/p8m9WI216W2zYRQ6eB74ey8K+sy1pKmT3YUblpTKA
 RrEVjFWbM0eIUaLQsO/8BIUZ/wHABAAA=
X-Change-ID: 20241206-of_core_fix-dc3021a06418
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>, Marc Zyngier <maz@kernel.org>, 
 Andreas Herrmann <andreas.herrmann@calxeda.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mike Rapoport <rppt@kernel.org>, 
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: qEn3x40e2-5ytIQ-RZbBmOqG71pieJRc
X-Proofpoint-ORIG-GUID: qEn3x40e2-5ytIQ-RZbBmOqG71pieJRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_05,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=950 clxscore=1011 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501090108
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs and improve codes for drivers/of/*.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v4:
- Remove 2 modalias relevant patches, and add more patches.
- Link to v3: https://lore.kernel.org/r/20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com

Changes in v3:
- Drop 2 applied patches and pick up patch 4/7 again
- Fix build error for patch 6/7.
- Include of_private.h instead of function declaration for patch 2/7
- Correct tile and commit messages.
- Link to v2: https://lore.kernel.org/r/20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com

Changes in v2:
- Drop applied/conflict/TBD patches.
- Correct based on Rob's comments.
- Link to v1: https://lore.kernel.org/r/20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com

---
Zijun Hu (14):
      of: Correct child specifier used as input of the 2nd nexus node
      of: Do not expose of_alias_scan() and correct its comments
      of: Make of_property_present() applicable to all kinds of property
      of: property: Use of_property_present() for of_fwnode_property_present()
      of: Fix available buffer size calculating error in API of_device_uevent_modalias()
      of: property: Avoiding using uninitialized variable @imaplen in parse_interrupt_map()
      of: property: Fix potential fwnode reference's argument count got out of range
      of: Remove a duplicated code block
      of: reserved-memory: Fix using wrong number of cells to get property 'alignment'
      of: reserved-memory: Do not make kmemleak ignore freed address
      of: reserved-memory: Warn for missing static reserved memory regions
      of: reserved-memory: Move an assignment to effective place in __reserved_mem_alloc_size()
      of/fdt: Check fdt_get_mem_rsv() error in early_init_fdt_scan_reserved_mem()
      of: Improve __of_add_property_sysfs() readability

 drivers/of/address.c         | 21 +++------------------
 drivers/of/base.c            |  7 +++----
 drivers/of/device.c          | 14 ++++++++++----
 drivers/of/fdt.c             |  7 ++++++-
 drivers/of/fdt_address.c     | 21 ++++-----------------
 drivers/of/kobj.c            |  3 ++-
 drivers/of/of_private.h      | 20 ++++++++++++++++++++
 drivers/of/of_reserved_mem.c | 15 ++++++++++-----
 drivers/of/pdt.c             |  2 ++
 drivers/of/property.c        |  9 +++++++--
 include/linux/of.h           | 24 ++++++++++++------------
 11 files changed, 79 insertions(+), 64 deletions(-)
---
base-commit: 456f3000f82571697d23c255c451cfcfb5c9ae75
change-id: 20241206-of_core_fix-dc3021a06418

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


