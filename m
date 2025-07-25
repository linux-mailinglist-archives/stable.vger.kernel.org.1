Return-Path: <stable+bounces-164782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB4B12752
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B51C24F65
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA56925F980;
	Fri, 25 Jul 2025 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCpKzEtC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B341A8F
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485869; cv=none; b=PPA7OsMCcww+2tvDr65RXU3TmL38lKiowSiMrNlIBFXCGKCRVQIKIJkwPc5ntC/ZBGa5SO8E7KHmAcN8t+ub3KosyTxmy6/vZ2ZsbjVPE9hGUBjguVcUO9OP48ztMyGvHAnrSPXmgGVswP8JY57a+TRjgPat2I0mLpFPZmsV98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485869; c=relaxed/simple;
	bh=2eHAyfwl1MdI4BJ7Wpa34PFUuMJS5IKQBYNKmgx7tR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdHMwg02oY/lB4lf6ND0HXsSkBe8ejYWyvBenfRZs0bRlxMkHl5X3WxYe1PYPUoCAl1qkvBEBAKFpRP+02H2+l3D5XRpQZYZher6x5VMUpkXwrte7VbcidUhUZ2HTsvxn8MoxflZMhX/LoDoL6Xc2Lvnly14LuzQKX7o7Pe6qz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCpKzEtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E177EC4CEE7;
	Fri, 25 Jul 2025 23:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485869;
	bh=2eHAyfwl1MdI4BJ7Wpa34PFUuMJS5IKQBYNKmgx7tR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCpKzEtC4ZO59U6Ooo49pzLIE1wAMR5C1kKaKGNDSfShmUXEWW5KPQEUWXMX8d9Pr
	 ACdP+0qAuPtFV5/2urqsXwHTtR89jxIg+Vc9CcSQ6X5em7TSL/8pG1Gly0rDPj3Vhm
	 NYVnBXOb1FQoBkMrG3Id2JV/nzZuSU4mcbxgMtBL9xjxdK23fMmM9FZzAEP8I/Y6MI
	 6pPGgeN2KEwV8V4rORe2lfGY3EoVeddKl1up8hhl2mdoy7aOXYO4eA8loo0U0Kartw
	 DjuHjugsVh28FBAgTABHZcdRas4QY1bC9Ze0kAZUsEvgSogcjsmW4e6FA6wd3i2MzW
	 97N3AEVXIGoeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: das16m1: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 19:24:27 -0400
Message-Id: <1753470449-69d1e818@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181257.291722-3-abbotti@mev.co.uk>
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
1:  ed93c6f68a3b ! 1:  866ef819f63e comedi: das16m1: Fix bit shift out of bounds
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

