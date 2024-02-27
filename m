Return-Path: <stable+bounces-24112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E18692B3
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4603D284E18
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD381419BE;
	Tue, 27 Feb 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRYUDY78"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84E13EFF4;
	Tue, 27 Feb 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041066; cv=none; b=RgYoR4kTBhqhzSXrLINBHljqmrVxiEA/zxvm7C/ePB7Q78GU0t1DK3DeO7GtRKcmKMsuSycvRqIgaGUNKzGW0j2GUZ9bRKBX+jRL7sCisYZJ64ARTtlJeCyX5SX6Eag9M0CtWtH/mWm9UEMy6PDbH0IbLoZvVxq6zKfASUhOoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041066; c=relaxed/simple;
	bh=2RtnR8HFlRPdJuVK7RFH+akfs/ZYpNgkcdJjorE+aoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep1ht41DT5JkY7VHWijL5aFdC1YU8iPi8T3mcj515yIj6us4sPRQVvgsknf3pXVSFE0+jqMpuYqbGwkqpDYiIlcm3eEcpdSNcnYi6mPeq/6nFua4fZhgcPk7EtfhX0sovJKZ2eXUXC2ZDVFGp6mUMapYbpe9IjWHXl4FZsZo5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hRYUDY78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF59C43390;
	Tue, 27 Feb 2024 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041066;
	bh=2RtnR8HFlRPdJuVK7RFH+akfs/ZYpNgkcdJjorE+aoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRYUDY78O7FbvM/XQIOD1iBhOxyAYQYWmeWybpsw1IvC9eB0LjMNLy1bH4ymkRy+g
	 iqrgklW0tN5FxYpyH8wjq+4SgxdQ+3Tw2llxbR4TooCR6tGfJZe5O8bbQOF9W89ck0
	 zcsiLlIiS/mN2DElgOUlG6rh0wO8ro5ZKP0LlYnk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Roger Quadros <rogerq@kernel.org>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.7 207/334] usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
Date: Tue, 27 Feb 2024 14:21:05 +0100
Message-ID: <20240227131637.451659283@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Li <Frank.Li@nxp.com>

commit cd45f99034b0c8c9cb346dd0d6407a95ca3d36f6 upstream.

  ...
  cdns3_gadget_ep_free_request(&priv_ep->endpoint, &priv_req->request);
  list_del_init(&priv_req->list);
  ...

'priv_req' actually free at cdns3_gadget_ep_free_request(). But
list_del_init() use priv_req->list after it.

[ 1542.642868][  T534] BUG: KFENCE: use-after-free read in __list_del_entry_valid+0x10/0xd4
[ 1542.642868][  T534]
[ 1542.653162][  T534] Use-after-free read at 0x000000009ed0ba99 (in kfence-#3):
[ 1542.660311][  T534]  __list_del_entry_valid+0x10/0xd4
[ 1542.665375][  T534]  cdns3_gadget_ep_disable+0x1f8/0x388 [cdns3]
[ 1542.671571][  T534]  usb_ep_disable+0x44/0xe4
[ 1542.675948][  T534]  ffs_func_eps_disable+0x64/0xc8
[ 1542.680839][  T534]  ffs_func_set_alt+0x74/0x368
[ 1542.685478][  T534]  ffs_func_disable+0x18/0x28

Move list_del_init() before cdns3_gadget_ep_free_request() to resolve this
problem.

Cc: stable@vger.kernel.org
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20240202154217.661867-1-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdns3-gadget.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2539,11 +2539,11 @@ static int cdns3_gadget_ep_disable(struc
 
 	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
 		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
+		list_del_init(&priv_req->list);
 
 		kfree(priv_req->request.buf);
 		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
 					     &priv_req->request);
-		list_del_init(&priv_req->list);
 		--priv_ep->wa2_counter;
 	}
 



