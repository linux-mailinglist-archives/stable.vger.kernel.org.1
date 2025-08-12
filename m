Return-Path: <stable+bounces-168847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E90B236ED
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFB47A7CC3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2327781E;
	Tue, 12 Aug 2025 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZObaF5xR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2C260583;
	Tue, 12 Aug 2025 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025531; cv=none; b=GT+DixNdaqCI1lq5YhtQhpu5aml5747oYxj2POnD0U0VU6viaE7tcDXUIVYr48zuP2dv8w/0PwT2b+wEx6Z3lnTfvh4/2CdEyj55smpfCooouR/WW5efE7rwSBAo3uCQ8g1LjDzs7cAPgDwd9rZmOclfdukGgvE2ElTf9bfQwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025531; c=relaxed/simple;
	bh=5WKxy2YD3wyobUrXnshwAjttu/vaxR5rXuNeY6FON0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfP8jF5N/wPGgaUVQtRFKqdyxqt2ZHm5VGcgQ9wAR4HDm/oZAMX+c4VuYhoID9FiKeD9d7qI4ffNvJuvooV4mQW5WiG1zfd6EDQg7rEn18eYz/ch2/FXg6Rhv5OoUyer5Qy1LKqlhLVsGkHhDqQKVPDWJXaWiU2TUejxkAuI0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZObaF5xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCC3C4CEF0;
	Tue, 12 Aug 2025 19:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025530;
	bh=5WKxy2YD3wyobUrXnshwAjttu/vaxR5rXuNeY6FON0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZObaF5xRn2l4uNr0YGWZhMil7Nc5TVW48vCzboCQ4mdBEQahVC/RG5O1gZKiw597f
	 lLr4X6Ip3WMNuAsYTd8odlx8EV7Mi3PRy42Ow8RoaMgx5Y3zufHZOfKO38xQ0ewyVj
	 lyc/D7w4QMeZQpTmeLBiaM6CGhZD2KNxctVuQ8aU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 068/480] Revert "vmci: Prevent the dispatching of uninitialized payloads"
Date: Tue, 12 Aug 2025 19:44:36 +0200
Message-ID: <20250812174400.226349445@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 8f5d9bed6122b8d96508436e5ad2498bb797eb6b ]

This reverts commit bfb4cf9fb97e4063f0aa62e9e398025fb6625031.

While the code "looks" correct, the compiler has no way to know that
doing "fun" pointer math like this really isn't a write off the end of
the structure as there is no hint anywhere that the structure has data
at the end of it.

This causes the following build warning:

In function 'fortify_memset_chk',
    inlined from 'ctx_fire_notification.isra' at drivers/misc/vmw_vmci/vmci_context.c:254:3:
include/linux/fortify-string.h:480:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  480 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

So revert it for now and it can come back in the future in a "sane" way
that either correctly makes the structure know that there is trailing
data, OR just the payload structure is properly referenced and zeroed
out.

Fixes: bfb4cf9fb97e ("vmci: Prevent the dispatching of uninitialized payloads")
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://lore.kernel.org/r/20250703171021.0aee1482@canb.auug.org.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/vmw_vmci/vmci_context.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index d566103caa27..f22b44827e92 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -251,8 +251,6 @@ static int ctx_fire_notification(u32 context_id, u32 priv_flags)
 		ev.msg.hdr.src = vmci_make_handle(VMCI_HYPERVISOR_CONTEXT_ID,
 						  VMCI_CONTEXT_RESOURCE_ID);
 		ev.msg.hdr.payload_size = sizeof(ev) - sizeof(ev.msg.hdr);
-		memset((char*)&ev.msg.hdr + sizeof(ev.msg.hdr), 0,
-			ev.msg.hdr.payload_size);
 		ev.msg.event_data.event = VMCI_EVENT_CTX_REMOVED;
 		ev.payload.context_id = context_id;
 
-- 
2.39.5




