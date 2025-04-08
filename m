Return-Path: <stable+bounces-131756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6878A80C23
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C6D7B8135
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B256712C7FD;
	Tue,  8 Apr 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="q6oecDEI"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0203BBF2
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118792; cv=none; b=uWhko3zuWQulUdasAG3LkAtGJYUl+uhSp0PW63dw/NrUyVLEsI/CZnYMYiiaLhiDCbKwiRcwme/Q+jzV1Qk6uNJcpVm991qnh6FT70Bsc749fMfppX0lX28qOB/3TGel4chRXrjBa16BS8V7zXdRub6jBmEGgVzA6HinNK9x6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118792; c=relaxed/simple;
	bh=WAUIDIsnKRAAA+UK8OPhXqHvCzs1BjI5KtJ72Bdx6jc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b5KEpxbPJ9Zohkac804xW0WnMUDqsT1nZrlPkgzldVCEjxTmODcs1varzi+J6Q1qyWXjsfpFzWdjQqxqNPOHXW2rCzSsvWciuMJ41r0fYlwUeMreL2bOzxvTffNcDcRoxczIs+mJkDttuSZRFbWoY2WPuU26/k5fKiqUF5ZHxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=q6oecDEI; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=rRupCG7fg7L/LdQTOLD+yYmhuKVa5h5e2wWxKMSjtaI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=q6oecDEIiT4+Xf2YVGpX9Te3vKf9f9Hrh3TT/lRe6vPXlORWVw66e4if+BWUTeUAs
	 3mlzK9uS9JZzPVBJNVSy8k6DXnmOFKPRviX8hZEU1BMA9bIFfkAbSG0n1DfNt1vjwM
	 Gvk++m4qhB/xzL1aMsicbPOelB47Bz/+fmeEc61JPA06VKxWynnSgndzPWUmNh2c05
	 JOFDbTeYCMSIXOyDjWWv2DQtvLqsqwdB73Ng+jJ5C66IqjgNrs49HEARshQw8R7MGX
	 yLrckOjAK0u8kK4pBTnldBN08ERJxlv0M3z+G0Q5qUvljKdK1HTwjnYxl8ZRZpMuDX
	 +6p5Kok/uC0wg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 980E24A0234;
	Tue,  8 Apr 2025 13:26:22 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/4] configfs: fix bugs
Date: Tue, 08 Apr 2025 21:26:06 +0800
Message-Id: <20250408-fix_configfs-v1-0-5a4c88805df7@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO4j9WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwML3bTMivjk/Ly0zPS0Yl0zS0tzE2NDM+NkMxMloJaColSgPNi46Nj
 aWgD20misXgAAAA==
X-Change-ID: 20250408-fix_configfs-699743163c64
To: Joel Becker <jlbec@evilplan.org>, 
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 0BKMqQEmZowqoHAp5lCCka2RxPLuDXLp
X-Proofpoint-ORIG-GUID: 0BKMqQEmZowqoHAp5lCCka2RxPLuDXLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_05,2025-04-08_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=862 spamscore=0
 adultscore=0 suspectscore=0 clxscore=1011 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504080095
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (4):
      configfs: Delete semicolon from macro type_print() definition
      configfs: Do not override creating attribute file failure in populate_attrs()
      configfs: Correct error value returned by API config_item_set_name()
      configfs: Correct condition for returning -EEXIST in configfs_symlink()

 fs/configfs/dir.c     | 4 ++--
 fs/configfs/item.c    | 2 +-
 fs/configfs/symlink.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
change-id: 20250408-fix_configfs-699743163c64

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


