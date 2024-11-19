Return-Path: <stable+bounces-93907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C775D9D1F5B
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDAC282D3C
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791F14E2CD;
	Tue, 19 Nov 2024 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwSqVYqv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D214E2E2
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990996; cv=none; b=JMqyO0n/Sff6UIOET4M70zXnM41AYf95Vipo9L9CVCAha7FLKNUoA/cKbRagbP4FCeqj9idRIcEXUr6gM0poSk7etbr/vV2lsCpFiHEDTQc4/gtRmjseBDjMhv8jLXqDKoBk99TFwHTgrIiByITMiloNhCQsGvq5Oy0Ry06zWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990996; c=relaxed/simple;
	bh=nfVh3WG0lh5aJTr5YWaZx8HjXmvlm0FbdhnlV+O1fjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ntd8vG7DyS8DQchTomIXfIm8mR5gkY+xIADOD4b7DnB/BjFNhHSuVjFWv9wQZ4ahPe2bUIITvRchFcjhFR8N+wCvE/gUr6VrAejO9CiEPZi4gUBaYdJajIaDloNCKyYcgV4E+xJm1TbAxleAo6e+onnNm2uzu1aMtTlFD85LFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwSqVYqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E2BC4CECF;
	Tue, 19 Nov 2024 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990995;
	bh=nfVh3WG0lh5aJTr5YWaZx8HjXmvlm0FbdhnlV+O1fjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwSqVYqv5LP6YTzrXAkmRA8+kGIP0Ul6M9dgWb5+imgYXfpyD9WQrJhJKF7GEQAJN
	 2UHkUd+FuF3h1lVw3ff8NWSmaE+yvjFvd1wgq5Z3IoB0uYOiwcSFpZIoRVbYWzR/Y/
	 JhbTWUXK3LXFoNcOPhlgQemVnlWTUO+TrZI5BObwUehYazarQ4KXJ1AAD4XN+XJ1bR
	 7JfJsMknk4Q12NxxWSmYElxrk860dQD8S5CXPUIcXjxyCG2RSPpqMn9RRJ8atWW/C5
	 9sXsKcB0DLvp0bsoi8AaQzTXloG8XwztdqFG3JKaaZf76BNx5iYDbTtdz31m9lz0bg
	 t7xtzQNxhUDOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/3] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Mon, 18 Nov 2024 23:36:33 -0500
Message-ID: <20241118102050.16077-3-kovalev@altlinux.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118102050.16077-3-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: 985b67cd86392310d9e9326de941c22fc9340eec

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev <kovalev@altlinux.org>
Commit author: Lizhi Xu <lizhi.xu@windriver.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: e1373903db6c)      |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 22:36:26.258041949 -0500
+++ /tmp/tmp.H7dIMzFjni	2024-11-18 22:36:26.250299326 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 985b67cd86392310d9e9326de941c22fc9340eec ]
+
 When mounting the ext4 filesystem, if the default hash version is set to
 DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.
 
@@ -5,18 +7,19 @@
 Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
 Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
 Signed-off-by: Theodore Ts'o <tytso@mit.edu>
+Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
 ---
- fs/ext4/super.c | 7 +++++++
- 1 file changed, 7 insertions(+)
+ fs/ext4/super.c | 8 ++++++++
+ 1 file changed, 8 insertions(+)
 
 diff --git a/fs/ext4/super.c b/fs/ext4/super.c
-index e72145c4ae5a0..25cd0d662e31b 100644
+index cf2c8cf507780..68070b1859803 100644
 --- a/fs/ext4/super.c
 +++ b/fs/ext4/super.c
-@@ -3582,6 +3582,13 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
- 			 "mounted without CONFIG_UNICODE");
- 		return 0;
+@@ -3559,6 +3559,14 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
  	}
+ #endif
+ 
 +	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
 +	    !ext4_has_feature_casefold(sb)) {
 +		ext4_msg(sb, KERN_ERR,
@@ -24,6 +27,10 @@
 +			 "mounted with siphash");
 +		return 0;
 +	}
- 
++
  	if (readonly)
  		return 1;
+ 
+-- 
+2.33.8
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Failed (branch not found)  |  N/A       |
| stable/linux-6.6.y        |  Failed (branch not found)  |  N/A       |
| stable/linux-6.1.y        |  Failed (branch not found)  |  N/A       |
| stable/linux-5.15.y       |  Failed (branch not found)  |  N/A       |
| stable/linux-5.10.y       |  Failed (branch not found)  |  N/A       |
| stable/linux-5.4.y        |  Failed (branch not found)  |  N/A       |
| stable/linux-4.19.y       |  Failed (branch not found)  |  N/A       |

