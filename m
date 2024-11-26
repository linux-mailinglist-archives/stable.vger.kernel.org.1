Return-Path: <stable+bounces-95544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E49D9A8B
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23222B248C4
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE51D63FB;
	Tue, 26 Nov 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8Hiuy71"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82D1D63F1
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635565; cv=none; b=NZXGoMdXAguiU28UBkOXlOH7UdQ1IVsWeYLEGBnp8IDhsXxHM3fvI7Incj3WG9UNGR1QzuYAywfRg0naudg080gokX6v45byhderckFkHhZTV65t+j4e1rGNdi4P4IxNXyLp7fDjoA9mmP4aGwiEDZWLeUFDTt7cKONjIhVduIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635565; c=relaxed/simple;
	bh=ngbCQeWt2Hlr2K2aGEkUD7z+cETKBKI+uklEqTfqloY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUp6NADIW2VPnrm89/w2Ti79BSHcfWhOaWAh9YQdcwKEnZCwzl+w8rWeUB9LyD3xkMTUfwlA/Er2Me8Fn6FhVnI5bnMpIta54MMUNlQkNnwhgMhiFWDFpMTl3YSdpGCG6iRowzqfOREkZtmNWnSKkEKII9JlCzSPyjgxjl0r7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8Hiuy71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF9CC4CED0;
	Tue, 26 Nov 2024 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635565;
	bh=ngbCQeWt2Hlr2K2aGEkUD7z+cETKBKI+uklEqTfqloY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8Hiuy71+orVeLcK2ERmQo5BaWkB7fcTjfK/kWBf7gdRhFiOicgiQE1WA/iILxtq2
	 6JO617gTetXh2zCAqBoNAoobG/9TGmZzHK1ZwFs+9nccvnSqFdZrf6qA1D+zJLDPDt
	 nxc1QKN+332NYy0PIgILfeMyOlAAqwJ9bze9ujgLYkqF7RaSv4z9HMxv5ENCcZdREq
	 VDhdL2KzBe0c799nnFjyoQpwxbnbycdT3dUCNNWtEURIMFbu2qxLmVzRP03JbqOPw4
	 JqvTvzB4meE7he3ajZlDo6NmdrgzEbrC+cb8jDGi4UuGiVz6+OF3xZE/dfuI8Uk2Ls
	 VyJ2fjMF412zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1/6.6] drm/amd/display: Add NULL check for function pointer in dcn32_set_output_transfer_func
Date: Tue, 26 Nov 2024 10:39:23 -0500
Message-ID: <20241126080354-3b61861b38e6d5e1@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126101051.2749602-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 28574b08c70e56d34d6f6379326a860b96749051

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 5298270bdabe)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 07:56:54.529350297 -0500
+++ /tmp/tmp.sd7vGIw1jd	2024-11-26 07:56:54.518708793 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 28574b08c70e56d34d6f6379326a860b96749051 ]
+
 This commit adds a null check for the set_output_gamma function pointer
 in the dcn32_set_output_transfer_func function. Previously,
 set_output_gamma was being checked for null, but then it was being
@@ -18,15 +20,16 @@
 Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
 Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 4 +++-
+ drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)
 
-diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
-index fcaabad204a25..c3bbbfd1be941 100644
---- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
-+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
-@@ -582,7 +582,9 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
+diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+index bd75d3cba098..d3ad13bf35c8 100644
+--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
++++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+@@ -667,7 +667,9 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
  		}
  	}
  
@@ -37,3 +40,6 @@
  	return ret;
  }
  
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

