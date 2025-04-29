Return-Path: <stable+bounces-138289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BEDAA1752
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DD51B68317
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B976244664;
	Tue, 29 Apr 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ZB+94Dn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFBC148;
	Tue, 29 Apr 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948784; cv=none; b=LvO4OmBSsP3pgqOmXqSQvtKpXzcyyOJNe+VkgxjOLsaw6RXFGigUiJ106BSXsxkmBpj+owpcNzrHliT9g+L5PzCshx9nioEGoUpju8QZ+uf3xUg/LUEoR6B2JLyE9UaPQ61gbxMsOZM+GfkV2VvRSdeALmfGkE2hYSxGV4Yqgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948784; c=relaxed/simple;
	bh=sobehw6PRgpZaJQ3mDjGteE5AtcFVNAoYZR2ImoczBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCHMP1u33nPMkQBtwnwXpy6E4V5xVXVD04RBD1oobksqlvIK9UWTUWmzk0y98GNaVM2Py+EAMNf7HHJNoNXWZzGfdeoYW6vnPEmiGyz/tnAlz/TLX8grq/nkkLT9gLwHoh5siM9/mR23wbmvJRS+0UkC/ulKgvkb4vRbKypObSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ZB+94Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666C0C4CEE3;
	Tue, 29 Apr 2025 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948783;
	bh=sobehw6PRgpZaJQ3mDjGteE5AtcFVNAoYZR2ImoczBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2ZB+94DnKzimYn2likVz8cPXhXhZv4gm4Zb693LPDSU2Y8/8TR5IRJQ/kzWBweEum
	 H7UwTkSLb9RCRNjNO+Kwyfx5lql7Sk+yuaMQs7YWain5UvO3F/CtK4Lyhr6zkIidb2
	 H7j+bRgEJQhW47JACaaQpft6D/ACq0NQ5Ty0cRL4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 5.15 111/373] of/irq: Fix device node refcount leakages in of_irq_init()
Date: Tue, 29 Apr 2025 18:39:48 +0200
Message-ID: <20250429161127.736751486@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit 708124d9e6e7ac5ebf927830760679136b23fdf0 upstream.

of_irq_init() will leak interrupt controller device node refcounts
in two places as explained below:

1) Leak refcounts of both @desc->dev and @desc->interrupt_parent when
   suffers @desc->irq_init_cb() failure.
2) Leak refcount of @desc->interrupt_parent when cleans up list
   @intc_desc_list in the end.

Refcounts of both @desc->dev and @desc->interrupt_parent were got in
the first loop, but of_irq_init() does not put them before kfree(@desc)
in places mentioned above, so causes refcount leakages.

Fix by putting refcounts involved before kfree(@desc).

Fixes: 8363ccb917c6 ("of/irq: add missing of_node_put")
Fixes: c71a54b08201 ("of/irq: introduce of_irq_init")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20250209-of_irq_fix-v2-7-93e3a2659aa7@quicinc.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/irq.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -555,6 +555,8 @@ void __init of_irq_init(const struct of_
 						desc->interrupt_parent);
 			if (ret) {
 				of_node_clear_flag(desc->dev, OF_POPULATED);
+				of_node_put(desc->interrupt_parent);
+				of_node_put(desc->dev);
 				kfree(desc);
 				continue;
 			}
@@ -585,6 +587,7 @@ void __init of_irq_init(const struct of_
 err:
 	list_for_each_entry_safe(desc, temp_desc, &intc_desc_list, list) {
 		list_del(&desc->list);
+		of_node_put(desc->interrupt_parent);
 		of_node_put(desc->dev);
 		kfree(desc);
 	}



