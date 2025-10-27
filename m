Return-Path: <stable+bounces-190040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E90FC0F485
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4470E19C06C9
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BCB31283D;
	Mon, 27 Oct 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNmsGPe9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186A312819
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582564; cv=none; b=VsldSwSI0TY8a8HyorsJtJXCuDPcPAKpkFEdzxdb5z6k0vfjDLzK99M0bvcKmNyhKFOiGqn2w2qOb3MCpPIjZ19L0fr2ZyO8R0uzvRBacpmlDeZ8goO2N92oF71NEU6v9fgR6lXfPvlGonJNrYnqHhnQibcwWcCoZin2V2UQdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582564; c=relaxed/simple;
	bh=ThDDN49hubCs6tOgnnx2SFA3yS9UT22iylhuRKfhU6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpPPRE8CD/ZKnGP4Zm1n2Y8lvcwKZEg6DNPfXO1CPUISY6f9atsET4+Am9Ep0kxlVzs6ntk+OsyIkMKtrLNmRkPBB5aQviMaPaXQUGkdI0WkFYxDsWl7r0VQg6EjEJSLCfLG33nzKwFpVsdavj8PTXN1oDZUG0zEoXDBphD3Z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNmsGPe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C100C4CEFD;
	Mon, 27 Oct 2025 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761582564;
	bh=ThDDN49hubCs6tOgnnx2SFA3yS9UT22iylhuRKfhU6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNmsGPe9FbsvVzAzCQmhxMz7lgaAPmmuRd0DG89VNl/wZih8f9Ncx+iaM169kjiNh
	 HDCxuX03nocFi5B93hD8LfTzaEJ70lNjm//V1+Vv2c9iriz9Jz0eOxaayJ6nNpbbnN
	 FmIMXzjaiQ4ju0xqQVG7eH4GjQVyQJm3NluxdGJeYzTrf19KQolI3Lxdj16qk+yTgh
	 JWrczkL1wr++VIvP1cDkfTw2x0oyPjWzs1GUqzDpyN+fuYCa/Ds9L3FKN/sOb+xMHQ
	 7Rp/4Jv5FPcil3ksWXdioVx7DvFlEa+9dbQPve5Fz0cftVeTYmifjttifI3YnCwWo+
	 kUWxKIjk/o/kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] xhci: dbc: Improve performance by removing delay in transfer event polling.
Date: Mon, 27 Oct 2025 12:29:17 -0400
Message-ID: <20251027162919.577996-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027162919.577996-1-sashal@kernel.org>
References: <2025102712-unearned-duplicate-8c3b@gregkh>
 <20251027162919.577996-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 03e3d9c2bd85cda941b3cf78e895c1498ac05c5f ]

Queue event polling work with 0 delay in case there are pending transfers
queued up. This is part 2 of a 3 part series that roughly triples dbc
performace when using adb push and pull over dbc.

Max/min push rate after patches is 210/118 MB/s, pull rate 171/133 MB/s,
tested with large files (300MB-9GB) by Łukasz Bartosik

First performance improvement patch was commit 31128e7492dc
("xhci: dbc: add dbgtty request to end of list once it completes")

Cc: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241227120142.1035206-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f3d12ec847b9 ("xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 643afd3ab0988..177382632614e 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -987,7 +987,7 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 		/* set fast poll rate if there are pending data transfers */
 		if (!list_empty(&dbc->eps[BULK_OUT].list_pending) ||
 		    !list_empty(&dbc->eps[BULK_IN].list_pending))
-			poll_interval = 1;
+			poll_interval = 0;
 		break;
 	default:
 		dev_info(dbc->dev, "stop handling dbc events\n");
-- 
2.51.0


