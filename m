Return-Path: <stable+bounces-152504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB037AD6594
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5583AACE8
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385B1C1F13;
	Thu, 12 Jun 2025 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH5ZeUoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F27A1C07C3
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694945; cv=none; b=nGpMS4y1sucWLSh9qlko8oJy8eenxrIGxuf3Zt4JlqXKEIy8kiq0K3f7eYJ3SguqydFf2EMleGSkHxshUWgPdVTOo2dMwySU94Vm529xtAJOPtLgJ60vG4dloxflLIzEhMIQ04uk708oP/hUIsk5XY4qMTyWJ2NlmdLSyMPsgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694945; c=relaxed/simple;
	bh=0aYtAy9bgxrt3yrNjhS73IpcQh3Gq74X+wEzuW+lMqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4dFoGXiBqSFIjMxFye4mNZ+budpGvAoXJVMkHruBa4r5zLyfaRGVaaFvVTO0Z//ttsvJQqJJol0r5Y2JaWCE3KRPmKjwg/DaQD+dzTFvyX/TxcEYqTHDrLtHJn8oexOooiJk31y3Cpg/IHIv2L0O5FFjo+6MnmvRdbtn9plzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH5ZeUoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493DDC4CEE3;
	Thu, 12 Jun 2025 02:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694944;
	bh=0aYtAy9bgxrt3yrNjhS73IpcQh3Gq74X+wEzuW+lMqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vH5ZeUoYlGz1qj5IJH/mzPios168Hr2kkWAsqkE9xfSoWLKl+jiWGcbAWtHbRpHSb
	 5CohUkm2jZDFHvmq5mjh0E4q6bGvTjEwlUqeImRmnT6r+tLSanSMPYwiHkauyj/rXl
	 aXnqQagQ2drlaZIu8YQdUCYiaonJz/qu0rww1Z7r4d+mDKHHXwhScCFpMAA4fWpDuc
	 cxWO7cZAY+WTZlC8u1j+hi7upCKOixDnin4PwwebKtrwkUOBlBBaTowkbch4x1/AHh
	 TcRKFojEGHFlhpxp8VJ/pGZ0/UdhMnvEC9DqGYHb5Y6vk64LrgxxaQ/Bh+s71fxonb
	 LLUBs74Rbr8Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 4/4] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 11 Jun 2025 22:22:22 -0400
Message-Id: <20250611113512-89dca3579996b366@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050131.471315-5-claudiu.beznea.uj@bp.renesas.com>
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

The upstream commit SHA1 provided is correct: 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f

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
1:  651dee03696e1 ! 1:  02a2e6f97b6d1 serial: sh-sci: Increment the runtime usage counter for the earlycon device
    @@ Metadata
      ## Commit message ##
         serial: sh-sci: Increment the runtime usage counter for the earlycon device
     
    +    commit 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f upstream.
    +
         In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
         with earlycon mapped at index zero.
     
    @@ Commit message
         Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
         Link: https://lore.kernel.org/r/20250116182249.3828577-6-claudiu.beznea.uj@bp.renesas.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
     
      ## drivers/tty/serial/sh-sci.c ##
     @@ drivers/tty/serial/sh-sci.c: static int sci_probe_single(struct platform_device *dev,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

