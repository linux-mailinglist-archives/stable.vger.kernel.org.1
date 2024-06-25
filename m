Return-Path: <stable+bounces-55482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F3F9163C6
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D406328C38A
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7295149C69;
	Tue, 25 Jun 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mC+3QGhp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A941494AF;
	Tue, 25 Jun 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309033; cv=none; b=s39vCPBSNEzlkrKksJb7EVfi2/zdwJykGpuZr2np37iLsuGRK/jELj4uTYlEtUDj8bwRsxa/lU/d/AguRGx2YXTEm7sV8dXJn7FKZuBvAmxbWgxqwA3Z7RPhLvMaBUX89uM8VtMfwlgHzsJvotB3gJ8fFpZYo91DOnjzztwDFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309033; c=relaxed/simple;
	bh=QTMCK8bMpmpImPgOlkyjx1lkPXGn+xzLFjPfN60xSqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGqqxF/4+iLECHepzBjYkcPEXdGmRsD2rIHDs8xooAs77CMsj6YfdzM4mc+Nr2KoUqSL1M29du/5LClwf/X0X1LD0di7YSqgUwPLRLIhXT4TLTBZY8Chseh3rAQPrOWS8fk3C1kbc9nSd/NljhL1LNT6nltZXB19s6JsQG5wN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mC+3QGhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26519C32781;
	Tue, 25 Jun 2024 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309033;
	bh=QTMCK8bMpmpImPgOlkyjx1lkPXGn+xzLFjPfN60xSqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mC+3QGhpoggdmq6/EAwI033Nuf/CDqRxVq6XMwWKa5PEDSXSSYtvCv9J8StqscMuh
	 RNz2LUU1UaY8ufHhrYZICl7EOmfs938gUmWp5ZCkHvf/u6klH5NVVoMl+AuNKDVFos
	 7W8MP4sij/I2fR4kuGqXyZhbWQSlkOFk5nhSnQwg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 072/192] net: mvpp2: use slab_build_skb for oversized frames
Date: Tue, 25 Jun 2024 11:32:24 +0200
Message-ID: <20240625085539.940047558@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>

[ Upstream commit 4467c09bc7a66a17ffd84d6262d48279b26106ea ]

Setting frag_size to 0 to indicate kmalloc has been deprecated,
use slab_build_skb directly.

Fixes: ce098da1497c ("skbuff: Introduce slab_build_skb()")
Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20240613024900.3842238-1-aryan.srivastava@alliedtelesis.co.nz
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index aca17082b9eca..05f4aa11b95c3 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4001,7 +4001,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			}
 		}
 
-		skb = build_skb(data, frag_size);
+		if (frag_size)
+			skb = build_skb(data, frag_size);
+		else
+			skb = slab_build_skb(data);
 		if (!skb) {
 			netdev_warn(port->dev, "skb build failed\n");
 			goto err_drop_frame;
-- 
2.43.0




