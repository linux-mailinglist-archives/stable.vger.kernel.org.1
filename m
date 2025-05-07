Return-Path: <stable+bounces-142031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B0EAADDBD
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A5F1C23860
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D780A259493;
	Wed,  7 May 2025 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lhoFOqm0"
X-Original-To: stable@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster4-host5-snip4-1.eps.apple.com [57.103.65.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8C257ADE
	for <stable@vger.kernel.org>; Wed,  7 May 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618668; cv=none; b=PtKxu5+zlNPeOqOrlmlJ7svg5D33ZzEHHj7LuEhwBCMxQvjB33CsugeSleouUrwbns4+kPIUI8ln+MchiPAG1vxxLcLZpGOwgMbbovOrDWV8YOLlWOmoXcklCEN05GGjKsCYJTbID0p5z04ghKRDgdgWASuJLWZBrQZD0Kph6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618668; c=relaxed/simple;
	bh=fhTWpgyQW4P7IBBWg9OM1EczAevb0P/mq5oliB5kZ3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jN3gRrN0XuzUPdCmAw0S8h7CsCCB/xN+Qr4TzBtEk2DSauaPWF+Qi4FjSnRHp6xUbu9VkmKAYCjZ9vAhM2j2V2WLwyDXpODPr0PHJwtqOoxyVErEIcur9FceugV6utcTQjlcwFqXKkYdk/eG01xvFdTR4ldBwOi/G4ntwvU8Gzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lhoFOqm0; arc=none smtp.client-ip=57.103.65.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=nl6EKOqjrfqi7ZEcZQMGd15wSOqkAoUjOXK+nIwxAOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=lhoFOqm0ZH81MiWNSkToRYUwOu87bNpDjKhdl/QlYj/tGHXGqkooUMdhzsuT1coYi
	 SSLpKZ6548iU+y7a+gwkMaGVpxLWtJyYuuL+6r6S8uGWa2qfyxMw6GVAVlaQBaVMsl
	 LeAxJ++aTjmlMQbn2mS+9+8j7AswIzXuRWKV0gjPBXntcvMW26JES261oaNx48wFW3
	 SLG6Lq2AeQ5L/EmYA8E7geqVIh5SKDOsk9YLQeDBb6JL3ZpLM8zZoy3UfqCdcxA21b
	 wyh4vi2s07n27DDm71Wxg6ZPVE8KlYf388aQMiyTubuxTQc6AqOYe96uCVnHsy5RAT
	 mZnAuY/0mF8jw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 813091800673;
	Wed,  7 May 2025 11:51:01 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 07 May 2025 19:50:26 +0800
Subject: [PATCH v3 2/3] configfs: Do not override creating attribute file
 failure in populate_attrs()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-fix_configfs-v3-2-fe2d96de8dc4@quicinc.com>
References: <20250507-fix_configfs-v3-0-fe2d96de8dc4@quicinc.com>
In-Reply-To: <20250507-fix_configfs-v3-0-fe2d96de8dc4@quicinc.com>
To: Joel Becker <jlbec@evilplan.org>, 
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: d8YdO6rX9Xpq4YSvq0ihvZ3f5-oOcUlh
X-Proofpoint-GUID: d8YdO6rX9Xpq4YSvq0ihvZ3f5-oOcUlh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2505070111

From: Zijun Hu <quic_zijuhu@quicinc.com>

populate_attrs() may override failure for creating attribute files
by success for creating subsequent bin attribute files, and have
wrong return value.

Fix by creating bin attribute files under successfully creating
attribute files.

Fixes: 03607ace807b ("configfs: implement binary attributes")
Cc: stable@vger.kernel.org
Reviewed-by: Joel Becker <jlbec@evilplan.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 fs/configfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 6d4a1190f694fe5260577dbedeb755d6fcdf6703..ebf32822e29bed882c4204c71b1b3b4e5df2f2bd 100644
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


