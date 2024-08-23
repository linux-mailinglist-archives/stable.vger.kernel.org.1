Return-Path: <stable+bounces-69973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5705595CEAA
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDE7B265BC
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4740B1898EE;
	Fri, 23 Aug 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx3eVsD3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9CC189539;
	Fri, 23 Aug 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421705; cv=none; b=FCVBqRD8NYp11SzUUIRfjTEYwj0YxZhibCUTscjJoKM6e1jAuzEd7QCfExR/8JxE3iIslL/Ft0k2aC+MsZALgpn/oGGMORwM+bxzRJauSISnRs3ucvIRwbk95nDwCEkhEEBUJV73tYKkuMXjEz38xA5Jtc+8M+OQ/iamFFQVQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421705; c=relaxed/simple;
	bh=A+8IDrqHLvCaio1WlnaM+9dxm61MWuaWKW5yzW0PJQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fX+Nq7w5Bc4aaqsww4RFU+QLoChtyHmg8Lwcg4Pq+oXJ1otLpunUqAERR2kVgDVfJmS8tWKKwVpWuCPgj+nf41fxqRXOOmgf7k73vXQYBPrqrYJf5eCS7BoU1aaHV91FfKXcvYgLmzfidPR8AKjyQpH3I/X3Biqsu4nmGkmSwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx3eVsD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94409C32786;
	Fri, 23 Aug 2024 14:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421704;
	bh=A+8IDrqHLvCaio1WlnaM+9dxm61MWuaWKW5yzW0PJQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mx3eVsD3KqBU7H8cv6lLDAxb2SK+FfRCCX5hE6z7PD3a1MyXWYJtBfh4kZzpTxhH9
	 xcHtnVf6q8h/SPKUvm3IksprLSAszyjGH6r6LumAcegajRYizv6Bw3KLjKKuAcY8xi
	 ctnzkYlsVUtmZzvqY1HRp3e1YyrYlpWOMksZgvwH0iRGpUa7/XdqqyVaRHtjFSlQ/x
	 4VucM0aXkpLwVHpwP6q/PmtRH2ab8n851Q4NnZlxvGhQa+hWyPCPS22vsF7vH2qPCC
	 4mME4sLKE3kTF7lcUauZPuE8PxCH6yoo+VM8T5H+x+oYALm7i5iE7MpmuB/PgSgvZ0
	 ZkdFcOBZqEqVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Foster Snowhill <forst@pen.gy>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oneukum@suse.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 06/24] usbnet: ipheth: drop RX URBs with no payload
Date: Fri, 23 Aug 2024 10:00:28 -0400
Message-ID: <20240823140121.1974012-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: Foster Snowhill <forst@pen.gy>

[ Upstream commit 94d7eeb6c0ef0310992944f0d0296929816a2cb0 ]

On iPhone 15 Pro Max one can observe periodic URBs with no payload
on the "bulk in" (RX) endpoint. These don't seem to do anything
meaningful. Reproduced on iOS 17.5.1 and 17.6.

This behaviour isn't observed on iPhone 11 on the same iOS version. The
nature of these zero-length URBs is so far unknown.

Drop RX URBs with no payload.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ipheth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 017255615508f..f04c7bf796654 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -286,6 +286,12 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 		return;
 	}
 
+	/* iPhone may periodically send URBs with no payload
+	 * on the "bulk in" endpoint. It is safe to ignore them.
+	 */
+	if (urb->actual_length == 0)
+		goto rx_submit;
+
 	/* RX URBs starting with 0x00 0x01 do not encapsulate Ethernet frames,
 	 * but rather are control frames. Their purpose is not documented, and
 	 * they don't affect driver functionality, okay to drop them.
-- 
2.43.0


