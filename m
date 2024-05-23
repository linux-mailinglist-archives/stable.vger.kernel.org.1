Return-Path: <stable+bounces-45943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85C88CD4AA
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F372865C9
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C4C14532F;
	Thu, 23 May 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2epsRE46"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71EA1D545;
	Thu, 23 May 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470809; cv=none; b=G7mhmG+scaUkOjHwmFz6bWmXSBF6+UXFkAqeb3yGpSmYmMYkjTt8A2MUFrdD3oJxWsBl2RQwN7L6let9rCrvAPRZ+Iy8I+VQM4ZYE2QbjQ/82N/nQdcrrNPTJ1TfwmANP8++TtOb7WoOJMlcYAySzcumyqliDNG18p5YF2pli+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470809; c=relaxed/simple;
	bh=gBj9IU3CWprPQzZzxhGYAdkKo7qhtVn7/J9Xi35vWFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdLtPCVkzeDoOkgPWvFSPyNhV2c/OyOKgu2DB4vKd3tlVrtyOn4Cye8fNKQKAQifF5O0PmYB+0hnmXsY1cVMG/jK7V9SkLs/bwpwgBR31U1XgmaLqTMz9kgmRDblMLX4yDblHkYTHWiBkG84M+6a7wUrG2vGfrifHSwDlMeXTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2epsRE46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E72DC2BD10;
	Thu, 23 May 2024 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470809;
	bh=gBj9IU3CWprPQzZzxhGYAdkKo7qhtVn7/J9Xi35vWFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2epsRE46JRUYM/h3eBdnGF4P5g0B6HOrwCJuk7aQiiJWt+HqMu1ngiFl8XyyD/So0
	 iw54uKD5OnDuf41LjZPYEHlgUfrvDwQeFreFGyYrLOzdr4JnHFK5RMg2hagQzpwLtY
	 udBiOIxxydzQKhXGjCFVn5MZ0ZOZ67XCcLngPJIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 6.6 096/102] remoteproc: mediatek: Make sure IPI buffer fits in L2TCM
Date: Thu, 23 May 2024 15:14:01 +0200
Message-ID: <20240523130346.093953908@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
References: <20240523130342.462912131@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

commit 331f91d86f71d0bb89a44217cc0b2a22810bbd42 upstream.

The IPI buffer location is read from the firmware that we load to the
System Companion Processor, and it's not granted that both the SRAM
(L2TCM) size that is defined in the devicetree node is large enough
for that, and while this is especially true for multi-core SCP, it's
still useful to check on single-core variants as well.

Failing to perform this check may make this driver perform R/W
operations out of the L2TCM boundary, resulting (at best) in a
kernel panic.

To fix that, check that the IPI buffer fits, otherwise return a
failure and refuse to boot the relevant SCP core (or the SCP at
all, if this is single core).

Fixes: 3efa0ea743b7 ("remoteproc/mediatek: read IPI buffer offset from FW")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240321084614.45253-2-angelogioacchino.delregno@collabora.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/remoteproc/mtk_scp.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -126,7 +126,7 @@ static int scp_elf_read_ipi_buf_addr(str
 static int scp_ipi_init(struct mtk_scp *scp, const struct firmware *fw)
 {
 	int ret;
-	size_t offset;
+	size_t buf_sz, offset;
 
 	/* read the ipi buf addr from FW itself first */
 	ret = scp_elf_read_ipi_buf_addr(scp, fw, &offset);
@@ -138,6 +138,14 @@ static int scp_ipi_init(struct mtk_scp *
 	}
 	dev_info(scp->dev, "IPI buf addr %#010zx\n", offset);
 
+	/* Make sure IPI buffer fits in the L2TCM range assigned to this core */
+	buf_sz = sizeof(*scp->recv_buf) + sizeof(*scp->send_buf);
+
+	if (scp->sram_size < buf_sz + offset) {
+		dev_err(scp->dev, "IPI buffer does not fit in SRAM.\n");
+		return -EOVERFLOW;
+	}
+
 	scp->recv_buf = (struct mtk_share_obj __iomem *)
 			(scp->sram_base + offset);
 	scp->send_buf = (struct mtk_share_obj __iomem *)



