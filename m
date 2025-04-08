Return-Path: <stable+bounces-131758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F51BA80C69
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF595064C0
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C017CA17;
	Tue,  8 Apr 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tMlh6pgt"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBEA70824
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118817; cv=none; b=EEuQnpO/rZ38vCtwVy8a7zeq2pNqRvHgw7v/6CjmIfI5hA9yn+/vgU594O7RzUo6mqXTjljlwQnfN0QinFEGeN3xOhkem6XtWYOYfxEAz057pQiVOnoN6IFnORzafuWH8qaCrHzEk0cF2Sxg1tXeNps9ShaqcOqyvb90btMs3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118817; c=relaxed/simple;
	bh=mtSZiNQOogGx0MHYX1eT2nG24+zA53rj37aOcTwxrFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2Sx2qR/tuhKFU8x8idlBui3jhI7vlVx9SqykzOIQGU/ogdf34FTXz5OQY7q/IDAQx5+k/Ur2h+gvsWZjL1lCOMrTGnD5z5Lasz5QCWmh0ttxUcL2YbEu3i1dxBDAqy2ipXAxBdNMojI71NRgYqBtQfOuQ9pRlehX/8I0vsb5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tMlh6pgt; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=ToX3+7Y3Y2WjC89z+4I5sSRGLFPhZkkySKnQkQN6CUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=tMlh6pgtP+e4aHPaY48QsfzwTc0DFy+y6ALPBZCmdtAuheIUOC61vlAnmb4IQZree
	 G9SEJHx4mfmKa8jnthhCI15BIl68U+k2/9nZiPqs3MeZDD9P0MpyuRpIGSghJ4tLwA
	 qWEcCiJcYndUwFepuZ/Kapj2u8yovAGmC7wQa2mtoOmSAFcPwRXYZapky+1a+UWBoK
	 39DZdhS33NXhsJJaohUEjidj5EwyDtZTIH28O8Ab8Y7gtQo/76G2cJ2FTXbktHrYxd
	 9q3/Ldq30o1hVdtH17Z1p2j5CXhL1ljo/vZBF8lm4dQ6PUAW8YW1dlyEoDfyqA1xSv
	 Rt8jJISoUBiJA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 19F3F4A03F7;
	Tue,  8 Apr 2025 13:26:49 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 08 Apr 2025 21:26:10 +0800
Subject: [PATCH 4/4] configfs: Correct condition for returning -EEXIST in
 configfs_symlink()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix_configfs-v1-4-5a4c88805df7@quicinc.com>
References: <20250408-fix_configfs-v1-0-5a4c88805df7@quicinc.com>
In-Reply-To: <20250408-fix_configfs-v1-0-5a4c88805df7@quicinc.com>
To: Joel Becker <jlbec@evilplan.org>, 
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: NxXVWSIJKHafJxtQFxXPa_5-hUFwf5zZ
X-Proofpoint-ORIG-GUID: NxXVWSIJKHafJxtQFxXPa_5-hUFwf5zZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_05,2025-04-08_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=739 spamscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504080095
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

configfs_symlink() returns -EEXIST under condition d_unhashed(), but the
condition often means the dentry does not exist.

Fix by changing the condition to !d_unhashed().

Fixes: 351e5d869e5a ("configfs: fix a deadlock in configfs_symlink()")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 fs/configfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 69133ec1fac2a854241c2a08a3b48c4c2e8d5c24..cccf61fb8317d739643834e1810b7f136058f56c 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -193,7 +193,7 @@ int configfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (ret)
 		goto out_put;
 
-	if (dentry->d_inode || d_unhashed(dentry))
+	if (dentry->d_inode || !d_unhashed(dentry))
 		ret = -EEXIST;
 	else
 		ret = inode_permission(&nop_mnt_idmap, dir,

-- 
2.34.1


