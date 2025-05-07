Return-Path: <stable+bounces-142030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9656FAADDB9
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B263B3A71B3
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87958257AD3;
	Wed,  7 May 2025 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rvLd25vn"
X-Original-To: stable@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster4-host8-snip4-5.eps.apple.com [57.103.65.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13568257AC7
	for <stable@vger.kernel.org>; Wed,  7 May 2025 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618657; cv=none; b=YRswnh3SO2ERArkP+FGz8Ui5UDcFFeKOwraykKEfosssffcG8fGlv4MjeQMr4DZ9ua24tyRVhRqkM4YzqeW5iiSFhFvW405gBxNZgQX+GzIh/LL808GGtoeWSnHKL1qeM7S9KfLpnhjZetz+T7HZvLPl5uJ0HQo62VEXr9xJZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618657; c=relaxed/simple;
	bh=oDXS7Iv9ESrigVT8yDofRqAl6D+tr1qroP5oD1MvuX4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ootg+uhJ+x6s3OG4xW7Fyuy8dPoeH9LtZPmnmHx8cop/0rJ4fnPpCiBHt91G2pnBIsUASZHkG6JrBc3K8sMcmHoU1bC3zUKmxEA8KitMw6TGEIoRjM3Yz9CXsgzEijsSEoNjbe+73bk9ophe3LvfI2bzXenn/wLQZ04pwLbswfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rvLd25vn; arc=none smtp.client-ip=57.103.65.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=u6Ar7PNlePfv0tbFS0qNV80XajEfxKCgPXtPAJebxL0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=rvLd25vnk6izcGaVGTlr+DSqkwlUaWfuk8ic3icr0Af/wRhJEVf1MIwtrw3xICbbe
	 LV3sBGJjyekG+B/uehMk9a80IPcYlMqNnWqDV8nf0t6tI0O6fr5QInmMF6G0MRvUa1
	 75Wk8ErVJQ//evA6Io8QOoAHunlsKjkvnyBUpOuRyHAkiXp4YLO+xQpAhuCzzWsVdi
	 gAdowK6DpyhP38TR+sgVdfDGbrGTEOwvGXeEfTMIly1vetUk5CMKNZ9hIpVT3DdKS8
	 IS6YBZLK4g062mD4JhrH+omX8J4EdpThYk5IIW18v+6BG8/jK+PNSxdrUVOVLbr05i
	 pa8VmZTNFu6iA==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 9110018009C0;
	Wed,  7 May 2025 11:50:48 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v3 0/3] configfs: fix bugs
Date: Wed, 07 May 2025 19:50:24 +0800
Message-Id: <20250507-fix_configfs-v3-0-fe2d96de8dc4@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAABJG2gC/3WMQQ7CIBQFr9KwFgMUWurKexhjmg+0fyFUUKJpe
 ndpV2rict7LzEySjWgTOVQziTZjwuAL1LuKwNj7wVI0hYlgQjHJNHX4vEDwDgeXaNN1rax5U0M
 jSVGmaMu/5U7nwiOme4ivrZ75uv4JZU4ZVb0ErTVTxrXH2wMBPewhXMmayuJD5+pHF0V3YJRoj
 eFayG99WZY3CInCBukAAAA=
X-Change-ID: 20250408-fix_configfs-699743163c64
To: Joel Becker <jlbec@evilplan.org>, 
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: HfjbSoOaVj10G7Pw07YThKiJxMhJcXzq
X-Proofpoint-GUID: HfjbSoOaVj10G7Pw07YThKiJxMhJcXzq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=950 spamscore=0
 clxscore=1011 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2505070111

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v3:
- To both Andreas Hindborg and Breno Leitao.
- Link to v2: https://lore.kernel.org/r/20250415-fix_configfs-v2-0-fcd527dd1824@quicinc.com

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
base-commit: eae324ca644554d5ce363186bee820a088bb74ab
change-id: 20250408-fix_configfs-699743163c64

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


