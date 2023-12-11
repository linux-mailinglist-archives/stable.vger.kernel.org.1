Return-Path: <stable+bounces-5997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8779180D83B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B531C215DC
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F188651036;
	Mon, 11 Dec 2023 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rRYISPAN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47EFC06;
	Mon, 11 Dec 2023 18:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35E7C433C7;
	Mon, 11 Dec 2023 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320234;
	bh=xkViQvrCntSMLyQKpVQGfI4LE7qKyXoM0A2gynSyUKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRYISPANZGvp4tWXr/bkQjiOUfLGlsaaIxaghsUgh/dzcyvCX2v9Sm3rQQLrifxM1
	 rywbaLg1DfUc0MUw+MF3y9pC5MG2JmTw84SsbZ+zeptsfmUt9VcGUG2/djR+DBYx2S
	 TiYtgM8CBdCnlHQ227DEq3dtcBPfPd+uqxVfv8sY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.4 53/67] serial: 8250_omap: Add earlycon support for the AM654 UART controller
Date: Mon, 11 Dec 2023 19:22:37 +0100
Message-ID: <20231211182017.259349333@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronald Wahl <ronald.wahl@raritan.com>

commit 8e42c301ce64e0dcca547626eb486877d502d336 upstream.

Currently there is no support for earlycon on the AM654 UART
controller. This commit adds it.

Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Link: https://lore.kernel.org/r/20231031131242.15516-1-rwahl@gmx.de
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_early.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -176,6 +176,7 @@ static int __init early_omap8250_setup(s
 OF_EARLYCON_DECLARE(omap8250, "ti,omap2-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
+OF_EARLYCON_DECLARE(omap8250, "ti,am654-uart", early_omap8250_setup);
 
 #endif
 



