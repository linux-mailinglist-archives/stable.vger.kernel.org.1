Return-Path: <stable+bounces-59789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC720932BC2
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD481C21991
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BE619AD93;
	Tue, 16 Jul 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HKqbBbUv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92319B59C;
	Tue, 16 Jul 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144913; cv=none; b=J/YZIRxh5+IFSpfPNbMb2DuJPK7CurYG7UMNVGPEaqoMzfdUuSimu7UZIqAKQwXUUYQCIvnWkc6Os1s9eeqIvtMfnvLWYK6nAFUDui20YD/Zgf+c18d/60F3Sae1ylyOGXJB3rJTek0iCoE7bLo1cyc0IOO/DFgmW/pcYqN5T+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144913; c=relaxed/simple;
	bh=7K61HglfsTfW6EOSN68GEYtIuxU39UbmA/+gnic0KBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abd6P/Cxf/rinRCH73ccWmWSt28KMGUvww9TFZpUn1ZKVGUniqFrqsAn/cKRo3etCC4K9w5WyhSC6wVbrbF51PnaWooBk3AMKmVF/n+cfyXwZz1p+h+qD6gAiiC98/GZnMSVIXCwF05CTzwZqDvOShHmlkkmkUjHA0cifJGt+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HKqbBbUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A9AC116B1;
	Tue, 16 Jul 2024 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144913;
	bh=7K61HglfsTfW6EOSN68GEYtIuxU39UbmA/+gnic0KBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HKqbBbUvpCIKMY7ckdJkxr6q1WzptrEW00xcS+g9hLcSmkb6rh8kFfBlttXRMAtvC
	 ntRZs29sVT0LuaBuGWvBFO0ayRlpJRIJ9hCglD/PHpVUZCQ4J+MpCA+Nw4JBDSUo68
	 xTQXWdW9el3PLEY6qmzxn8+JvYJzdvdgj42pe7c0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+ec0723ba9605678b14bf@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 038/143] ppp: reject claimed-as-LCP but actually malformed packets
Date: Tue, 16 Jul 2024 17:30:34 +0200
Message-ID: <20240716152757.452863167@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit f2aeb7306a898e1cbd03963d376f4b6656ca2b55 ]

Since 'ppp_async_encode()' assumes valid LCP packets (with code
from 1 to 7 inclusive), add 'ppp_check_packet()' to ensure that
LCP packet has an actual body beyond PPP_LCP header bytes, and
reject claimed-as-LCP but actually malformed data otherwise.

Reported-by: syzbot+ec0723ba9605678b14bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ec0723ba9605678b14bf
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/ppp_generic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index fe380fe196e7b..996dee54d751d 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -70,6 +70,7 @@
 #define MPHDRLEN_SSN	4	/* ditto with short sequence numbers */
 
 #define PPP_PROTO_LEN	2
+#define PPP_LCP_HDRLEN	4
 
 /*
  * An instance of /dev/ppp can be associated with either a ppp
@@ -493,6 +494,15 @@ static ssize_t ppp_read(struct file *file, char __user *buf,
 	return ret;
 }
 
+static bool ppp_check_packet(struct sk_buff *skb, size_t count)
+{
+	/* LCP packets must include LCP header which 4 bytes long:
+	 * 1-byte code, 1-byte identifier, and 2-byte length.
+	 */
+	return get_unaligned_be16(skb->data) != PPP_LCP ||
+		count >= PPP_PROTO_LEN + PPP_LCP_HDRLEN;
+}
+
 static ssize_t ppp_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -515,6 +525,11 @@ static ssize_t ppp_write(struct file *file, const char __user *buf,
 		kfree_skb(skb);
 		goto out;
 	}
+	ret = -EINVAL;
+	if (unlikely(!ppp_check_packet(skb, count))) {
+		kfree_skb(skb);
+		goto out;
+	}
 
 	switch (pf->kind) {
 	case INTERFACE:
-- 
2.43.0




