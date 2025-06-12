Return-Path: <stable+bounces-152514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8598BAD6590
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9DF2C1694
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146481E5718;
	Thu, 12 Jun 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJY6OY7k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79DC1E378C
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694964; cv=none; b=thhD8uiby8U/Tt8p17Qrkhro8VhlGLA69uQMCDO1lZ97thr/35n7sAn6SX3ggUeMNVWUqEWoLdj1rDwX1q4UUqZLUIenUqtKL8qE8bLaUG2lcGrbHykcE1TY4gT9wC+ix8IXK3pSWu6iwbOVZBXCUG9g5us+j9GIJPSDAdE25w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694964; c=relaxed/simple;
	bh=t1+BDSEKaDuQW9y7WYYx2WLAwKx4+OeF8DVETbrqU7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouZbaYuJipj5VYqC73CG8Y2x6tueqQ1hF2/gNomja0s8asIITVqJcfKDvBEm2vo5ig7x44lJkUeRvJ1C1Nj50GEeMyX3icCwSJcQR67RWMK+soew4eDwDwnVTAjbE6x3DeXBvtfpZWA48x4nrfqSsOnSH0rJPTBS+VsiM7SIG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJY6OY7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC800C4CEE3;
	Thu, 12 Jun 2025 02:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694964;
	bh=t1+BDSEKaDuQW9y7WYYx2WLAwKx4+OeF8DVETbrqU7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJY6OY7ko+vytwMqijBmPm+UO0E069YMovwnJpmPzE/SNzlySEV+VmBbjiEj6EXOw
	 Qe0USq3N0bisnhEBg/oZfCNOC1sXTfMyzl0XBQo87VowTBvmbJ9TjolbUHJS8a87n+
	 U50HLpz/rMh8fESWRXUYHbohl+XTqCikgpYMmrCf/nRogSdwud+lmOHP6/bvSlo//f
	 zK/sM9GuPGA+PT3w+5pZKr/6WvbgXrdvst3Aal7E2ldFT3sUSRS/phjkET8wpGs6Tm
	 rq52LHqTvjHZsFIV0cqTdHDp2YvNYH5unQQvaQKLEJIeMSZw7BP0SDIGsL1VqIpSR+
	 nBKdw2lFSS6bQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/4] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 11 Jun 2025 22:22:42 -0400
Message-Id: <20250611100934-25912261a62c9c06@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050552.597806-3-claudiu.beznea.uj@bp.renesas.com>
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

Note: The patch differs from the upstream commit:
---
1:  239f11209e5f2 ! 1:  11940341da104 serial: sh-sci: Move runtime PM enable to sci_probe_single()
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
      #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
          defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
      static void serial_console_putchar(struct uart_port *port, unsigned char ch)
    -@@ drivers/tty/serial/sh-sci.c: static void sci_remove(struct platform_device *dev)
    +@@ drivers/tty/serial/sh-sci.c: static int sci_remove(struct platform_device *dev)
      	sci_ports_in_use &= ~BIT(port->port.line);
      	uart_remove_one_port(&sci_uart_driver, &port->port);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

