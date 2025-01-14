Return-Path: <stable+bounces-108610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A791A10A9A
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11A83A13B7
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8C615A863;
	Tue, 14 Jan 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PbiSuzpR"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C346B85C5E
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868210; cv=none; b=ce3QfYhJeubUNmxDLTgvh64DR66C7OLBXyFQxLrRJ0dOfFLAQWTemyIHrG4Jq8wad6bTdANGPKBn7JG4fUFJTUYmntJFrdL/JhaEiFmLCJC1f9khx46J/ktvbhQbDkpy7wkAdMK+xWIZ7nlxyt5PqiOUB/7EzWXXNBCEB8hrQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868210; c=relaxed/simple;
	bh=lTGtKB96ZHROBWPPfSXcN4ms+HG8xznUJB9qKdB3qG8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qz1chv7AAStCQHRfFurM3v33LfMRIQwEbYicACEq+gFvq41MnCln1Ss81l3wgEd07J3DRtEL7RRmft69h2Q/aSukzvzvw+c962arzB6uQ6ybuKvtgj6/X53P5kml8F2lMlmE+jOR4GAkUjNQ3VrjoNcQJJnSqDjSFYwbNXF8YTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PbiSuzpR; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736868208;
	bh=11aOXu0cBvqb7EJQdTd19PD1k/78idh6SaAtqeWWNEw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=PbiSuzpRnh6yaqpobTAnvr/JqVHa8/lMDMxSAejG0CFnsZB3ZlRHvideq45GBrVBK
	 qI2Fx8kZulGzkRegzLzumkojG5YxeS0kArh/THxlyiRhC3dkwb/JdFzzJBzl4xZaX5
	 B9m876/phnsY4HTZIlNhoWfvfhG3jkjeFKuVE7XV/3Olrk7APl2teeLfmz+tM76Ct5
	 fMWu26L+Ag+mJ3QjQnspjNToycp3EG4GKxQt/OOpw1C3u2QIufQ+jJnjBVuWi527bn
	 o7t+eTXLEi2urf0dE+v2lu4vWFTpMBmPaA55EtmAlt1WE7H/PyTHZmnMCHvJRCOA1y
	 DDoZhuNhtM1vg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 66B967401DB;
	Tue, 14 Jan 2025 15:23:24 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v5 0/3] of: fix bugs and improve codes
Date: Tue, 14 Jan 2025 23:23:02 +0800
Message-Id: <20250114-of_core_fix-v5-0-b8bafd00a86f@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaBhmcC/23QwW7DIAyA4VeJOC8TBkJIT3uPaarAOCuHhg6ya
 FPVd5/TalKz9Wij7xfyWVQqiarYNWdRaEk15YmH7qkRePDTO7Up8iyUVAaUtG0e95gL7cf01Ub
 UUoGX1oATLE6FeH2tvb7xfEh1zuX7Gl9g3T7uLNBKjilHsbOBUL98fCZMEz5jPoq1tKg7DX+0Y
 k12CG60Mnr7QOt73W+1Zq0DmsErciH6/9r86k6CHLbarD8Pzvec7oLDrb7cjlKItzXNt8uI4Cu
 1/H5M865BMECIGgljb00/DAQ9OtWBVFZriz4466Tk2OUHjPjplq4BAAA=
X-Change-ID: 20241206-of_core_fix-dc3021a06418
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 0etXE3b9PednbwyZtner1ll0qYpm2q-a
X-Proofpoint-GUID: 0etXE3b9PednbwyZtner1ll0qYpm2q-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=660
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501140121
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs and improve codes for drivers/of/*.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v5:
- Drop 12 patches and add 1 patch
- Correct based on Rob's comments
- Link to v4: https://lore.kernel.org/r/20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com

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
Zijun Hu (3):
      of: Do not expose of_alias_scan() and correct its comments
      of: reserved-memory: Warn for missing static reserved memory regions
      of: Correct element count for two arrays in API of_parse_phandle_with_args_map()

 drivers/of/base.c            | 7 +++----
 drivers/of/of_private.h      | 2 ++
 drivers/of/of_reserved_mem.c | 5 +++++
 drivers/of/pdt.c             | 2 ++
 include/linux/of.h           | 1 -
 5 files changed, 12 insertions(+), 5 deletions(-)
---
base-commit: c141ecc3cecd764799e17c8251026336cab86800
change-id: 20241206-of_core_fix-dc3021a06418

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


