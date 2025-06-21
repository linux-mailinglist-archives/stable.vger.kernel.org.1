Return-Path: <stable+bounces-155225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73FAE2824
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B597D7AE1D0
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3E1DF974;
	Sat, 21 Jun 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK4pLN47"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8581940A2
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495943; cv=none; b=WltmzU8GuPWgp6W1iCIhGRi3CEl3haYX9hZ/P/PvebvQIo4ahF0Ck/yzTXHJvx3y2LrKhfEGg3St76ry2Gcnjv6IfZq0/oZE8EA4iqjVsTMkrOA3A8SZZTSeT5IqOyuzd0whQ/9JJykxaU6zo9bD7WHLH+0U7kItph/RGi7+FqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495943; c=relaxed/simple;
	bh=wsKS0i578MOw0dXut5jze7f7qQ8VTJhdzHk5CbC3X5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufgZmU/tdlj9h0intPoMPGGHdjJdkUTronihuIqqbidGYhjEzaRDa6F0SfN3vnWtJ+Ut0mLqTz1RHO7jKqZwLjeh27VGntMckO37E+PQXe3SoUlwor+Edzq5rPAijstfEfZVTw7DDm/xQf3k4Gzxr+euwx0tnZ0XSPCeMqXUDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK4pLN47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A66EC4CEE7;
	Sat, 21 Jun 2025 08:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495942;
	bh=wsKS0i578MOw0dXut5jze7f7qQ8VTJhdzHk5CbC3X5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iK4pLN47RmnWYZbhUJPKrV1o6OMi0VG8e0d32m61ONDba3O7uuFq/VIYZw/wR38N0
	 V87EAxmYnUfY70i36hoKRlpnzyrddPQqUcfeZsAoEq2pafAETJaK1R1HZy6fZtzoD7
	 asTqhv938WgsN3/OGH34z1Uln9zLezXuWXREKKE+5OoJrmgHjjF33bADAkQVrwE/fL
	 +KoQNiH50YTBrd2PLRrom9wyCjFLsE/70smSOfChxOdXNLpWwoPv1H6fUs0GpZidni
	 0hidtJEpXwi9xmSO3OzXiVXSiXdwm7uaIGc6xB/w8raHEI1+saBRjUYQMvBvLxDAbG
	 oByQQO+DAiVoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
Date: Sat, 21 Jun 2025 04:52:21 -0400
Message-Id: <20250620232958-999f278202013ebe@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250620084958.26672-1-aha310510@gmail.com>
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

The upstream commit SHA1 provided is correct: af98b0157adf6504fade79b3e6cb260c4ff68e37

Status in newer kernel trees:
6.15.y | Present (different SHA1: ddfb8877c6b5)
6.12.y | Present (different SHA1: 25cc031107f4)
6.6.y | Present (different SHA1: 543c9aed6f73)
6.1.y | Present (different SHA1: e7c29c3b1d88)
5.15.y | Present (different SHA1: b58688929dc8)
5.10.y | Present (different SHA1: b5960460d84e)

Note: The patch differs from the upstream commit:
---
1:  af98b0157adf6 ! 1:  e2e4e77718de3 jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
    @@ Metadata
      ## Commit message ##
         jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
     
    +    commit af98b0157adf6504fade79b3e6cb260c4ff68e37 upstream.
    +
         Since handle->h_transaction may be a NULL pointer, so we should change it
         to call is_handle_aborted(handle) first before dereferencing it.
     
    @@ Commit message
         Cc: stable@kernel.org
     
      ## fs/jbd2/transaction.c ##
    -@@ fs/jbd2/transaction.c: int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
    - 				jh->b_next_transaction == transaction);
    - 		spin_unlock(&jh->b_state_lock);
    - 	}
    --	if (jh->b_modified == 1) {
    -+	if (data_race(jh->b_modified == 1)) {
    - 		/* If it's in our transaction it must be in BJ_Metadata list. */
    - 		if (data_race(jh->b_transaction == transaction &&
    - 		    jh->b_jlist != BJ_Metadata)) {
     @@ fs/jbd2/transaction.c: int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
      		goto out;
      	}
      
     -	journal = transaction->t_journal;
    - 	spin_lock(&jh->b_state_lock);
    + 	jbd_lock_bh_state(bh);
      
      	if (is_handle_aborted(handle)) {
     @@ fs/jbd2/transaction.c: int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

