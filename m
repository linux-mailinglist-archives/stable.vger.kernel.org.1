Return-Path: <stable+bounces-152510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91525AD6597
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A923AEEA8
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E83A1DF723;
	Thu, 12 Jun 2025 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXRA1/ZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348122094
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694957; cv=none; b=ulYqE50gsN6Plpxu3B8qcN0jqrkzlPh5J4rEReU5u0G3OoIgb+Eo4J3gwb3+B/3nLUuiwbCmvTpYl9TgYUm6oEjbzagUbB8pWx5f0OOHVQ+SLUa2MFTE9h5PEVaSxGsgMQ7wTC2DRhLFy+/mW9DS0NJcYklVaN+DGnZ7ULW5udA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694957; c=relaxed/simple;
	bh=CNlav41z8WAtnVw9yI/bpzGoZ4RbpxIQvMrc5xkWfqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxI1r0aCgdEPvHGAcPi0oBtCWhQMxx33LEyU5s3XXftR3Rmhrd24wojkc9yGBG43ksCGv+cN2hMZpppdEuOUhdXmu5M80c/RaAdD5GkatofgVxU9PdYaxKsC7ieusXxzJQxIFRFcpIwLtwr0lNrrm0mTep9Gki1tQryWelA0i7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXRA1/ZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8BBC4CEE3;
	Thu, 12 Jun 2025 02:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694956;
	bh=CNlav41z8WAtnVw9yI/bpzGoZ4RbpxIQvMrc5xkWfqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXRA1/ZVDwbKmuQCjrHVry8wi4+RJXTII51CE2r7+qXamdY/mDO4PxnqNNFXx52Bi
	 4hXUpqyxy6ipbWmRuAaa1gHDGtfAAyHZRUku17ikIqMQfIs6t/iYywdmwxK+PtqBVB
	 1l8KDcZaw7twHjc/FEZnjH+ZLU9i6ggl+jnGYm9zE+gZSAblrXs03rQbheo5ocIbhF
	 LKGr/gVgjHbtfcg0PfqRQbIEr21+vieRMII1/rQsoxTzXZLtQI7+H7DbrS5bPCi96o
	 pNXtuN9GA5SEMot8Xp4nTf2m0au5+2taSemcyrWR6B/IUbR8E+OdIpbZjf3/tsm4oZ
	 n/6R8ALF6cI0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/4] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 11 Jun 2025 22:22:34 -0400
Message-Id: <20250611103336-bcb0d965f80e1318@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050517.582880-3-claudiu.beznea.uj@bp.renesas.com>
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

Note: The patch differs from the upstream commit:
---
1:  239f11209e5f2 ! 1:  1661c18e629fe serial: sh-sci: Move runtime PM enable to sci_probe_single()
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
| stable/linux-6.6.y        |  Success    |  Success   |

