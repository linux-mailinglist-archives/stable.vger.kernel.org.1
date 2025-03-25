Return-Path: <stable+bounces-126078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52D8A6FEE8
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19243178BC6
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC480259CAC;
	Tue, 25 Mar 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XAzd71R3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC922853FA;
	Tue, 25 Mar 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905559; cv=none; b=R3hL0EHUAyRlrPf0QR8ysVMoIUmykPb91zrToFSyV+sqt3IUkWoknSzo9dmAUiWPRWQqob9MBVVdB6PFhT5lviUrWUnMDjKVLCV3i4EPeJZr1ub0nAW4RUhYu/PwpulOI8lmDCcyS+fYiJknEaNfg3pik4LJ5yVldsibvHAqoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905559; c=relaxed/simple;
	bh=9sMX2Kxx8JB/B/DWyxrGRHOfzkpydnx+yrCEH+iBMc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRv6BaIiNDNHqXbTju7GPUy3Z5VOxKYiHL9u3PYbN4oxHOELzFCnPmugbcg2XEbVC/kTNm6joxk35fUlkHzD/Le37Q2IVkZ+d+Ghs1aX8h//P+8T1PVsbHmC2C92E3IQ0d8FHz53xZj7kQlz0iRP/0cu5UsuTkO8kLHO0RqO5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XAzd71R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C39C4CEED;
	Tue, 25 Mar 2025 12:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905559;
	bh=9sMX2Kxx8JB/B/DWyxrGRHOfzkpydnx+yrCEH+iBMc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAzd71R3QDUKvh7Y6vWnm8lf3NzAHbWWAKbGHwP2U/gG5PYZvkecuOvDaAhvAXSCC
	 rm6rW82xLEnllk+NSQIOe81YcR953JA4sQA1ZnoPnTlQvCQFVK7Xx2pKz8y7TBJ0rt
	 ncWw+Wrm+JSyYGM7OG6qp+R+t2KSoFY5hn5CyXpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jun Yang <juny24602@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 010/198] sched: address a potential NULL pointer dereference in the GRED scheduler.
Date: Tue, 25 Mar 2025 08:19:32 -0400
Message-ID: <20250325122156.911799489@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jun Yang <juny24602@gmail.com>

[ Upstream commit 115ef44a98220fddfab37a39a19370497cd718b9 ]

If kzalloc in gred_init returns a NULL pointer, the code follows the
error handling path, invoking gred_destroy. This, in turn, calls
gred_offload, where memset could receive a NULL pointer as input,
potentially leading to a kernel crash.

When table->opt is NULL in gred_init(), gred_change_table_def()
is not called yet, so it is not necessary to call ->ndo_setup_tc()
in gred_offload().

Signed-off-by: Jun Yang <juny24602@gmail.com>
Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>
Fixes: f25c0515c521 ("net: sched: gred: dynamically allocate tc_gred_qopt_offload")
Link: https://patch.msgid.link/20250305154410.3505642-1-juny24602@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_gred.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 872d127c9db42..fa7a1b69c0f35 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -913,7 +913,8 @@ static void gred_destroy(struct Qdisc *sch)
 	for (i = 0; i < table->DPs; i++)
 		gred_destroy_vq(table->tab[i]);
 
-	gred_offload(sch, TC_GRED_DESTROY);
+	if (table->opt)
+		gred_offload(sch, TC_GRED_DESTROY);
 	kfree(table->opt);
 }
 
-- 
2.39.5




