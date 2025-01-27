Return-Path: <stable+bounces-110857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7928DA1D546
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B46166BD2
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5111FECA0;
	Mon, 27 Jan 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErX5V/iO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C161FE451
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977121; cv=none; b=HwcOGFjjtrVM16azIL0EkEkDMBxZV9LFx73yXA1QX1eoceBzA41hPHadxW3DM9hPp8pFtQKWkYC78NOMU3ahgZc781pvjvgYIoiOuT9a0AqKc2d1yv6hcdokM92huLNqHYMC2E4NWxITML2c1VI86l4SWxg3OB8EZbf6rUVButM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977121; c=relaxed/simple;
	bh=j07Jkd+Eh02Zg2LOYnmmNKf5svs06tMk/DU9ivXC21g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oqyc3dSsCJwGOezlH/5OV5Z7c/zePPdgHCOE6mWpqSQiDZNbKmTZj9eQZw1K7YJrdftrikXCjCkIakMC2xBhcG4PgpBrnkT9fCS67VEqoAH43U3Fn0F6FhyHpDM5pMsiWGAyq+BZZlqxGHwvUpc6A/Nh++fy7wO2KSBVBCuzBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErX5V/iO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1885C4CED2;
	Mon, 27 Jan 2025 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737977121;
	bh=j07Jkd+Eh02Zg2LOYnmmNKf5svs06tMk/DU9ivXC21g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErX5V/iO+EmImOGKqlzhKRBGH4HgZufqoqAyNyQ01c8hWq0nILrl26uNsgAQITU1B
	 LHJxpcGIkxKk9XbjZkHFID4rNPoRu05tE7LFlXnbCHf9dlfVWKn716BL8R3HTWZFwV
	 wXZYWnzl0kK4TDmmtDkCWJMhPHjqQWEaN5oIta6WKY0QdC8VWXWznA9kGp4VrbhK6F
	 gRhmKVW6jXIlGnfUnasYqXSCHcmQKMIk87o6t5wgZY5r5RwP1ZCqy0kQ1C9Z3aIHMN
	 NCIKyZDbcFYE27a4hhZxrf9gwduDGDm9KefsgCwSeob8I3MCLpjzPixKZbrfGC74ku
	 +dGfJ55Kv300g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 1/5] md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
Date: Mon, 27 Jan 2025 06:25:19 -0500
Message-Id: <20250127041636-cfdee9945400d753@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250127084928.3197157-2-yukuai1@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 08c50142a128dcb2d7060aa3b4c5db8837f7a46a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yu Kuai<yukuai1@huaweicloud.com>
Commit author: Yu Kuai<yukuai3@huawei.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  08c50142a128d ! 1:  c5f3371866713 md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
    @@ Metadata
      ## Commit message ##
         md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
     
    +    commit 08c50142a128dcb2d7060aa3b4c5db8837f7a46a upstream.
    +
         behind_write is only used in raid1, prepare to refactor
         bitmap_{start/end}write(), there are no functional changes.
     
    @@ Commit message
         Reviewed-by: Xiao Ni <xni@redhat.com>
         Link: https://lore.kernel.org/r/20250109015145.158868-2-yukuai1@huaweicloud.com
         Signed-off-by: Song Liu <song@kernel.org>
    +    Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
     
      ## drivers/md/md-bitmap.c ##
     @@ drivers/md/md-bitmap.c: __acquires(bitmap->lock)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

