Return-Path: <stable+bounces-211480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHkYClwLdmkNLAEAu9opvQ
	(envelope-from <stable+bounces-211480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 13:23:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8033F80837
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 13:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C8D330048D6
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B06331985D;
	Sun, 25 Jan 2026 12:23:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA963EBF21;
	Sun, 25 Jan 2026 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343830; cv=none; b=Lf586zXMnicuLgkTbVEeYbxdKPljmp4UcMRrDy1mww9qRWZU6ML3nbiVTSDJ6JTDMPO8kstCaY45BWipryJIcFuZHsQrS9xx2iAqJy4u8B4Xd6R0VhYeatfhjzJ5q2/spa/DmZnu6vcl+q+Ur1NwSOLBvHGRVxWAm5kiyaUSPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343830; c=relaxed/simple;
	bh=A7ZNenREdKva72mcfILf0vXj6lo8W9TsdkB+zsI1spg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nhNOgtaOMgMGBajjgna10Enu0SUnCWyyu+K9RUI351abI1UA6L1Os95IzCT9N2BLxCzl8VRh1RalRIpi8Vzb1t5lNB9Y2R3Ow7z1HgqVq24AzTNd/n2qDLxMdYt1iygkwySV1zVL/tSyWJ1ptjsO1A7fcaSeTS8aw3CS/MMJI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-01 (Coremail) with SMTP id qwCowABnEW1NC3ZpK0orBg--.10392S2;
	Sun, 25 Jan 2026 20:23:41 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: airlied@redhat.com,
	chris@chris-wilson.co.uk,
	simona.vetter@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] intel-gtt: fix an error handle in i810_setup()
Date: Sun, 25 Jan 2026 20:23:39 +0800
Message-Id: <20260125122339.2008087-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnEW1NC3ZpK0orBg--.10392S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1ruw4xuF48Cry7Xr13Jwb_yoWkJFc_WF
	yFg34kG3yFkF1rCr1UAr17ZFy2kw1FqrZaqF17Kryaya4SqFs3KFy5urn3u3WkXrs8ur9F
	qa47Xr1Fyry2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU18sqtUUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwkSE2l1q+x0JgAAsG
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[7];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihaoxiang@isrc.iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-211480-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isrc.iscas.ac.cn:mid,iscas.ac.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8033F80837
X-Rspamd-Action: no action

In i810_setup(), if ioremap() fails, the memory allocated
by alloc_gatt_pages() should be freed. Add free_gatt_pages()
to do so.

Fixes: 820647b97a9c ("intel-gtt: switch i81x to the common initialization helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/char/agp/intel-gtt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index bcc26785175d..dfb6282ce401 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -186,8 +186,10 @@ static int i810_setup(void)
 	reg_addr = pci_resource_start(intel_private.pcidev, I810_MMADR_BAR);
 
 	intel_private.registers = ioremap(reg_addr, KB(64));
-	if (!intel_private.registers)
+	if (!intel_private.registers) {
+		free_gatt_pages(intel_private.i81x_gtt_table, I810_GTT_ORDER);
 		return -ENOMEM;
+	}
 
 	writel(virt_to_phys(gtt_table) | I810_PGETBL_ENABLED,
 	       intel_private.registers+I810_PGETBL_CTL);
-- 
2.25.1


