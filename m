Return-Path: <stable+bounces-128531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A885DA7DE94
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FF816AFD1
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11F825290E;
	Mon,  7 Apr 2025 13:11:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4172512FD;
	Mon,  7 Apr 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031506; cv=none; b=UciKjM/CQ6K+X1kQS12BpaaIv0cnoYV9aH4/Tcc6wlWPylvssuqL6GPluBWWmzU8JVNrAzNjg1ge6Li8PF8wRvDtcYQU3Xxe4EvzUTmQGccyAbsniutvbgHuYk6VrL8nuEEimRYSL4QVVMfEU8vLjb2eiIZ/frcjFatPeIK0PTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031506; c=relaxed/simple;
	bh=2Kyzltuee9lw0VbxAQZivPwT/I9GE7kNboJtO2TQKb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckjsgP2LUOBlmgXLQzLmk67SuinOAuCEYLwiqSjNiNXAf8iR95tyXyFEVPpNjRVEXLSKnb83B6pEbOlLPGNK1q3NQRaogPSrALkOgYJB+kI83TvWXn+T5J0mKvp1OQV8ytYgZtPm0QQctxLsupwIOd3KijhbqMS81Ggf6Lqy82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowABHtkL+zvNn2JviBg--.35685S2;
	Mon, 07 Apr 2025 21:11:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] sfc: Propagate the return value of devlink_info_serial_number_put()
Date: Mon,  7 Apr 2025 21:11:10 +0800
Message-ID: <20250407131110.2394-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHtkL+zvNn2JviBg--.35685S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1fuFyfAry7tw48WryxAFb_yoW8Xr4rpa
	y3AFyagFyfCFy0ga18uF48uFy3Za1UKFyqgFZ3Kw4ruanxJr4avFsY9a43Kr15ArWkG3Wx
	tr1UCrWfCFn8ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU52NtDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoFA2fzvEUKpgABsL

The function efx_devlink_info_board_cfg() calls the function
devlink_info_serial_number_put(), but does not check its return
value.

Return the error code if either the devlink_info_serial_number_put()
or the efx_mcdi_get_board_cfg() fails.The control flow of the code is
changed a little bit to simplify the code. The functionality of the
code remain the same.

Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
Cc: stable@vger.kernel.org # v6.3+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v2: Simplify code logic.

 drivers/net/ethernet/sfc/efx_devlink.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
index 3cd750820fdd..53b17cd252c8 100644
--- a/drivers/net/ethernet/sfc/efx_devlink.c
+++ b/drivers/net/ethernet/sfc/efx_devlink.c
@@ -584,11 +584,12 @@ static int efx_devlink_info_board_cfg(struct efx_nic *efx,
 	int rc;
 
 	rc = efx_mcdi_get_board_cfg(efx, (u8 *)mac_address, NULL, NULL);
-	if (!rc) {
-		snprintf(sn, EFX_MAX_SERIALNUM_LEN, "%pm", mac_address);
-		devlink_info_serial_number_put(req, sn);
-	}
-	return rc;
+	if (rc)
+		return rc;
+
+	snprintf(sn, EFX_MAX_SERIALNUM_LEN, "%pm", mac_address);
+
+	return devlink_info_serial_number_put(req, sn);
 }
 
 static int efx_devlink_info_get(struct devlink *devlink,
-- 
2.42.0.windows.2


