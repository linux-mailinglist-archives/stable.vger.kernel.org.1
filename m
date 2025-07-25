Return-Path: <stable+bounces-164789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D67B1276C
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1393A8945
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A0626159D;
	Fri, 25 Jul 2025 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogYgwELg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFA25B1EA
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485974; cv=none; b=TfLNZuARBi0kdfIdxtWQnG3Cz1gxBfME3TTKQr1EpeY1Ek3caZjtOWLLjx4vrbMaZI50RFfYTXfKAkaZB4xOqFXXj2dm+TUCVlhGkNfR/C9V2uyLyJB+fQBa3/CYpVeCnQAV/8fao/ZSVyVSHZ4fYgd7A3gtF4GyJ9RKl+TWLRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485974; c=relaxed/simple;
	bh=A8lRWrOmSDL4Mo13ipD99uCDOe4px4v7CRGv5AXc7TM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpZlwV7EC9Nc42JATariifvrNrHQUHVNnsSeRdsQkm+AAD8LoZtoUhHJAFHhfGwo5Az2Woq7t895WRpgHim5LW1luv3/bjpT9fZLlfTPxJoS4dfRGfhI5qU9q6d34cirLywueyLr0eITcrt87mZ0FHJWW8nCFvYST4ky2AmlUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogYgwELg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94381C4CEE7;
	Fri, 25 Jul 2025 23:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485974;
	bh=A8lRWrOmSDL4Mo13ipD99uCDOe4px4v7CRGv5AXc7TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogYgwELgt82aELn5a0e0XMB8c1YlwFvM7oFksIE2izaDVA2rKhcqcOcdbogZqpwyn
	 lsr81MYxOKCU2hdU6Fq1M90OGwmO23p9u+S/MUlM3pm34mgoFid0co7mqfQ5trzJQC
	 raqwQMwyMlPElyMwg69c2ZM9xUnktZMoA1MtwicVK19VbkQ+mylqDbxveclsf3JXAx
	 7bZPcmEDuRhubbYFGEKodyPIPkIpgG24jiEVm4CjdT5e60snoeTnp5zxq8XDacIal4
	 LchQleq2Kh6pxBGBWgPr1qT3/Vbte1ABQPi03LnMYNF1TDD3/8hcMs9HdeAvqO2oVR
	 8EsTWQ8PjO8qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: das16m1: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 19:26:11 -0400
Message-Id: <1753467188-2b92728d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181646.291939-3-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: ed93c6f68a3be06e4e0c331c6e751f462dee3932

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ed93c6f68a3b ! 1:  cd8b98d5fa76 comedi: das16m1: Fix bit shift out of bounds
    @@ Metadata
      ## Commit message ##
         comedi: das16m1: Fix bit shift out of bounds
     
    +    [ Upstream commit ed93c6f68a3be06e4e0c331c6e751f462dee3932 ]
    +
         When checking for a supported IRQ number, the following test is used:
     
                 /* only irqs 2, 3, 4, 5, 6, 7, 10, 11, 12, 14, and 15 are valid */
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707130908.70758-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers/das16m1.c ##
    -@@ drivers/comedi/drivers/das16m1.c: static int das16m1_attach(struct comedi_device *dev,
    + ## drivers/staging/comedi/drivers/das16m1.c ##
    +@@ drivers/staging/comedi/drivers/das16m1.c: static int das16m1_attach(struct comedi_device *dev,
      	devpriv->extra_iobase = dev->iobase + DAS16M1_8255_IOBASE;
      
      	/* only irqs 2, 3, 4, 5, 6, 7, 10, 11, 12, 14, and 15 are valid */

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

