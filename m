Return-Path: <stable+bounces-95268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075559D74BE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E7528B5FE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2421FCFDC;
	Sun, 24 Nov 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6M0ct6o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743B1FCFD6;
	Sun, 24 Nov 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456528; cv=none; b=UYuVHhWRMiWHdzoWrMp2Afx/a7VHaRZ4n1IYMH+pT3DaJ2V6+3MCWMKyGI3MpaeGZN1zDFQ2PIAV5GCkpSAxEMfmigf+yzxYoxkwz+cHGi3LMSzlLkOexUeaQsJ591mV6O9ZH0GU4DmhGnTqyAX1dGqJN5L9bNz6e/0aGtAI9eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456528; c=relaxed/simple;
	bh=u8EP5drxKPrzvzbBan3RsyQujzQo+A4/oHiSkOOsTJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLH7b4ny4Lc6DkpoBcnkjM4411Xo4lKbvMK1WdtEB3pYCxv1wlLUfqI5dkI+nsssrw0mbitBax81NJzfZ4FgMhMmkk4rrC7JSf4mezCDwc3/8rxCbA2q+U7OWQpL5KUpFZnYP6uCfZWLgVYw8t/BtuzPWsrYWQwtpIywFwxWzu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6M0ct6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4A0C4CECC;
	Sun, 24 Nov 2024 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456528;
	bh=u8EP5drxKPrzvzbBan3RsyQujzQo+A4/oHiSkOOsTJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6M0ct6opxELDO/mC3F2GhhNmt5LyrRyc0RJ+N6U3RkjsiiXrcyiRPtgqRcScoGU6
	 3f9+EWR5gvOt2fwKhWikYCJcTsDPmXSbfbocVHiNKTsFIjAMSYyRnyV+/ZRNXn/0uZ
	 plMvSJA6lWLlsdc07lAXokb+jqxOt3TFnjXT5jGJ33Fv0HUtNhilofF2/joU8inATy
	 J8M9HpTq5vrcRjlPm0vupRXUQoOQP14T/vuWen3gc3mL8HrVBqq0UXUTS+C8UHHvzI
	 wNJIkRnKMjU5WaNDe23ud0cu1RzTpLKQL5+nbeHe0juuAZoSvrbc3HQUTKBHbjpyvl
	 R5cqOtV61citQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	viro@zeniv.linux.org.uk,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 33/33] netpoll: Use rcu_access_pointer() in __netpoll_setup
Date: Sun, 24 Nov 2024 08:53:45 -0500
Message-ID: <20241124135410.3349976-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit c69c5e10adb903ae2438d4f9c16eccf43d1fcbc1 ]

The ndev->npinfo pointer in __netpoll_setup() is RCU-protected but is being
accessed directly for a NULL check. While no RCU read lock is held in this
context, we should still use proper RCU primitives for consistency and
correctness.

Replace the direct NULL check with rcu_access_pointer(), which is the
appropriate primitive when only checking for NULL without dereferencing
the pointer. This function provides the necessary ordering guarantees
without requiring RCU read-side protection.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index f76afab9fd8bd..4475b2174bcc4 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -635,7 +635,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		goto out;
 	}
 
-	if (!ndev->npinfo) {
+	if (!rcu_access_pointer(ndev->npinfo)) {
 		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
 		if (!npinfo) {
 			err = -ENOMEM;
-- 
2.43.0


