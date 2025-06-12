Return-Path: <stable+bounces-152516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B583AD659B
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B4B3AEF7E
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D001E7C24;
	Thu, 12 Jun 2025 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlQ8KJ9A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A01E47AE
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694968; cv=none; b=BJgxqP1Oaj+dws3Ot4uRJuaOKxI4I4kAvMTs3Ze4E9rprl+E59QSiirYzTE7sPYwMX2K7qJMDKc61AodrPDaJ95Dnsj5mD100YTQRVGYKQXzxRwObtmFZsudpm0NzxI9/7og6tcQQ3UPlZjCnZkseR0+WyIpdppLozUKZ+8OKAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694968; c=relaxed/simple;
	bh=gnIFhIi5CpiiH3Eshkxs79ScrCXrpH1WpAjE6HabdpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aptO8ZQZODrst+yF5SBPqaUJMeuLbS211eAnG7v2dBglsLTD2u1uQNfzghg3KYAcrSFtAFlQ5gMCuBKbRUlafsW0i1563PN0iSRgm7se55raiL7CClxGnnh09imee9ljVqd4X55tJL7pdVRyHm2VAZ6afGNd3ombgj55aZY06q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlQ8KJ9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA36BC4CEE3;
	Thu, 12 Jun 2025 02:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694968;
	bh=gnIFhIi5CpiiH3Eshkxs79ScrCXrpH1WpAjE6HabdpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlQ8KJ9A6oC7jr6EmM0OY0XnkFv8QjA5SxkUeDB8lFR9DfzmJsLOetptKrMXc65uh
	 N5jtDNxfl7AEZrG2Gr/vtA9k4n5kil5/KLps/v3VAF6S1d2IF6/wt7B3xaqpgS9E6o
	 FfV/bK9twYIDEjFNfM5Jfb6MtMuxC0MJEWKIvAXBZsI/LkUjFJyath/j/0FB5PNTx/
	 DQIlcgbou0YCYQ2jb6/iSs7Isn2unmZfY07MlVQLsvLDJWUxMAkfI+FTeZq6HsZ/e9
	 yBC70VUG8OQNIrbLKP360uJcSCxBtRNXA+dBg2z5MA5n63G7Zf9E9EhSSXE/OfcXMt
	 Qsrri2IORoXxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 5.10.y 3/4] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 11 Jun 2025 22:22:46 -0400
Message-Id: <20250611110644-edcd669842126366@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050053.454338-4-claudiu.beznea.uj@bp.renesas.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5f10170699334 ! 1:  b79b1e0e4a210 serial: sh-sci: Clean sci_ports[0] after at earlycon exit
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
| stable/linux-5.15.y       |  Success    |  Success   |

