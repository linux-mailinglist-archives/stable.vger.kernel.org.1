Return-Path: <stable+bounces-152505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D84BAD6587
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4801BC3CFC
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749CF1C860E;
	Thu, 12 Jun 2025 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svZGvMZM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D691C84BA
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694947; cv=none; b=pufJh3dyM1MnAVZqf2s9nMJ2aGUZGviSMAl8U7V/AQAb5wzxLMGGfrUBXRH9EdKNA3cyYRJCyO/+fi4+5NYCbr7EGT49/8PSOVCxubD873iMH5PjXxjgarsOwzzwfjW4s4j07TkcDd49cMizYqx5VrHrrVOCPOlN9e4GiGaEnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694947; c=relaxed/simple;
	bh=ngEriYARCC9zcoXz/c+LU8Ls5+op73s2As9SsHMbvr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g171JPESZXL4RnhITkZ8HxbetXaczw6PmDtuPTr9JEiLixU4gFUQgX2kg0BJ0dPk1kj5fXw5/3DlcenYywmzPlf7Zh/Oh/LrOocm7N7+JG7o22FOUswDqzFnClYKJlHZyQJTbxaQ1cRugC0v6LWQRTd4ey1AG7RyPdORFj8xTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svZGvMZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DECC4CEE3;
	Thu, 12 Jun 2025 02:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694946;
	bh=ngEriYARCC9zcoXz/c+LU8Ls5+op73s2As9SsHMbvr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=svZGvMZMGTn/Eri60ogY1HuZa459kUpJoMRlqZIEmYTE5xZsp/AQXM/0VxlUfWVy3
	 tQsZ7/pCNCwueZQYI0bmuk85KKV6Of6YRZQK/he0jnyFDZSMbMbrk977IJ4S/uz1ET
	 vVcq5D3EbfBEOawHE+Y6LdL/v3LLDx3oLWkb5C902TvAnu1ioOOg7H98Cm7Oc7g1/d
	 Lii3JQ/UeHP7+ObzybKxzvgJEEqM7ytoAX/3NtN2T6miRzpeLlPtlJfoOIsTT8/Hc2
	 fsP6Pbz3xrPGVTJwyR7wbWJs0XEshHmyHYTXx/K8lxhM7Y7Wfv4hfUUkTYphC3gr1n
	 OmcUj1UfhoTuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/4] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed, 11 Jun 2025 22:22:25 -0400
Message-Id: <20250611100338-327a61e603d1d1e1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050552.597806-2-claudiu.beznea.uj@bp.renesas.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 7cc0e0a43a91052477c2921f924a37d9c3891f0c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Claudiu<claudiu.beznea@tuxon.dev>
Commit author: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 7415bc5198ef)

Note: The patch differs from the upstream commit:
---
1:  7cc0e0a43a910 ! 1:  7703151faa0b0 serial: sh-sci: Check if TX data was written to device in .tx_empty()
    @@ Metadata
      ## Commit message ##
         serial: sh-sci: Check if TX data was written to device in .tx_empty()
     
    +    commit 7cc0e0a43a91052477c2921f924a37d9c3891f0c upstream.
    +
         On the Renesas RZ/G3S, when doing suspend to RAM, the uart_suspend_port()
         is called. The uart_suspend_port() calls 3 times the
         struct uart_port::ops::tx_empty() before shutting down the port.
    @@ Commit message
         Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
         Link: https://lore.kernel.org/r/20241125115856.513642-1-claudiu.beznea.uj@bp.renesas.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [claudiu.beznea: fixed conflict by:
    +     - keeping serial_port_out() instead of sci_port_out() in
    +       sci_transmit_chars()
    +     - keeping !uart_circ_empty(xmit) condition in sci_dma_tx_complete(),
    +       after s->tx_occurred = true; assignement]
    +    Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
     
      ## drivers/tty/serial/sh-sci.c ##
     @@ drivers/tty/serial/sh-sci.c: struct sci_port {
    @@ drivers/tty/serial/sh-sci.c: struct sci_port {
      #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
     @@ drivers/tty/serial/sh-sci.c: static void sci_transmit_chars(struct uart_port *port)
      {
    - 	struct tty_port *tport = &port->state->port;
    + 	struct circ_buf *xmit = &port->state->xmit;
      	unsigned int stopped = uart_tx_stopped(port);
     +	struct sci_port *s = to_sci_port(port);
      	unsigned short status;
    @@ drivers/tty/serial/sh-sci.c: static void sci_transmit_chars(struct uart_port *po
     @@ drivers/tty/serial/sh-sci.c: static void sci_transmit_chars(struct uart_port *port)
      		}
      
    - 		sci_serial_out(port, SCxTDR, c);
    + 		serial_port_out(port, SCxTDR, c);
     +		s->tx_occurred = true;
      
      		port->icount.tx++;
      	} while (--count > 0);
     @@ drivers/tty/serial/sh-sci.c: static void sci_dma_tx_complete(void *arg)
    - 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
    + 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
      		uart_write_wakeup(port);
      
     +	s->tx_occurred = true;
     +
    - 	if (!kfifo_is_empty(&tport->xmit_fifo)) {
    + 	if (!uart_circ_empty(xmit)) {
      		s->cookie_tx = 0;
      		schedule_work(&s->work_tx);
     @@ drivers/tty/serial/sh-sci.c: static void sci_flush_buffer(struct uart_port *port)
    @@ drivers/tty/serial/sh-sci.c: static inline void sci_free_dma(struct uart_port *p
      
     @@ drivers/tty/serial/sh-sci.c: static unsigned int sci_tx_empty(struct uart_port *port)
      {
    - 	unsigned short status = sci_serial_in(port, SCxSR);
    + 	unsigned short status = serial_port_in(port, SCxSR);
      	unsigned short in_tx_fifo = sci_txfill(port);
     +	struct sci_port *s = to_sci_port(port);
     +
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

