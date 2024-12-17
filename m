Return-Path: <stable+bounces-104865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2F19F537F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD324188CCC5
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E88F1F8925;
	Tue, 17 Dec 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pL8rczPx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F01F76B1;
	Tue, 17 Dec 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456339; cv=none; b=OhcBayrK9e2nh9svnJPVQakKV/UU6W9HhDzmxapMVsy9oHKhwQ5Ub1HFvUVkLZi1QLFW5vjUPE7kRMANHscmlO13uYW8xtG7S2/R5JIrWohlj5lyO5a8IxyskCxX+FLq7SvMk4oXpi7xqxeoLhUfyCWijUk+7o7lx/rBIZFJrM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456339; c=relaxed/simple;
	bh=yCXPeFzwNVx/xsrpt6FdmQTNGQIxmlV4J9q7pWGWkKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZShh+LwWO81izWubp3ofKDxb36WdqSfgWHYws0j1bT6DEIS7xHDk0QScXAV+IuEkk4s5tPLfOXABUVxNpCYPnWQNU2LuheBZ1QS+YVOwKHkKk22jIqFcVDJaPprqYKU3+Kx1hKvinkpy4fvU0SBL33WhqBGXrj+62L5bXP/DPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pL8rczPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79023C4CED3;
	Tue, 17 Dec 2024 17:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456338;
	bh=yCXPeFzwNVx/xsrpt6FdmQTNGQIxmlV4J9q7pWGWkKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pL8rczPx/ofzQShUOlYJdh7DeOiIE6ktwD+TdtP0pWcrJY0sV8IfsuSwTM9fr1BHg
	 WgAxdZk5uRIbpEFGikqYvb3oe+NnEjs4/Z47kfdrwXjhyzqPihd7dpVdbTMM8PAk9U
	 D7TSOfZ2onbaFDxwmh3Jo/5yhJw6f3GR+ZJOb1EI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.12 028/172] crypto: hisilicon/debugfs - fix the struct pointer incorrectly offset problem
Date: Tue, 17 Dec 2024 18:06:24 +0100
Message-ID: <20241217170547.431916732@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenghai Huang <huangchenghai2@huawei.com>

commit cd26cd65476711e2c69e0a049c0eeef4b743f5ac upstream.

Offset based on (id * size) is wrong for sqc and cqc.
(*sqc/*cqc + 1) can already offset sizeof(struct(Xqc)) length.

Fixes: 15f112f9cef5 ("crypto: hisilicon/debugfs - mask the unnecessary info from the dump")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/hisilicon/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 1b9b7bccdeff..45e130b901eb 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -192,7 +192,7 @@ static int qm_sqc_dump(struct hisi_qm *qm, char *s, char *name)
 
 	down_read(&qm->qps_lock);
 	if (qm->sqc) {
-		memcpy(&sqc, qm->sqc + qp_id * sizeof(struct qm_sqc), sizeof(struct qm_sqc));
+		memcpy(&sqc, qm->sqc + qp_id, sizeof(struct qm_sqc));
 		sqc.base_h = cpu_to_le32(QM_XQC_ADDR_MASK);
 		sqc.base_l = cpu_to_le32(QM_XQC_ADDR_MASK);
 		dump_show(qm, &sqc, sizeof(struct qm_sqc), "SOFT SQC");
@@ -229,7 +229,7 @@ static int qm_cqc_dump(struct hisi_qm *qm, char *s, char *name)
 
 	down_read(&qm->qps_lock);
 	if (qm->cqc) {
-		memcpy(&cqc, qm->cqc + qp_id * sizeof(struct qm_cqc), sizeof(struct qm_cqc));
+		memcpy(&cqc, qm->cqc + qp_id, sizeof(struct qm_cqc));
 		cqc.base_h = cpu_to_le32(QM_XQC_ADDR_MASK);
 		cqc.base_l = cpu_to_le32(QM_XQC_ADDR_MASK);
 		dump_show(qm, &cqc, sizeof(struct qm_cqc), "SOFT CQC");
-- 
2.47.1




