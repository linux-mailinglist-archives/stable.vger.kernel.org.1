Return-Path: <stable+bounces-259468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO3EE484HWoqWQkAu9opvQ
	(envelope-from <stable+bounces-259468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 09:45:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C44AB61B0FD
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 09:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC80308E663
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 07:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA1386C3D;
	Mon,  1 Jun 2026 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ebf5L0hK"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58914346A0B;
	Mon,  1 Jun 2026 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299522; cv=none; b=UmLX/OyV3EvsW9ZHOQNeUlJIYOMmAWG2c+Iwv59XBGIr0J+apZzMM40fOT3smB6jsto9lA7uCgkzU3idPU1dVUzOPd2WyBijEEiS4+INBXrE37GG7ghd/4P7au9+5MmtFAUEUhLGBohXFgTAvutfn4dsMjyneYpO7mfeNUqavqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299522; c=relaxed/simple;
	bh=2yuERC0w0nuLV7GbKdVOdx0oS2BPdFl4X1xUjG0Ef6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B4BPtL1//ZRqshZBpV6BUzbcTZxNYSo+v+PJp5RocgLPJcw0hHdvvWjnA7TuG4/h6Ty7StPBQGoRcsfuuLzukYXUAIeqUZ7XMEdN3hzjog8+E+H5zSxQ8ccawDVnrQzqmpv8XGKNKtTun5wvBAcWSVlc3bM8Ey5WbXHEZPYOPP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ebf5L0hK; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hm
	T4AIPgEo68prmsXkRcpooHN7WO/b5izamdHrZwu80=; b=ebf5L0hKzJSbjiwQ6+
	q/o/fuiozlsvKO4jhLpXEZUHa2j7C0yx2dP2mu+dAKFCzuylN3A0z5oQp1IuOCn7
	K1kEYxTgnGTW4Iy/WLpIM0WxoQ2d5m9jQwyGflYVsFAEg8MjwIh/rK6Ewgsv1sV4
	BRz1wrPHtyf9RslKzmoEm4f84=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnL1_lNh1qwo_TAg--.52807S2;
	Mon, 01 Jun 2026 15:38:15 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.15.y] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Mon,  1 Jun 2026 15:38:11 +0800
Message-ID: <20260601073811.73430-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL1_lNh1qwo_TAg--.52807S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15Gr4DWFWUtF1ruFWDCFg_yoW8Cw4xpr
	48Ka4F9a10qr4vqwsrJa4UJFW5W3W2q3s3ur9rCa4Svr4Dtry5tF1DXFyagFyUArWxCF4Y
	yw1Yvw1vva4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pij-e5UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxAipcmodNui1jAAA3H
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-259468-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: C44AB61B0FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 9d724b34fbe13b71865ad0906a4be97571f19cf5 ]

If an error occurs during register_netdev() for the first MAC in
cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
cpsw->slaves[1].ndev would remain unchanged. This could later cause
cpsw_unregister_ports() to attempt unregistering the second MAC.
To address this, add a check for ndev->reg_state before calling
unregister_netdev(). With this change, setting cpsw->slaves[i].ndev
to NULL becomes unnecessary and can be removed accordingly.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://patch.msgid.link/20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/net/ethernet/ti/cpsw_new.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 9d52b949ae3f..bef2c71b9059 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1447,7 +1447,8 @@ static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 	int i = 0;
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
-		if (!cpsw->slaves[i].ndev)
+		if (!cpsw->slaves[i].ndev ||
+		    cpsw->slaves[i].ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
 		unregister_netdev(cpsw->slaves[i].ndev);
@@ -1467,7 +1468,6 @@ static int cpsw_register_ports(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(cpsw->dev,
 				"cpsw: err registering net device%d\n", i);
-			cpsw->slaves[i].ndev = NULL;
 			break;
 		}
 	}
-- 
2.43.0


