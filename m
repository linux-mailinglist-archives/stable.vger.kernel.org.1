Return-Path: <stable+bounces-220469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEtJNmY4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D291C6456
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1F5530E98FD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768123BFD81;
	Sat, 28 Feb 2026 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHQdV5mE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975B3BED2A;
	Sat, 28 Feb 2026 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300356; cv=none; b=i/wNPFIw4/gk4ePfixeQ6Z3GuNke44ON5XDU/XSFb94IDYMbykuwxzltrlvpjRMcJyE0xt3aStmanNBrEahxANP8p2oDVSyx4tpHgIq/tzyCKzd3llySMz5LYEQJr2UxuYqKjjjV1Y12OZsk1Sg8+l4ZbPPTDPkHlIBttOAR1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300356; c=relaxed/simple;
	bh=cMDqkK33dyeBBPrf5Ta6K24p+p4t+4mm1cDDdK4KIqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsSR3jFCaLQrxitpKKuuDX39abW48vrKw6dp+JKveTu5sUyqBLzF6uUz3hYz+k6GKaVwEYj4+eNeKiZgsEtgG0VLeJSmqKq8EuKA9Je0LA8vsS78CWNcr8MYoiMMuIE3husLmLxPNMYO5F9FANq4xGgPkDltERlqRjSxDtB4H7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHQdV5mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8056BC19424;
	Sat, 28 Feb 2026 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300356;
	bh=cMDqkK33dyeBBPrf5Ta6K24p+p4t+4mm1cDDdK4KIqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHQdV5mEzf2jYKzD2lnV0cGhB5YVc64ApO3DLMKN0Ej1BjAjpb8pRJl+HLkihiCdS
	 tInKi972pdpGRmhvG32UW+tXxxv9cvtSVFL12UDe68uTpjwucAlccQ15ina9dCoQ1j
	 XW8+B3ltj3ZFgnaH58BpOmrG71hwPH5yFruNA7C/l0g1puafcoCZPSu/wT1SFkMf+L
	 V/j/T5e6232zAwHdaszHjK1P+5HsUmVpFJJsnmXUpk0MtgAfMsPz+1yGTjOAkTTy/Q
	 3EaExUysZQpEYlFTzOD4idlULmXtonXfEeQ6kQgQ6upXhsefFOyJVfhBq4s9XQ3/HI
	 3XFPq81lOodTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Moteen Shah <m-shah@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 390/844] serial: 8250: 8250_omap.c: Clear DMA RX running status only after DMA termination is done
Date: Sat, 28 Feb 2026 12:25:03 -0500
Message-ID: <20260228173244.1509663-391-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220469-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 69D291C6456
X-Rspamd-Action: no action

From: Moteen Shah <m-shah@ti.com>

[ Upstream commit a5fd8945a478ff9be14812693891d7c9b4185a50 ]

Clear rx_running flag only after DMA teardown polling completes. In the
previous implementation the flag was being cleared while hardware teardown
was still in progress, creating a mismatch between software state
(flag = 0, "ready") and hardware state (still terminating).

Signed-off-by: Moteen Shah <m-shah@ti.com>
Link: https://patch.msgid.link/20260112081829.63049-3-m-shah@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index e26bae0a6488f..272bc07c9a6b5 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -931,7 +931,6 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 		goto out;
 
 	cookie = dma->rx_cookie;
-	dma->rx_running = 0;
 
 	/* Re-enable RX FIFO interrupt now that transfer is complete */
 	if (priv->habit & UART_HAS_RHR_IT_DIS) {
@@ -965,6 +964,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 		goto out;
 	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
 
+	dma->rx_running = 0;
 	p->port.icount.rx += ret;
 	p->port.icount.buf_overrun += count - ret;
 out:
-- 
2.51.0


