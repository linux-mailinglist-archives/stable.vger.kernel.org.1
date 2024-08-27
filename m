Return-Path: <stable+bounces-70465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F4960E43
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD8E1F248C3
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF991C57AB;
	Tue, 27 Aug 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VqyL+lq0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F5DDC1;
	Tue, 27 Aug 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769996; cv=none; b=KHSCy4RCpJyZBG3wRu0YP/N2ATKSatpdV3Ag8Epa02j3/bclwwTKkqPCB4HfoElghZM5CE+li4AJAw/m5R6Bgx55O27AWXgxF1DxhzhLNVxRq5VF5Icr2CORE/kFM0RaxthyY1gvXIXMpVsxAHmOAUt2yfZksvJD/znN/xW1gHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769996; c=relaxed/simple;
	bh=JHGp4P8qMQi34yttHob/BqNkyUnYXnh+VJqRqaiFIxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVAGHICus5bSwEvXqpXpEySiAS9VOcziea1zxkhDJCHnT5ZGNgLIhlm2MYxPW27INeP7yLZghWYQKbLal6YdalhsPv+8Mp+JCf0eqKWjho/54rGql3puo0WxHGtrAjqNUEYeZaTjur+q7VasSzykQFf4Map6BoZ3toVpxhT24MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VqyL+lq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA46C6106D;
	Tue, 27 Aug 2024 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724769996;
	bh=JHGp4P8qMQi34yttHob/BqNkyUnYXnh+VJqRqaiFIxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqyL+lq0yNc41N6TYxIYQA50Zc05tX4MjzviXDhIuYlUAIvsPERLAN6430ye4xvNt
	 527Z0SLH6IJ+PvpwdkXBKefDZzHbZOkCrFAVaKvW4a8du6QhJkpwV2MWzr86c0+htq
	 Lm04Fso8xcgwUa70ANDs0hI9mPn6TRfIG3PHnwFI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 097/341] cgroup: Avoid extra dereference in css_populate_dir()
Date: Tue, 27 Aug 2024 16:35:28 +0200
Message-ID: <20240827143847.098452815@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamalesh Babulal <kamalesh.babulal@oracle.com>

[ Upstream commit d24f05987ce8bf61e62d86fedbe47523dc5c3393 ]

Use css directly instead of dereferencing it from &cgroup->self, while
adding the cgroup v2 cft base and psi files in css_populate_dir(). Both
points to the same css, when css->ss is NULL, this avoids extra deferences
and makes code consistent in usage across the function.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d872fff901073..5eca6281d1aa6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1728,13 +1728,13 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 
 	if (!css->ss) {
 		if (cgroup_on_dfl(cgrp)) {
-			ret = cgroup_addrm_files(&cgrp->self, cgrp,
+			ret = cgroup_addrm_files(css, cgrp,
 						 cgroup_base_files, true);
 			if (ret < 0)
 				return ret;
 
 			if (cgroup_psi_enabled()) {
-				ret = cgroup_addrm_files(&cgrp->self, cgrp,
+				ret = cgroup_addrm_files(css, cgrp,
 							 cgroup_psi_files, true);
 				if (ret < 0)
 					return ret;
-- 
2.43.0




