Return-Path: <stable+bounces-159100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0594AEEBF3
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01817A67D6
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0CD18B47D;
	Tue,  1 Jul 2025 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I69Ls2jA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981BB660
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332537; cv=none; b=T8gPOsoOFXO5+geZ50F/Vm5pfLhgi3ePrV1Vw1rRmc6afKkx8mAKQkJuSgfGw98LVIF4rkjNVj7sZEt+iAY5M45yLtcB8tuRRHLdXvOkNIP5sFuUfyFJAbioNJyfVGoIjK3233guMTIZiZ3Yj5wnhVe81N5KByltQtpSFEyeMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332537; c=relaxed/simple;
	bh=5CTKtKKqT/dGIAkhi/FQoAnFEzANMg0AfYNi2mDmUd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVEQYp05qHbfW+nSrXgrrSiZcKQto9o4pdYUiFzXbR1Rj/ePeo8fNOEf9M4vEZo96149MiVM0jwbW+g8jrr3E3Uyu8c/xzTMnwhdP8//6DKL7Qfw0oaPa0QhY5tWP7TUC0DkVRAdHRb06nCqMcJU5/hE4N3OASua7Xqw4azSm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I69Ls2jA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE52C4CEE3;
	Tue,  1 Jul 2025 01:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332535;
	bh=5CTKtKKqT/dGIAkhi/FQoAnFEzANMg0AfYNi2mDmUd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I69Ls2jAEACjh3NLH5Pt/mvrL18C9vwxMKVyFH+dFtWNyS3v0Pg9qwDFhWvnDSXOm
	 woQZRtJlgsGMXaarbYKTDNZGEY/rjbpYkrP4dEvVtyk4HKRxjpkgT2ZHjnJsRkwVH0
	 RK4QxsYMWmup775qRx0hI78aLNl0RleXQWXK7ElLgoeCxlb8U9C5efR93CNqxRJ4wS
	 8nTuMNIIPW5drkF3kPACnw8GRj6l12MrT0rxAHQ6En02nmKzu5Rxd6kUjunl66dksH
	 f1PHvqGNkefulX6fa1Vf5YKDITUpoDM9UC3DGTLCB/nv+XmzJgOLzcak1c8NwJ/p7t
	 f1wU/5e1ndFJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mathieu.tortuyaux@gmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 2/3] net: phy: realtek: merge the drivers for internal NBase-T PHY's
Date: Mon, 30 Jun 2025 21:15:33 -0400
Message-Id: <20250630190849-e9e8ea1f69e28bf0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250630142717.70619-3-mathieu.tortuyaux@gmail.com>
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
1:  f87a17ed3b51f ! 1:  24f62a93a7c87 net: phy: realtek: merge the drivers for internal NBase-T PHY's
    @@ Metadata
      ## Commit message ##
         net: phy: realtek: merge the drivers for internal NBase-T PHY's
     
    +    commit f87a17ed3b51fba4dfdd8f8b643b5423a85fc551 upstream.
    +
         The Realtek RTL8125/RTL8126 NBase-T MAC/PHY chips have internal PHY's
         which are register-compatible, at least for the registers we use here.
         So let's use just one PHY driver to support all of them.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |

