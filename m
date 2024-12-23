Return-Path: <stable+bounces-105913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27129FB247
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1805C1634EE
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A821B4145;
	Mon, 23 Dec 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LMfHCsiW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236671B4141;
	Mon, 23 Dec 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970563; cv=none; b=Ra0EN1laMvoVT91sGldhColkLWl73A+urNppe+7lxJgzsg6nXXhAmoTc3KnNvrwZSY4vVs3YVhypfMq0Jj2ZC4YSIB5z0DHzNNriPTQDG631Yunw9FmTrDhrDxwvDgTT2ByuA7K3yU4PPvWdUTdfuUyrmvOb7Yac8y+87Y9IxzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970563; c=relaxed/simple;
	bh=Nr58av+NLc2y0umSTW81rQ3r3tY+Zaru0spBWEcQ4wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaeHL82niB/IArEfRogahn5/DUhmp137/NCa+2bWzlA5S0xJgFBfI0hx7T33UWRQ4+6mjmUznHdGJFuzzolwxiDLQlW3/0ljC9WWQ5OJoigz0W8kxoJyK/spON67DnoNibf8DvswngU6NbTQwQqxaMXV9fDK8WY6SJY3t8kSgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LMfHCsiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89040C4CED3;
	Mon, 23 Dec 2024 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970563;
	bh=Nr58av+NLc2y0umSTW81rQ3r3tY+Zaru0spBWEcQ4wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMfHCsiWvdjs68WTZptcbAsJjGzOSdo1xFicHSy796fycS5TcmHKY5S8P1HbMoH5P
	 QbQwoBc2qnjZxFQlFXYwidgM2RtZFSLHKWm5Kung+Y99AzyOogdINlY+hwdtxqtLie
	 wUrT7ExlN0jxtmSHELJmzX97Ug5+j8LZ/LwhWyM8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.6 101/116] of/irq: Fix using uninitialized variable @addr_len in API of_irq_parse_one()
Date: Mon, 23 Dec 2024 16:59:31 +0100
Message-ID: <20241223155403.485400993@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
References: <20241223155359.534468176@linuxfoundation.org>
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

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit 0f7ca6f69354e0c3923bbc28c92d0ecab4d50a3e upstream.

of_irq_parse_one() may use uninitialized variable @addr_len as shown below:

// @addr_len is uninitialized
int addr_len;

// This operation does not touch @addr_len if it fails.
addr = of_get_property(device, "reg", &addr_len);

// Use uninitialized @addr_len if the operation fails.
if (addr_len > sizeof(addr_buf))
	addr_len = sizeof(addr_buf);

// Check the operation result here.
if (addr)
	memcpy(addr_buf, addr, addr_len);

Fix by initializing @addr_len before the operation.

Fixes: b739dffa5d57 ("of/irq: Prevent device address out-of-bounds read in interrupt map walk")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20241209-of_irq_fix-v1-4-782f1419c8a1@quicinc.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/irq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -355,6 +355,7 @@ int of_irq_parse_one(struct device_node
 		return of_irq_parse_oldworld(device, index, out_irq);
 
 	/* Get the reg property (if any) */
+	addr_len = 0;
 	addr = of_get_property(device, "reg", &addr_len);
 
 	/* Prevent out-of-bounds read in case of longer interrupt parent address size */



