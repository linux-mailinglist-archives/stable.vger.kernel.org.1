Return-Path: <stable+bounces-127328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B129FA77BAC
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 15:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094111884924
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE20A2036E1;
	Tue,  1 Apr 2025 13:06:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613229A1;
	Tue,  1 Apr 2025 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512797; cv=none; b=VrQWAGKQhWH3zp8aP/uE+Nl8zjxrkgF1zdiJZjPMuHUw3heSHZDTa//2GRzWP4VdLpLObDA3EQAukjfq4ocF8xDU93sRVAFRZQuoVsLh2vbIbaEs7EU+qyJIgdoWH6Haoz7UnGcU342jhosu8jHiCMOqAOmWX3p3RnJCpzsUwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512797; c=relaxed/simple;
	bh=aM4P6LXDP5Ax4pIA2Q6gLObhPDwVSK/b1kVvhkanqUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=taYgupAhslhcHXW3/3UWEe3Za6Befa14Yi8N/oh+ocyUF0o8tXCGml5dl7wDI7dj9ZKHuMOnkN1eaCAAKDqC7zNkwUfSNr1l/jXW23X/fsbeIcylLUQ9YA5jchWnfA1E2y0OTSxisL3ge38Ekz3OyTbO8AsCTzLy1x1v71o00ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADXgQLL5OtndRXABA--.4273S2;
	Tue, 01 Apr 2025 21:06:19 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] sfc: Add error handling for devlink_info_serial_number_put()
Date: Tue,  1 Apr 2025 21:05:57 +0800
Message-ID: <20250401130557.2515-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXgQLL5OtndRXABA--.4273S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1xArW5KFWxXw13JF17GFg_yoW8Gr1fpa
	y3JF9IgryfGrW09w4UZF18ZFyavayUKF1DGFZakw4ruan3tFn0vrsY93Wa9F4UArykG3Wx
	tr1UCrW7C3Z8A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUaeHkUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsTA2frlYK1dQABsH

In  efx_devlink_info_board_cfg(), the return value of
devlink_info_serial_number_put() needs to be checked.
This could result in silent failures if the function failed.

Add error checking for efx_devlink_info_board_cfg() and
propagate any errors immediately to ensure proper
error handling and prevents silent failures.

Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
Cc: stable@vger.kernel.org # v6.3+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/sfc/efx_devlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
index 3cd750820fdd..17279bbd81d5 100644
--- a/drivers/net/ethernet/sfc/efx_devlink.c
+++ b/drivers/net/ethernet/sfc/efx_devlink.c
@@ -581,12 +581,14 @@ static int efx_devlink_info_board_cfg(struct efx_nic *efx,
 {
 	char sn[EFX_MAX_SERIALNUM_LEN];
 	u8 mac_address[ETH_ALEN];
-	int rc;
+	int rc, err;
 
 	rc = efx_mcdi_get_board_cfg(efx, (u8 *)mac_address, NULL, NULL);
 	if (!rc) {
 		snprintf(sn, EFX_MAX_SERIALNUM_LEN, "%pm", mac_address);
-		devlink_info_serial_number_put(req, sn);
+		err = devlink_info_serial_number_put(req, sn);
+		if (err)
+			return err;
 	}
 	return rc;
 }
-- 
2.42.0.windows.2


