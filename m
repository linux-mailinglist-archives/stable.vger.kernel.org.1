Return-Path: <stable+bounces-205872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDA5CFA02B
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AA7632EDA8E
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E2036BCC8;
	Tue,  6 Jan 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vP9GpqZm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB836B048;
	Tue,  6 Jan 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722140; cv=none; b=MDvL9IOiXx1c+3qwbjZM8eAQlzdVrzdJ0kWYCNYRMDBMg6AOs5/nX60NMx/bsHlrSHPTOz9z3+u/zNtdep4dJpzwSpOF2yhhTVhnLzHMlIwjRQLoLdFgI7x8A7lVj8mRUIao9BWPaS1+LYSbDf/IGnQU04jZqaSq1kCBV8h9HU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722140; c=relaxed/simple;
	bh=ZOIZ+VQdw5m0oOPUt8vj74U0Emr9hleBf/vr5LorPt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs5jwtP9ISthA1qOncu3NeETlbAjpRMr1zJHzqBUF16uj2crd90Fo49TevLpio+o6jGtfqSFYB8fz3j8I7sp3Kr8WFPhVJUWyGi6b3J2L7sW44B2me+FMAIb6qSKKSOlZLIpOneFFU8AKR9Bv4/y502yjkxX4B1SgjSi91mFr7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vP9GpqZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD79FC116C6;
	Tue,  6 Jan 2026 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767722140;
	bh=ZOIZ+VQdw5m0oOPUt8vj74U0Emr9hleBf/vr5LorPt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vP9GpqZmVd6++ccR6JLP6OO7S+Oz83t0rl022U4eIJF7OP+SuiaUJI3InE0DoC3/E
	 kG1nsz4XKObzNWwrYfLZwzBcFjFHicOq072tVChhqAu4GrPtwEwHajVSmHvgfDV/Dp
	 2tVVeBYK9r8rzBgKiegSw6wYmF8LtzvSyuHp9hdw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.18 178/312] media: renesas: rcar_drif: fix device node reference leak in rcar_drif_bond_enabled
Date: Tue,  6 Jan 2026 18:04:12 +0100
Message-ID: <20260106170554.272963723@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaoqian Lin <linmq006@gmail.com>

commit 445e1658894fd74eab7e53071fa16233887574ed upstream.

The function calls of_parse_phandle() which returns
a device node with an incremented reference count. When the bonded device
is not available, the function
returns NULL without releasing the reference, causing a reference leak.

Add of_node_put(np) to release the device node reference.
The of_node_put function handles NULL pointers.

Found through static analysis by reviewing the doc of of_parse_phandle()
and cross-checking its usage patterns across the codebase.

Fixes: 7625ee981af1 ("[media] media: platform: rcar_drif: Add DRIF support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/renesas/rcar_drif.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/platform/renesas/rcar_drif.c
+++ b/drivers/media/platform/renesas/rcar_drif.c
@@ -1246,6 +1246,7 @@ static struct device_node *rcar_drif_bon
 	if (np && of_device_is_available(np))
 		return np;
 
+	of_node_put(np);
 	return NULL;
 }
 



