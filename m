Return-Path: <stable+bounces-145988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B537AC0229
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B757A1B6807E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127434D8D1;
	Thu, 22 May 2025 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGU2pluQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D818E3F
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879578; cv=none; b=rw98AsQyDwVayAxyzSeGu/v6NRbjZ0IoneLRERT5wTByHwGvffMcTvcV9FJ6mUCilpdwm7pxMyc9MR2Jcyhai4hhFAAMIPz8lzbc9x8orpS1w8oKO0c9xXgnINLHUn8VNlnNpdetXTRIhqQNUBsBmSUSL524zHK6ernpGavyUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879578; c=relaxed/simple;
	bh=Dhk64RmEHX6KZsbhhxONOvRN+TLyt4M61pCOtjM0juw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVszghUkgRJm6aB3rPkwhj0lB4Yy9HYEwmfZn/aG2/iMhEsME8s2r3s+03I12B5+RQQ5bit2KXMTmG1tgJy5YWsbG3x8rObAkLE9TAruViet2GpuY1xoeUXqBcnOnIM2yN0IPRom7pZCKr9WJUgPcd+qoWZdwAPAAIAhBGHIqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGU2pluQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7C6C4CEE4;
	Thu, 22 May 2025 02:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879578;
	bh=Dhk64RmEHX6KZsbhhxONOvRN+TLyt4M61pCOtjM0juw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGU2pluQs4eRoQyDxPN5opDXYXFEyYMRzbGVYdaMEtwO4LWPFE18Pj6jq9J9e35nC
	 1XjC8KLgi0vusrAszNAOJOAiebyxn8uFbKgrEBVrP8tXZmK5dva6uCnsUvjiTXzV00
	 QBxMmX2adi+h6XYsFF+0VDPjJbIV6QDMuK8+nWArG10QHeVt9fIHJf491Adbiyshy2
	 13pbmHz5tzi10pL/836/VpDhVtYJkc96ptw9zDPGc4ZKfBG0LyJdKmlBpUZDg0jzZU
	 ZUDvBO/Dwk8B9xX69t10e0e+E+Cq6kO8dK9ISNmaVY6GpHQvjz6efpSdll8X9cU8Rt
	 /d0C786uodUzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 26/27] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
Date: Wed, 21 May 2025 22:06:14 -0400
Message-Id: <20250521215511-1d28e8bb6e0913c0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-27-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 041933a1ec7b4173a8e638cae4f8e394331d7e54

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Michal Luczaj<mhal@rbox.co>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  041933a1ec7b4 ! 1:  c5354d822aa1a af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
    @@ Metadata
      ## Commit message ##
         af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
     
    +    [ Upstream commit 041933a1ec7b4173a8e638cae4f8e394331d7e54 ]
    +
         GC attempts to explicitly drop oob_skb's reference before purging the hit
         list.
     
    @@ Commit message
         Signed-off-by: Michal Luczaj <mhal@rbox.co>
         Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 041933a1ec7b4173a8e638cae4f8e394331d7e54)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: enum unix_recv_queue_lock_class {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

