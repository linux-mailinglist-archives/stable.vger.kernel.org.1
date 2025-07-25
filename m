Return-Path: <stable+bounces-164796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E41FB1276D
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48165A3285
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA7E2609C5;
	Fri, 25 Jul 2025 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB4Pf3gs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54A2609D4
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485993; cv=none; b=KrQ6k1xv0f0Iwxiv5YuIAVT7zHO92OCyIOeavj57jnfZSOK0LuxWVn23gS/QvWZ9mIPFsMXHA0jKdvnIAMMpVjR2p47V5dXnY5ZptOrqEqGiVQNgI8FFAOXiHLor1Wch+lU4ZCWmSnefA8R20NOCfTTJytIl7VEsmZJMUj6ApUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485993; c=relaxed/simple;
	bh=geMCQkr10e8zdmp7+iJ6eZx1//0T6rT4Bf8gC6yyUws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/qct2Jz9ABF1eIOMx75YiSHVPOzP690a/N3DEX9+9OEtCzTJVMm3R4Q8f30JmCBoZmtZb+SyvTlJvSteWCRn/FPvjAbNl59i3sXPiGv10GB2Yu/a1QWkco5n1exs1GlBGZATUBwOq6P/jMpXnAClww3DRbuciO9qoChqN0VCr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB4Pf3gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF5C4CEF5;
	Fri, 25 Jul 2025 23:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485992;
	bh=geMCQkr10e8zdmp7+iJ6eZx1//0T6rT4Bf8gC6yyUws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vB4Pf3gsT7v9x5X2camMX/3PM4FvR5TGFYZMdXQrgIhFbmAvOVpYncfAqdPpfbdU2
	 e0ZF66GOTWcv77ASDoAowY1XRNutOLRFwymxZGJCzHsJw/GjCzWfpBTU+7aHyBaHVc
	 SAl1qwKVSt4+M7ZthNxFR+lKXdcyNgn863Gd7q84ELTdJ+ryJ+BdoaK/B/ujQmaDn7
	 rB0H+ZAPYbGggYzATJnARx96qu6QECI1Q5kDSZXmr+WDJq6j17SFQn7KcdOoSSaf64
	 Q9sMKKV9lGx3ubImP6OrBAe+clmp0NpL7WVUFfU84Qo+m1lK0n7WJCxS3/alYzWcmt
	 M7siB6LnJm62w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] comedi: das16m1: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 19:26:30 -0400
Message-Id: <1753469136-2f6c2e73@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724182218.292203-3-abbotti@mev.co.uk>
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
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ed93c6f68a3b ! 1:  05de6bb6adee comedi: das16m1: Fix bit shift out of bounds
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
| origin/linux-5.4.y        | Success     | Success    |

