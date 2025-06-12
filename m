Return-Path: <stable+bounces-152522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD586AD659E
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D453ADABE
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8BE1EC01D;
	Thu, 12 Jun 2025 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJXvXcFq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D15D1EA7E4
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694980; cv=none; b=awcC2od/l2LBZn1UXTo9EpvEOXVLsSuvB9igwnkjrnXpi6y5BrotODOgotq5ONWvwaQym9vn6GNeF7Z1wnmtsWcUYmXwwbhb7VZo7OU0/9IYqBAEESjh9LvFyEkJ17viaO1JRl/Rx1a3yCkAA9jaG+USJa9de5EQnnLx/8QaCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694980; c=relaxed/simple;
	bh=jJMf8xnHuI5kPMMmRUEdSqHPrsYAOhp0Ln0EBJTnH+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw8bl8e7pOH01PqGaOB7Sv9rRFpZb2N7DC/Yd8RtmcEe+Bedyi3OWssp3UDmgHMp+iAmoU1srtIRh9apeihah+aGZEiXwCrSzalVaqfyAQO1LyZnDmNeNYhy8tKgipChfxepqRv1uQ46SIhm07F85wZc6yXcFNSeNTw85KTcn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJXvXcFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC98C4CEE3;
	Thu, 12 Jun 2025 02:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694979;
	bh=jJMf8xnHuI5kPMMmRUEdSqHPrsYAOhp0Ln0EBJTnH+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJXvXcFqRsrQnvLxsUF126hcNiD7Xzxu6ukTvcPCUuA+eZHhaLJIh6mv6i2foNxZd
	 m4itsQIixE5+Eyhk/RxM3m7/SWMWvgoV6xUSOcqi1MlF/VWTl4+Oqnye+zfie8vWlg
	 4J25YBAS5uXOHmpyaD+9ewcanKjXWyBW/6ohnI+k/paw13aA1/zmpYDeJ3+CK/X2GN
	 PlyqLN8A4Mo7Q03zDyS7UyrvnN5atgvmY7TDZsbi+Le5sZeaItmYxbFsMFhAsH7hlF
	 eTjxYdYHpbutR5K5RR4sR9vegLguerRoo7T7nHEYvvUASeqlCLiY1r+mVf5VTJnuMl
	 02sDl9tOX+CcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 5.10.y 2/4] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 11 Jun 2025 22:22:58 -0400
Message-Id: <20250611110143-8988edd8af3ebc24@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050053.454338-3-claudiu.beznea.uj@bp.renesas.com>
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

The upstream commit SHA1 provided is correct: 239f11209e5f282e16f5241b99256e25dd0614b6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Claudiu<claudiu.beznea@tuxon.dev>
Commit author: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  239f11209e5f2 ! 1:  42e2ae38d46d3 serial: sh-sci: Move runtime PM enable to sci_probe_single()
    @@ Metadata
      ## Commit message ##
         serial: sh-sci: Move runtime PM enable to sci_probe_single()
     
    +    commit 239f11209e5f282e16f5241b99256e25dd0614b6 upstream.
    +
         Relocate the runtime PM enable operation to sci_probe_single(). This change
         prepares the codebase for upcoming fixes.
     
    @@ Commit message
         Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
         Link: https://lore.kernel.org/r/20250116182249.3828577-3-claudiu.beznea.uj@bp.renesas.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
     
      ## drivers/tty/serial/sh-sci.c ##
     @@ drivers/tty/serial/sh-sci.c: static int sci_init_single(struct platform_device *dev,
    @@ drivers/tty/serial/sh-sci.c: static int sci_init_single(struct platform_device *
     -
      #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
          defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
    - static void serial_console_putchar(struct uart_port *port, unsigned char ch)
    -@@ drivers/tty/serial/sh-sci.c: static void sci_remove(struct platform_device *dev)
    + static void serial_console_putchar(struct uart_port *port, int ch)
    +@@ drivers/tty/serial/sh-sci.c: static int sci_remove(struct platform_device *dev)
      	sci_ports_in_use &= ~BIT(port->port.line);
      	uart_remove_one_port(&sci_uart_driver, &port->port);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

