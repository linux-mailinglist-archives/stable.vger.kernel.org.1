Return-Path: <stable+bounces-248679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCfZB8hSB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:07:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A977554772
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5420433EF6D5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930513F9289;
	Fri, 15 May 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hyiy/tEX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495093CD8C1;
	Fri, 15 May 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862348; cv=none; b=YBMj/xcuerGxP1gc3zdEyOG0RqwBFa+FiC3AG/J2Ceg3HOTsCYfEgTcipSVxUmzyrnugEp4DfyxF8F1mbqGkp6QjSeGVwEzJEokgUhtlHu6NJGBp2l3xYA10j4YdmkiF5lrbzyP9kGCgQvh3lAXl+Qj9wgCeWwo+leIcawn8G3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862348; c=relaxed/simple;
	bh=B8ov53LBO3gmmOJENPQh0hwbe5VaNanFnYGSfnbC5Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhwspWhp82UEtYNaQJT9wuzgaN24ja0rEOkEL8aKzD5wLOidpf/+jIS5IOFeAvmjEbE5U/nxU2ckwm8GB4svIbA6A3aRJPAo5oiLJsNTbJgWAotPtn+W4/ZL3J9Fnm9+nR+3m6n7gWynwI6wMejXPp3WXqDNLU3Me+8VGQ13GQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hyiy/tEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F1FC2BCB0;
	Fri, 15 May 2026 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862348;
	bh=B8ov53LBO3gmmOJENPQh0hwbe5VaNanFnYGSfnbC5Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyiy/tEX18uLM/S7XuCxc7CXomHp4p8oYIafu8ijl8+P3RMA8qwn6PTBfd+zJxT4F
	 b5y5xwhoq9fDzdPg+kNurIuwhvmLJu867hfOg1rbLPygwH277PDKZGkACSLuSZOTgy
	 uw5orOaN/pxbl8IqOMj7+wc4JpemWHR3QFpZcyZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Scally <dan.scally@ideasonboard.com>,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <barnabas.pocze@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 7.0 015/201] media: mali-c55: Fix Iridix bypass macros
Date: Fri, 15 May 2026 17:47:13 +0200
Message-ID: <20260515154658.866104458@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 8A977554772
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248679-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Scally <dan.scally@ideasonboard.com>

commit db7faf488ecf846c46884310ff1bf28daf2ad39a upstream.

The Mali C55 Iridix block has a digital gain function and tone mapping
function, whose enablement is controlled by two different bits
in the BYPASS_3 register.

Unfortunately, the "Gain" and "Tonemap" bypass bit definitions are the
wrong way around. Swap them.

Cc: stable@vger.kernel.org
Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Barnabás Pőcze <barnabas.pocze@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/arm/mali-c55/mali-c55-registers.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
@@ -128,8 +128,8 @@ enum mali_c55_interrupts {
 #define MALI_C55_REG_BYPASS_3_SENSOR_OFFSET_PRE_SH	BIT(1)
 #define MALI_C55_REG_BYPASS_3_MESH_SHADING		BIT(3)
 #define MALI_C55_REG_BYPASS_3_WHITE_BALANCE		BIT(4)
-#define MALI_C55_REG_BYPASS_3_IRIDIX			BIT(5)
-#define MALI_C55_REG_BYPASS_3_IRIDIX_GAIN		BIT(6)
+#define MALI_C55_REG_BYPASS_3_IRIDIX_GAIN		BIT(5)
+#define MALI_C55_REG_BYPASS_3_IRIDIX			BIT(6)
 #define MALI_C55_REG_BYPASS_4				0x18ec0
 #define MALI_C55_REG_BYPASS_4_DEMOSAIC_RGB		BIT(1)
 #define MALI_C55_REG_BYPASS_4_PF_CORRECTION		BIT(3)



