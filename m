Return-Path: <stable+bounces-152509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1666AD6596
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D512C3AEE67
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4041DF977;
	Thu, 12 Jun 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc2ZuH8q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DB51DF723
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694954; cv=none; b=Svhzd/x+5dhO2IQJ8s1NMQtAd1I/UHtAW2Xmh4AvXHZQn6x3stCZEh4giZWtVmzoe9GKcKzGu7JiJRVYUHBsXUFIzPzfqV/tw6yTRZQdPPSucqQTh5ovuBHfINOW+FrdwpIRv6wPOd8+1Bb6I+aOb/FTD791hGTpeOveo02k+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694954; c=relaxed/simple;
	bh=9fEOUijltx2siR+cUe6DLtkxYnxnMMRYA3UwWw5l7rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2OzeJJRa5HOK1minSSI4mC0GUE+hPEAqTtEsZ8iF3MnB09TA8fVx/jYs1o0ciJWQ3esZ0InZCQ/tIuT3Q18wQzMvJNUcnyJT3bxuRcimTfY+uoLSZEJ9C6ETIlgY7fyGr5DBgr0R0wcswGdLlfvyb123Xkb+0nJbA8ux7jFMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fc2ZuH8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9CAC4CEE3;
	Thu, 12 Jun 2025 02:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694954;
	bh=9fEOUijltx2siR+cUe6DLtkxYnxnMMRYA3UwWw5l7rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fc2ZuH8qq1mG4rlteDVzUsmF5e5BzsmEPFHMXBGoUs7S5mhTX4ddogHUQOr/p4XYM
	 uUI7ZB301uj8kSLCjz1j6R/coqXuW2MV4It+0r67aj+Q/tTX1nTEe5N4eWY2FC2fwe
	 gsW3iIKsO0nTD7nQaclcEUHfBVq+Dr5AFqsXrKifKqTIBPyWQgBEQ5KBSvTn/SJ5Qm
	 tRn3C7XJ+FyVxT7kGZ3XpylxMpHdNbdO20o+SlEInPYiKHh5DLCsn4hSG+/2C+G3qa
	 63iwDUY4gTDQd4sMPgzdEG6cEAMYYo8Xz5ZO4xLg8bzu9bNi8OpmAXwNhC9JzRGf4M
	 p+9Gd9QqGpQYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 3/4] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 11 Jun 2025 22:22:32 -0400
Message-Id: <20250611101530-f186ccab6cbc8fe7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050552.597806-4-claudiu.beznea.uj@bp.renesas.com>
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

The upstream commit SHA1 provided is correct: 5f1017069933489add0c08659673443c9905659e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Claudiu<claudiu.beznea@tuxon.dev>
Commit author: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5f10170699334 ! 1:  586833987a38f serial: sh-sci: Clean sci_ports[0] after at earlycon exit
    @@ Metadata
      ## Commit message ##
         serial: sh-sci: Clean sci_ports[0] after at earlycon exit
     
    +    commit 5f1017069933489add0c08659673443c9905659e upstream.
    +
         The early_console_setup() function initializes sci_ports[0].port with an
         object of type struct uart_port obtained from the struct earlycon_device
         passed as an argument to early_console_setup().
    @@ Commit message
         Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
         Link: https://lore.kernel.org/r/20250116182249.3828577-5-claudiu.beznea.uj@bp.renesas.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
     
      ## drivers/tty/serial/sh-sci.c ##
     @@ drivers/tty/serial/sh-sci.c: static struct sci_port sci_ports[SCI_NPORTS];
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

