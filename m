Return-Path: <stable+bounces-171403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA7B2A934
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755EE7B8FD2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006BB31CA48;
	Mon, 18 Aug 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="obbg2dLD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27DA34E1A8;
	Mon, 18 Aug 2025 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525803; cv=none; b=iYBm36wwOGaaDjJ05hj+C/VphGnl6LQ/pLHHQFt3XNIKeyly0c71lXGi0sYlhE3VVqQmSvdqKL2c2hvDdabHS6cZpNSA6YGSzWDwKpjCbbfLl+KsZzIXI2uT9vJXVwowvJFZBuskbd++hPAOxHyv8FjvGbQ5gxnZGcH1qWiEAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525803; c=relaxed/simple;
	bh=fssLHxEadwbQiFWqMYnvZxqADe9xt2mw79ks+S9JzQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUB7bshiZ6cRXPdqWWCbnSHNktee9zko5NhDyrCsg7EYH1uSBW6x70lgsuLQ1V3fjbnRN8A3c0LEc+/mERI72zS5qKGJKNOixGbC0MewRGZzxj9Gpe4kEz4JXKcy5pEdROKAreTdjhDZn8WdTNJ8VcFyXOxWy6lX6nSI3gU0uZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=obbg2dLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223C3C4CEEB;
	Mon, 18 Aug 2025 14:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525803;
	bh=fssLHxEadwbQiFWqMYnvZxqADe9xt2mw79ks+S9JzQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obbg2dLDQXnMYKPYlr85p6mleavmo2kEhm0URuRnC4u8GRWa4YM3kaPwLMjE4AFRD
	 nhVzb31wtgifuGTHnsvamwxIDgHZk2RsUbpu5xBv6Yyr8urHWJKKkgAjTIA7NxrDbX
	 kxE8SkBdH0L5bgQHnaqvHjqEeSzZvx8YhNOEwJig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Showrya M N <showrya@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Chris Leech <cleech@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 370/570] scsi: libiscsi: Initialize iscsi_conn->dd_data only if memory is allocated
Date: Mon, 18 Aug 2025 14:45:57 +0200
Message-ID: <20250818124520.108356159@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Showrya M N <showrya@chelsio.com>

[ Upstream commit 3ea3a256ed81f95ab0f3281a0e234b01a9cae605 ]

In case of an ib_fast_reg_mr allocation failure during iSER setup, the
machine hits a panic because iscsi_conn->dd_data is initialized
unconditionally, even when no memory is allocated (dd_size == 0).  This
leads invalid pointer dereference during connection teardown.

Fix by setting iscsi_conn->dd_data only if memory is actually allocated.

Panic trace:
------------
 iser: iser_create_fastreg_desc: Failed to allocate ib_fast_reg_mr err=-12
 iser: iser_alloc_rx_descriptors: failed allocating rx descriptors / data buffers
 BUG: unable to handle page fault for address: fffffffffffffff8
 RIP: 0010:swake_up_locked.part.5+0xa/0x40
 Call Trace:
  complete+0x31/0x40
  iscsi_iser_conn_stop+0x88/0xb0 [ib_iser]
  iscsi_stop_conn+0x66/0xc0 [scsi_transport_iscsi]
  iscsi_if_stop_conn+0x14a/0x150 [scsi_transport_iscsi]
  iscsi_if_rx+0x1135/0x1834 [scsi_transport_iscsi]
  ? netlink_lookup+0x12f/0x1b0
  ? netlink_deliver_tap+0x2c/0x200
  netlink_unicast+0x1ab/0x280
  netlink_sendmsg+0x257/0x4f0
  ? _copy_from_user+0x29/0x60
  sock_sendmsg+0x5f/0x70

Signed-off-by: Showrya M N <showrya@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Link: https://lore.kernel.org/r/20250627112329.19763-1-showrya@chelsio.com
Reviewed-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libiscsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 392d57e054db..c9f410c50978 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3185,7 +3185,8 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
 		return NULL;
 	conn = cls_conn->dd_data;
 
-	conn->dd_data = cls_conn->dd_data + sizeof(*conn);
+	if (dd_size)
+		conn->dd_data = cls_conn->dd_data + sizeof(*conn);
 	conn->session = session;
 	conn->cls_conn = cls_conn;
 	conn->c_stage = ISCSI_CONN_INITIAL_STAGE;
-- 
2.39.5




