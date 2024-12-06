Return-Path: <stable+bounces-98888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6720B9E628A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2135518839F4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5369274421;
	Fri,  6 Dec 2024 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hi6Yfp8S"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24563E499
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446385; cv=none; b=bQDho5TpL2yHU6VtxGyC0RvMcwlZ3c3ffmCso9K634p0bNSXuS4etfue8dl4FfcxspJ75vtPqr86W1j1fdp3B7694WuZSP98aniMAet3XxTcZqc7wAsGSvnDF4V5TQSP5gfhQCcAiGKkY3grgA2P8wDUZ1Um4+pIHfd4aN/9YQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446385; c=relaxed/simple;
	bh=wOYv63c54RyGiFTh41AjUWVq3YW54AG1Xq0ZEBZHwOU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=enZSeUto4NQeN/mR1qkEOB6vMlN3YAYti7CATdRN2Xz9ULhjU8+0Gv5lNKP5UvTfMBLzDm/J2W+iAw9FoecjwQnjHqQ5k+TZ7yZWXLzNxmNruYMzZ9+kzzdsNSaPTD9+tOpD7uBdajGlv29kVGmGrh1HNmSW9dxpFywm/Fw19YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hi6Yfp8S; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446383;
	bh=69NzVYXYPQWlYMOcr43m0o4u0Tn+jvvdpHpCjTYFKq8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=hi6Yfp8SHYtfqSvzeIf1VMzeEDn117wDCHpk42aB/M+M0aJASb/JfUgSre3R3RR8P
	 htDyMTdPapZ+zbtIvOzAu4xswfZQC7wCbGGj2h/Tx3Nqg3ek6KbFd8sP3T5yMhcMdR
	 bvZNBXYDEAs93hhyVhzRIdAKGSHobFg3k0EZSqW2UISQ3Bvxe5rsTuyqdXS+Gz5nSt
	 ktVeggp8MKF1lKZuNApgBPhsMTxx81GMFBfpG8kXlN+foT9moosTl+rU3ILY2nsEKP
	 90wafh1BcqTVs0YFOsKXnTv1ZIt8hQXyQaHoy2irWvFiipX6E/4E8n7h8wm9rsuO0z
	 IsHk/UblZ86oQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 33936A0295;
	Fri,  6 Dec 2024 00:52:56 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 00/10] of: fix bugs and improve codes
Date: Fri, 06 Dec 2024 08:52:26 +0800
Message-Id: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpKUmcC/x2MQQqAIBAAvyJ7TtBNJPpKhIiutRcNhQjCvycdZ
 2DmhUaVqcEqXqh0c+OSB+hJQDh9PkhyHAyo0GhUVpbkQqnkEj8yhlmh9soavcAorkpD/7dt7/0
 DOvoJVl0AAAA=
X-Change-ID: 20241206-of_core_fix-dc3021a06418
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Leif Lindholm <leif.lindholm@linaro.org>, 
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: -bVrGoRo7FM41P3ICiq7MYlGOzclqN52
X-Proofpoint-ORIG-GUID: -bVrGoRo7FM41P3ICiq7MYlGOzclqN52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=685
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs and improve codes for drivers/of/*.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (10):
      of: Fix alias name length calculating error in API of_find_node_opts_by_path()
      of: Correct return value for API of_parse_phandle_with_args_map()
      of: Correct child specifier used as input of the 2nd nexus node
      of: Fix refcount leakage for OF node returned by __of_get_dma_parent()
      of: Fix available buffer size calculating error in API of_device_uevent_modalias()
      of/fdt: Dump __be32 array in CPU type order in of_dump_addr()
      of: Correct comments for of_alias_scan()
      of: Swap implementation between of_property_present() and of_property_read_bool()
      of: property: Implement of_fwnode_property_present() by of_property_present()
      of: Simplify API of_find_node_with_property() implementation

 drivers/of/address.c     |  2 +-
 drivers/of/base.c        | 25 +++++++++++--------------
 drivers/of/device.c      |  4 ++--
 drivers/of/fdt_address.c |  2 +-
 drivers/of/property.c    |  2 +-
 include/linux/of.h       | 23 ++++++++++++-----------
 6 files changed, 28 insertions(+), 30 deletions(-)
---
base-commit: 16ef9c9de0c48b836c5996c6e9792cb4f658c8f1
change-id: 20241206-of_core_fix-dc3021a06418

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


