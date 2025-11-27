Return-Path: <stable+bounces-197256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F100C8EFAF
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035C73B9C1B
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0529931281E;
	Thu, 27 Nov 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MjOdyJmW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435E299943;
	Thu, 27 Nov 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255235; cv=none; b=KUWclSCkD3wN/W7iwW5szlblHeEukIMN8TKA8DrNs2T1fsADbJhfFh9cj7rpWmNOQ9ReAoeqiL7WWOhuzhqk+bQ91zwxqJM9E3V0itbOnVctNj59POG9jrAjqp63ptf3yBsD2P78LToFxxz7NPtLTlGgyhF/r/GGUspPSNDEi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255235; c=relaxed/simple;
	bh=4740ZerBnfUc4Yd6rQRhxg5Yv+0GPv2A10jWKTDlJoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pybTqIStv8EteIuBBVVXHkL6cA/VcVRe6qJbt2gaBzdsYt/H10KO5THXPDaaoGrRDSqriO+JxeAEy/tP6YsR/V4bxfXMJJtKjGBBIrb8rByTlaQnM0DZLPlkBg3EbTVVnp049IOmwXlVWOfTuqOH0aanxXJ/6clRbVCKf9xXIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MjOdyJmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0214EC4CEF8;
	Thu, 27 Nov 2025 14:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255235;
	bh=4740ZerBnfUc4Yd6rQRhxg5Yv+0GPv2A10jWKTDlJoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MjOdyJmW4YgRBcOcyGs3SLvvpmSve+vWhT9gJJbmwWTSdcd/dtlOyq4r35NFfAizt
	 JMEHXLR2Y3BJhLKZFr/AKUFsgnHMiw8i9DpUEH+ZssjhCbGuP+9tJafSZ+fwl/b411
	 fbd0qdNCZR/RRXYT3LJBoMtPLq9fhxMgP7/0uDzA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 053/112] xfrm: drop SA reference in xfrm_state_update if dir doesnt match
Date: Thu, 27 Nov 2025 15:45:55 +0100
Message-ID: <20251127144034.783357615@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144032.705323598@linuxfoundation.org>
References: <20251127144032.705323598@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 8d2a2a49c30f67a480fa9ed25e08436a446f057e ]

We're not updating x1, but we still need to put() it.

Fixes: a4a87fa4e96c ("xfrm: Add Direction to the SA in or out")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_state.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1e2f5ecd63248..f8cb033f102ed 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2117,14 +2117,18 @@ int xfrm_state_update(struct xfrm_state *x)
 	}
 
 	if (x1->km.state == XFRM_STATE_ACQ) {
-		if (x->dir && x1->dir != x->dir)
+		if (x->dir && x1->dir != x->dir) {
+			to_put = x1;
 			goto out;
+		}
 
 		__xfrm_state_insert(x);
 		x = NULL;
 	} else {
-		if (x1->dir != x->dir)
+		if (x1->dir != x->dir) {
+			to_put = x1;
 			goto out;
+		}
 	}
 	err = 0;
 
-- 
2.51.0




