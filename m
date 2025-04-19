Return-Path: <stable+bounces-134679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B59A9432E
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832D117C8E5
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4A1B4244;
	Sat, 19 Apr 2025 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfpxZCLW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963318DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063222; cv=none; b=glWhQ/QLFBlFIsei00VqakIf9XkxHWk2c8m2KFqpubA2zw6QzcNyfhLKKTEaG0Job/Lho8RtZJt4X2BWK2DVFQbvSCK186A70nxtNjvD4FeIBzO9Z0GPifboGMILVV3fO8xxukqnF6ds/NzEkEW5dObFsH8BHDPF1g4qK3FXjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063222; c=relaxed/simple;
	bh=OrjRa3dRn6XZS/ah3vAUHh/RIlF2X1fhW+lgR+pzghg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyiXE2P9nYPlw3/1iw50rMIFP5h+iISwseySW9ymM/H+mOw50tc7AlZxEtRkrPaiBaDBErw7zMdyPHVc3hbxWAyD9v8K/XS6/cvy02XtV4BeHrPVnJPJNSdpSqr48NyWV/S5W+bfpoUxIpOiLdSoFap/rQIpcCP4mdLMXrXXrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfpxZCLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4340C4CEE7;
	Sat, 19 Apr 2025 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063222;
	bh=OrjRa3dRn6XZS/ah3vAUHh/RIlF2X1fhW+lgR+pzghg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AfpxZCLWBQ4pLYN8nT8hQziiyWvRTjofu6RiftIl0XrTFNr9tWqoEchKXopaH2B4T
	 XTkZdIdKXJDOzK5nljy8JYZUs6cCOCt65nB6gaTSd023ysB/thyYMmts3mfONrwviP
	 tMogpW8T90AFU91JSaeuVaYYb2FS3NP8E3K93aC8oMDFO7igoZgGIMfS0pGECx03Yw
	 hiQDqeSLIQK07LX4Wo0KzERkVcdm1aZV1q1bXUWHY8VhokrxwqYpH1rr1yBcsg9UzJ
	 VRw0SgRZIbBdmI3ajH6GgLayO+e5FQQRmLqieH1+ZNRWGIKr0r772SSd9UJOcEgeLT
	 vZrQWzXG0ePKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bvanassche@acm.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/3] block: add a rq_list type
Date: Sat, 19 Apr 2025 07:47:00 -0400
Message-Id: <20250418190345-000dcd31ed1bd983@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418175401.1936152-3-bvanassche@acm.org>
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

Summary of potential issues:
ℹ️ This is part 2/3 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it
⚠️ Found follow-up fixes in mainline

Found matching upstream commit: a3396b99990d8b4e5797e7b16fdeb64c15ae97bb

WARNING: Author mismatch between patch and found commit:
Backport author: Bart Van Assche<bvanassche@acm.org>
Commit author: Christoph Hellwig<hch@lst.de>

Found fixes commits:
957860cbc1dc block: make struct rq_list available for !CONFIG_BLOCK

Note: The patch differs from the upstream commit:
---
1:  a3396b99990d8 < -:  ------------- block: add a rq_list type
-:  ------------- > 1:  9bc5c94e278f7 Linux 6.14.2
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

