Return-Path: <stable+bounces-95149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9119D73B4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C672845E3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B412E22FBF9;
	Sun, 24 Nov 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev5aMOHK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97B22FBF8;
	Sun, 24 Nov 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456144; cv=none; b=KNBJplbjT2P6SyNbhgsY3ooDWZDi/90TU1kONIR3RDYKxKSCjNspvnG7bshxTzv5Gbzi6eVjM71ICj/dQxvSBsjZERrGcKMDImhC/HSNMUkLHKsIIbjfdWrvPd3vVMXWhHVzIJl1TtvZyBKg6cREQNsDv1FwgiSsjx4X67g7zz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456144; c=relaxed/simple;
	bh=fKFqPoYIBX7KqlaFGH/qVI1sKDFUgPkpK1kwpJXs4ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atRl7A74xNOyjfq9aX9C1w0BJqAe/LtYo2mf7WlBDQuNUYIsd9107JTilHdvtU2HWQ/zs8KpaQ5myGHuFdXTWOkA/SEGIKGd9JSzUrYSWlHJfsjdTbzW1mMxwu4em5pFSKu4CigBss/NFpk05WpHV4p7tpqBUWh7a5qMcpU37uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev5aMOHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE9EC4CED3;
	Sun, 24 Nov 2024 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456143;
	bh=fKFqPoYIBX7KqlaFGH/qVI1sKDFUgPkpK1kwpJXs4ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ev5aMOHK5vXuBTB/62rElTINccJnl2JT5r/GV6c1jnyaGvHqtlYVwFgC9W+WQnPvY
	 pVsVlQ4ZeVQDGllnUv/UUtuB+0swa7s+NR69+VDl6OLdxqEIP4+dOONF/d7JE4lEq9
	 SWY7N3op4j6q9iXx6Wfu3cGoZCeEAIIb9qg1GccExb5AMCUo8hthWwgscIqrZ63Axx
	 MV/I7yicUYZe5WTo+orys+xPiYWT60Kr7OM1woXANX2ecm0hYr4POXjeWqFI3qyVUz
	 pKcNx9QakbFeUqvrIwfG+AeGT7nGaKEy+0Up3H3FhdeQP77Hk/yEK/ca1uEwlzUeVn
	 JVTOWF0nyWguw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 59/61] rocker: fix link status detection in rocker_carrier_init()
Date: Sun, 24 Nov 2024 08:45:34 -0500
Message-ID: <20241124134637.3346391-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit e64285ff41bb7a934bd815bd38f31119be62ac37 ]

Since '1 << rocker_port->pport' may be undefined for port >= 32,
cast the left operand to 'unsigned long long' like it's done in
'rocker_port_set_enable()' above. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://patch.msgid.link/20241114151946.519047-1-dmantipov@yandex.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/rocker/rocker_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 9e59669a93dd3..2e2826c901fcc 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2504,7 +2504,7 @@ static void rocker_carrier_init(const struct rocker_port *rocker_port)
 	u64 link_status = rocker_read64(rocker, PORT_PHYS_LINK_STATUS);
 	bool link_up;
 
-	link_up = link_status & (1 << rocker_port->pport);
+	link_up = link_status & (1ULL << rocker_port->pport);
 	if (link_up)
 		netif_carrier_on(rocker_port->dev);
 	else
-- 
2.43.0


