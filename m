Return-Path: <stable+bounces-51474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA9907019
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DB228960D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BA8145A05;
	Thu, 13 Jun 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hJb3eAat"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171C145B08;
	Thu, 13 Jun 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281404; cv=none; b=O+wb1WkIwpQYgfxh33zQi9WcQ6VKgurA1OzC0niQBoF3yJh21WYT9FrZN8RxABYEpvzYYCwN3Wu20fw7OJm9Os+OiK//qUQhMeg/pPUozAxo4tTkbWNtz8A8v/A655qJ1S3s6vZjcB8kDOHp2k/+j0VoK+BzBp+ResWHKi5eopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281404; c=relaxed/simple;
	bh=6lZ+9BDQRzGWVsa+b4COvKQMZJDoCqLArsq2geuGNbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q92xwWlXgomRytq4ml98hpSyIegCkt83jcO3LaLzhaAKDYt1vV8ItZSGK8TzHqj5WrhlnvtNRy1tSxckwxWzqpP0yAqZ0igdBWBlJFL85pIjglGrEEDW4yqmxC93QrQVVerdnPBu3Fc0RfIVkK+JQmCej2m5+J1oPK+kWJXJ5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hJb3eAat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA50C2BBFC;
	Thu, 13 Jun 2024 12:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281404;
	bh=6lZ+9BDQRzGWVsa+b4COvKQMZJDoCqLArsq2geuGNbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJb3eAattRPcItMvaOd1yko+ruzNBfzPaX5ObPsgRrP1kJ0SzItGkviTIgxI9HnNE
	 HDQqRsfvOIH2uvhKHPOaL7uHGKBaFRRqAWOXCpRUeecLpxlwbEfjw5uouewKwDKQc9
	 T2sLVYnjNKajT4BGz6YusG/65kk38eSw1X8KE8Wo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 244/317] nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()
Date: Thu, 13 Jun 2024 13:34:22 +0200
Message-ID: <20240613113256.989312161@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryosuke Yasuoka <ryasuoka@redhat.com>

[ Upstream commit 6671e352497ca4bb07a96c48e03907065ff77d8a ]

When nci_rx_work() receives a zero-length payload packet, it should not
discard the packet and exit the loop. Instead, it should continue
processing subsequent packets.

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240521153444.535399-1-ryasuoka@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index ada7f32d03e48..a7e6b8b272505 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1517,8 +1517,7 @@ static void nci_rx_work(struct work_struct *work)
 
 		if (!nci_valid_size(skb)) {
 			kfree_skb(skb);
-			kcov_remote_stop();
-			break;
+			continue;
 		}
 
 		/* Process frame */
-- 
2.43.0




