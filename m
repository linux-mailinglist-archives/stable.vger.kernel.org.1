Return-Path: <stable+bounces-108217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C2A098BB
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557CF16AF40
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F391213E8A;
	Fri, 10 Jan 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlFOg+v8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85D213E7D
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530759; cv=none; b=Ys2cvE17AMTLYDkhciln/mgakDRK9xk2fv7W4tenCQiNUR1w8wDIZ8u8radgNcMeYKfzmN609XR/EGe8H/SKJHYKCZ+X+DoT729loniJpLRclN1qy4W20I0syCOPdFY0MmVnbdK31KETtsPViYqD42p6QlYZM/zCPT0kQaGWcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530759; c=relaxed/simple;
	bh=6F+COQ00gbzTFldMTi4gNs1sg5NIDIZUyLm+5Ft+jo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goH3NqJkoKOQypGMIQ11ouOMMjJCrqpDPB6GzVJFrdXkLSQoU3WmyPKCHFx+FJM3rGMbigYl4KODVkyD9buLTeM6KVk0hM9Q6cktWjQvnlx1AHR44RMOkBMwVW8EXUqHgTiBQTSSjpTjDM2GtaZOjnolLiFfiY83RQ0h2fLobRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlFOg+v8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC61C4CED6;
	Fri, 10 Jan 2025 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736530759;
	bh=6F+COQ00gbzTFldMTi4gNs1sg5NIDIZUyLm+5Ft+jo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RlFOg+v8DBmVp8mmsyKqSUzRmGejsBgnaaE0Wxuf4DO0gtCjyPWqTLkDlM35kyYjQ
	 2Ri1PBsTB430XZAnnk0dbRE9SSCpCv+uX1robXWnKo2ipv7A1GhvhQtMERCaIbVLAW
	 8121sAa+XMFecOZ0q1oz36UURxOhSWNdof59nM+GCAA/uj/7CvW9GFynJHUeIqfR0i
	 k5Zsf4ba/7Pm2clQyo/XAYfzogl3EgojoFU0J9gi/2fgYKI0dl36NJX8DvHGNn/xu0
	 2aiBAQNUqvMoIY7x/ReIlxHTWsS9y0gX85xyzVzngppimtxXHRKA6mMDp1Oz9/Yv3j
	 oUoShI5lXOopA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,5.10 1/1] netfilter: nft_dynset: honor stateful expressions in set definition
Date: Fri, 10 Jan 2025 12:39:17 -0500
Message-Id: <20250110100849-fc97cf2c50e21e88@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250109154538.43720-1-pablo@netfilter.org>
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

The upstream commit SHA1 provided is correct: fca05d4d61e65fa573a3768f9019a42143c03349


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (different SHA1: 3272f66580d6)

Note: The patch differs from the upstream commit:
---
1:  fca05d4d61e6 < -:  ------------ netfilter: nft_dynset: honor stateful expressions in set definition
-:  ------------ > 1:  692982d39947 netfilter: nft_dynset: honor stateful expressions in set definition
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

