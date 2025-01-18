Return-Path: <stable+bounces-109460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A8FA15EA0
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 20:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F891166239
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20A81ACECC;
	Sat, 18 Jan 2025 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEm2DHUN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FACA1B7F4
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737229257; cv=none; b=I6epXocSoLCAgxqdQtBTz0Iyve8HAYFDJSgPpoQh2kUc9N8SmRwgLI7UbHvOdirSPOxjl+HGPv8g3pHMJQAvCHsZIVjj39yxBdm8tPvUV48EdI7kLEkgPJr22YwowMZEAjky8xDGuK1YMgLLowMuH33SAldPu9fg7lRwJSCskqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737229257; c=relaxed/simple;
	bh=1wM5BtOmjqjOYwCyK6O95LNbnLEcj+7ePI/QEA8Ihkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGJ9SaMA0t4Nvd4QqSR+q8WSSsIDo0etYp0pbDol7FUXI1g6OCSxiIOZ/v9kdrC7/69tZvkqs9daveAvNz0Wb217GK9MV1BviwCIJIOtWFEVRizHUvztoQxHPbx7YDkYmuxABLJjA0zWOuLdZaCr1hjrGnXS73ZR2wZtSHFlafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEm2DHUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1945C4CEE1;
	Sat, 18 Jan 2025 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737229257;
	bh=1wM5BtOmjqjOYwCyK6O95LNbnLEcj+7ePI/QEA8Ihkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEm2DHUNo03ydr49OKLBCcJQ2iv63oE3phgFtiEvToZIA1BRGEHr+UHbW95jYM6w8
	 zvX0vw85w1SHJuUwGnP7bbXbKxmalHbXNUiqg2GdaUXCL7/PaMo0HkQoR9EpFFRhJq
	 Ga6d1oJQh/eahxp2nzi6OKgDoCsaHEmRQT3uVX8GkAmTUVyCYSQyyqpZnsXSa7IkoM
	 yOn+bTVqF7oYd8/5JH5I0pkr4Yseu/hbe36MT2U+q+a5oUQxAKHqn2qavuX5NDRFxU
	 YYBGLWKjU1Az70Y6IMb5qqNulEYVOtyWcJngsOL9GPDg/W0Rq1rOrIMF4WW78PaZfp
	 5FDHtvqlxH0fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Tritton <terry.tritton@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] Revert "PCI: Use preserve_config in place of pci_flags"
Date: Sat, 18 Jan 2025 14:40:55 -0500
Message-Id: <20250118132322-e766f042b40ff786@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250117151625.6429-1-terry.tritton@linaro.org>
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

The upstream commit SHA1 provided is correct: 7246a4520b4bf1494d7d030166a11b5226f6d508

WARNING: Author mismatch between patch and upstream commit:
Backport author: Terry Tritton<terry.tritton@linaro.org>
Commit author: Vidya Sagar<vidyas@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3e221877dd92)
6.1.y | Present (different SHA1: f858b0fab28d)
5.15.y | Present (different SHA1: c1a1393f7844)

Note: The patch differs from the upstream commit:
---
1:  7246a4520b4bf < -:  ------------- PCI: Use preserve_config in place of pci_flags
-:  ------------- > 1:  a66142759fe0c Revert "PCI: Use preserve_config in place of pci_flags"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

