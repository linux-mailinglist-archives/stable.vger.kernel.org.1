Return-Path: <stable+bounces-131055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF6EA80772
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5E11BA0029
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08AB26A1C1;
	Tue,  8 Apr 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HeCmTHYM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0E2673B7;
	Tue,  8 Apr 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115367; cv=none; b=Rzfcrw54UWjUHkTAh7s/u95Ymslu1nVKLX4L4dDLmj1MHctB5qe+TUu2NoMFN0jio1vSZWUWaq8PclV6ffPwHmaQ1Ha0NSkYw8sm74UQa4f3q5UGrXXFHdaOJGzniNtJEIfywoD0clyE0saVOvP8M0pI9q3CKk1sJ7dUYwxf95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115367; c=relaxed/simple;
	bh=QmeBQfBoiTGpX445bh02rWMBwGEjfv80+Xqw9chD6us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KK/+5BqUY+TlVCxcRTCZmWBTu29iYRrVdPVdpTjbveIoC+ap6wEp5Xvl3MEQzNc0z2ZQekUbs2P+vLNb0ywgjIosp3X8bK21q68ZYNei3CPlk4jMPXMPimxoYT0isoUid3TOsbGdeX9ww8Dq3VmGKYpa+LBajIr4OpCIpaBAKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HeCmTHYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B7BC4CEE5;
	Tue,  8 Apr 2025 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115367;
	bh=QmeBQfBoiTGpX445bh02rWMBwGEjfv80+Xqw9chD6us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HeCmTHYMxlaoDsL05yxeH/zDDkBX8bt8a0JVh66VvgGHMOAvqXWNtWd9vtbwF1l4G
	 7WOc86rUYekNudRj+m8sOmyVqnQQjC5Fsj/mWgxAaPuqRdesnnHbA56AN9wN0hKm67
	 RtF+OVjchxH1W/JbZg9wAdAHhOYLaQDWvdnAOn/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jon Mason <jdmason@kudzu.us>
Subject: [PATCH 6.13 448/499] ntb_perf: Delete duplicate dmaengine_unmap_put() call in perf_copy_chunk()
Date: Tue,  8 Apr 2025 12:51:00 +0200
Message-ID: <20250408104902.402355270@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Elfring <elfring@users.sourceforge.net>

commit 4279e72cab31dd3eb8c89591eb9d2affa90ab6aa upstream.

The function call “dmaengine_unmap_put(unmap)” was used in an if branch.
The same call was immediately triggered by a subsequent goto statement.
Thus avoid such a call repetition.

This issue was detected by using the Coccinelle software.

Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ntb/test/ntb_perf.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -839,10 +839,8 @@ static int perf_copy_chunk(struct perf_t
 	dma_set_unmap(tx, unmap);
 
 	ret = dma_submit_error(dmaengine_submit(tx));
-	if (ret) {
-		dmaengine_unmap_put(unmap);
+	if (ret)
 		goto err_free_resource;
-	}
 
 	dmaengine_unmap_put(unmap);
 



