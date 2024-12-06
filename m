Return-Path: <stable+bounces-99964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241079E76C1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D756C2827BD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC951F3D5E;
	Fri,  6 Dec 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTHGdlne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4C1E1A05
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505092; cv=none; b=G9ptq89fBtMLMIXN+rAuTrEVkY5PJFdADk6RGFzruxTHP/FLE55OQ4ncuvoJ5sJNt4fYarQqrscOSAm4cGe7m+a4gnMXm1oXVvmlCHKNOP/zqrhYKRRmVPrW9yvXTH/kW01Wmv6ZZ073AfyNdXIH0MvDytFb6+ztSnhs4f1NJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505092; c=relaxed/simple;
	bh=dcxqr6gb66BKtV8Z/ehf383CJIrjXaNV5E5qqn1Kjnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uA2/K4pBTIgoRnbFWDQ7fAvSCarQF0c4pvgLuSVz3bvuHvuSk6fjsbhFGw+YO6WCy+y/+IhVKmH5qzluSRVgDPGUJdyi7JNmeie58OaG9Qp1sSizhbDA2jCxZqnRo7lzjYAtrnFHGYj4qQQXLi5ECOMvu+1b5grDvDkHGYku5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTHGdlne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41825C4CED1;
	Fri,  6 Dec 2024 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505092;
	bh=dcxqr6gb66BKtV8Z/ehf383CJIrjXaNV5E5qqn1Kjnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTHGdlneqGfLH41Xe0cIfzxGH8+VesLf+57CBy0sV2dzT2k7+2GOq4mw11FrpxPGQ
	 Y/p7tQxqWninw0D/GMp5C2L+HKAzTD+LWpTCzKoix9rZ3R14Rh9ninkHwCAzZ2XEE+
	 NQy8EYzOtkuEkbqb5bBKYwRJ5QNmFbtnc9H5ZdtlgRj2C2rmpwwkMkF4aDKlVpZ6Xn
	 pFUNTwcQi2wpExjmhEzxaVd7I4gLn7uz8MOVA3++Kp06izoTyGFYJrEJ/DwuCuHD/T
	 s+nMbZJzw3V9rLre+GWS7COCJhCwAmPp8jh4eifgTbV17lrhafDh3NEj8TBkobXY0P
	 v5QRRVNypyumw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10-v6.6] btrfs: don't BUG_ON on ENOMEM from btrfs_lookuip_extent_info() in walk_down_proc()
Date: Fri,  6 Dec 2024 12:11:30 -0500
Message-ID: <20241206112129-3501fbcbea4a5d21@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206040846.4013310-1-keerthana.kalyanasundaram@broadcom.com>
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

The upstream commit SHA1 provided is correct: a580fb2c3479d993556e1c31b237c9e5be4944a3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Commit author: Josef Bacik <josef@toxicpanda.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a580fb2c3479d < -:  ------------- btrfs: don't BUG_ON on ENOMEM from btrfs_lookup_extent_info() in walk_down_proc()
-:  ------------- > 1:  614d01a4521eb btrfs: don't BUG_ON on ENOMEM from btrfs_lookuip_extent_info() in walk_down_proc()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

