Return-Path: <stable+bounces-207306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31754D09B9B
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D608830B1BB8
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01133B6C6;
	Fri,  9 Jan 2026 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZpRlV3+L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26338FA3;
	Fri,  9 Jan 2026 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961680; cv=none; b=ux+3M8OW6X8w7N1pTa/PgOhSUr/WbdJh85vr0nJNvYs9U0SbC+TgB6r3jUtBMCCUt90/wxfFw6t3DLbh6T0qVK9NxqYdIQbc2oAjWF2Co5kt0rbJa0p5yqSIGGjI183cbc3d1ETsrp5DaLeI1VUsCkv6MveVUZh4zlhFsmWXF2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961680; c=relaxed/simple;
	bh=+chvDVFSV9ASrDopwP/Vo/ECarMFuwoFLSjaJ9bHj2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJ4wFPE2uIL7yZ9I4JmCYocWTUrWkvVsAaMI3ZNu28MR+BMVjSmT5ycr2CNEv8HrgwVnSdBm3VwXK0N2jsAoFG846bu7jQtTmnNPSsIp04NzGPYxSTrVNjlzAWlWYRZ7fJDip/G541wWgT85iSPy3JPEJ/bLybswuuZ6yF+bbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZpRlV3+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC934C4CEF1;
	Fri,  9 Jan 2026 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767961680;
	bh=+chvDVFSV9ASrDopwP/Vo/ECarMFuwoFLSjaJ9bHj2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpRlV3+LgZWfaJD8n76CdGpOO986+/Ti4W/lzPhKmygH808B8Ai+iOVY9GaJqFCba
	 sqEY9fvoCYkalN0a1rDt3563sT1FxgveN2FBy9PohH1gI0YkcbPjpqNQUpn26ZNkNz
	 lcVL5FZBrMVsc8ZDA4lXCn4eQsG7BJYmBiodreuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 097/634] RDMA/rtrs: server: Fix error handling in get_or_create_srv
Date: Fri,  9 Jan 2026 12:36:15 +0100
Message-ID: <20260109112121.083828920@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

[ Upstream commit a338d6e849ab31f32c08b4fcac11c0c72afbb150 ]

After device_initialize() is called, use put_device() to release the
device according to kernel device management rules. While direct
kfree() work in this case, using put_device() is more correct.

Found by code review.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Link: https://patch.msgid.link/20251110005158.13394-1-make24@iscas.ac.cn
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 8b3b9b798676b..51ec4620ca821 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1448,7 +1448,7 @@ static struct rtrs_srv_sess *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 	kfree(srv->chunks);
 
 err_free_srv:
-	kfree(srv);
+	put_device(&srv->dev);
 	return ERR_PTR(-ENOMEM);
 }
 
-- 
2.51.0




