Return-Path: <stable+bounces-103616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6939EF7FE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF6A28E7B5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A169F223C5A;
	Thu, 12 Dec 2024 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y/SmskX/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C657223C4E;
	Thu, 12 Dec 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025100; cv=none; b=Tkd9Y8mDwQDwlaf/HQm9AOqis/cQCUG3jTISVUKSi3MyqQtdP6rDse/zPrfuOCZkpChx3KjXcWhcv8peN4dDfwsohpk9B467FqOrZjxAudH3DIxmSzi2WkWB5km2IXWGbxWvw2CqTfWBzBtyiI2CwzNyoaoj7PATrIkx1QctJVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025100; c=relaxed/simple;
	bh=1U9DDfr2PlmJdj7AT3vgFx69lIfhRJO8Yn1gCSONO3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDb/VEtjCxXIe0Ke/RdgabMM9apBfjCdTdX6UF5HGdygQ16kKB8ZcBxn3Ejs40r3UQ1iovlQBwL28G50fOwS87RakXBnMctX6D9UyAxojEP8WPPo8Ha7znqhib4TnyZg3/8LVM9tbR0JEIOxG3igWQ2+YzoLVGoIkQph4NXYi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y/SmskX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8946CC4CEDD;
	Thu, 12 Dec 2024 17:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025098;
	bh=1U9DDfr2PlmJdj7AT3vgFx69lIfhRJO8Yn1gCSONO3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/SmskX/5GSea+gwqn1uEWz1QLS283Do+BKJbHLRiyaJsx9qtXOsRe6rW/lNVA4b+
	 a/d4Y5YalHgEchpeCbbvr0CWEK3I5zrCToybjYY5/SBUBSwtXgs5gYxiNqqBYwsCh3
	 dD9FhRcr1FkJj1UWvGctfxJXDnrFBE1Rn6JxtMIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeongjun Park <aha310510@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 056/321] wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
Date: Thu, 12 Dec 2024 15:59:34 +0100
Message-ID: <20241212144232.204667945@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit 8619593634cbdf5abf43f5714df49b04e4ef09ab ]

I found the following bug in my fuzzer:

  UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:51
  index 255 is out of range for type 'htc_endpoint [22]'
  CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.11.0-rc6-dirty #14
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Workqueue: events request_firmware_work_func
  Call Trace:
   <TASK>
   dump_stack_lvl+0x180/0x1b0
   __ubsan_handle_out_of_bounds+0xd4/0x130
   htc_issue_send.constprop.0+0x20c/0x230
   ? _raw_spin_unlock_irqrestore+0x3c/0x70
   ath9k_wmi_cmd+0x41d/0x610
   ? mark_held_locks+0x9f/0xe0
   ...

Since this bug has been confirmed to be caused by insufficient verification
of conn_rsp_epid, I think it would be appropriate to add a range check for
conn_rsp_epid to htc_connect_service() to prevent the bug from occurring.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240909103855.68006-1-aha310510@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 99667aba289df..00dc97ac53b9d 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -294,6 +294,9 @@ int htc_connect_service(struct htc_target *target,
 		return -ETIMEDOUT;
 	}
 
+	if (target->conn_rsp_epid < 0 || target->conn_rsp_epid >= ENDPOINT_MAX)
+		return -EINVAL;
+
 	*conn_rsp_epid = target->conn_rsp_epid;
 	return 0;
 err:
-- 
2.43.0




