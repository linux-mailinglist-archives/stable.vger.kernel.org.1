Return-Path: <stable+bounces-199213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A46C9FFF4
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 268CB30194C7
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18E34107D;
	Wed,  3 Dec 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J87TWtMj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9C7338591;
	Wed,  3 Dec 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779062; cv=none; b=PQf0F1gm0gUN6uWvoEAznlvJstIiUSRNJfHKEtnYe8FRgD5bIA9D6r82yk6rcit5b4CPPTlW602JaCZjGIGbSRqpJC3eZTXCWhNsr3X9HSKJ79r5wStBgzXL29B3el52qtHQ8857SMhcm88XJNKmDe/lXZUSHPjuIvN5YVZBoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779062; c=relaxed/simple;
	bh=djtv5EF41Plgpc5kN5xM9VhOHjOqjMT6qQq8qB6kUKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Em/2BMhySOTFhY20iZuQV4S1z96dWjxyOv7Zh0gmZPKWnmZq+qw6uYuw2d9AZqqBtWoOEgQ1wIxQ6a7+vAjgZO2BlbRQ7hVUmsdVzOhIFb04S67pLvGsdjHRFTYMb3DCbX1BiqvnOsDtVjaNvp6ua8azz29SYV38JicMHcg2eQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J87TWtMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581ECC4CEF5;
	Wed,  3 Dec 2025 16:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764779061;
	bh=djtv5EF41Plgpc5kN5xM9VhOHjOqjMT6qQq8qB6kUKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J87TWtMj5ON+a4EvKdrFAbz/nJKYFfZuknXGKCOeMdKJFr1Kdra0Sz7Ym7CMhUHjA
	 AjLvjiRGfwWpf36SobTjA36YRqFYZ3lzM8qmrcfUt+Hh0UZERWnhAP9NUESisThi0/
	 Fpbu8WmAZg7iruC+OYL//qoIpcX+kPBhLXUOuvHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 110/568] tee: allow a driver to allocate a tee_device without a pool
Date: Wed,  3 Dec 2025 16:21:52 +0100
Message-ID: <20251203152444.764420849@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
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

From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

[ Upstream commit 6dbcd5a9ab6cb6644e7d728521da1c9035ec7235 ]

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index a9a893bc19fa4..a2feea6e16f38 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -889,7 +889,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);
-- 
2.51.0




