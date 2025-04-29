Return-Path: <stable+bounces-137072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D2AA0C12
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5643D843BC0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF702C2AB8;
	Tue, 29 Apr 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6X+nNvO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE28BEE
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931002; cv=none; b=QyzItlRfbJCR3kTkc0scLKUNoHyjPXaChcYC9Seil+Cw4hMAKtdICipjChsoX3P61StOetTjp30Npf1oeotPTW6FaUjW0tfJKv+6YoFiPAmq4vWHHoKlJpyEExyy1ZTDYKJSouMJ3uExaH2aFQUh87YePY1ys6/zcfaCvtJrTjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931002; c=relaxed/simple;
	bh=B5+b8kcXZaFAcUjzInTFDMwV8U/uy3ZlRhwbgvmMWYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anxaXAIGUnfhbO062fjuWP5kgk4tZ4xzpiviYMn3SLDQZ337WNw8QmtVq2cO1PwwgDY8/QiI2/apig7FmB8k7F54gqb4tqsabFJopct8RDIT4achqQVEutsD6wQxr3ynYnLx3hWU4bDZaCHzj1heJF5osM5TQJOuvgYJlWsXuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6X+nNvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8F6C4CEE3;
	Tue, 29 Apr 2025 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931002;
	bh=B5+b8kcXZaFAcUjzInTFDMwV8U/uy3ZlRhwbgvmMWYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6X+nNvOKxZg4EBG77rmBuVvhsE2IaQDGvGbggUoSiNhd7J8BIc4plevChRvwPXp0
	 Xqqkr+X0fnSA4xz+cek0vQvS8Xep8a++RRHASfWSDOQjC0PGcQrXxPOzf1hltuNBCz
	 NH9hZn6nBJQKj7fhMDFwk3DxhF59c6CsKPmRRmC62aUshxEM1ce8zGIq9ExjbGUt8P
	 XspBt7T5bp4f83CPRq2rlUtnSyH2Ue0n8R07FCilem5qFE7E1xiRD/GUPRkkfKP2da
	 NO+t9PAq1LjmOp/NDTRW67OFT23GsstOL6ln+aD2bwALHJCCbEPCvs0qnqqhr+hgOL
	 ahrHOeBzRKL3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/4] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 08:49:59 -0400
Message-Id: <20250428221800-904beedf56663b1b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428082956.21502-2-kabel@kernel.org>
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

The upstream commit SHA1 provided is correct: f85c69369854a43af2c5d3b3896da0908d713133

Status in newer kernel trees:
6.14.y | Present (different SHA1: 7eb13e5b4615)
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f85c69369854a ! 1:  7c0965ecf22b2 net: dsa: mv88e6xxx: enable PVT for 6321 switch
    @@ Metadata
      ## Commit message ##
         net: dsa: mv88e6xxx: enable PVT for 6321 switch
     
    +    commit f85c69369854a43af2c5d3b3896da0908d713133 upstream.
    +
         Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
         info") did not enable PVT for 6321 switch. Fix it.
     
         Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
         Signed-off-by: Marek Behún <kabel@kernel.org>
    -    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    -    Link: https://patch.msgid.link/20250317173250.28780-4-kabel@kernel.org
    -    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
     
      ## drivers/net/dsa/mv88e6xxx/chip.c ##
     @@ drivers/net/dsa/mv88e6xxx/chip.c: static const struct mv88e6xxx_info mv88e6xxx_table[] = {
    + 		.g1_irqs = 8,
      		.g2_irqs = 10,
    - 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
      		.atu_move_port_mask = 0xf,
     +		.pvt = true,
      		.multi_chip = true,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

