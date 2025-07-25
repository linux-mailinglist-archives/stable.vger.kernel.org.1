Return-Path: <stable+bounces-164779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C03D1B1274F
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE1F189DB22
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496925F976;
	Fri, 25 Jul 2025 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxVOw0NG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5C41A8F
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485861; cv=none; b=XmdWwg3dMCR8PseTawUhbjmPRPL1HXdIZ+vPIQlBd+4tvpH2lQuNkQgGai47mstwD5oDJ+Uylsi+TmNocbB+nv2e5yXWkse3z1S9KyoFwsgH3X5vc4p8jPnB6Zvh2FuAm0szpol60cdeDKvWOOTVzDJ9qQmMtonUsCDCUcQkj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485861; c=relaxed/simple;
	bh=XgKKoWybCRLRsK6sI09HxBWs1NzrU9D+NlC2heVmPoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgOHhoHZGDegrMtrKRNk8jX0cuLfBPuDuwTYcNrne3AA+bwswPMiMVQxKqTP9OpjjKEwv1RXwRFk4D/z2bZu43z9aVSTEUUG6eu5/MgctTMtEjZYa7aM9220iAROlvx/6mH9ZgzLJu6Vx+wYPcugzUqdknRi/cUHvTE8wyGhOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxVOw0NG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D80C4CEF4;
	Fri, 25 Jul 2025 23:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485860;
	bh=XgKKoWybCRLRsK6sI09HxBWs1NzrU9D+NlC2heVmPoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxVOw0NGF+lr85BaHxz1iXNMjXZZe8UXSX2baZ8gETMaBML4DodDP7gzXwjzWjkrc
	 81KOlyamg8c0WWz7CHkz/EHosSOhAPolrAcJI3XUjzHU8549Komj1VMX/KPjbCUAe1
	 ELonU3M8uFeSziWtnM9DMB5ndEbOOt3e3nCZDpFkXjD1ddDuY0Ddq91cNWWR7rSlAE
	 pJOvX/14aG4dyfOOfsT7s0qptmOsMYUXU6Ndi+6lZlcqRS0hr1rqnC2KPRUi8zp0UX
	 FI3l/g2tlm0UzBbliNl/uOuWmCE6O+088Q/tL1CTGOFTdZrmowl1VirLXsfy0ZzkYu
	 cAVwK9PLVuoGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] comedi: pcl812: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 19:24:18 -0400
Message-Id: <1753469462-1066e8c9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724182218.292203-4-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: b14b076ce593f72585412fc7fd3747e03a5e3632

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b14b076ce593 ! 1:  952eb52a154f comedi: pcl812: Fix bit shift out of bounds
    @@ Metadata
      ## Commit message ##
         comedi: pcl812: Fix bit shift out of bounds
     
    +    [ Upstream commit b14b076ce593f72585412fc7fd3747e03a5e3632 ]
    +
         When checking for a supported IRQ number, the following test is used:
     
                 if ((1 << it->options[1]) & board->irq_bits) {
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707133429.73202-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers/pcl812.c ##
    -@@ drivers/comedi/drivers/pcl812.c: static int pcl812_attach(struct comedi_device *dev, struct comedi_devconfig *it)
    - 		if (IS_ERR(dev->pacer))
    - 			return PTR_ERR(dev->pacer);
    + ## drivers/staging/comedi/drivers/pcl812.c ##
    +@@ drivers/staging/comedi/drivers/pcl812.c: static int pcl812_attach(struct comedi_device *dev, struct comedi_devconfig *it)
    + 		if (!dev->pacer)
    + 			return -ENOMEM;
      
     -		if ((1 << it->options[1]) & board->irq_bits) {
     +		if (it->options[1] > 0 && it->options[1] < 16 &&

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.4.y        | Success     | Success    |

