Return-Path: <stable+bounces-43864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867788C4FF2
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F171C20B19
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A1C5025A;
	Tue, 14 May 2024 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b65beGx/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5C4F1F8;
	Tue, 14 May 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682755; cv=none; b=llW2YrdqkT8oM/iFV50ZZt5KfkXNeKptpzu6WZp5wvNIj5chYZ5HaW8O8RI317YdP00nWsl2demVLFGx1uce4ECwfCSkExD7nvf3l+oxsiUUEmdVtD3603MJxXXRGDgPUAbVAVepl2Kfyy2apfcV5fMYwyRnFMTENGAJeJvASyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682755; c=relaxed/simple;
	bh=CZB3SOiZRwIMrhsM4AP8ppPpZxL+IvIaxRkOWZG+t6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT6LLUZ5PTGH5FSFev04riFa5yC+9kECrZacfoXgBtNfq16hl2qosY8Xag+g7csNt1EBJT2A19acDuTmbABhSqF/J5LWp2RfkAPThmRIsYsrkxitoMO49Oesq++R4byH70Gm2U/H6UFd3nI1FdnhUDtsQ7DoQhVns9KRP4R1ZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b65beGx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13C0C2BD10;
	Tue, 14 May 2024 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682755;
	bh=CZB3SOiZRwIMrhsM4AP8ppPpZxL+IvIaxRkOWZG+t6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b65beGx/Lr0FSDizT0UAWCms7CW7Ans8qRRR0+5eLUaUBwHVAgWb9L6hDWjbEZgNs
	 dcEpbaigX+uE1z8wr5D23BKVRXieIJPNS0LwDEsAlJLKJddbpBs7NGNxrQfnd8VO4K
	 cTwhglLlIHwVVsijHxaa8fDbyXV/mnHkJl1xtNkc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tung Nguyen <tung.q.nguyen@dektech.com.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 077/336] tipc: fix a possible memleak in tipc_buf_append
Date: Tue, 14 May 2024 12:14:41 +0200
Message-ID: <20240514101041.512770903@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 97bf6f81b29a8efaf5d0983251a7450e5794370d ]

__skb_linearize() doesn't free the skb when it fails, so move
'*buf = NULL' after __skb_linearize(), so that the skb can be
freed on the err path.

Fixes: b7df21cf1b79 ("tipc: skb_linearize the head skb when reassembling msgs")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Link: https://lore.kernel.org/r/90710748c29a1521efac4f75ea01b3b7e61414cf.1714485818.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 5c9fd4791c4ba..c52ab423082cd 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -142,9 +142,9 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 	if (fragid == FIRST_FRAGMENT) {
 		if (unlikely(head))
 			goto err;
-		*buf = NULL;
 		if (skb_has_frag_list(frag) && __skb_linearize(frag))
 			goto err;
+		*buf = NULL;
 		frag = skb_unshare(frag, GFP_ATOMIC);
 		if (unlikely(!frag))
 			goto err;
-- 
2.43.0




