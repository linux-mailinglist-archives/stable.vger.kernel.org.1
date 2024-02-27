Return-Path: <stable+bounces-24508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D8C8694D6
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7920A1F21C9B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D213AA55;
	Tue, 27 Feb 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zkbc0RfR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB013B295;
	Tue, 27 Feb 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042203; cv=none; b=S/Ul2MhpQjX3zcbkxmE7zcj5ranlZCdzYoliYAZgXgrvcSw5F7pLBNQP1+L0qJ18IH6Au8qL/C1GEcBeoTY1+WQWNMmakrpx7IswjUN3IXyVfVXM0SEJZkG/96tJearf+aAVEFJtqcoZ+B5DIAVwvsNS3TYiM0UebENU0r1HIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042203; c=relaxed/simple;
	bh=y1FPBb0XwSr+KEQHaR0zjyUaD6lTfndyafD6zomCFJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sR0RBRr2opTj7USBCAlsej0+Yc63+iwLtMTC4z10OAdCuHI/xBQUyiGN+4ZsoOaZUefEPF3eejvsrDQn3iyq4dmLGacaZbjxPyEIUPDC7f+JjyN9Egy23/cPO2XKkehcu57at0PT2Litcut1Z3Gy0d20ODwz2uJku3X2YiiQZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zkbc0RfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E7DC433F1;
	Tue, 27 Feb 2024 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042203;
	bh=y1FPBb0XwSr+KEQHaR0zjyUaD6lTfndyafD6zomCFJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zkbc0RfREREhaRyUzPS9B+KztMBZpLnsDPwnmrIcYQVggDiK63AcWBKQ+I+6fWVzV
	 qfuulKRlKaruk7bbbL+Dwdgy53o7z8Zeur8RtGEAQXIIYXNq8zzDRrGdZFtoF9yX+N
	 q21E5FjqHa/F9e8NAAffMZ1oOkpvgCcDEiO8lPbc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Roger Quadros <rogerq@kernel.org>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.6 186/299] usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
Date: Tue, 27 Feb 2024 14:24:57 +0100
Message-ID: <20240227131631.820997901@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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
 



