Return-Path: <stable+bounces-152508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BAAAD6588
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548971BC3C52
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A4B1DF75D;
	Thu, 12 Jun 2025 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWEGm5By"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125821DF723
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694953; cv=none; b=OF9YnMHtynn5MTVF7xe6FVYw3nJdhImnXV5qq7g9hHdkU95YtJCprw9S9GE6rRSIN4dCbfr4upB6ihemq6AopRhj2rs0nIn7aZPiR1+W3O8z6F2uVR7ZZwKB7nHXHFpRqpijXcp4bH4JLb2aTMSLF4nCmVctbHgo7/7MnBl0Wls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694953; c=relaxed/simple;
	bh=MAhwLscfu7+Kmqd9mxcLo2/wPMO3zgbDMyyr1Gpqby0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzF/hvmfphg8VLvInIWHZpmG5FBDIqytztnTEHcNttH8WyPYYpAR1dARN9NDc1Pqv6bA4/SaLUkVeicxbOZaiPhgb8VfwqtdKfBMmZeAp9qedk+m6D1TaCabE5PRdDZtVDkQ33QBfyr6tFXkqhJflAqUj3BZbnxjg9Dxe701/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWEGm5By; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C17CC4CEE3;
	Thu, 12 Jun 2025 02:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694952;
	bh=MAhwLscfu7+Kmqd9mxcLo2/wPMO3zgbDMyyr1Gpqby0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWEGm5ByS7OULwVsj0xrHyeDGPZxC1xN35NHjGQ57jyUgvSUPtsMzeSiDobDs9ZP5
	 rYT6clUWW2izCpgSO3XRhdOxOUu/x0auWrjgw3duNjDvWFhgpP7lr3yqXycE8l81Ao
	 d8IgihFTw50cUnzGbiIE4leIr+/+uaSS9wTbZaDNDWUT/gOjqc7U1IyG4ztwSeWP7o
	 GRH6M/wM5NfE9KMdXYux+uTPhUtrMDrSWrNqXFobY9IAbZJfyEOrsYSVXZct7veXjx
	 GLK48BsYWVWqqxUZwcO9C+sNaJbHSywah6JSixMUsgv3BJpScJssj54urpP2icu6gb
	 pukTaf85LsTRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 4/4] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 11 Jun 2025 22:22:30 -0400
Message-Id: <20250611104526-92045c9e4f26d69e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611050517.582880-5-claudiu.beznea.uj@bp.renesas.com>
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

Note: The patch differs from the upstream commit:
---
1:  651dee03696e1 ! 1:  c17445145f725 serial: sh-sci: Increment the runtime usage counter for the earlycon device
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
| stable/linux-6.6.y        |  Success    |  Success   |

