Return-Path: <stable+bounces-156726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF6DAE50DB
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785841B62DFC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643171F4628;
	Mon, 23 Jun 2025 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hDEfU1EM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E01E5B71;
	Mon, 23 Jun 2025 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714116; cv=none; b=IPc0uNjv/dZCQbYwmyMRyWWR0VbUyrb9n37ur6cpt2O/RoNPGNB8yZAqkeuwtLS1XDKxOlNAXmm8kKiZLCDXx9wwVrpkgtwEQ0cTsLM2QjqtKLicp4BJBpfy+yO6V/lCPCdXEVZB4aKMikRjzR4vx/gwtkC/LPAEDZ4b2iyYwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714116; c=relaxed/simple;
	bh=MLPa6WBThknhFY0KRIEgnUTYjRs/CIu1KOimUgSCLvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSdx/Aa3Vd0WwOXaiCAAwdDK+/skCQfuMC6grzf5XGNMj30wVLm93ZCnmSr/QlVJvCOzpq4LbHhF5j1/pjpiKf6Hf1TtA1o6qMqrt+RzfIXq+FkhhhgrMusNgcGjAVPb/NuOAUZVlxpNd4K3UGkJCUdsFjII+9JRJ0Y3hboFX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hDEfU1EM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2E1C4CEEA;
	Mon, 23 Jun 2025 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714116;
	bh=MLPa6WBThknhFY0KRIEgnUTYjRs/CIu1KOimUgSCLvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDEfU1EMcd5oaiuxyZAUciJjC1LaCrlw98yex0oITD2RnCs7ewKDbG+tFtVvrL7ue
	 fEsEcaxX7CtdBbhervbZ+PbUnkiiNck4g4YSb7ybhAoWz6ByVhILamaKJSjqE3bfDK
	 usX7ElKftiH+eP1oGf06vTHZNAMa6DK3bd0mWNpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 103/414] NFC: nci: uart: Set tty->disc_data only in success path
Date: Mon, 23 Jun 2025 15:04:00 +0200
Message-ID: <20250623130644.677799536@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit fc27ab48904ceb7e4792f0c400f1ef175edf16fe upstream.

Setting tty->disc_data before opening the NCI device means we need to
clean it up on error paths.  This also opens some short window if device
starts sending data, even before NCIUARTSETDRIVER IOCTL succeeded
(broken hardware?).  Close the window by exposing tty->disc_data only on
the success path, when opening of the NCI device and try_module_get()
succeeds.

The code differs in error path in one aspect: tty->disc_data won't be
ever assigned thus NULL-ified.  This however should not be relevant
difference, because of "tty->disc_data=NULL" in nci_uart_tty_open().

Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Fixes: 9961127d4bce ("NFC: nci: add generic uart support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20250618073649.25049-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/nci/uart.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -119,22 +119,22 @@ static int nci_uart_set_driver(struct tt
 
 	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));
 	nu->tty = tty;
-	tty->disc_data = nu;
 	skb_queue_head_init(&nu->tx_q);
 	INIT_WORK(&nu->write_work, nci_uart_write_work);
 	spin_lock_init(&nu->rx_lock);
 
 	ret = nu->ops.open(nu);
 	if (ret) {
-		tty->disc_data = NULL;
 		kfree(nu);
+		return ret;
 	} else if (!try_module_get(nu->owner)) {
 		nu->ops.close(nu);
-		tty->disc_data = NULL;
 		kfree(nu);
 		return -ENOENT;
 	}
-	return ret;
+	tty->disc_data = nu;
+
+	return 0;
 }
 
 /* ------ LDISC part ------ */



