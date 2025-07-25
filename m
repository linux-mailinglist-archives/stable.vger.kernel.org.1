Return-Path: <stable+bounces-164795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C4B12771
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6523B38F9
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B474A262FE4;
	Fri, 25 Jul 2025 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3USqqtb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A7262FDD
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485990; cv=none; b=fvP5DOLgcfU/0yrQQECNAzQDTSjueHjhhLqnuUiizg8idTcRp13D7gRarRmBprc+2NpFa0olQRx3FTis4i0pTVncTpi2ER3jRzH2Gs6AZ5XbDg+k4YSMuSIwCRXmqSfsx+7S+ttYFQp1vPZnuysssam3iCQ/dpT89Rg5aTa0kWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485990; c=relaxed/simple;
	bh=mdQCM8fdYyEJWXSlYY01lLM0sRIlgQNM3wCpJw31ZgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUs6btangG2IRErrx74HP3GxULuRLndrlsDQ08br4MOkEGqVpC4ASAl9lYkJDtjnveQREhIMAJU/XilAO6xwX1fwC+x1zRyDy5x1sCLPWdtbvVXYynL1f1kzYdrj25DzvaKd8h8NsquRNqtjR5ufC5CRG+Li7pHPxgG26rUC4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3USqqtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8871BC4CEF9;
	Fri, 25 Jul 2025 23:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485990;
	bh=mdQCM8fdYyEJWXSlYY01lLM0sRIlgQNM3wCpJw31ZgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3USqqtbQkmjN3qkz0O6xaqPhje2Tn9Eix87/GNlDyFqBI8GIObccNkwbL+Ka3NoM
	 KNWkEuAOH4RCVYF84kgaEswbYzoOWlAlBTgt7lBFpR3H6V2yXQOwNzijsYmbh6PQdB
	 rzOD2FUusKfDUwMDk9r8YXMsvIR65uzwMlZ9jKUHTQwg6KmuWfd4tA5YS08me95qgV
	 GpaJKp8XJn8DZTD+DGqtRf4SykGpBlL8Z7H9MA7VG7EX+MyQUfmerw2jv8VRaoaJe7
	 DXmbGI7Q5NwWmwBTPL2mCb/2zR/gLVB6CxU6LfV2PtTSUB7s9zY/y744cCYiGz+9g/
	 nwmQnLbTwGVyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: aio_iiro_16: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 19:26:27 -0400
Message-Id: <1753466194-0038cd62@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181257.291722-5-abbotti@mev.co.uk>
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

Found matching upstream commit: 66acb1586737a22dd7b78abc63213b1bcaa100e4

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  66acb1586737 ! 1:  050bb07db030 comedi: aio_iiro_16: Fix bit shift out of bounds
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707134622.75403-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers/aio_iiro_16.c ##
    -@@ drivers/comedi/drivers/aio_iiro_16.c: static int aio_iiro_16_attach(struct comedi_device *dev,
    + ## drivers/staging/comedi/drivers/aio_iiro_16.c ##
    +@@ drivers/staging/comedi/drivers/aio_iiro_16.c: static int aio_iiro_16_attach(struct comedi_device *dev,
      	 * Digital input change of state interrupts are optionally supported
      	 * using IRQ 2-7, 10-12, 14, or 15.
      	 */

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

