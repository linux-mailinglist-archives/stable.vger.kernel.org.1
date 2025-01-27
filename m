Return-Path: <stable+bounces-110856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD026A1D549
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66627A3A66
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D325A646;
	Mon, 27 Jan 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FawtjTmL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367FB1FCF6B
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977119; cv=none; b=Al4FejVB2JSPK81nFneo88ddYwCiG7rUK5AEieju8nQw6RztuRwPfzWiZnhebGnxItT23V0RFx2GtUDYGinvYmLsW6/B58qpKScuSBN1YmAlmRzIwnt7sVMsU/pJOoIc1gKEVaiIcOK6dD9BtpVHe4oYaYCpUrR2a2quSPT12ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977119; c=relaxed/simple;
	bh=tUlF6KVkoyv4+xHlWdKcES1yxWPu0z2Z34+H6J2LHyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqFIo/sRmhVM0nSQFAS6ABrwsdqFZYQm8YzaivhEwzbkvCaT2jIPeweZ6fOnTcVu2wY7jCoy9C2GWinnATZpMe4797AR85xy4SCNX/dx5gWN7Cnk9BAFJlxKT/GBL7WwOXVQoCBrVDit+lL54d8lZhenJKo3+DViYO1EsVg9IYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FawtjTmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98179C4CED2;
	Mon, 27 Jan 2025 11:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737977119;
	bh=tUlF6KVkoyv4+xHlWdKcES1yxWPu0z2Z34+H6J2LHyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FawtjTmL3G9Wp04nFZHoRAGhCsq9GEf1dRaZ1rOQjj1eEdck4EdjLKOb6oPxGQJ6w
	 ABQGwUXc2lLvoF3sApKqwo+RB2/FLwhq05LznKzXYTvK4VPU8zQdJtaHyL4binyGeY
	 o0YsV9SHH79EWZ7y9xmjqaWwUyQRIyrsEzkhCjvnx1xHJCzaFHEcZx+uJxvY7+m+PN
	 0LIBeiPLvlKK7tV5Io7MatXs0KVWbsVEFODCxSq1gfqrx34+5JFBoyl4IbrrrtyVCz
	 H3kjrPgTFuVDufXvHPOq7Os3QGWkuHsaiXS2FxQV3QnsSpdx+QikLMPKrTuXrE1le6
	 n2Ji7PvYRk8Mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/6] md/raid5: recheck if reshape has finished with device_lock held
Date: Mon, 27 Jan 2025 06:25:17 -0500
Message-Id: <20250127043040-429aec38a5285030@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250127085351.3198083-2-yukuai1@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 25b3a8237a03ec0b67b965b52d74862e77ef7115

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yu Kuai<yukuai1@huaweicloud.com>
Commit author: Benjamin Marzinski<bmarzins@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  25b3a8237a03e ! 1:  64000dbb8dcf7 md/raid5: recheck if reshape has finished with device_lock held
    @@ Metadata
      ## Commit message ##
         md/raid5: recheck if reshape has finished with device_lock held
     
    +    commit 25b3a8237a03ec0b67b965b52d74862e77ef7115 upstream.
    +
         When handling an IO request, MD checks if a reshape is currently
         happening, and if so, where the IO sector is in relation to the reshape
         progress. MD uses conf->reshape_progress for both of these tasks.  When
    @@ Commit message
         Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
         Signed-off-by: Song Liu <song@kernel.org>
         Link: https://lore.kernel.org/r/20240702151802.1632010-1-bmarzins@redhat.com
    +    Signed-off-by: Yu Kuai <yukuai3@huawei.com>
     
      ## drivers/md/raid5.c ##
    -@@ drivers/md/raid5.c: static int add_all_stripe_bios(struct r5conf *conf,
    - 	return ret;
    +@@ drivers/md/raid5.c: static bool reshape_disabled(struct mddev *mddev)
    + 	return is_md_suspended(mddev) || !md_is_rdwr(mddev);
      }
      
     +enum reshape_loc {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Failed     |  N/A       |

