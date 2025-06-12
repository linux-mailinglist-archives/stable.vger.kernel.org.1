Return-Path: <stable+bounces-152520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1287AAD658C
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FE1189C2D2
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314071EBA0D;
	Thu, 12 Jun 2025 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKF7JzuM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DC1E47AE
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694976; cv=none; b=uaHjXJM0NSqBD2/Lcurw1mKS8Sx0AhatTOib4ZZ/ykldRXNeurclUhkLtSQRgm15RjOtYUx9Uk4TlsEV4oUTU5/f+G/55dZUnu3Qd6G7Sjp7BiQEswvvrMdjaoV5m7wDSZChQ+K4B+4YDzZJEMF1ChiKIrR+RNyLTsjUzQ9qrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694976; c=relaxed/simple;
	bh=O039DW4WGGXTlkTgbyEvYtv8OnQAZMX1nhwdqJNbYU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZUSLpxkv9tPkM9m7C1T8BaQfQNraLp+Ay8y3rOxvSJkCNychMeOg/HNidyrSRTH4OJtfIotdWU6CYXTQYopALzPZHtZZmLxQvCxh2Lm35wML1XKGDn5PWpGZfNnsh+CC5ihvX6Q5CzFGuaLHB4QanCrSXtdvPDjsGZTOezYqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKF7JzuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B132C4CEE3;
	Thu, 12 Jun 2025 02:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694975;
	bh=O039DW4WGGXTlkTgbyEvYtv8OnQAZMX1nhwdqJNbYU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKF7JzuMfwQWRzRggYhgAy7w5pwKZNA5Hae0u/T5ZcFwMY5FnhlBoIHho3NB/+etB
	 MJt+1Tjk3OaXV8RJRx0mo+bw05aUTc0Arb+1afQfC8hpxNfwmNs0lHHcOyuNZN378J
	 mVzg3mLAIVTtMQ7CYqRmHn2q+AHYHLWa1a7pc7csx642bOJc7JMJiJGDpHVZ/8cFDk
	 kttXZDz660B1cVHqze36D4C11moKRgmld6GRtA/AOLxxRb4r8u381lQpD4Y4bpMIZk
	 iB2sLqAKWwgtTy+phngLz39hJp9V+/qtLGrZrYCxoJN8UVQVNsscMvbO81fGVmyCr+
	 U8qhVpKfSLt1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/4] serial: sh-sci: Check if TX data was written to device in .tx_empty()
Date: Wed, 11 Jun 2025 22:22:54 -0400
Message-Id: <20250611111849-125190ad0bc78885@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050131.471315-2-claudiu.beznea.uj@bp.renesas.com>
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

Note: The patch differs from the upstream commit:
---
1:  7cc0e0a43a910 ! 1:  0cf02d41640cb serial: sh-sci: Check if TX data was written to device in .tx_empty()
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
| stable/linux-5.15.y       |  Success    |  Success   |

