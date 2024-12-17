Return-Path: <stable+bounces-104495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8839D9F4BF7
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 14:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CF21893472
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092001F473F;
	Tue, 17 Dec 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="IUy45N7a"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005B1F4737
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440869; cv=none; b=KoYEcThiTENIAN6mp9sK4BfqDz1iFqJ4ulHyF1FFyIAeyPthy+VR2lIL4nnt3eGtY6lMGzAkWEKoplSssgIujbnYF3j3e71uAY0SATDx7/oT2AStUVFj8Wy9iJSJ1HjeQDX63/UicI7QquyF3aGxccLWW0r5QKSIwKv9POcsxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440869; c=relaxed/simple;
	bh=jXk1HHf2gyAt/0sGR0rPE3DaboIEoRBqCiTJdvJqzMA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lnwpvd5GHD2TW/AFQjwR/m+zozRe8iqV3IHnP91P34c++uYUoUuYkhG7XUvfSV73Cgt+M6ls2adweTNdg2/RGNcrS8L3cCvhOghKvVRQ8BTS9oODTfwL4XtUgwtoPCAKJRo0QzmIEF1DakQ7KchtN2lfuL8ioww7x8HmoK/bYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=IUy45N7a; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734440867;
	bh=4UTblqxlw0pJ/2T1O2BsVf7I7B31S6M4FKaeLQ2CLL8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=IUy45N7a5KN5gN0btOHeaU51bgdo93qeGN7OfoKs4ZWVWAair2sqniWhrBZzIqPpe
	 RmH1vDVHZCwZGVBWsPPQJgPahZidA7Z1ImytFPGRhmOMtOysN1kCzFmBXWR5c3Nw0y
	 LPiV5Pb6pfy8yqsQO/bCrqb3CUWBPUbkSRKWjRuFeT+yq9Q03lmIxEnsIgZwADgn+6
	 bSPdch0/cUyaLqkU4TS1qasKJ6Fz242LHh4khDZm3T7zcagew4tb9ZsM8MaE9JtmgB
	 HaYfV6peJPHhoOjCM4ItvAFH+9X0a23ZbSa6N1o0XZNlSNBx1Zm/NbhRMIHmXe4gGk
	 nM9W551SDqo7w==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 8B919960142;
	Tue, 17 Dec 2024 13:07:44 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v3 0/7] of: fix bugs and improve codes
Date: Tue, 17 Dec 2024 21:07:24 +0800
Message-Id: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIx3YWcC/22OwW7CMBBEfyXyGVdrOzEJJ/6jqpC9Xpc9EIOdR
 q0Q/94FLhXqcWb0nuaqGlWmpnbdVVVauXGZJbhNp/AY5k/SnCQrC7Y3Frwu+YCl0iHzt07owJo
 AvjejEuJcSeqH7f1D8pHbUurPQ76ae/u/ZzUaRGZHSoOPhG5/+WLkGd+wnNTdtNo/tHmhrdDkp
 zhmDyn4F/r2PFZJ2sbL852KoZGW/cTLroO8xeCzn9zQE6CbrItR7uBkExCG2KcBgiOR3X4B/RX
 +NDIBAAA=
X-Change-ID: 20241206-of_core_fix-dc3021a06418
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 5fTvD1eVcxEqX29Tblk1OTpQE3_H7JiF
X-Proofpoint-ORIG-GUID: 5fTvD1eVcxEqX29Tblk1OTpQE3_H7JiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_07,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=752 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs and improve codes for drivers/of/*.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
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
Zijun Hu (7):
      of: Correct child specifier used as input of the 2nd nexus node
      of: Do not expose of_alias_scan() and correct its comments
      of: Make of_property_present() applicable to all kinds of property
      of: property: Use of_property_present() for of_fwnode_property_present()
      of: Fix available buffer size calculating error in API of_device_uevent_modalias()
      of: Fix potential wrong MODALIAS uevent value
      of: Do not expose of_modalias()

 drivers/of/base.c       |   7 ++--
 drivers/of/device.c     |  33 +++++++--------
 drivers/of/module.c     | 109 +++++++++++++++++++++++++++++-------------------
 drivers/of/of_private.h |   4 ++
 drivers/of/pdt.c        |   2 +
 drivers/of/property.c   |   2 +-
 include/linux/of.h      |  31 ++++++--------
 7 files changed, 102 insertions(+), 86 deletions(-)
---
base-commit: 0f7ca6f69354e0c3923bbc28c92d0ecab4d50a3e
change-id: 20241206-of_core_fix-dc3021a06418

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


