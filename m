Return-Path: <stable+bounces-140425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9DAAA8C1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB009A1061
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5713507CD;
	Mon,  5 May 2025 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUpx4Zey"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA63507C1;
	Mon,  5 May 2025 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484827; cv=none; b=Y5N+VB2+q1G0HydJXG/2yMENEFs0AktrGz1XFQR3sBCg2j9W5j646LsIh0UJldz5JIIAEp0Ut+uadGjXU72v1dg9+IO0t+7NP+LHcocy2+IIDealYU+fs7mF1HGLhKgZkUtuxPpYNEb1x92a7VaPP/gW3pmSw4OCLHyvsEC37V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484827; c=relaxed/simple;
	bh=OGW0F4QvS8DbYbXpN3qy/YT541L7GWQwrrihldaHDOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ipegFHvWc7yEFiDgO5ZDNEeojC7eq3149hieIc7vjlFVJwg87z6mweqxhBPyxlsGB1OroQHXk48NPue9uq+KHbDE8y3w9SvqwOQ957HJUGzuD2e/4kP/sEBbiniP9XhxZD7ZIFYlTonNoyQTz5NCDTsKZodFhXobqN+VKuFU+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUpx4Zey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CA2C4CEE4;
	Mon,  5 May 2025 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484827;
	bh=OGW0F4QvS8DbYbXpN3qy/YT541L7GWQwrrihldaHDOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUpx4ZeyQ95nMw2FaWtVp4h4LWVkAhzISsL5bi+7dt505U7H7ek6WD+E7TdmYMA6Q
	 QEm9bnkV6UO5MF4HaBNRuOFItORm/xS0eelyq7nAKEydDxOIpUfGdrZIa3pXUaJZPR
	 Z1sfII+D5w6DksypIPFCckt9WgUn/NtPLb1R9Jn5t4mmHNeLMBQzHeow4MDw+lcmdH
	 cbLxNvQqpF/5/+EwbC56tp1KlEl7tLzeeDdBO5VQtxMGm9REv91pwvtohTcwvU2a3J
	 f5pY+WmgjsrQM2TFceXiUE1sWRHMzPo7dTLKf3kxRZnusBoQMVFIbkxHuTn4cFE5Cf
	 5/I3zclgZ3MnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Hsu <d486250@gmail.com>,
	Daniel Hsu <Daniel-Hsu@quantatw.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 034/486] mctp: Fix incorrect tx flow invalidation condition in mctp-i2c
Date: Mon,  5 May 2025 18:31:50 -0400
Message-Id: <20250505223922.2682012-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Daniel Hsu <d486250@gmail.com>

[ Upstream commit 70facbf978ac90c6da17a3de2a8dd111b06f1bac ]

Previously, the condition for invalidating the tx flow in
mctp_i2c_invalidate_tx_flow() checked if `rc` was nonzero.
However, this could incorrectly trigger the invalidation
even when `rc > 0` was returned as a success status.

This patch updates the condition to explicitly check for `rc < 0`,
ensuring that only error cases trigger the invalidation.

Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>
Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mctp/mctp-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 6622de48fc9e7..503a9174321c6 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -538,7 +538,7 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 		rc = __i2c_transfer(midev->adapter, &msg, 1);
 
 		/* on tx errors, the flow can no longer be considered valid */
-		if (rc)
+		if (rc < 0)
 			mctp_i2c_invalidate_tx_flow(midev, skb);
 
 		break;
-- 
2.39.5


