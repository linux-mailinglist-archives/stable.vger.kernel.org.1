Return-Path: <stable+bounces-135061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA6A9629B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 10:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BC83B9E1F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD90825742A;
	Tue, 22 Apr 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZXpC/fPc"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E8280CE4;
	Tue, 22 Apr 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311023; cv=none; b=TatJ2sLYSYxQ3xF7P7BUiulN3rF6zo7mR38LWp2bhMS+5s8iiVaCqvg76GQ/17kEm2dJWK4h9KZ8sosjM1cg8LsNIxWtbjBsGHHKVcCcFsxXYjhmlURBZnSqanhQOpW2zZY1y9Wf2xlsbPPOc8uDYcCeQvAmqA8gauYsSu8R1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311023; c=relaxed/simple;
	bh=9nVtJDWo1D6O2kwPTFwcqfZG5VNM50pQxF6ze3uZES0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pB0P/7E2gydQAU1LtFPA+j4AC/hNh0kfLyOkvHRwNJg1ktWYQ2Z+sneuR6GhMaU+nmmnlpUpANzJgt5wkP6Zm9T0NVSiBmAz22qolu5vh3VGDHWC8IB8s4M6lf3ABxqjqNpYrzJ5UESn6sRA1QSlcw12EYna51V0LX4Krh1HMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZXpC/fPc; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1745310926;
	bh=JU0RHM3LhfHpd/Z5hHY05Fgimq/QoxL5zXExBc+3S9E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZXpC/fPctka+9qXUBdjclQbhACdJTYhapimN3OqCiTNs2F6lJDkRkxGLgdZBqVsbE
	 0XOJQTSQM9Lrgx/TEx59K8DoxYUkLK5pFt8Cj/k5QfUhd2o+ModbkFkOuujd4oEIV5
	 uy4HbmJI46RFo/Oeok3MrvdDA4WrG5ifrtwpnlVg=
X-QQ-mid: zesmtpip3t1745310920t8b1bb162
X-QQ-Originating-IP: xDaMskdxdpmttZVyDVx0vXx2WDh0zl++cOZsOP5r3rE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Apr 2025 16:35:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7588482841693843882
EX-QQ-RecipientCnt: 11
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: james.smart@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WangYuli <wangyuli@uniontech.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.12/6.14] nvmet-fc: Remove unused functions
Date: Tue, 22 Apr 2025 16:34:31 +0800
Message-ID: <56AA32057D5B8285+20250422083431.96652-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MtJoEQFRGvIzFftxGMkZ/AEm+5UDCmqNmKwWbuiBZy2fJTtEfcgljhf3
	OKuNR89Oir+i1EI7OSwRiki0hOAN48+UEaFqwYk7wcC4CjbAAo8zCi2yNkvsNGpPS+ZDT+M
	j0NYmn8p8htVLqN5h6lSCnYB/U8Z7GfJnOVHS/Df4wUXfo1b3NukB2YlhD3xlbfPJdA+joD
	jLX0NAcQm4bqN/wbc+31Lf8JTb3plKQMqITgdrJQy+a51bcrFTY8nTEr2YDLwJRHxgUWNVO
	/ADPLKSiQi6DdIliBYWCVVWr9VAv9kWuUdMbp3flBNsnbI0wIkCPuN6EkrrVICz2GVtYlE4
	8OAYGTfwu9pmtmuyNUsDYi/RXdTxYH6Bttaid7NE6DvSaJuOfnJnIuv45sVDvhTDpLKSYZI
	l75wmR4cmgjX35mqL5cpOAUPjXwgwnJR66h/eX37/e1Mk7TzdBzxFOJlr2JPV42UDmtW7yB
	Q2ph7EQZJKsV7NwHzTBdiCPTKM7PIi8GdYZoZYnKKoCcbiAMK0iQ+zhnj05uWhmtUGSgmEl
	kBT7d0kTbfcM6K8AT89DvVRhmanjCakhKyc+VFdZD751tRkUI5BouYpWbIBqkyLWv3Or5uQ
	em2VDnV8LZkHw5vjUzrajp5VHTEawrGaZNkoahZ7I9lqcupqPTH8ydpFsRswHwesyWbUUft
	uniwveDjxAIzmMWjxDsFO13RWq0+ksiTsuqECQjR/R6kPzXU0rD5ktX3wud1x/y5RPDV7d0
	6oDdoWPPjsSK/8FeEyfBQ8zYYNdSfzBClSlkXDOHpTdZus8xy+kX+3+CQ15LtOuq8ZvlN8+
	UrVKgklOjr+k60lVaDkgOrIIXmnwqJwH4cjpcTc6cKdsVa21r+mkKtiRZEGPElDo0yH9X8c
	StUW/FfP2/IFGDE1IIvYOzqGG1ZXH4j3dIYqdCNnSafVuiCYmHXf6NJ1w0joLXIVfHo3RT0
	bb8vGfPSTH3QkiIMJqXWOPyxZfXBJlNdQsJ/97KgZ7sWVpS04QknHjfv8YSCUOGO7BKnhRD
	u6gOFKdg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

[ Upstream commit 1b304c006b0fb4f0517a8c4ba8c46e88f48a069c ]

The functions nvmet_fc_iodnum() and nvmet_fc_fodnum() are currently
unutilized.

Following commit c53432030d86 ("nvme-fabrics: Add target support for FC
transport"), which introduced these two functions, they have not been
used at all in practice.

Remove them to resolve the compiler warnings.

Fix follow errors with clang-19 when W=1e:
  drivers/nvme/target/fc.c:177:1: error: unused function 'nvmet_fc_iodnum' [-Werror,-Wunused-function]
    177 | nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
        | ^~~~~~~~~~~~~~~
  drivers/nvme/target/fc.c:183:1: error: unused function 'nvmet_fc_fodnum' [-Werror,-Wunused-function]
    183 | nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
        | ^~~~~~~~~~~~~~~
  2 errors generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/nvme/target/fc.o] Error 1
  make[7]: *** [scripts/Makefile.build:465: drivers/nvme/target] Error 2
  make[6]: *** [scripts/Makefile.build:465: drivers/nvme] Error 2
  make[6]: *** Waiting for unfinished jobs....

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/fc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3ef4beacde32..7318b736d414 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -172,20 +172,6 @@ struct nvmet_fc_tgt_assoc {
 	struct work_struct		del_work;
 };
 
-
-static inline int
-nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
-{
-	return (iodptr - iodptr->tgtport->iod);
-}
-
-static inline int
-nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
-{
-	return (fodptr - fodptr->queue->fod);
-}
-
-
 /*
  * Association and Connection IDs:
  *
-- 
2.49.0


