Return-Path: <stable+bounces-164777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E0AB1274D
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05E7AC0AC7
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF98725F988;
	Fri, 25 Jul 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKh5IPz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9052D1D9A5D
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485855; cv=none; b=KyNmwx93YvvRp1KjQ4Bn/HJ1Myi80uJ+IUU2DzIdHgoNk9ZsCSm2/GUtKXb6pgyhiTHkVPoSF0ca/wFJj9gFP3pr1kOtPnZK9qthIvyCdhKV2tgPQg+CJ6/08Tifs4LOu5Bgi8nEQK6ZWkmEAndQf027Txf+HsXoy5gDcR8j9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485855; c=relaxed/simple;
	bh=uT4b6pbwSgxv9vH31s2pC7oNhY5ESdEcWnxwq+QxvWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frOA4UGReQCfQ0UStbrZYVo/c0YqKsqNjBBdQEuVAT5kIqFTu0ZfUokIZ6uNn39jWvdq1xo5smFuw7fC4hDyi7F8HjlWLD4HVhNwdM6Q1VyLt3305HTzFA4Mu3cyvVrlCJwqfAsqbZ9Bah7KSbk7ll/mhITX+iDEOGIbkIwlaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKh5IPz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D6EC4CEE7;
	Fri, 25 Jul 2025 23:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485855;
	bh=uT4b6pbwSgxv9vH31s2pC7oNhY5ESdEcWnxwq+QxvWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKh5IPz8slxvnwlyAANbMPayOTEtcLv4b6p8G9ppYk71Te5lUlZ8SB84iuoaBSKMf
	 BBQNFy5yGtbELaIdfMpAm+Z+BQ30Vpn+Wez5GSwC09t4ffbWW1+ZKgHXMEZAh0Cfkt
	 yloUjRxNS/kR0MHPrtRod6o3khCvqUNskL32bR3IqNSVpkriOQ2TdEwdjGrCPUdb4B
	 OVaCaYlpHB6d/5bBQYa2V8agSlbdIkv732FmBfmc05WWq4H8UGt9daMIR+V/OnnaMe
	 3XAmyrTLRGKeQCeoSRlprQY3eGu8qmv/Z91ImUqfLhVF1ixDKRZyp7mbhglkgbUBYp
	 awKwzUzLFluuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: das6402: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 19:24:13 -0400
Message-Id: <1753470778-0abcf3bc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181257.291722-6-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 70f2b28b5243df557f51c054c20058ae207baaac

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  70f2b28b5243 ! 1:  dee1eb300666 comedi: das6402: Fix bit shift out of bounds
    @@ Metadata
      ## Commit message ##
         comedi: das6402: Fix bit shift out of bounds
     
    +    [ Upstream commit 70f2b28b5243df557f51c054c20058ae207baaac ]
    +
         When checking for a supported IRQ number, the following test is used:
     
                 /* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707135737.77448-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers/das6402.c ##
    -@@ drivers/comedi/drivers/das6402.c: static int das6402_attach(struct comedi_device *dev,
    + ## drivers/staging/comedi/drivers/das6402.c ##
    +@@ drivers/staging/comedi/drivers/das6402.c: static int das6402_attach(struct comedi_device *dev,
      	das6402_reset(dev);
      
      	/* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

