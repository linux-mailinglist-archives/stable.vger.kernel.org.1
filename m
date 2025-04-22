Return-Path: <stable+bounces-135066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9C7A9633F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB073B7C1F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADA259C8B;
	Tue, 22 Apr 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jA90xRtW"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A71EB5FE;
	Tue, 22 Apr 2025 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311704; cv=none; b=TbznRYpaFurn997g+q5DRqAB/RRCMJP70Fd2PjbDmHxMX5cTKouEFGmeC4qp+hlRqGSjLUFVTL8foB2bNbtujLDfhlqV1aINWL2e9/xPiGnVnOcyvbmJPQTkgyUmu036V9fkZtPY67PplgB80jn+ECj7qrlGQ4NIAwO4IssaYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311704; c=relaxed/simple;
	bh=NODx8qfsyJ8m7uk0HyQ06uCxjDXpJQxJXYskeQoB00Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCgzlj12JuGKuW5sXRiivLv9T4oYhpfkQLzE6zMkPo4mPZOtvAHxxfXmX8IdhjyF6ZrDmduB07t+GSVzYgES9HYz8eXe3Fq2DEAKEDmu5KJVB9y7nC44/TWEknF1uTSlfVAxLRuHeZTqIjAJrGYlDchaUFXO87YtC4aCDftPeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jA90xRtW; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1745311614;
	bh=Mn/KlAzNwHEUhyTCzKuyDP8x4usPzEJXQKKgGUzJ4zE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jA90xRtWI6KmAt77gAVpMgb4LkBg93XT0EEAkxJDEg1MVlXEA5GYRIi+9anXY8SD5
	 iDRhVTkln1ibySg2WHfV9n8n70ETnk/CbVh+ZDiNdjhoJYXMcdNMp0VFB+1r6zoW/0
	 Kyf1GoQwEJqax3komuoWQfNM/q2VyZNFafZaR9AI=
X-QQ-mid: zesmtpip4t1745311608t1f9ad96f
X-QQ-Originating-IP: 5XEdCAWppwNKQdwP3OVG0Gd9FLc+JSOm9olJHjetOpY=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Apr 2025 16:46:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1164871164617083514
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
Subject: [PATCH 5.4/5.10] nvmet-fc: Remove unused functions
Date: Tue, 22 Apr 2025 16:46:11 +0800
Message-ID: <E2B130726D65F768+20250422084611.103321-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: OQDnMK6ucigbltoy6M3+6MJFsHv5JMUVIT5oBvRnFfiO79S5lu4bGpam
	bBL6oG2AQSXW+FU/Qy0UJA/NALYASWagOXmGv4fbhpT+kfhDLfH0EFanKy+4vCoR4nsJlCW
	8VhW/r13uBwVnsabLun5YGHT1gILtxeVOiL7jNKDpPpZRn8HAHq3KYx8g0fRPDbrJTYaUns
	nJsbgv7XKmjkl4uxwQ9djGwe6UA5aEXv6exxhRNeFFpga69qqHv2Oz66qIPeoR2RnuwhfGf
	rGpgcwKpVVPyoexCsTeDFk6HPgUrTlmr/zdbaGT5tn6ufLhFWoY5OyJxPKaL4FMYE8QqLFj
	2lKng0lMdYko2wtAHjUl09gzbKKncbA7cecBHiI6DF3XqEam9VDtb1oMqm6ZKGtdI14IN/p
	meRf0f2wTJ0UuP1pp36iPbuajXBAIEioROU7eWUsiL7Fye78eNda0zauQgk6+kxBjqWcfxS
	66kPlKetWsasEZdRSFRpwa3W3/H4yKIXw7qpfKCu2GcATZAh+8xQcO6xHZGyLolAOye8UL8
	g/y8lixJubhESSEh/++kEWjCrey7wNtWzu77MPquXBQpsc4py+3HtX1KolEOS0GAxoglGfx
	jzGONCD4e0PHzZ1XgqPfZbLMWwr6QTne2esYdyPB93VBvXOBxPLSYgncrzEGN+YgWG9zW4U
	96iuiLBiy4V1J5IxbTER8RkhKmILNt8mRsJWAvCnl+XhIx2/bqSBdK7zDH4zWmg4WO8XLVF
	NVenYrufI8UoSDMp1l+b9i31Mif5Af1dtkZKGNuuZ6/RED5DZ5xDCFKbzvzj7cjKlws4Wbr
	xhCr027xPbtK4wnMzPhIk5+2i4XNk7kfmM4TB9Dkqs+I/NWevA2ZYyF1xG6Dv6ZSzFJhuWO
	fOARG9t7PTvsJ1GtfhaaiHfg0g0sSMsEpnquQBzZa3KLWXUsS+nIJScHs8qNVUucQXB6HYm
	tl8oSwGIoaSw8/BbhlhjvdQTwirHCIUfuekwhJAwMvkBkNaOrLncGzpO3ZUonMvAUXyFbpD
	WV7zdUyWlYpWKHl4F7iLxJx6xW5OliAcINs86c32R+bhqJ+XrxPpFhNRDmniOdrPWLZf53p
	56DucQhxe7C
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
index 846fb41da643..321859753ae8 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -169,20 +169,6 @@ struct nvmet_fc_tgt_assoc {
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


