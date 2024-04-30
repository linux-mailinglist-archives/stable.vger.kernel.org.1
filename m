Return-Path: <stable+bounces-42130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E153E8B718E
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9F1C2217C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19AB12C476;
	Tue, 30 Apr 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UOULp32z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C812C499;
	Tue, 30 Apr 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474665; cv=none; b=iSJsj4ymVomvymEgQ9hln1OyMB4wuQSchcqLxbIUJgbxVClyuUWhNw4kD04QoC4qAwPvRlJE66ZLIs64IzkMRh3fCgeynX1m+Qj++ITR3ykonHfYo3isXQa13lbGF6gGiLYBmR9+XWBonpmbD0dGRsx0F37tB3BhxA0+d86BHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474665; c=relaxed/simple;
	bh=e6S9pWi43rfm1zy6yty8cS1ISsC/mg4wlPfgtExCx+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvYYgQsuiNSCAf1gWETcm3iXM4ZZ2RwiGX/5AnKxuAtr0/5jydi8jjwl30HKMuz3nn2d0PKKaD2FXVN7dESJSRU2JZ4iC/GfgLTovYhGE31XqsLN4AVNmfgpTIWixwNbu5rQKTZ1BCEncjgCXjhtOj9sUu9TNAAFVbSfN8WN0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UOULp32z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38738C4AF18;
	Tue, 30 Apr 2024 10:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474665;
	bh=e6S9pWi43rfm1zy6yty8cS1ISsC/mg4wlPfgtExCx+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOULp32zyiSmSXkVB5tZ0v9M1mGLgPwVLb+MYaA92MqwBLEuECQ2yKrvaEZAw801z
	 cygfKZmKLypKtnIwbvaKP4dUbG8tjSdJhSJLeKsVPrSvRgwyyTQalGn+dp28Tzhggs
	 4ImZiNXh9Hk87JAcRLhTiEUKUocw1g0tYwAqoeQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Peter=20M=C3=BCnster?= <pm@a16n.net>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Vaclav Svoboda <svoboda@neng.cz>,
	Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.8 187/228] net: b44: set pause params only when interface is up
Date: Tue, 30 Apr 2024 12:39:25 +0200
Message-ID: <20240430103109.197955230@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Münster <pm@a16n.net>

commit e3eb7dd47bd4806f00e104eb6da092c435f9fb21 upstream.

b44_free_rings() accesses b44::rx_buffers (and ::tx_buffers)
unconditionally, but b44::rx_buffers is only valid when the
device is up (they get allocated in b44_open(), and deallocated
again in b44_close()), any other time these are just a NULL pointers.

So if you try to change the pause params while the network interface
is disabled/administratively down, everything explodes (which likely
netifd tries to do).

Link: https://github.com/openwrt/openwrt/issues/13789
Fixes: 1da177e4c3f4 (Linux-2.6.12-rc2)
Cc: stable@vger.kernel.org
Reported-by: Peter Münster <pm@a16n.net>
Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Vaclav Svoboda <svoboda@neng.cz>
Tested-by: Peter Münster <pm@a16n.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Peter Münster <pm@a16n.net>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/87y192oolj.fsf@a16n.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/b44.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2009,12 +2009,14 @@ static int b44_set_pauseparam(struct net
 		bp->flags |= B44_FLAG_TX_PAUSE;
 	else
 		bp->flags &= ~B44_FLAG_TX_PAUSE;
-	if (bp->flags & B44_FLAG_PAUSE_AUTO) {
-		b44_halt(bp);
-		b44_init_rings(bp);
-		b44_init_hw(bp, B44_FULL_RESET);
-	} else {
-		__b44_set_flow_ctrl(bp, bp->flags);
+	if (netif_running(dev)) {
+		if (bp->flags & B44_FLAG_PAUSE_AUTO) {
+			b44_halt(bp);
+			b44_init_rings(bp);
+			b44_init_hw(bp, B44_FULL_RESET);
+		} else {
+			__b44_set_flow_ctrl(bp, bp->flags);
+		}
 	}
 	spin_unlock_irq(&bp->lock);
 



