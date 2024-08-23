Return-Path: <stable+bounces-69996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F0095CEF8
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB031F28566
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076F194C91;
	Fri, 23 Aug 2024 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulhLl+f6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89F194C75;
	Fri, 23 Aug 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421803; cv=none; b=Pf3C8okI1d7+pXlbcut2yvWDJwGuixlnU9CKqc0y7aUHNLMAvR9DBvFmdbhlHRKyOOc9rpN9BSurrqkteSfCheDRsVPek5uRShJjnkTIUDFdDCco3cXLCMUzLI7E31luaWQoVpAvaIGt6/I3E6ePeCYYh0bhFQ2CbDCzHxB7M94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421803; c=relaxed/simple;
	bh=A+8IDrqHLvCaio1WlnaM+9dxm61MWuaWKW5yzW0PJQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHYu/P328O8gbx9CV3uhr+yNUKJfhHmB8pER8s5Gr2q2oAnZ4xaTFCEdzj1ZtFLu41SJuzuTgXN6aDmY6QBdyhJNkOwM/lqNclpxnTgKBUvwE9L88GUZXTpcEO739N739SQpN6zUEryTo8ciYRqQw/9Ih6NUpot7TN1++w5nqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulhLl+f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661BFC4AF09;
	Fri, 23 Aug 2024 14:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421803;
	bh=A+8IDrqHLvCaio1WlnaM+9dxm61MWuaWKW5yzW0PJQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulhLl+f6fuLkXhFQB4zC+4WBDJbuG6q1k8SEzEFms6HQLR9iRwcLWi1r7gRsoajPn
	 uLvv9iOTla1ALml+ah75Ed9nbEnwj+ExmAISPDCVBfv/WXI1AhkCEuBxKUP+sRYK7n
	 7rSP8792HH15NZk8M172WVlJzyyjRWUwYjAJ7L2paww9uWBfehnp0eFi7ZJtGzKExL
	 tWk1FM8hrhZk1U4e6uRkRUHbGcr+h8Giu+5uhhCG41yh10NlWptpcI6IA24iatm3vu
	 r400RE8iwM1LUQfCv/wy4HDJ8wT4R7Pw8eLWq80/x27knxVhqo77XRpbT8ObKWiHdq
	 z9HXZgfkX6JEA==
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
Subject: [PATCH AUTOSEL 6.6 05/20] usbnet: ipheth: drop RX URBs with no payload
Date: Fri, 23 Aug 2024 10:02:19 -0400
Message-ID: <20240823140309.1974696-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
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


