Return-Path: <stable+bounces-100917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A39EE7CB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B409E1888076
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3862144C0;
	Thu, 12 Dec 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="h77d4NB+"
X-Original-To: stable@vger.kernel.org
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A6211A0E
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010761; cv=none; b=luz8UiajJ+SQzEPBqCM73jbvifUo5Q9ZbuoQMX8AY/jT00DAEprsqAFfAYInWd0CV80atxVQxs0GKpPje6HVrYs0MVOOhWdn5ctNRFj3f1Rrxd263hPbnbDN4+Vh5K25BKoNTdobSGIMt12RZysCtQw8ynynzDL/OFbi0OfGank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010761; c=relaxed/simple;
	bh=2jrvVsx2RIa0RV5EyHAFqJ1UM43l3qMuGJWqPFA6iiA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mz5i8Ve2IRqJAZoewknAru0bzDVopS4vDozr38/QSBovKS/gzlSy7aDYm++0482BBk1hIA/iW5BRWodk9hhMmoWv84tk8ltq2t+95hVf5VzgpGJuSNiCI5wpMedTavgDNXSbGdN/KFRXm3uF3/9J0A4Y34mOMoxgPPgU6HaHchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=h77d4NB+; arc=none smtp.client-ip=17.58.63.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734010758;
	bh=VUEKRgBCANiJKzI+jVMX+MwQUzbz+CtH2wDUFRlHHLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=h77d4NB+TKx6IRA0ovKbRuP+o9KfvIPwb2zigCmj+BmI6oOJ4TAolqgCmMxot8B/p
	 nusI0F+UlTHwEVdEBRPC8KiNNEcYNtBb5xmE7A+ufiYOkUaaDmkZE29PsL6sG/c/W5
	 LSdYknd4pSnJuNVFFs6b58V35wykVEiJOT9ZIztd2dXBHLyo4SWFnYarCSWy1STtV0
	 NAl5OCtqVAilHat9WRMbhSDsmEzJShxUgtYXxahnrml1+E4fWkpT7tJn9DdvdRpg11
	 D8+L4MCoApG5cg6hfkoNx0oO701NP+9OSkYT9fHVvJgwnrB7LZd5owHswfOlYtfl7w
	 1rfAMPkPX234w==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 28718CC058E;
	Thu, 12 Dec 2024 13:39:08 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v3 0/9] driver core: class: Fix bug and code improvements
 for class APIs
Date: Thu, 12 Dec 2024 21:38:36 +0800
Message-Id: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFznWmcC/12Q0WqEMBBFf0Xy3JRMjNH41P8oRSaZsRvo6tZYa
 Vn23zvrUpA+3pvcw2GuqvCSuai+uqqFt1zyPEmonyqVTji9s84kWVljHYBxOn1gKcOYv/UIrY8
 UOKK1Sv5fFpZ6Z72+ST7lss7Lz47e4N7+UZoDZQNtdGc678cQgsPm5fMrpzyl5zSf1Z2z2cMW7
 HFrZdvWBKEjg4b+bW8PqYWlLXl9mKmIhbW8n/PaV4moNhwjxDDWHppA4mG6LnpAZusdexeoRXW
 8R1/tLtaAcKayDjSmgeaJNSKnFriOkbHfnCjcfgHZvJ3HYgEAAA==
X-Change-ID: 20241104-class_fix-f176bd9eba22
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
 Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 6qORa1iOtrNDRli4AFpyHQ82i5YMLoVo
X-Proofpoint-ORIG-GUID: 6qORa1iOtrNDRli4AFpyHQ82i5YMLoVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=980
 malwarescore=0 bulkscore=0 clxscore=1011 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs and improve codes regarding various
driver core device iterating APIs

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v3:
- Correct commit message, add fix tag, and correct pr_crit() message for 1st patch
- Add more patches regarding driver core device iterating APIs.
- Link to v2: https://lore.kernel.org/r/20241112-class_fix-v2-0-73d198d0a0d5@quicinc.com

Changes in v2:
- Remove both fix and stable tag for patch 1/3
- drop patch 3/3
- Link to v1: https://lore.kernel.org/r/20241105-class_fix-v1-0-80866f9994a5@quicinc.com

---
Zijun Hu (9):
      driver core: class: Fix wild pointer dereferences in API class_dev_iter_next()
      blk-cgroup: Fix class @block_class's subsystem refcount leakage
      driver core: bus: Move true expression out of if condition in API bus_find_device()
      driver core: Move true expression out of if condition in API driver_find_device()
      driver core: Move true expression out of if condition in API device_find_child()
      driver core: Rename declaration parameter name for API device_find_child() cluster
      driver core: Correct parameter check for API device_for_each_child_reverse_from()
      driver core: Correct API device_for_each_child_reverse_from() prototype
      driver core: Introduce device_iter_t for device iterating APIs

 block/blk-cgroup.c            |  1 +
 drivers/base/bus.c            |  9 ++++++---
 drivers/base/class.c          | 11 +++++++++--
 drivers/base/core.c           | 17 ++++++++++-------
 drivers/base/driver.c         |  9 ++++++---
 drivers/cxl/core/hdm.c        |  2 +-
 drivers/cxl/core/region.c     |  2 +-
 include/linux/device.h        | 14 +++++++-------
 include/linux/device/bus.h    |  7 +++++--
 include/linux/device/class.h  |  4 ++--
 include/linux/device/driver.h |  2 +-
 11 files changed, 49 insertions(+), 29 deletions(-)
---
base-commit: cdd30ebb1b9f36159d66f088b61aee264e649d7a
change-id: 20241104-class_fix-f176bd9eba22
prerequisite-change-id: 20241201-const_dfc_done-aaec71e3bbea:v4
prerequisite-patch-id: 536aa56c0d055f644a1f71ab5c88b7cac9510162
prerequisite-patch-id: 39b0cf088c72853d9ce60c9e633ad2070a0278a8
prerequisite-patch-id: 60b22c42b67ad56a3d2a7b80a30ad588cbe740ec
prerequisite-patch-id: 119a167d7248481987b5e015db0e4fdb0d6edab8
prerequisite-patch-id: 133248083f3d3c57beb16473c2a4c62b3abc5fd0
prerequisite-patch-id: 4cda541f55165650bfa69fb19cbe0524eff0cb85
prerequisite-patch-id: 2b4193c6ea6370c07e6b66de04be89fb09448f54
prerequisite-patch-id: 73c675db18330c89fd8ca4790914d1d486ce0db8
prerequisite-patch-id: 88c50fc851fd7077797fd4e63fb12966b1b601bd
prerequisite-patch-id: 47b93916c1b5fb809d7c99aeaa05c729b1af01c5
prerequisite-patch-id: 52ffb42b5aae69cae708332e0ddc7016139999f1

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


