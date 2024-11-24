Return-Path: <stable+bounces-95266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6E39D74BB
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6547B28AB63
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33D246541;
	Sun, 24 Nov 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVbk4SrM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A091E573A;
	Sun, 24 Nov 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456522; cv=none; b=Id6VGih0DV6e9Da5CRGvp1kisO0cvzFr9UIcymYqUFFDClT1zLpoLFK16+JwW3QI7mLsqQkn0tgu2yJ6cD7iW1q3ZZXeqttpGJbSh/nc1I7hZH2BxzI9965rdJUtHecfbuvLQsGU/kUmpCdFLio5xl7bwbJpUfY3J/kkBdcwhWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456522; c=relaxed/simple;
	bh=0lhnnWOAg8PPnct0Flrtv8sPMcbv3pyFaTo4yaof1g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq9N9qOhd31yl4fe1DkEaEzbr3WtxV+VSAn3h/Yy4FW9T00dgCD3OjbSzXBZzDzvde9hNNtuF15sN0wNJWzVJnUgp9YJj0q05m4LFMrLLxs5V4aY/uYLa3lsWdIYGKhM9KrXhGGfKbNJlEmpyrsEJUK0RJC9wgRcxP/tcL506EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVbk4SrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833F4C4CED6;
	Sun, 24 Nov 2024 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456521;
	bh=0lhnnWOAg8PPnct0Flrtv8sPMcbv3pyFaTo4yaof1g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVbk4SrM+rcJEay27ucYh9pntpIBguGhIrIhs0DeE+r8wJsGwry4+8cZcLq1kFQuV
	 1LEz6EqSj/Nt+rp63IonmnmI12OYqNmgNjNuVu91JbqMa8XJ6MAODQgw3J5chxmk66
	 495yqmQPq4IT8KQvb/ir58ExranO4RJHgy5NoA9NquWXe25zXsOCJIgYE/xyeJZtjk
	 h6/dgM+vZLMtT/2+mZ21BVsgTCjAE0LRs4KpBJ8TKt+YLOvCN5MvFoWLc5NlvMMqfQ
	 IdPUbBVIooe4LRHYFI29cEaBs8JzzfQH0uKa1NpjykJbfGBaCl0eFrl8n4T2buGpTw
	 xm5RpLToXPqMw==
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
Subject: [PATCH AUTOSEL 5.10 31/33] rocker: fix link status detection in rocker_carrier_init()
Date: Sun, 24 Nov 2024 08:53:43 -0500
Message-ID: <20241124135410.3349976-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index dd0bc7f0aaeee..ec90f75289dbe 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2542,7 +2542,7 @@ static void rocker_carrier_init(const struct rocker_port *rocker_port)
 	u64 link_status = rocker_read64(rocker, PORT_PHYS_LINK_STATUS);
 	bool link_up;
 
-	link_up = link_status & (1 << rocker_port->pport);
+	link_up = link_status & (1ULL << rocker_port->pport);
 	if (link_up)
 		netif_carrier_on(rocker_port->dev);
 	else
-- 
2.43.0


