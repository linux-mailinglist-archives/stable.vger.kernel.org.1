Return-Path: <stable+bounces-134445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A8BA92B15
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B3A1B6592A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC6F2517AF;
	Thu, 17 Apr 2025 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PbQwYBsk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC11E834D;
	Thu, 17 Apr 2025 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916147; cv=none; b=b4rvBEJZ/90gMTTsQlcz8TnW5/lT6uSBvMEgH/54fS0uxeDrmpUpmuhK77PxtLgd7+AM/ANIufLAiiED9NNUco42IJulguIkni2bpR9uaWaMC5ghP2imxAg8RBAilYBbJMk0QL12yqqrUcGx+yhHdyZu31HXketIj2MZicl7cwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916147; c=relaxed/simple;
	bh=2wCuIWZsi7BWt3+4fMSNaABqW90ncgbo+gAm2yEqHCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0xxqsIJigHMRx6XLzFh+rqlrcHZMw8nX468FusNHRSWJDB+nwReAjKj9os9tPyfGjCAVpLkRkahLv/kfK7shzfLSZmDRu/K+JwCEkmZiGxZccTa0Ma/mzzHKr5yik555DBgCMfIzubseLsgm/MJ6CWpU/QyBaHbtu+zumESu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PbQwYBsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2B5C4CEE4;
	Thu, 17 Apr 2025 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744916147;
	bh=2wCuIWZsi7BWt3+4fMSNaABqW90ncgbo+gAm2yEqHCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PbQwYBskxx1Yp15i+aF+TMI/AcQWJdKSRLM0h8hF7Se4k+KwTmiXjifmJ5C9sqDYM
	 EzMU9SDOakGX2oDTaeh9Rsw+QgTtETz4KRPNJSt3r/OKVQUE2bGr9zeCvUUyWEmpNC
	 oxIx0OCiYIXNrq9BTvg7dw6qgll34Lo3Jvtcr5Jk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.12 359/393] of/irq: Fix device node refcount leakages in of_irq_count()
Date: Thu, 17 Apr 2025 19:52:48 +0200
Message-ID: <20250417175122.037739385@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit bbf71f44aaf241d853759a71de7e7ebcdb89be3d upstream.

of_irq_count() invokes of_irq_parse_one() to count IRQs, and successful
invocation of the later will get device node @irq.np refcount, but the
former does not put the refcount before next iteration invocation, hence
causes device node refcount leakages.

Fix by putting @irq.np refcount before the next iteration invocation.

Fixes: 3da5278727a8 ("of/irq: Rework of_irq_count()")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20250209-of_irq_fix-v2-5-93e3a2659aa7@quicinc.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/irq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -508,8 +508,10 @@ int of_irq_count(struct device_node *dev
 	struct of_phandle_args irq;
 	int nr = 0;
 
-	while (of_irq_parse_one(dev, nr, &irq) == 0)
+	while (of_irq_parse_one(dev, nr, &irq) == 0) {
+		of_node_put(irq.np);
 		nr++;
+	}
 
 	return nr;
 }



