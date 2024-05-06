Return-Path: <stable+bounces-43157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ADA8BD6CF
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 23:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2E81C2152A
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 21:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD13F15B54C;
	Mon,  6 May 2024 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="B2ejlLLr"
X-Original-To: stable@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177015B553
	for <stable@vger.kernel.org>; Mon,  6 May 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030758; cv=none; b=Z1OLKKLFmKYgwNR2+tvN3l4t0VnLW1fCmyiRQBPU4EY9q1dwjvBGXyXYh+BdXh/+cC5JED1dKplgwqpgzolvcMY3Ii9MECbwjKT+gWZd16EgKoRI7yWVCwYZnsIvVUDoJHiIJN3jig64xIBJ9qNOwcCwlSER8a+bGpV2Wu0zSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030758; c=relaxed/simple;
	bh=ep6r33EM0/AijhB4Ad0efd2EEmnJEsFmPvvx/kmeG4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFISrMatUbuB9rzYxGWmwCA79Cw/9bMvpskPyhobiklCedze2ASwr0A2cgxReTq4NhtIR3rjx/ldTK+Wnq4+prayHN8oZfvmmI3l1Wb9wBIa7TkTUxSKowBxUTnv80YqhD+Ekdl7MbSF/yTisr0KCq+9Xxqxu/p8IF07xVRmE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=B2ejlLLr; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8A993600A9;
	Mon,  6 May 2024 21:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715030753;
	bh=ep6r33EM0/AijhB4Ad0efd2EEmnJEsFmPvvx/kmeG4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2ejlLLrfpu5qQxjXxvxVZsFuxomjRqVee1Kav49UBuNlmv1l+yBnzEnGHTKyG8aG
	 G7LSUWpKWdDKogWQnjJMx7gSECPsfe+/FM9jffCQqyXfFKPmSZExbjL9QJmUN41B6y
	 609CQOvkg6xLBXwIurMzGtjE5pPdV0A9YJYeJE37ABLpPLLUqewI+IQGuo03qpeNC5
	 KJLZb9WseTs3Yy8/g9+1ZI59h4GQKJZFykHfvjxLjCMyX5QmA3899PPIyNypf46AZw
	 zmqbnA1I14FZtBeCq531t6bolIRd3QoATxh3v2dRQRS0k1qbtGLw41CmCQF2el68vU
	 M4WC07LjUzk3Q==
Received: by x201s (Postfix, from userid 1000)
	id C529D203509; Mon, 06 May 2024 21:25:35 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.4.y 2/2] net: qede: use return from qede_parse_flow_attr() for flower
Date: Mon,  6 May 2024 21:24:23 +0000
Message-ID: <20240506212423.1520562-3-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506212423.1520562-1-ast@fiberby.net>
References: <20240506212423.1520562-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit fcee2065a178f78be6fd516302830378b17dba3d ]

In qede_add_tc_flower_fltr(), when calling
qede_parse_flow_attr() then the return code
was only used for a non-zero check, and then
-EINVAL was returned.

qede_parse_flow_attr() can currently fail with:
* -EINVAL
* -EOPNOTSUPP
* -EPROTONOSUPPORT

This patch changes the code to use the actual
return code, not just return -EINVAL.

The blaimed commit introduced these functions.

Only compile tested.

Fixes: 2ce9c93eaca6 ("qede: Ingress tc flower offload (drop action) support.")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 69d9b4a32c56..304bdc92bab4 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1960,10 +1960,9 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse flower attribute and prepare filter */
-	if (qede_parse_flow_attr(edev, proto, f->rule, &t)) {
-		rc = -EINVAL;
+	rc = qede_parse_flow_attr(edev, proto, f->rule, &t);
+	if (rc)
 		goto unlock;
-	}
 
 	/* Validate profile mode and number of filters */
 	if ((edev->arfs->filter_count && edev->arfs->mode != t.mode) ||
-- 
2.43.0


