Return-Path: <stable+bounces-151962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4419DAD16D1
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C39E18883F9
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E972459C5;
	Mon,  9 Jun 2025 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMkbWPA1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A01157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436454; cv=none; b=WjA7iK1ywtIzId2DObHuBNypNLhhDDVLm/D6Ms7ZMzm00h1M3v9ZE2VA3CoviElQ+qIPfrq+9dog0WwP8evkfwRiOzGxX5BUt8u0jf+G/BTRw9xQNFI0v1IbFy9+TN8a/oWsjmcWS++uagwbyTR2Wvr8SxMAc/RbLCkKDl3JrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436454; c=relaxed/simple;
	bh=ovp6zJSR2RoyiSQCuRueWm4f6Rr1oUCTeWz44EucbH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QU0ihZvSbORKtgvPKixxPJOzwFK0dmCTF8rAAPI2MD5Rkc3JIHNFx8aKQz5j/lWE+FYUqf1UWW/oIlG3iYrWeCKbOdzzGIFQTGzk26/qB4f4PQOlI6KakbuioI7BYbOwOYkPOmC+REUmkV64QOlrGsanXMo1CY+o7Ss3BtIHTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMkbWPA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF86C4CEEE;
	Mon,  9 Jun 2025 02:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436453;
	bh=ovp6zJSR2RoyiSQCuRueWm4f6Rr1oUCTeWz44EucbH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMkbWPA1kVVAVbJm7o9ANXUm6P0wxT6H/ypJHjV/PDyRhmkLtI/LVfQtK2oGdck+k
	 D55xMEsmL6klbPWUr3l5P+C4T7SDhTFIbaEKEMjZfdzPKPK9ZXZydilkQoN0h3Ours
	 gzkq8QM7tiGmrlRbHGezgnQvGzCstc/MK+QJSehg18c/AzoLjzE42IsvETUFB1S7Q6
	 VQcrTA1MiLIU0DQTfk5Hs9Q0NFyiZhHIY9aTmss+A8szo2KUeHDmAdkTf9DjIhq5jT
	 yPPvNhT2YPxGE2O/0lhjkwnvASUiBTvIahfRxXAEW3C3auyD2OhbPbIPyGW32rSgQb
	 2PE/IWxfINIvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 05/14] arm64: proton-pack: Expose whether the platform is mitigated by firmware
Date: Sun,  8 Jun 2025 22:34:11 -0400
Message-Id: <20250608185850-ecf5b1bbf50dda87@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-6-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: e7956c92f396a44eeeb6eaf7a5b5e1ad24db6748

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: James Morse<james.morse@arm.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: aa32707744d6)
6.12.y | Present (different SHA1: ec5bca57afc6)
6.6.y | Present (different SHA1: 854da0ed0671)
6.1.y | Present (different SHA1: 351a505eb478)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e7956c92f396a < -:  ------------- arm64: proton-pack: Expose whether the platform is mitigated by firmware
-:  ------------- > 1:  27ee7df26006c arm64: proton-pack: Expose whether the platform is mitigated by firmware
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

