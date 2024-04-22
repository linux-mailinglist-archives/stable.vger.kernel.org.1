Return-Path: <stable+bounces-40400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DC8AD46B
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 20:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDBD1C21413
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A647A1552EF;
	Mon, 22 Apr 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loiR+IJ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1811552E3;
	Mon, 22 Apr 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812076; cv=none; b=VlOhXC2mxVuoam9voi8r301ydrcHDu5Zdatl9FfKN5sLNbhn1kpZwHejIDkjii9o0aPq89LByqOdX+BOGRudsFHf6HlCsr8KzcZ9X+mye2vF1HpC5q+MLrjul9eLptWzP1yzAerUeC8UgYBIjlAhfJO6C8ZundMz2UWcGtCLdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812076; c=relaxed/simple;
	bh=0VulwEmxbw+TEjzwRlIsiaj0G4/7yYeaxTjsvfq8Qyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obDFzLsuEiBBLQ665lg31ppScHQG81gQlXSUZwviSB5WldfE6Qe/R/Fe1gZ4xJi4cga20vFPi23HaX5+CgXS3ZDWF8zJoHQe06cyXB20NgYjykUpILInmi9n7vmNewridmEow+xPr/n36YhE6DdiKELRp8a10uLhx7GPuyU+Tsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loiR+IJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD26C113CC;
	Mon, 22 Apr 2024 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713812075;
	bh=0VulwEmxbw+TEjzwRlIsiaj0G4/7yYeaxTjsvfq8Qyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loiR+IJ8wlG4fEnzE3jDIWggVTVM2FuR0sJOnjnJdTI0vAV7iCj/AK0PLy8XwOqvi
	 g7UiQ3MZkAJjeafejpKyUmolzrdzRxa0aeUZ2l9wVaMDhWGuqVpGK4gT5FFoHYUF8t
	 wLdWng2P56rubadC+3g9oy3nbJQfuztBFYBmqC9OqvWt1Azb2SX/x2ppAZ/j+tuHjn
	 7ClGUmO/9aUPncOsEBU786brjCsLxfjUMfUo/y1Ywd9gev3CUxHYO1Cc0eVvI+3Xts
	 1rB5PryTMULQhq5r4WUdaNkaul+JmFE5Wex9v/6nwAe2NUAo0onVUGIR+9j+CtZ8sx
	 k27UWNmyeoYow==
Date: Mon, 22 Apr 2024 11:54:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: Patch "configs/hardening: Fix disabling UBSAN configurations"
 has been added to the 6.8-stable tree
Message-ID: <20240422185433.GA10996@dev-arch.thelio-3990X>
References: <20240421171119.1444407-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8pgIU5OAIaSZWnNn"
Content-Disposition: inline
In-Reply-To: <20240421171119.1444407-1-sashal@kernel.org>


--8pgIU5OAIaSZWnNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 21, 2024 at 01:11:19PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     configs/hardening: Fix disabling UBSAN configurations
> 
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      configs-hardening-fix-disabling-ubsan-configurations.patch
> and it can be found in the queue-6.8 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit a54fba0bb1f52707b423c908e153d6429d08db58
> Author: Nathan Chancellor <nathan@kernel.org>
> Date:   Thu Apr 11 11:11:06 2024 -0700
> 
>     configs/hardening: Fix disabling UBSAN configurations
>     
>     [ Upstream commit e048d668f2969cf2b76e0fa21882a1b3bb323eca ]

While I think backporting this makes sense, I don't know that
backporting 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL") to
resolve the conflict with 6.8 is entirely necessary (or beneficial, I
don't know how Kees feels about it though). I've attached a version that
applies cleanly to 6.8, in case it is desirable.

Cheers,
Nathan

--8pgIU5OAIaSZWnNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="e048d668f2969cf2b76e0fa21882a1b3bb323eca-6.8.patch"

From 8990975f1a5b3042a51253d1be0a360fba38b43e Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 11 Apr 2024 11:11:06 -0700
Subject: [PATCH 6.8] configs/hardening: Fix disabling UBSAN configurations

commit e048d668f2969cf2b76e0fa21882a1b3bb323eca upstream.

The initial change that added kernel/configs/hardening.config attempted
to disable all UBSAN sanitizers except for the array bounds one while
turning on UBSAN_TRAP. Unfortunately, it only got the syntax for
CONFIG_UBSAN_SHIFT correct, so configurations that are on by default
with CONFIG_UBSAN=y such as CONFIG_UBSAN_{BOOL,ENUM} do not get disabled
properly.

  CONFIG_ARCH_HAS_UBSAN=y
  CONFIG_UBSAN=y
  CONFIG_UBSAN_TRAP=y
  CONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=y
  CONFIG_UBSAN_BOUNDS=y
  CONFIG_UBSAN_BOUNDS_STRICT=y
  # CONFIG_UBSAN_SHIFT is not set
  # CONFIG_UBSAN_DIV_ZERO is not set
  # CONFIG_UBSAN_UNREACHABLE is not set
  CONFIG_UBSAN_SIGNED_WRAP=y
  CONFIG_UBSAN_BOOL=y
  CONFIG_UBSAN_ENUM=y
  # CONFIG_TEST_UBSAN is not set

Add the missing 'is not set' to each configuration that needs it so that
they get disabled as intended.

  CONFIG_ARCH_HAS_UBSAN=y
  CONFIG_UBSAN=y
  CONFIG_UBSAN_TRAP=y
  CONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=y
  CONFIG_UBSAN_BOUNDS=y
  CONFIG_UBSAN_BOUNDS_STRICT=y
  # CONFIG_UBSAN_SHIFT is not set
  # CONFIG_UBSAN_DIV_ZERO is not set
  # CONFIG_UBSAN_UNREACHABLE is not set
  CONFIG_UBSAN_SIGNED_WRAP=y
  # CONFIG_UBSAN_BOOL is not set
  # CONFIG_UBSAN_ENUM is not set
  # CONFIG_TEST_UBSAN is not set

Fixes: 215199e3d9f3 ("hardening: Provide Kconfig fragments for basic options")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20240411-fix-ubsan-in-hardening-config-v1-1-e0177c80ffaa@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
[nathan: Resolve conflicts due to lack of 006eac3fe20f and de2683e7fdac
         in earlier releases]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 kernel/configs/hardening.config | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index 95a400f042b1..cac20e001c5b 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -39,11 +39,11 @@ CONFIG_UBSAN=y
 CONFIG_UBSAN_TRAP=y
 CONFIG_UBSAN_BOUNDS=y
 # CONFIG_UBSAN_SHIFT is not set
-# CONFIG_UBSAN_DIV_ZERO
-# CONFIG_UBSAN_UNREACHABLE
-# CONFIG_UBSAN_BOOL
-# CONFIG_UBSAN_ENUM
-# CONFIG_UBSAN_ALIGNMENT
+# CONFIG_UBSAN_DIV_ZERO is not set
+# CONFIG_UBSAN_UNREACHABLE is not set
+# CONFIG_UBSAN_BOOL is not set
+# CONFIG_UBSAN_ENUM is not set
+# CONFIG_UBSAN_ALIGNMENT is not set
 CONFIG_UBSAN_SANITIZE_ALL=y
 
 # Linked list integrity checking.

base-commit: 12dadc409c2bd8538c6ee0e56e191efde6d92007
-- 
2.44.0


--8pgIU5OAIaSZWnNn--

