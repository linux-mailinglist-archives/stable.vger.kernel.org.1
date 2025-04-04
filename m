Return-Path: <stable+bounces-128256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9D7A7B3FC
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B637A52A9
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B216E2080F3;
	Fri,  4 Apr 2025 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/mr05iW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBDE2080E4;
	Fri,  4 Apr 2025 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725258; cv=none; b=hjaO5CHa2uaJS3KpVm8RM6Z1Jp9G7XkRii+FbxtW8/rOk2yjhWH1b2sO7SChVknPPkkwqPLjrbQqM2XBLdTP02F5QT0nf+IXOEJrvlMCTSgk17xC9OEGnNar1QMF8VQwmQ+8xDtlquI3Dy+tM/RbwNaKW+6cwDdMSlZ7HvVyiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725258; c=relaxed/simple;
	bh=xLyzOR5hGmlEjjKhed6HMgHMahwf9hr0eTGU0vzuFNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJ945ZH28ElIo5WqVMnMtznSB8UPBgaXBATuBKQQyOCkxWimkRux9ic4ZKlwOuXw2E33RfDVfVheJwbLMH0Y3jqp9xqXs8jsbIQycxwsamSlnnx6DM86reV1Mt8lM41vL6rumYfTzVVfI5xbK+MTlx7q4v2G+6EooCKOpr/vB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/mr05iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0441CC4CEE3;
	Fri,  4 Apr 2025 00:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725257;
	bh=xLyzOR5hGmlEjjKhed6HMgHMahwf9hr0eTGU0vzuFNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/mr05iWWEKuS4Iu8elhPfXHHgRhdSZNkmy1QvRP9t+ZUfywlZthiT0YrqXskQ27y
	 4KULbH6REP3wJQ4TqGYgvoIr6uMPHJVklp8DSLgF4wugtF/7V73MV0nlMfJyuOkoW1
	 wEzhFWfp10CSCzGNmW8Y3XdZIDRJIG8GqfUlBbzqE+WESAHdVb0rKmw7iit85hTO7P
	 8iMcXaAqToq13r2VpInaMc04YIU2BT4DGQ6DHOMGv0CpSFfiTGqSyYqnNB4Rt4D600
	 aPwUFtN5mdGv990t73HRTO/rEiar5o4URiB+JQmkNh7lxPI3blZ0ZJbLozN3FokMwQ
	 YX+YLWt9z3K+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org
Subject: [PATCH AUTOSEL 5.15 3/8] HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition
Date: Thu,  3 Apr 2025 20:07:21 -0400
Message-Id: <20250404000728.2689305-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000728.2689305-1-sashal@kernel.org>
References: <20250404000728.2689305-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 96d0eccca3aa7..8f7c4fd100d62 100644
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


