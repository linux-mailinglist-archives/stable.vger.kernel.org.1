Return-Path: <stable+bounces-179465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A8B560CA
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33CE1C25140
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99902EC546;
	Sat, 13 Sep 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0qbtbeE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D09DDD2
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766401; cv=none; b=VBxpaMVoxd7ZxFpfGEAzrfXi/qkd8YiAnCqgn174RCLXAf9FIvD1wQCqvhniOtflVL9SK5xIaZrFW0ZkiD4bpwwCKt8rPPgwFOJuzyHKpOoSO+//wKfJz+OkZIKKAlQIByMIK1gAe+gmpU3I2eRpBgc/fjgwod05VR7lCMXaXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766401; c=relaxed/simple;
	bh=ubil0PCJMIwy8ohfl9Kuaw0d9Vp4yzPXjl1i1BHGfYE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rN3Sod9NY8gWiyg7NcZhxAhxHST6jRJ3k1s8fOnsBL63OvFPp7nOWKYqpDeSmgLxcxNI9aNHcp3RnKcj32QvmpkH97U1A9fIElti4UvBLFWGK+VjqP+GADAWBmug8/h13/XT1mbhvsJu0CXQ+qkSA7Rcn5KcVhMGo8gm3DUOsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0qbtbeE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA15CC4CEEB;
	Sat, 13 Sep 2025 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766401;
	bh=ubil0PCJMIwy8ohfl9Kuaw0d9Vp4yzPXjl1i1BHGfYE=;
	h=Subject:To:Cc:From:Date:From;
	b=0qbtbeE+vLNo73elJfgZFlCDWHWF05y0QElH/DvoNadLX/vIyf+j8D2Uz0PCwPvpc
	 3HFdXsoeyhw2S4q13/5Edm+zUDB9UsVnivDDAZzlVvsdLKEeanFHN2/yUPKGsRtnbQ
	 UWCDvsSJ9BVjwmnAxD1yW6CGdRMSqH/6aJK9ltBY=
Subject: FAILED: patch "[PATCH] mm/damon/reclaim: avoid divide-by-zero in" failed to apply to 6.16-stable tree
To: yanquanmin1@huawei.com,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org,wangkefeng.wang@huawei.com,zuoze1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:26:27 +0200
Message-ID: <2025091327-cyclist-impeach-ca7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x e6b543ca9806d7bced863f43020e016ee996c057
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091327-cyclist-impeach-ca7c@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6b543ca9806d7bced863f43020e016ee996c057 Mon Sep 17 00:00:00 2001
From: Quanmin Yan <yanquanmin1@huawei.com>
Date: Wed, 27 Aug 2025 19:58:58 +0800
Subject: [PATCH] mm/damon/reclaim: avoid divide-by-zero in
 damon_reclaim_apply_parameters()

When creating a new scheme of DAMON_RECLAIM, the calculation of
'min_age_region' uses 'aggr_interval' as the divisor, which may lead to
division-by-zero errors.  Fix it by directly returning -EINVAL when such a
case occurs.

Link: https://lkml.kernel.org/r/20250827115858.1186261-3-yanquanmin1@huawei.com
Fixes: f5a79d7c0c87 ("mm/damon: introduce struct damos_access_pattern")
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: ze zuo <zuoze1@huawei.com>
Cc: <stable@vger.kernel.org>	[6.1+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 3c71b4596676..fb7c982a0018 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -194,6 +194,11 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		return err;
 
+	if (!damon_reclaim_mon_attrs.aggr_interval) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = damon_set_attrs(param_ctx, &damon_reclaim_mon_attrs);
 	if (err)
 		goto out;


