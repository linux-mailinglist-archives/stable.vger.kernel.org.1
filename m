Return-Path: <stable+bounces-152511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A7AAD6598
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215623AEED1
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C0F1AAA1D;
	Thu, 12 Jun 2025 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA+aijkW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C422094
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694958; cv=none; b=ESg0DNJ7RaI2EX9k/VUr8JrPTvxhWsupWpPQS73g8VRzm/LJZZkKayIXRvzLwwyFhTuIBes8v1BBXW29T6HpCtGpBZp2u6mZPt7A49ud1GNQ9UYrxm9Z8ImQVS0kwdLNLr0mtUXYaLSSdSzcWmhe5O8aZjwQsY4CIcDIT2vIvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694958; c=relaxed/simple;
	bh=iQrRfkZcZw0GWHBMRp7Pww6dxy2gyPkBLVLuPUwetPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEYQGeZ5Bhm2lir1jwvvRH9ZF8ubBb1GbO1/yRo9jxRlT9oUhFYal0phhGLIW7YxM2adUeaSsqK/bhjOvkwAc+5qr1SKlgmPpeL5Cy01y+JdKzJK4jiDNPs5UPQOC4TkBKnaTIGhnQFV+iKwEMubMTDsSfWxzi7n8nnHRMRQpnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA+aijkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24100C4CEE3;
	Thu, 12 Jun 2025 02:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694958;
	bh=iQrRfkZcZw0GWHBMRp7Pww6dxy2gyPkBLVLuPUwetPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uA+aijkWPhOKeILGe/QyNi4xkpmMMkifrdUr5G67EQ52+xNB4/ckNp3Zw+xK/fjr0
	 sraesuK8Pq+H5rLWHtQhWfvk38oIdM2GG0nEZx/ge9R6aEJ5E7DPsr9aDUe6q+8N7o
	 bHtb3locawlQ+v+Bdtaiw6IMrwgTrslRERN6UJUmkuGh2AntCKJhN1f/JMGuF6b3B5
	 tzazbF/yH72qONPj2iUKjcRENNHVmGg9wbefoJEwTAl7W/HPp0GelWdgZjlku2fMGf
	 55svxFwwEA7VeY+I7kBVZsyKWEM4xbcL0YSIu8uPRxesrfdjHSkUcSG4ejSU1MQg63
	 28+iem+3LcQDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 3/4] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 11 Jun 2025 22:22:36 -0400
Message-Id: <20250611112945-e6948e9caf36ed1b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050131.471315-4-claudiu.beznea.uj@bp.renesas.com>
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
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5f10170699334 ! 1:  da97259b65a48 serial: sh-sci: Clean sci_ports[0] after at earlycon exit
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
| stable/linux-6.1.y        |  Success    |  Success   |

