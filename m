Return-Path: <stable+bounces-103903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78B59EFA31
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97E61882A43
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE5713C918;
	Thu, 12 Dec 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg7GKHW4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C31714BF
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026253; cv=none; b=oprWcUApmDwwjisM3oaHSHX8/ny4TDxTumzogiMNPReIK/NLi5BMWnyyiQcc6sYYsnqWJ/ZpcahwtN0eybroyoit3QGAxXK63UtpKq10ti5Eu7+2eR6klZV09LaC8rS1whOUNAas4PlH5nyZKOvlzNosK1kb9vHjR6EPFztrwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026253; c=relaxed/simple;
	bh=3uKLoV2WP30MqUA53jVrQF9yFw1XvfHNYZr3ruzX5/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k347QDVoC9M3HzgCgvZLr9ovL6bnaMv16Uoddyz6toM/Wg7KB1CIdmGO9KVNVmUtNkn+qipWYXdSkYqWC3meJLwi+Ve2YvYG82mZQyBf6ZS/Zb4oRnwRKQC/yXnC8mBTWCAb+434yB9qlwzRdLHuW21V9ZMgwsNhr13F3bby2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg7GKHW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECB4C4CECE;
	Thu, 12 Dec 2024 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026253;
	bh=3uKLoV2WP30MqUA53jVrQF9yFw1XvfHNYZr3ruzX5/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pg7GKHW4nIycN7ZiuFdqcoaB9L8BerAlslNdsdXeTW6jdXqbvd5NRs3OxQPXSi+58
	 ZPlVihu/a30hKD2mlivjls6vAxQ2/vQ7XMx5LYVNai5pJX47jeMsn3P/ZHAYVafMAC
	 a1CvISFXCVztv8Bu/EE/BdPquzN+Qve0gg+sqwd+60PPzGPFgcQKnhW0H5eVbBiV9L
	 WMzUThWaa0rjqr2As1nbi0rOYIiUMw0E0Bl8UpEo41p0ghc6RxXZfXZwX1bco8bZsF
	 sHArX3dkYlET3rFNvEC41Cwu9MKGUtRCIYt46GJfcNUT84mNW89dXz5R4jU2wJHO/e
	 +yy3IdszjawjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: FAILED: patch "[PATCH] clocksource: Make negative motion detection more robust" failed to apply to 6.12-stable tree
Date: Thu, 12 Dec 2024 12:57:31 -0500
Message-ID: <20241212123708-71e2205ef2c9ba6b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <87cyhx9c7l.ffs@tglx>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: c25ca0c2e42c77e0241411d374d44c41e253b3f5

WARNING: Author mismatch between patch and found commit:
Backport author: Thomas Gleixner <tglx@linutronix.de>
Commit author: Linus Torvalds <torvalds@linux-foundation.org>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  76031d9536a07 < -:  ------------- clocksource: Make negative motion detection more robust
-:  ------------- > 1:  58afb84e26cfa FAILED: patch "[PATCH] clocksource: Make negative motion detection more robust" failed to apply to 6.12-stable tree
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

