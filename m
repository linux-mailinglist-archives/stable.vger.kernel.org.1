Return-Path: <stable+bounces-2046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2BA7F8288
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CFD285735
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E9B37170;
	Fri, 24 Nov 2023 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YYJ7kmrs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F135F04;
	Fri, 24 Nov 2023 19:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267C4C433C8;
	Fri, 24 Nov 2023 19:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852915;
	bh=r7x3sHBz02FHR8lv5Oouxt9c1WSLoV/JCFVOruCvIas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYJ7kmrsorsr+iYJM7obgBOghtJPKwBfqG8TLU4NbnuX09UD32n07HMI7hfJz0k3u
	 cpl6hFZ5Jd03chMqNkaNQLdLWzN2hKYRZuI0EPHNkqtmk9Uwv9Zc1SoKpsOHCRY/Yn
	 E8TNoTAKM2GOb0VaJTGjUl2IilC9IkaDs+4cBkLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Colin Ian King <colin.king@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 148/193] serial: meson: remove redundant initialization of variable id
Date: Fri, 24 Nov 2023 17:54:35 +0000
Message-ID: <20231124171953.120844563@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 021212f5335229ed12e3d31f9b7d30bd3bb66f7d ]

The variable id being initialized with a value that is never read
and it is being updated later with a new value. The initialization is
redundant and can be removed. Since id is just being used in a for-loop
inside a local scope, move the declaration of id to that scope.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Addresses-Coverity: ("Unused value")
Link: https://lore.kernel.org/r/20210426101106.9122-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 2a1d728f20ed ("tty: serial: meson: fix hard LOCKUP on crtscts mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/meson_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 91b7359b79a2f..d06653493f0ef 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -729,12 +729,13 @@ static int meson_uart_probe(struct platform_device *pdev)
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
 	int ret = 0;
-	int id = -1;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
 
 	if (pdev->id < 0) {
+		int id;
+
 		for (id = AML_UART_PORT_OFFSET; id < AML_UART_PORT_NUM; id++) {
 			if (!meson_ports[id]) {
 				pdev->id = id;
-- 
2.42.0




