Return-Path: <stable+bounces-133690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C7A926E3
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72448A6964
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFE21DB148;
	Thu, 17 Apr 2025 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gr9DXUnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E1256C6B;
	Thu, 17 Apr 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913846; cv=none; b=hz0TTCKfK9fSLPYwMiiNzqlZCJsJD2qPI75ltBV/CvshbwdMt/FcQtJqJ94G1IDiu+62bUDuaQ7ZInJyVPiFusow+0Af5dZ6Icjhrhqxa5LjCXYhwUfnjL21btdTskEZ9B3l8VCo/vhDKlmP0PhEzGuALCDv/LL/k+KWsqJpbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913846; c=relaxed/simple;
	bh=pDd9tI3Sjjzc3ndZp5j6rlGImX1O5HsjQWOtiTcq76E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMRSoEuw+P/xdg+nx8i1McuVi3z7+NS+/M1VYfZEoXqKgScw2lfMZycqPVAjhBX/l8QKoiuA5g4eIAlWgav/q1fpja/vuBiU0+0GXEwavH+gJehtR+qvgBGE8Dl333uThWkdC4t79ltFUWasxj3GS+IcUM7oyZGIwH751YzW2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gr9DXUnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5193CC4CEEA;
	Thu, 17 Apr 2025 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913846;
	bh=pDd9tI3Sjjzc3ndZp5j6rlGImX1O5HsjQWOtiTcq76E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gr9DXUnduJJGa2uaa6KsCnlqhckWkiV43k68AbALxCxODXc8MrfIYzDJ5ovp4WWlj
	 Lib39TMX8AqYdgNaT2Xqlv4dx/BZTfu+gp8hx7FH+mhTEUP9Xm5Rm8Sl2tnhTo7Y9W
	 YgEHvIKu6ZSDgVU2NlBAyZqhRr23RDh2kMH9Ztl0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 014/414] tipc: fix memory leak in tipc_link_xmit
Date: Thu, 17 Apr 2025 19:46:12 +0200
Message-ID: <20250417175111.979491165@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tung Nguyen <tung.quang.nguyen@est.tech>

[ Upstream commit 69ae94725f4fc9e75219d2d69022029c5b24bc9a ]

In case the backlog transmit queue for system-importance messages is overloaded,
tipc_link_xmit() returns -ENOBUFS but the skb list is not purged. This leads to
memory leak and failure when a skb is allocated.

This commit fixes this issue by purging the skb list before tipc_link_xmit()
returns.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Link: https://patch.msgid.link/20250403092431.514063-1-tung.quang.nguyen@est.tech
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/link.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 5c2088a469cea..5689e1f485479 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1046,6 +1046,7 @@ int tipc_link_xmit(struct tipc_link *l, struct sk_buff_head *list,
 	if (unlikely(l->backlog[imp].len >= l->backlog[imp].limit)) {
 		if (imp == TIPC_SYSTEM_IMPORTANCE) {
 			pr_warn("%s<%s>, link overflow", link_rst_msg, l->name);
+			__skb_queue_purge(list);
 			return -ENOBUFS;
 		}
 		rc = link_schedule_user(l, hdr);
-- 
2.39.5




