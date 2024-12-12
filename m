Return-Path: <stable+bounces-102420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460279EF2A1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABADB17629C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D34B2358BA;
	Thu, 12 Dec 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zyHHCmP1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16C2210DB;
	Thu, 12 Dec 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021163; cv=none; b=OtgBV2cjE4d1J1tIMJtyZyeOS0mLkYfNw6TMaV1qRo6d6WTsgiI64wuCqZG/XChCnxJi0GPE3ZwexfxaxpWbSRvVTa5yKWzatpTGwPXQ9kgUoYlbkXm1qKfoBeTqS/FxxxRhUwHyJcXl+xbleRzveXveld3Jb8zli3fnmbTmrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021163; c=relaxed/simple;
	bh=+nUdeA8gIhlGFfX2tFaALBlDzbcShm6WNq4r/L+SX8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlOOs8nuIdqvuhIWPu//oQTo9ZJKpyQS+5q6OntEz/IsC5ggplf/zeL4fggGEP4QSY0yfcN5CBZf+yZEqQOqYa5zw7ME0jI2gcpIHzDccn5WKZys8hRnL0/tIwERFnTLprXbLJiOGjTPMyoOm5NgxOBleUoo9/V1riyPD7C4iBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zyHHCmP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D948C4CED0;
	Thu, 12 Dec 2024 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021163;
	bh=+nUdeA8gIhlGFfX2tFaALBlDzbcShm6WNq4r/L+SX8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zyHHCmP1e+i/zRBAMwchiYR821Zn0Sd0CWPHNDf2rjjraTqCOS+DLHZa8I8F5NpQz
	 uohWt/ZC+g+0gqnOBGvIrbjLhNUUIGkomX3sDDtnKRZc11lKBlGnXY7B2IOzY+P0HQ
	 OghBhskXjnj40l6Re5BVmFZ65uR1M5wZfJFiuoKs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 663/772] samples/bpf: Fix a resource leak
Date: Thu, 12 Dec 2024 16:00:08 +0100
Message-ID: <20241212144417.311475037@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhu Jun <zhujun2@cmss.chinamobile.com>

[ Upstream commit f3ef53174b23246fe9bc2bbc2542f3a3856fa1e2 ]

The opened file should be closed in show_sockopts(), otherwise resource
leak will occur that this problem was discovered by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241010014126.2573-1-zhujun2@cmss.chinamobile.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/test_cgrp2_sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_sock.c b/samples/bpf/test_cgrp2_sock.c
index a0811df888f45..8ca2a445ffa15 100644
--- a/samples/bpf/test_cgrp2_sock.c
+++ b/samples/bpf/test_cgrp2_sock.c
@@ -178,8 +178,10 @@ static int show_sockopts(int family)
 		return 1;
 	}
 
-	if (get_bind_to_device(sd, name, sizeof(name)) < 0)
+	if (get_bind_to_device(sd, name, sizeof(name)) < 0) {
+		close(sd);
 		return 1;
+	}
 
 	mark = get_somark(sd);
 	prio = get_priority(sd);
-- 
2.43.0




