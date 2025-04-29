Return-Path: <stable+bounces-137738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BADAAA14BA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB70D173522
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BB125335B;
	Tue, 29 Apr 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DYIEwWbG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58424E016;
	Tue, 29 Apr 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946979; cv=none; b=mKswlGT12oBWKiNYA/G8reweom0c7gA74wLx03rFyfeugDRjxYLtahVEZ2WCBBe0Crp7Fq0KrsmOTIENBU1vAQ7PXDwRktDisPbpN6YK6uR4t8qi08OpUT48AFER0Ohyf6H4EkF+ZpFAAJ9e/YR1Wugc5br7mjyBz7eaSXX76YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946979; c=relaxed/simple;
	bh=4EvJ1L4HPkrsILKfwcWPTTirHWID7SCM1M8wxwyAviU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzvkqXz21aRaFKobLb+L3yzzzJbpfQn/J0B1llCjhynxycKZOkdKu6soEBOoECR+ZX5wVKZXdDP103qakbp2sUdWsluKrzWfaPpe/PHZorgQoV7ihKeZGSpe2saBMnynKXgIr0LM1x9PG4tdURpBeijxM5rUxnFObPQgYe0OSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DYIEwWbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BCEC4CEE3;
	Tue, 29 Apr 2025 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946979;
	bh=4EvJ1L4HPkrsILKfwcWPTTirHWID7SCM1M8wxwyAviU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYIEwWbGlK2Z9H41tP1WLvCZH6HGwCwUiqpHWkd2oJ+h6/pss6jHztoS66cpCBtAV
	 rmPeCw2LKj0OJ9GT4WIe74XyR23slrxUoqD2QyKBWOTRtyavpZWNsvFxow+f+p0U+7
	 lbekuqzVIMjnhLG1rfNhQWLjtaO+ZVHofbKwmX9M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.10 101/286] HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition
Date: Tue, 29 Apr 2025 18:40:05 +0200
Message-ID: <20250429161112.012123544@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kaixin Wang <kxwang23@m.fudan.edu.cn>

commit e3f88665a78045fe35c7669d2926b8d97b892c11 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hsi/clients/ssi_protocol.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -403,6 +403,7 @@ static void ssip_reset(struct hsi_client
 	del_timer(&ssi->rx_wd);
 	del_timer(&ssi->tx_wd);
 	del_timer(&ssi->keep_alive);
+	cancel_work_sync(&ssi->work);
 	ssi->main_state = 0;
 	ssi->send_state = 0;
 	ssi->recv_state = 0;



