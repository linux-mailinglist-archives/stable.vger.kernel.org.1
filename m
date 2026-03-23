Return-Path: <stable+bounces-228042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJuQOPhHwWlGSAQAu9opvQ
	(envelope-from <stable+bounces-228042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:02:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6429B2F3AF3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFEC2305DD39
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546CB3AE1AD;
	Mon, 23 Mar 2026 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k5lUBUiW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAB3AD527;
	Mon, 23 Mar 2026 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273952; cv=none; b=lgevun+Y+ud1DYl+gHst0Yswb7WEKOEregsOJke1X5Z7W6tkGgFNcn1C9gsnE56OZsof+PmzwuM+QIPulMLTRv8+BH+fkVpi//3elFeA6Ivem3RSE1hvPbxkW9qiEq12yIPgja2psxOXDE73HbnZDPOevL0sCyAgt4etmeaef4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273952; c=relaxed/simple;
	bh=61grHwQ/vLnx4N/BrpNwyK2y+GikjA6u40rue9ZUaUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iabsTIR6uKf+ZPGFF79NzUPFl96RFkBPewrZzgynaNXF+KpygesoZZQBWRLZd2nMiu+x21hwb07Py4YrT6RkKalDk/JvepGkE2lhS1cEsob40l8pF/UROUURkpLhydV8sGL7dA8+tc2+lj54fsEtE0Puj135c1HJGhdasBCzsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k5lUBUiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8732DC4CEF7;
	Mon, 23 Mar 2026 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774273951;
	bh=61grHwQ/vLnx4N/BrpNwyK2y+GikjA6u40rue9ZUaUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5lUBUiWi3bPZ9Gf/5aqWDvf8vL/zNJ34G6zWiE+vfL/0PGQnvvUsyOWtiFnO4KIM
	 zBV+c3LGbaR0BD6OVDYC+7MngubYg/mZJ07lGoxp1My5xMw9mDWbAnsCmH7tL1DYF8
	 gSQLQXenC1CewHR3jFBCQptAN1f3QnCLGiyO729A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Raul E Rangel <rrangel@google.com>
Subject: [PATCH 6.19 060/220] serial: 8250: Fix TX deadlock when using DMA
Date: Mon, 23 Mar 2026 14:43:57 +0100
Message-ID: <20260323134506.486952925@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228042-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6429B2F3AF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raul E Rangel <rrangel@chromium.org>

commit a424a34b8faddf97b5af41689087e7a230f79ba7 upstream.

`dmaengine_terminate_async` does not guarantee that the
`__dma_tx_complete` callback will run. The callback is currently the
only place where `dma->tx_running` gets cleared. If the transaction is
canceled and the callback never runs, then `dma->tx_running` will never
get cleared and we will never schedule new TX DMA transactions again.

This change makes it so we clear `dma->tx_running` after we terminate
the DMA transaction. This is "safe" because `serial8250_tx_dma_flush`
is holding the UART port lock. The first thing the callback does is also
grab the UART port lock, so access to `dma->tx_running` is serialized.

Fixes: 9e512eaaf8f4 ("serial: 8250: Fix fifo underflow on flush")
Cc: stable <stable@kernel.org>
Signed-off-by: Raul E Rangel <rrangel@google.com>
Link: https://patch.msgid.link/20260209135815.1.I16366ecb0f62f3c96fe3dd5763fcf6f3c2b4d8cd@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_dma.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -162,7 +162,22 @@ void serial8250_tx_dma_flush(struct uart
 	 */
 	dma->tx_size = 0;
 
+	/*
+	 * We can't use `dmaengine_terminate_sync` because `uart_flush_buffer` is
+	 * holding the uart port spinlock.
+	 */
 	dmaengine_terminate_async(dma->txchan);
+
+	/*
+	 * The callback might or might not run. If it doesn't run, we need to ensure
+	 * that `tx_running` is cleared so that we can schedule new transactions.
+	 * If it does run, then the zombie callback will clear `tx_running` again
+	 * and perform a no-op since `tx_size` was cleared above.
+	 *
+	 * In either case, we ASSUME the DMA transaction will terminate before we
+	 * issue a new `serial8250_tx_dma`.
+	 */
+	dma->tx_running = 0;
 }
 
 int serial8250_rx_dma(struct uart_8250_port *p)



