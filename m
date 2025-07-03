Return-Path: <stable+bounces-160105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC4AAF8037
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42EC1CA1E80
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5318C2F5334;
	Thu,  3 Jul 2025 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKK0dmIG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4C2F532C
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567689; cv=none; b=WRvwU5RMszwulSmkngPSBBWQVDUa8HL17VBuF2nzpEwOXKyRJ9OcRJcstKk0naUcEfl0pGUCt/sOIeSm4z/MYKlK8rKW/stUHySMrJIN11KfwpJqJ6SBZ6cg6pSDRxLGAftWvdkLG9dqSIShSEuRnErK49WYidKIDRZH7N6nR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567689; c=relaxed/simple;
	bh=sU6P+kaVSmFG5H5cqKg9LS/UTfDXC7WEni/PL6gHuag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHecdeTgTPv91LYBdyehHD8q3b45muDKpY6fFC6kF3cQwRZYQmwuF+0JW/pf0442Ug+1EK6EL5hsIqbmgA5d1/77GAV3tzgf4PpZWd9/AIwabOuHuUvG6QkbvkZzQAnRoIxj8ObZAGIw47QlGmYZ8m/TnFKH9oN4MVfHHZQF+UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKK0dmIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41896C4CEE3;
	Thu,  3 Jul 2025 18:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567688;
	bh=sU6P+kaVSmFG5H5cqKg9LS/UTfDXC7WEni/PL6gHuag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKK0dmIGP5brbMpYNXYyks6+gAGJjJhjM2NCLeptZlmanglQMIRcNd84f2Kv98WaJ
	 1ELwM60wE9PnfHExj+4++0LhFTX1bxv4BGCzua8BbvUXHfRyJ6wvCg5Oz8PnttqedB
	 gWSvLF0lbNqmeX7spj0IKsxbwRhCU/BpzIjHTeoQB4TCanl6dJxD24KQIrvPGeeVDX
	 zmufaH1mXubxg8m/w1TWUEFWQu+tF0HQEVWsbdsZiFhfChyd4xAoVzHRGW3ONDNSZx
	 OeBfA/talQH0OL5ZvWLdJ/SLwo3zSzgYnYiiGnFq2mEsYt3WI7VemgtsY//9OdRyvN
	 sHdGldXK9T3fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mathieu.tortuyaux@gmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y v2 2/3] net: phy: realtek: merge the drivers for internal NBase-T PHY's
Date: Thu,  3 Jul 2025 14:34:47 -0400
Message-Id: <20250703114429-7c612512be0de726@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702102807.29282-3-mathieu.tortuyaux@gmail.com>
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

The upstream commit SHA1 provided is correct: f87a17ed3b51fba4dfdd8f8b643b5423a85fc551

WARNING: Author mismatch between patch and upstream commit:
Backport author: mathieu.tortuyaux@gmail.com
Commit author: Heiner Kallweit<hkallweit1@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  f87a17ed3b51f ! 1:  70e9914c26e15 net: phy: realtek: merge the drivers for internal NBase-T PHY's
    @@ Metadata
      ## Commit message ##
         net: phy: realtek: merge the drivers for internal NBase-T PHY's
     
    +    commit f87a17ed3b51fba4dfdd8f8b643b5423a85fc551 upstream.
    +
         The Realtek RTL8125/RTL8126 NBase-T MAC/PHY chips have internal PHY's
         which are register-compatible, at least for the registers we use here.
         So let's use just one PHY driver to support all of them.
    @@ Commit message
         Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
         Link: https://patch.msgid.link/c57081a6-811f-4571-ab35-34f4ca6de9af@gmail.com
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    Signed-off-by: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
     
      ## drivers/net/phy/realtek.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |

