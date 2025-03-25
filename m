Return-Path: <stable+bounces-126033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF66EA6F457
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FB7164E31
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D11EFF95;
	Tue, 25 Mar 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvlCMmQG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899619F111
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902689; cv=none; b=r9gv4QkNWGVOKabEELxUTKsp7MY5+CkvXgzgNMkZeep/qM6es5kcf3lv/UC2DkkYh5p+g/5sEjk4l6t/8ytuECuQJD6T7iTB8R8+H0CepsXxqx6S372asVDNFX461W4JlrXeOFMGzg2X5MROVUSOmAaQAR8jwfmImls5aH5e5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902689; c=relaxed/simple;
	bh=KKII46K1/GjPZGI3U/wkOmZ1hh3Onv0HcF8pZlyqR1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGt6QhNjXmG1/xMB9sXH6/E1mAXEAaYrVuI0RkACZufy/QVuD6zOrJWNz/gD6ed2KS+TUY6S63FaX8tC/zdEMOOFZv9dwhTGY256XFcUZ9LiyvH88wvamKkoEjbYfTgxFeoch1bhNUfE9sEBJbZg3KhKR4FH/uhufbJp9of34Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvlCMmQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E86C4CEE4;
	Tue, 25 Mar 2025 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902688;
	bh=KKII46K1/GjPZGI3U/wkOmZ1hh3Onv0HcF8pZlyqR1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvlCMmQGZ2Q7M/xK0vGL9OfqpLIV0oOoZ7OAWvLIiSAiIWzlX7e7tfSJUnlUMFXx/
	 49t+E7CBaQ+qST0ZpS9gG/+G/q2QhOlYg03oLimPZJbBwayxxbuWcntArVf7q4GGFv
	 MQQZbwrrEzx0DyoDlUZYweh4l+18N/gCbGh4bVtFJFMTuTdHKrW/YiM7dj8LAhwC7q
	 tW+gf+MfRXoWLBWVgoLd15PNuojDc+fpeVx2tq5JFGsJSCKHgC2T8SBbu7swZvNCgf
	 AziTUBN8RBdVxqEpqy74uWQ+/Ggd9G2HUSnUWsAyR2TR7kSW4hYmCnahR+U/7zilhA
	 osdlpUkUACVNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 5/7] binfmt_elf: Use elf_load() for library
Date: Tue, 25 Mar 2025 07:38:06 -0400
Message-Id: <20250324222857-fbbfbce71b29a55f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324071942.2553928-6-wenlin.kang@windriver.com>
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

The upstream commit SHA1 provided is correct: d5ca24f639588811af57ceac513183fa2004bd3a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d5ca24f639588 ! 1:  ccf2de90c4543 binfmt_elf: Use elf_load() for library
    @@ Metadata
      ## Commit message ##
         binfmt_elf: Use elf_load() for library
     
    +    commit d5ca24f639588811af57ceac513183fa2004bd3a upstream
    +
         While load_elf_library() is a libc5-ism, we can still replace most of
         its contents with elf_load() as well, further simplifying the code.
     
    @@ Commit message
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Link: https://lore.kernel.org/r/20230929032435.2391507-4-keescook@chromium.org
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static int load_elf_library(struct file *file)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

