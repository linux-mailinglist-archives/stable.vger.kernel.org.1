Return-Path: <stable+bounces-219338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEuaOHydnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6E192A0E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66BFB301BAB7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330C93081D6;
	Wed, 25 Feb 2026 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FuMXJzbn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5130171A;
	Wed, 25 Feb 2026 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002650; cv=none; b=guyfVh2kNLN7Csj+SV9QVQY50uFHAkwlMITUmcuQWXnYuo5qzNLZfV4eEh7v8edSrPnHuleEg+sMmmZ9WeWozsq1djLEfh8/3PI/DfkvtCfoRs8w3Xu0pw/bGeru5jLApbywg1TokxbmnL+5AVBQT6vQ3Fo+8iI2vuzkFmaYmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002650; c=relaxed/simple;
	bh=eWHrf5I/0sn+FtwXFHYGi6AhCiScjNKQ0qolVyfdYXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLF1Z3FdhzfN1gekfos50+K8GaBuLznb5nKWG+fLEjsebTLgIi/sWM+pUD1I2684PXfsAlNBZBOxQf+pHTGC0I2+dkX+9rIE+SZ7PqQkH/JGSbpI0Q0nixqbVCVjR4LCwLN8RjNmZbRDTb3+cebTEL1n3JyEcRZx8jh12QQ74Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FuMXJzbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4565C116D0;
	Wed, 25 Feb 2026 06:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002649;
	bh=eWHrf5I/0sn+FtwXFHYGi6AhCiScjNKQ0qolVyfdYXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FuMXJzbnZP0Jn8Cg+zbFFYx07gEuEWSrynCnaAqpAhhNG/LIstDhBTSACZ+AWxIq0
	 Ah4e/Xe65jXNR2qgXlMJ8DBHMuYEx6VqHntpNrBjwSSIBpSrY5ac+3p4IjJHRpDfKH
	 sbhiL4cPjmYvfPCDmZ/Z1DY80SkeKqkfjagaD5tE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 380/641] RDMA/mlx5: Fix memory leak in GET_DATA_DIRECT_SYSFS_PATH handler
Date: Tue, 24 Feb 2026 17:21:46 -0800
Message-ID: <20260225012357.801768608@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219338-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97C6E192A0E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 9b9d253908478f504297ac283c514e5953ddafa6 ]

The UVERBS_HANDLER(MLX5_IB_METHOD_GET_DATA_DIRECT_SYSFS_PATH) function
allocates memory for the device path using kobject_get_path(). If the
length of the device path exceeds the output buffer length, the function
returns -ENOSPC but does not free the allocated memory, resulting in a
memory leak.

Add a kfree() call to the error path to ensure the allocated memory is
properly freed.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: ec7ad6530909 ("RDMA/mlx5: Introduce GET_DATA_DIRECT_SYSFS_PATH ioctl")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Link: https://patch.msgid.link/20260126074801.627898-1-zilin@seu.edu.cn
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/std_types.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/std_types.c b/drivers/infiniband/hw/mlx5/std_types.c
index 2fcf553044e15..1ee31611b4b3f 100644
--- a/drivers/infiniband/hw/mlx5/std_types.c
+++ b/drivers/infiniband/hw/mlx5/std_types.c
@@ -195,7 +195,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_GET_DATA_DIRECT_SYSFS_PATH)(
 	int out_len = uverbs_attr_get_len(attrs,
 			MLX5_IB_ATTR_GET_DATA_DIRECT_SYSFS_PATH);
 	u32 dev_path_len;
-	char *dev_path;
+	char *dev_path = NULL;
 	int ret;
 
 	c = to_mucontext(ib_uverbs_get_ucontext(attrs));
@@ -223,9 +223,9 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_GET_DATA_DIRECT_SYSFS_PATH)(
 
 	ret = uverbs_copy_to(attrs, MLX5_IB_ATTR_GET_DATA_DIRECT_SYSFS_PATH, dev_path,
 			     dev_path_len);
-	kfree(dev_path);
 
 end:
+	kfree(dev_path);
 	mutex_unlock(&dev->data_direct_lock);
 	return ret;
 }
-- 
2.51.0




