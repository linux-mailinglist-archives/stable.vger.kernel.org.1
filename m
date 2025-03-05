Return-Path: <stable+bounces-120732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD22A5081A
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90743175028
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEC71C863D;
	Wed,  5 Mar 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xn1DAfmq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66A250C1A;
	Wed,  5 Mar 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197812; cv=none; b=OG6r1l7nwDOg91jEb3xT/2Yb+9xKCFGyYmnvsCu5L9D/DBfhlJnCQQuT8LDgRP0nlC9ZWI551/yuVmyQqf1UtjezjanuxFXSkUrs7oXCmVf+loKRjXKxkIvqkdkTzJksJp5iOjf/jm6ZOH41bMk7vGeDduWdRt7WBj//7dxiTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197812; c=relaxed/simple;
	bh=YdGtm6z9w4LZnLhtrqXuRtdE+RKTERu5wQLCKBsFo10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5w+9oY4BdF+qc0kXri40qkKnqwXuFEXasCnjZHDIZ0cHL50nlauzUZ/yI4ljon5kJv/fr9Mc3QjHYgUjfMe8vvjSMtgEzY6LUcfO+/ODBJKIzZ5ZCA2DTEV6/SlA7YbY8pjGnx25NWVhathtdmJtI2Jt1bnTU/NJYtsVeR6a+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xn1DAfmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6538EC4CED1;
	Wed,  5 Mar 2025 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197811;
	bh=YdGtm6z9w4LZnLhtrqXuRtdE+RKTERu5wQLCKBsFo10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xn1DAfmq1am6L4w19AqUNzNYIjATYOyKPSurmLYtp2+Sj04VaGzt2G9ApYVWD+e8L
	 K8CfeubOlyQncibr/U+FzyZlR+U42PeHHlOdn0Aph13+P7AlJg/bgr43T3HSDOF31/
	 4+6hEPVx9QW7a/+S5k8DO/nP9IyHzpMqjUo0RER4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 077/142] net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()
Date: Wed,  5 Mar 2025 18:48:16 +0100
Message-ID: <20250305174503.430462744@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Fang <wei.fang@nxp.com>

commit 249df695c3ffe8c8d36d46c2580ce72410976f96 upstream.

There is an off-by-one issue for the err_chained_bd path, it will free
one more tx_swbd than expected. But there is no such issue for the
err_map_data path. To fix this off-by-one issue and make the two error
handling consistent, the increment of 'i' and 'count' remain in sync
and enetc_unwind_tx_frame() is called for error handling.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Cc: stable@vger.kernel.org
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Link: https://patch.msgid.link/20250224111251.1061098-9-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -590,8 +590,13 @@ static int enetc_map_tx_tso_buffs(struct
 			err = enetc_map_tx_tso_data(tx_ring, skb, tx_swbd, txbd,
 						    tso.data, size,
 						    size == data_len);
-			if (err)
+			if (err) {
+				if (i == 0)
+					i = tx_ring->bd_count;
+				i--;
+
 				goto err_map_data;
+			}
 
 			data_len -= size;
 			count++;
@@ -620,13 +625,7 @@ err_map_data:
 	dev_err(tx_ring->dev, "DMA map error");
 
 err_chained_bd:
-	do {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	} while (count--);
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }



