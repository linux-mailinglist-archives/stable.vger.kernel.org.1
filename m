Return-Path: <stable+bounces-150754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C201ACCD26
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847C87A8BC1
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800C81E7C10;
	Tue,  3 Jun 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhe9XlDj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FFBA34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975765; cv=none; b=KuFfRbOCqs4NiNen5CzZ8rviqzZe8uUgDK9+FgdiyIyJ4sXEN3sqfJ4XpTJ4oTSb5sezN0n6AZkfGBjoWgcvIdLXxX60WQ9xwTrJdZeARHbreIwwhlH42VvijEkjyuSawvvoWNmNC15DNVTp8h07dov3besSHNgyMA6WUCA/NOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975765; c=relaxed/simple;
	bh=IWrDfMffoR0dN5jZfDSJyV2x/GQL3jk6H76b7ETNtbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOf1DbiQn/Fgb5ifxISWsW4avdGzj+d42BitAqYHsu4J1TUxw8ZZRc/W1k8k80AVVmJ5s1KD4stacZECQIV4aQo71FT2jJdiaNkM+dpSXNonytiKacmbdz17F7rltAMHo7PRn7xi1kTY1hH9vFSYRXkQ+bvK4Qh4LFzkbXTx2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhe9XlDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DDDC4CEED;
	Tue,  3 Jun 2025 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975765;
	bh=IWrDfMffoR0dN5jZfDSJyV2x/GQL3jk6H76b7ETNtbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bhe9XlDjYWOOWeB1e9U2/jMf2+RcTyNsjkHwkOHGmPivPspY0nyaYCxupKUUuJulz
	 BrlmRFnCtl3F7J0/zAV2aKwgrOtVAxg9nHw8YdVzYUr7u5oJVVxTcD0/sWR89C0uZq
	 geEjAfsP3LMXMqrzXSE9SXNox7ItrDiVrZ4BoHhT3HVfoYMZyxb6bTLVlmb6Vx2/ID
	 jcJ2ClHBxNPsrtKMYFoN1Yh82DIQ36werI4RtT+4c7rxB82PkR+kWic30CF7k5gPtz
	 qlOLEZ35DdDdPqtC5o8VGqW1PxWPuIZ2HbbPMGYihWo82X1pm3NIcHZNguMnDRSdQ2
	 eRspAkrdxH43w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/4] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Tue,  3 Jun 2025 14:36:03 -0400
Message-Id: <20250603142332-ed8dd7bfa3407463@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250603093701.3928327-3-claudiu.beznea.uj@bp.renesas.com>
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
1:  239f11209e5f2 ! 1:  ef2e932fb64e7 serial: sh-sci: Move runtime PM enable to sci_probe_single()
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

