Return-Path: <stable+bounces-128215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA449A7B388
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813017A5E1E
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9041F8BBF;
	Fri,  4 Apr 2025 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBDXqCLk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6121F8BA6;
	Fri,  4 Apr 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725163; cv=none; b=jN3LGfVY4j4Qh25gMqCb/k1yAMlzI1yjizMuGRYph/Zioa7+fNRG+vgVmTzzdtmA6iBLYiUoo06LucF/jRcQhUMSqM/po5pUewgNEieDdjKo6D8kDDwy40zDagK+199kA55FjeWu8xOp6zg0HLPpeh1g9bbZbztNlfIt8D6S7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725163; c=relaxed/simple;
	bh=tlVOcF69TDTf7UxAp0r3OROQx2LEOVK/tm0B01q4DIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ar73Uh+R0k2nqErYWq6C0ti4N+gNs9TagYXqUt6AMvngm2NAgNMPKM7CsrMs9Zs4pA541rWkCDTWHsgq3KfxCeA4KjC0IjpoAm3Uw2dFSfvoyO4Wkvoeqy/ewkgFwLqllmf8hmhdwKWC/UA1IDfrJdjPAbF13G9bGNVfA5yPtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBDXqCLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53D7C4CEE3;
	Fri,  4 Apr 2025 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725162;
	bh=tlVOcF69TDTf7UxAp0r3OROQx2LEOVK/tm0B01q4DIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBDXqCLk7sw6XelUS/imWqU3F0ixWoYwcLlYrP57GvFPVheLeVcL3LoWkPJlCj1bO
	 payAShrv2NeJbmZ7XZYCdW0pEvPPN753OjK7V4++lkfyzZIqSxchT4n3fL4xMaIQXc
	 WhZTfYg0GZ57UPrB9qDK5OQAG2NglplZ9k89hZVkXWpmtmOTlzuNYBLXJ24dHKrAHn
	 jOc8pJzpyck6DZmFYGBerP8yM4y5cy70r0giX4tZ4sJ3VKG1CSmOPmvlvJc9pi8Kqr
	 c8asIyfQ5ci85RzYuuaArswOrrkqSX1y3R6NpbOZUcDrc7usdyStW8+sgZfYrp/gil
	 j0RGINbvkjrug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org
Subject: [PATCH AUTOSEL 6.12 09/20] HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition
Date: Thu,  3 Apr 2025 20:05:29 -0400
Message-Id: <20250404000541.2688670-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000541.2688670-1-sashal@kernel.org>
References: <20250404000541.2688670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Kaixin Wang <kxwang23@m.fudan.edu.cn>

[ Upstream commit e3f88665a78045fe35c7669d2926b8d97b892c11 ]

In the ssi_protocol_probe() function, &ssi->work is bound with
ssip_xmit_work(), In ssip_pn_setup(), the ssip_pn_xmit() function
within the ssip_pn_ops structure is capable of starting the
work.

If we remove the module which will call ssi_protocol_remove()
to make a cleanup, it will free ssi through kfree(ssi),
while the work mentioned above will be used. The sequence
of operations that may lead to a UAF bug is as follows:

CPU0                                    CPU1

                        | ssip_xmit_work
ssi_protocol_remove     |
kfree(ssi);             |
                        | struct hsi_client *cl = ssi->cl;
                        | // use ssi

Fix it by ensuring that the work is canceled before proceeding
with the cleanup in ssi_protocol_remove().

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240918120749.1730-1-kxwang23@m.fudan.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hsi/clients/ssi_protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index afe470f3661c7..6105ea9a6c6aa 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -401,6 +401,7 @@ static void ssip_reset(struct hsi_client *cl)
 	del_timer(&ssi->rx_wd);
 	del_timer(&ssi->tx_wd);
 	del_timer(&ssi->keep_alive);
+	cancel_work_sync(&ssi->work);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
 	ssi->recv_state = 0;
-- 
2.39.5


