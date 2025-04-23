Return-Path: <stable+bounces-136144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E71E9A992E3
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCE01BA4343
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B71298CD7;
	Wed, 23 Apr 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o3NhdxWJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839BD298CB7;
	Wed, 23 Apr 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421771; cv=none; b=EIu9LiSplNCVy7N8ytuoTpHzGENqv3YGHksSja41gBi0BSyjQ7z6+cEpfozS5WFUkzoJ1AZhYRJ9URXbnuY3NFgaDw9s3E0X2G2/YkMhqO25NFsykzyvKMz5LwDuIfNvtso5c/osPgvIoxKv7rTabeLecYd4wNRq8AI7GPr9Fuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421771; c=relaxed/simple;
	bh=qtTVn/olsKvqxFaDo/f7oshDff9Ng9MAOIU/dDTY0vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahpLdM+HaRwEwovL/cUk/BRyx+FY5cgldxESKD4wU3vNKQzsuNA2JmPKQBPu0JA6/og8YWa9vhMcZUhr3uPnrONo+nQVf/FmLQHAfJpDOz24i/uDDP2Fx4EFGRY2XdhDO5THPCTR5jPYKc6ycYpYg4kko54AF2L1U2ncZXWnm3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o3NhdxWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CC3C4CEE2;
	Wed, 23 Apr 2025 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421771;
	bh=qtTVn/olsKvqxFaDo/f7oshDff9Ng9MAOIU/dDTY0vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3NhdxWJc1tnbcxjizjIccXuDyUTBgXRv0luJ6xTSIx2CcQPP1kKD9hOtPGUc1tAH
	 NDtgkxYkTbmycr8KVDIb82CeY22aZ6au8Oow6iUnsqPJ+felxre7hKbbqO6/7SN7z0
	 Zsd7j0gtjPnk6BkmQyjmjz9h7yNBC3k+EqrlD2Ik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.6 222/393] of/irq: Fix device node refcount leakage in API of_irq_parse_raw()
Date: Wed, 23 Apr 2025 16:41:58 +0200
Message-ID: <20250423142652.556370593@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit ff93e7213d6cc8d9a7b0bc64f70ed26094e168f3 upstream.

if the node @out_irq->np got by of_irq_parse_raw() is a combo node which
consists of both controller and nexus, namely, of_irq_parse_raw() returns
due to condition (@ipar == @newpar), then the node's refcount was increased
twice, hence causes refcount leakage.

Fix by putting @out_irq->np refcount before returning due to the condition.
Also add comments about refcount of node @out_irq->np got by the API.

Fixes: 041284181226 ("of/irq: Allow matching of an interrupt-map local to an interrupt controller")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20250209-of_irq_fix-v2-4-93e3a2659aa7@quicinc.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/irq.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -166,6 +166,8 @@ const __be32 *of_irq_parse_imap_parent(c
  * the specifier for each map, and then returns the translated map.
  *
  * Return: 0 on success and a negative number on error
+ *
+ * Note: refcount of node @out_irq->np is increased by 1 on success.
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
@@ -311,6 +313,12 @@ int of_irq_parse_raw(const __be32 *addr,
 		addrsize = (imap - match_array) - intsize;
 
 		if (ipar == newpar) {
+			/*
+			 * We got @ipar's refcount, but the refcount was
+			 * gotten again by of_irq_parse_imap_parent() via its
+			 * alias @newpar.
+			 */
+			of_node_put(ipar);
 			pr_debug("%pOF interrupt-map entry to self\n", ipar);
 			return 0;
 		}



