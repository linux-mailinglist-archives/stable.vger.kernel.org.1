Return-Path: <stable+bounces-248680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GARuJS5ZB2pmzgIAu9opvQ
	(envelope-from <stable+bounces-248680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:34:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9FE5553B9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D40433EF6DF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EE33CFF61;
	Fri, 15 May 2026 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PyEjYwHk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AF3CB2FD;
	Fri, 15 May 2026 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862351; cv=none; b=R67EWn6376nQvwa+xxNwZ9peud7Of/kuzLhfcNafP+pkjFbX6CnG6h1N80xcEwszkZEzqSn++IS78uZOEhKw3iv0yin3brMPc6XXjbFQVW6qsCMJTrLKCe+ovuU+HMqklHmVeXg0+GVn2RssWIMZFnUXhralSvfX76jIarGGXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862351; c=relaxed/simple;
	bh=KDgPG/oeKCfJuZkhLumxre0bgfbuqgAblRAGhfLk8gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PC0xyBYeUOP6IZ1VaA2P0Hfl4iGY9IpjR3q0LLNuuHR7C9dUcbAgq1hP/5XAbOKaH//997voasEb4ZzAQNo8w9WcGHta/zVPOJeudwQH5ArP6+qXw2pnp+tvRoNLgx3l1RYBMjhdLOTDbBDG4pQr0xpCZKCdnFjzZfmNQBOQq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PyEjYwHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6956CC2BCB0;
	Fri, 15 May 2026 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862350;
	bh=KDgPG/oeKCfJuZkhLumxre0bgfbuqgAblRAGhfLk8gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PyEjYwHksRcaxag1yzWKFT9h0WRDX5LUCAOTPbSJdKafo5X70fykYAikrL/07YGvl
	 HZn11RaBsmcYuhXIPMivB1fPaMq5e5KhS16VyvHDvCweMxWKZSyBwUYbnuQ+WGNOLm
	 iNO3G566UcpfdN3UqJIzUri/vB0HNh4W9OINZrNw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Scally <dan.scally@ideasonboard.com>,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <barnabas.pocze@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 7.0 016/201] media: mali-c55: Fix wrong comment of ISP block types
Date: Fri, 15 May 2026 17:47:14 +0200
Message-ID: <20260515154658.887165119@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Rspamd-Queue-Id: 3F9FE5553B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248680-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,ideasonboard.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

commit df16624248296ce4e8890c7ddcc95f0ccb642bcd upstream.

Some bad copy&paste happened in the description of the ISP block types
and AWB_CONFIG got mixed up with SHADING_CONFIG.

Fix it by assigning to each block the correct type.

As only the comment is changed, there is no uABI breakage or regression.

Cc: stable@vger.kernel.org
Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Barnabás Pőcze <barnabas.pocze@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/arm/mali-c55/mali-c55-params.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
index be0e909bcf29..c03a6120ddbf 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
@@ -43,9 +43,9 @@
  * @digital_gain:	For header->type == MALI_C55_PARAM_BLOCK_DIGITAL_GAIN
  * @awb_gains:		For header->type == MALI_C55_PARAM_BLOCK_AWB_GAINS and
  *			header->type = MALI_C55_PARAM_BLOCK_AWB_GAINS_AEXP
- * @awb_config:		For header->type == MALI_C55_PARAM_MESH_SHADING_CONFIG
- * @shading_config:	For header->type == MALI_C55_PARAM_MESH_SHADING_SELECTION
- * @shading_selection:	For header->type == MALI_C55_PARAM_BLOCK_SENSOR_OFFS
+ * @awb_config:		For header->type == MALI_C55_PARAM_BLOCK_AWB_CONFIG
+ * @shading_config:	For header->type == MALI_C55_PARAM_MESH_SHADING_CONFIG
+ * @shading_selection:	For header->type == MALI_C55_PARAM_MESH_SHADING_SELECTION
  * @data:		Allows easy initialisation of a union variable with a
  *			pointer into a __u8 array.
  */
-- 
2.54.0




