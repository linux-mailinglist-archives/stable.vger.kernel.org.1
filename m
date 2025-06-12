Return-Path: <stable+bounces-152507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF5FAD658E
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E5C2C14E9
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A66D1DED60;
	Thu, 12 Jun 2025 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0o1anfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693C63A9
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694951; cv=none; b=n6k53Wd/Hg8j+hzn+bqBX84Zx4+LK5ab+VMUhQwHkdos+2nzrIV/JY0kOzTVsu0bDO8dIx8CAztQn13RIFQCikT+GI6bzpAsHDZ8nS+QtdwG/F9PiKE+2OIOIuv/ATiFob+gO7ISpQHTUtCe0DK+pPC65p4kSASsJ4djTULdE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694951; c=relaxed/simple;
	bh=0leocndwJsHymKtiT9TmPkwTt5E3bR6yRNs9D4IuNdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEaaEMtfDwTrcqNLSpq9omU3rwymyMVKq1Oi5xSQRJ2OGZDIlYZbiqkjyIKNw6DLF9MpPXKtMCfR5Rtez5ClB6JIQhkvV6lkxjmmVws5M4bHvS2s5cfMMG5DIAXd9Zb3iOrho49CJOabBi1rLH+VHOgqScE5lzByB4h5aik8gXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0o1anfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E33C4CEE3;
	Thu, 12 Jun 2025 02:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694950;
	bh=0leocndwJsHymKtiT9TmPkwTt5E3bR6yRNs9D4IuNdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0o1anfbarLRPkxjD7uY28+YOpp+TZCqDdfnEQlEGRHzPmdL9Csm8avTPQdUvmUxs
	 9G46vLgRWDNx5CFdnfwAgss1dukGwk1+Te8pfKrYp7EgBFnN0aqAYvWdh3iHuF5fLC
	 Zkh35sMCza/U45R1WHxJUfRRbaELd5ytXONZYz9g6xsmV/9o66lTq7HIGOXddzw0ws
	 8SXNqHvJz4pPA1CmtoQ4z+aPCfELYme0+1qsyo1sDVU/Hzi75gfGWS2pDhMJKmkdO+
	 QaQWUNc5niaGhYOAQ4Qp4tYqDeWYiyjIQtnP7d0fs6F63lELQ4koKV6JMJ5kcpBcXF
	 xJHiPezOZz2mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 5.10.y 1/4] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed, 11 Jun 2025 22:22:28 -0400
Message-Id: <20250611105638-8972ca201301d288@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050053.454338-2-claudiu.beznea.uj@bp.renesas.com>
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
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7cc0e0a43a910 ! 1:  f2903cbeb0b7c serial: sh-sci: Check if TX data was written to device in .tx_empty()
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
| stable/linux-5.10.y       |  Success    |  Success   |

