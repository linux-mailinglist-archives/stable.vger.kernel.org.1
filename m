Return-Path: <stable+bounces-5534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5D80D542
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A2B1C21449
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85975102E;
	Mon, 11 Dec 2023 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AqW+BEF+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0524F213;
	Mon, 11 Dec 2023 18:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A0BC433C9;
	Mon, 11 Dec 2023 18:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702318921;
	bh=TScLGhxLqQ1B+unqo42uXwXMBjeBy1ozoq0HOT8VOYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqW+BEF+gWCLI0qeICDqXgvs4An4aCUNz3UpFk6RqILUF6ygnEt0+qL2fURVJ1y/i
	 KYCMQ+fNA2J29E2w9wQYxpkprPagbQICxC334GQIxHzWRR9vMqMz7PufF1q+wp62HM
	 ESYIfQAYGebeLF1hUHQYsHIwOzmzHuaE8S+UX/KU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	stable <stable@kernel.org>
Subject: [PATCH 4.14 19/25] serial: 8250_omap: Add earlycon support for the AM654 UART controller
Date: Mon, 11 Dec 2023 19:21:10 +0100
Message-ID: <20231211182009.396825544@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182008.665944227@linuxfoundation.org>
References: <20231211182008.665944227@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -179,6 +179,7 @@ static int __init early_omap8250_setup(s
 OF_EARLYCON_DECLARE(omap8250, "ti,omap2-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
+OF_EARLYCON_DECLARE(omap8250, "ti,am654-uart", early_omap8250_setup);
 
 #endif
 



