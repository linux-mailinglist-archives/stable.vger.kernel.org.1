Return-Path: <stable+bounces-128270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC85A7B429
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69D57A8714
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278621C9E3;
	Fri,  4 Apr 2025 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnEjRs5M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91221C188;
	Fri,  4 Apr 2025 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725298; cv=none; b=EXlxc4f4FFa3TnZ+EjAnsZKSFAE7kkZo+8szO7yxyxnYhhbGPmkZElxc71AmhCCNqy8DjElJDuTlUKWuqGhMh46gFz2uGI2/JfUGzQovomzbYGSwHRq3uu+KMkXL9BNwyWuGEMaoMaEzYdj8UujSZvgLwnFe+d5hkIrZeZKm9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725298; c=relaxed/simple;
	bh=Jw2vNYlpCXcAjx4h9+VdViP6otNJSnyGM8rTn0+NN38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6UGViukAiMBWmoNgNsV+PXfLsFFWcA0eeN0lrrDtkvPYQR0XdRlWKKC+SqqLi2l2rltp/hrQXBlhBvr4/6i7q/SL3963NYRCTX0Iv3g/zcbIeNmtkJ3gzvZ5J0mtfuXy8Wa6iEe049qqRxDJxkm7lBg0Awv6eOnw6rzRDKQ9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnEjRs5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00ADC4CEE5;
	Fri,  4 Apr 2025 00:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725298;
	bh=Jw2vNYlpCXcAjx4h9+VdViP6otNJSnyGM8rTn0+NN38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnEjRs5MIVFqJgkuFGIvEQ0cYm1XdlXWJfaD7MtcAYW37hZSXTOqoBbKCQYYNCxfu
	 qA28UnOnhHWe+LCdZH2tSnS02GN+uyWlJIIL0bhY6t2/2jIwBqEJZX7mM4v/9VKmvb
	 3iFMH9zii48vAh6o9+d3Lkbol8xzYO2cITnaq9yNsff6xV/VmyLfDA/VdkOeFWIiPf
	 D8P+Q8SvFstqGATfaif7gophqkVaizn15USkQkng+mStQtRIa6AO+jLa+R9j4JjKqs
	 yFemBUyRFgDMYfFcr60IltnV2WHBoPhPrYPhBV2MPpEXT3iluHnwNXQvYk70tOK6+v
	 HJTXuLuNxdt3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org
Subject: [PATCH AUTOSEL 5.4 3/6] HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition
Date: Thu,  3 Apr 2025 20:08:04 -0400
Message-Id: <20250404000809.2689525-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000809.2689525-1-sashal@kernel.org>
References: <20250404000809.2689525-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 365b5d5967acc..5c139d7851729 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -403,6 +403,7 @@ static void ssip_reset(struct hsi_client *cl)
 	del_timer(&ssi->rx_wd);
 	del_timer(&ssi->tx_wd);
 	del_timer(&ssi->keep_alive);
+	cancel_work_sync(&ssi->work);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
 	ssi->recv_state = 0;
-- 
2.39.5


