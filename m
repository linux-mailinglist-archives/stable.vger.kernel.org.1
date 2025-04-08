Return-Path: <stable+bounces-131757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2456A80C5C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A8D4C7FD8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C048634C;
	Tue,  8 Apr 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Gx4elMOX"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875A2B2DA
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118804; cv=none; b=mAxJIjk65Z60QHDXWFdtXZCtRg2iQLbH3aFJoh0D6KPhxQwJs7y5SM1hhiOLVlVtbk04sWvWsrGvcEie/HloOxjpo3jt34GzqFbGbC/OWvES/KHLhktvJjJrfes2OUFc1OO1ohqij4/HpYeQLxZCl8T3SqwBOjblCy6+DbjyYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118804; c=relaxed/simple;
	bh=bLhC+n9ipIuspiCutxwdQslMxGZ0/Ah47Imrz5DMmkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwqAuKWntVlyas/oJHZoCin0OQANzqWjXLXONnLcmeYt54cweRaLSqW23qafEdwy7vhyAJvapKiQJ+2YzDt7DXWnIUmeIs8GpAjZCBBzAHtUQQYom96pWH67Uzx7zANqPhuAuKz8JTyVP3q2SnXpifr0i9x1mR1GBBmwjDuuCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Gx4elMOX; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=zUlfhPT6fg1tSrewrL0ocqPybNKCthpvg4fclsB59Y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=Gx4elMOXbY2bzC3t6Qgh8wnYdQ3xOzIlCsRA0AiOXqFpGjUn5UQ6ESuGRAkWGvZv7
	 XEDlyDSbLoZu1Mq2+DqNrmD5S6NIAuPgIrVfmeEcRASJcyvCouR9pGp4nHD94jB4DE
	 ZLcLoeMLSRLhLr7+6CtiJiuFAhGsdc/KdhFfv7PxdtcnE1dH94uNyijwR4F1LB47K1
	 FBqIeWdmrlwVFW1DYDYe7gG7901ybRwfvd9MVipVl3uZqNJdrTVCya1vwb4bgtNhHz
	 d7ON/tPrwU6zN1aaV6d3w7lvSERya6xDCxDwK6vvwPjoMj50NBsROM/3AeuvfmxSDe
	 976q8u2ipJzqg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 713B24A00D7;
	Tue,  8 Apr 2025 13:26:35 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 08 Apr 2025 21:26:08 +0800
Subject: [PATCH 2/4] configfs: Do not override creating attribute file
 failure in populate_attrs()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-fix_configfs-v1-2-5a4c88805df7@quicinc.com>
References: <20250408-fix_configfs-v1-0-5a4c88805df7@quicinc.com>
In-Reply-To: <20250408-fix_configfs-v1-0-5a4c88805df7@quicinc.com>
To: Joel Becker <jlbec@evilplan.org>, 
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: BN2XzrWUhKjd3kmW2wflphInFUk-7QRW
X-Proofpoint-ORIG-GUID: BN2XzrWUhKjd3kmW2wflphInFUk-7QRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_05,2025-04-08_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504080095
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

populate_attrs() may override failure for creating attribute files
by success for creating subsequent bin attribute files, and have
wrong return value.

Fix by creating bin attribute files under successfully creating
attribute files.

Fixes: 03607ace807b ("configfs: implement binary attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 fs/configfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 0a011bdad98c492227859ff328d61aeed2071e24..64272d3946cc40757dca063190829958517eceb3 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -619,7 +619,7 @@ static int populate_attrs(struct config_item *item)
 				break;
 		}
 	}
-	if (t->ct_bin_attrs) {
+	if (!error && t->ct_bin_attrs) {
 		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
 			if (ops && ops->is_bin_visible && !ops->is_bin_visible(item, bin_attr, i))
 				continue;

-- 
2.34.1


