Return-Path: <stable+bounces-152512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F8AD658A
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DCE189CE59
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E511E51EC;
	Thu, 12 Jun 2025 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G92iAdtK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C111E47AE
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694960; cv=none; b=uHXkXuTW+ZAJ3FA0VERHAv+N5Jwu6ey2qVKdLmBSI0nXVtRxgGStSsNsezjiKcbt+pPBgqRq+9DuwpgYgd0eF7A9BGGuDGluUGkfAXlP3vjpasdSzwVXVkKd30ZTlczl1h5V62f++cu/c0Wj0JLNznjQtCUT8DVtYuwaZHJAqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694960; c=relaxed/simple;
	bh=OVXa5KAYONKM1aVUxM0YuOF8SfChcyRWEfCU+7XnS/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVyQsicjmWyR7VFTSYqoFvZQ6o3icg//8Qv+U1CuzpqvjXb2ZGeQMLBncNLa7hzqfl463P4rVtItuJAdTWe3sAqglHhB4QrQo4grInY69dK1kYlC18GQhQaheAsad56NRkRMtZduGFrsQWFEYcim4Ipps8qHT8+Y+uyyZ5iwJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G92iAdtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9C1C4CEE3;
	Thu, 12 Jun 2025 02:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694960;
	bh=OVXa5KAYONKM1aVUxM0YuOF8SfChcyRWEfCU+7XnS/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G92iAdtKPPjqd7TP6BCpGrQXzFy+w17onl9Bsojj58l3yezo+0bNeqZzygz/FSxMT
	 OsBdQsE/1+qJILb3fs7zhaCyUJVh2Rsj+mLVmLx4dbhJS6gZ0sCAKWYl9uxvoqc/Xv
	 V+PI5D56NaVnh5uffrLDkzeOS8QrvnPWq6iKJVpjIjWI4moF/x2mc46YarKRat1sUM
	 7R3O/NQVW/FaKQAirrqTi/Sm/1Q6GZ95PnR3vdUDQ3Dz8XRWiJc9Qwd3zcpU9upOK/
	 NZkYOLEV6cUTt6YE9exIheggaUV+VhktFPhUNKShoDy5tIPXFNTjGY4gB0r+7sZCyI
	 MxdB9u7rv37MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/4] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 11 Jun 2025 22:22:38 -0400
Message-Id: <20250611112416-85ffd179fb86e1bd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050131.471315-3-claudiu.beznea.uj@bp.renesas.com>
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

Note: The patch differs from the upstream commit:
---
1:  239f11209e5f2 ! 1:  66f2bf77a1e94 serial: sh-sci: Move runtime PM enable to sci_probe_single()
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
| stable/linux-6.1.y        |  Success    |  Success   |

