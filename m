Return-Path: <stable+bounces-176232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E8AB36C18
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC8AA016FC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047332AD32;
	Tue, 26 Aug 2025 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JO3/QQs+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6273223335;
	Tue, 26 Aug 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219120; cv=none; b=ulKRyOIYRgxiGeKSLdGpH8ddJDDDeNdVM8aWyQHUdZJaf+tdKEtgWddIVIcKuQ9wyMBF+zuBR7OqMRhswl8GceOpEGjX8U7B1tM9k/bcPybF/s7Z2Z7eCot1/6O2NDRnwhxNhCTC2wBWDFRqTDTC4N5w6JEhgL3smq92gGjNS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219120; c=relaxed/simple;
	bh=kDi1Fbege8PDwlklifNJHfkyDjF9SB0BCpnqN9tg2ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqDr7GNDJxEbj5cidwo8lnaBjHsmzL1TXggNpO/Zza26OFNXIejkfUvN0yGyPQ1y4Qj5s1KOnp1i5nT69JBzdeaCNCwtwYoO4nZ+UpJ+zikHYEpeB1x7puKvq601IrFlOUrNqVe+5yFnlEutYjKiduwOVL+p1d/cKHeMqb4Fq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JO3/QQs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49329C4CEF1;
	Tue, 26 Aug 2025 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219120;
	bh=kDi1Fbege8PDwlklifNJHfkyDjF9SB0BCpnqN9tg2ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JO3/QQs+9vryvCugiFjst5LlXwJRSDtQIOzL+7yiNW6bvOUnGCRGKzuP4uF8zmuW8
	 pkmO8WMtlBLaNRtDS0Ji3PTU8WdSWdjDKp8YE0+9bJyXPdTJ8IjDBBFdaikF6mP21T
	 CDFklkrojeVSif7e+8DNbn5I4blaDfIO/u4EdIYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Corey Minyard <corey@minyard.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 261/403] ipmi: Use dev_warn_ratelimited() for incorrect message warnings
Date: Tue, 26 Aug 2025 13:09:47 +0200
Message-ID: <20250826110914.027362037@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit ec50ec378e3fd83bde9b3d622ceac3509a60b6b5 ]

During BMC firmware upgrades on live systems, the ipmi_msghandler
generates excessive "BMC returned incorrect response" warnings
while the BMC is temporarily offline. This can flood system logs
in large deployments.

Replace dev_warn() with dev_warn_ratelimited() to throttle these
warnings and prevent log spam during BMC maintenance operations.

Signed-off-by: Breno Leitao <leitao@debian.org>
Message-ID: <20250710-ipmi_ratelimit-v1-1-6d417015ebe9@debian.org>
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 0833a2ac2f69..b8a13edee817 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4302,10 +4302,10 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 		 * The NetFN and Command in the response is not even
 		 * marginally correct.
 		 */
-		dev_warn(intf->si_dev,
-			 "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
-			 (msg->data[0] >> 2) | 1, msg->data[1],
-			 msg->rsp[0] >> 2, msg->rsp[1]);
+		dev_warn_ratelimited(intf->si_dev,
+				     "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
+				     (msg->data[0] >> 2) | 1, msg->data[1],
+				     msg->rsp[0] >> 2, msg->rsp[1]);
 
 		/* Generate an error response for the message. */
 		msg->rsp[0] = msg->data[0] | (1 << 2);
-- 
2.39.5




