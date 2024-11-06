Return-Path: <stable+bounces-90192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F19BE71E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0981C21E48
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA21DF726;
	Wed,  6 Nov 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="utNiAe6V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09A1DF736;
	Wed,  6 Nov 2024 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895042; cv=none; b=scWRhrXrZOKg4jwE8tGAuK/0f11HtOsvG+30Ix0YW8Sj/WJbddZFz80giXVo1q+WwnG37LvLAp9i93MZjvI0L7SPU/ayjJ7Z0gvCO+RNbVyqnTE78X8FRgzRjEtv4PR4ATn+Kvm0jwpMbcP+2UXN5eYMnauzYxgc0d2fDtll1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895042; c=relaxed/simple;
	bh=nOO3PPquZn8DFu7hczGG9veslLFK64yBSe8IpHgsv/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bl9KJPbW5d2DwoQHsI/J8ZcWfmg9G0DzIwWz3c9i9xRdFTVPuhndYDwhxcdQl+VECmRbVhrvOvjFy8noqsyd5UAJqhbTNpnxkTdte+df8TkZRe76kbqEW6zipK0dywbJrr9Xrp7d5l3fsOpwx7XSbazI9TWAKc/xa7CxjHj671o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=utNiAe6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76028C4CECD;
	Wed,  6 Nov 2024 12:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895041;
	bh=nOO3PPquZn8DFu7hczGG9veslLFK64yBSe8IpHgsv/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utNiAe6VwvDNs0tTUUjVo/qFprpbbqKfOB7ALmT3OqkahEY/CGw1KGk7H4xvD3uUx
	 s2CY4TWhp2wrdUvhZhvhxrg89ZBgPS7mfvTCWgUvYx/+Bw94ANEmcF3LwZtKZy0u3b
	 jys6qu1IeQ3podgX7EldBgTRfOJ8NXeU0iFiQFZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junlin Li <make24@iscas.ac.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 084/350] drivers: media: dvb-frontends/rtl2830: fix an out-of-bounds write error
Date: Wed,  6 Nov 2024 13:00:12 +0100
Message-ID: <20241106120322.970716623@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junlin Li <make24@iscas.ac.cn>

[ Upstream commit 46d7ebfe6a75a454a5fa28604f0ef1491f9d8d14 ]

Ensure index in rtl2830_pid_filter does not exceed 31 to prevent
out-of-bounds access.

dev->filters is a 32-bit value, so set_bit and clear_bit functions should
only operate on indices from 0 to 31. If index is 32, it will attempt to
access a non-existent 33rd bit, leading to out-of-bounds access.
Change the boundary check from index > 32 to index >= 32 to resolve this
issue.

Fixes: df70ddad81b4 ("[media] rtl2830: implement PID filter")
Signed-off-by: Junlin Li <make24@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/rtl2830.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/rtl2830.c b/drivers/media/dvb-frontends/rtl2830.c
index c0659568471b8..8cda25902d63a 100644
--- a/drivers/media/dvb-frontends/rtl2830.c
+++ b/drivers/media/dvb-frontends/rtl2830.c
@@ -619,7 +619,7 @@ static int rtl2830_pid_filter(struct dvb_frontend *fe, u8 index, u16 pid, int on
 		index, pid, onoff);
 
 	/* skip invalid PIDs (0x2000) */
-	if (pid > 0x1fff || index > 32)
+	if (pid > 0x1fff || index >= 32)
 		return 0;
 
 	if (onoff)
-- 
2.43.0




