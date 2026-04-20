Return-Path: <stable+bounces-239484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E63H3Je5mndvQEAu9opvQ
	(envelope-from <stable+bounces-239484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:12:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA0430BA5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1002A398F933
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8CD336EC9;
	Mon, 20 Apr 2026 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MB83Q4f1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC02D978C;
	Mon, 20 Apr 2026 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700371; cv=none; b=Tn4gz5Hj1LRW+zLNv5WIy9lUn7E/QkbB4MaHnhzRyxRlixbk3+yCTacEK82dKhh9G9nsodDobx2tAKaH8eJ6iJgtrIT2AF2+oMhUp400YMkgIOZ2L8UIpMUIhctTNp9QyaUmT43MFgOMUL7dbiwMmBLD36Pe4uWjithEsr9JtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700371; c=relaxed/simple;
	bh=yzHdlgyLCA/xYM7K3zysFazgPx3spysWO34ZhVbZcrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPJtIJjB4PZEJe2AgMBeAbeHroY4IBC+FEdRsBvHVnFAwUS7/sIEtMsMXnUOIORCTQtTF/tHeBwe5pjBdS+1skYpK77sciqGkUABcqhmbkVHHsjXyT5U6iLCHS945TOsT5liMuHebF5GtmE2RDjlaPzee1ZcVeM3Z8sUMkSd8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MB83Q4f1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE39C19425;
	Mon, 20 Apr 2026 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700371;
	bh=yzHdlgyLCA/xYM7K3zysFazgPx3spysWO34ZhVbZcrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MB83Q4f16WVx8lyqosQcxw5ufl2cnlL3uYi8P2XuUgtAlHGep7W4Lh2fAHK8Csbsn
	 xaqdy04APf0n3I3vHjNun9fy7nDVeQmpZ/9hOIF1pg5Xf0kADuUm23FoGFeoA7quMb
	 4wzLlga5YE4iuipvv41MldLjsQ/14ThIws0qGDX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 113/220] drm/xe: Fix bug in idledly unit conversion
Date: Mon, 20 Apr 2026 17:40:54 +0200
Message-ID: <20260420153938.099683591@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239484-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 0FAA0430BA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

[ Upstream commit 7596459f3c93d8d45a1bf12d4d7526b50c15baa2 ]

We only need to convert to picosecond units before writing to RING_IDLEDLY.

Fixes: 7c53ff050ba8 ("drm/xe: Apply Wa_16023105232")
Cc: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>
Acked-by: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Link: https://patch.msgid.link/20260401012710.4165547-1-vinay.belgaumkar@intel.com
(cherry picked from commit 13743bd628bc9d9a0e2fe53488b2891aedf7cc74)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_hw_engine.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index 6a9e2a4272dde..3e928b6c098f2 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -596,9 +596,8 @@ static void adjust_idledly(struct xe_hw_engine *hwe)
 		maxcnt *= maxcnt_units_ns;
 
 		if (xe_gt_WARN_ON(gt, idledly >= maxcnt || inhibit_switch)) {
-			idledly = DIV_ROUND_CLOSEST(((maxcnt - 1) * maxcnt_units_ns),
+			idledly = DIV_ROUND_CLOSEST(((maxcnt - 1) * 1000),
 						    idledly_units_ps);
-			idledly = DIV_ROUND_CLOSEST(idledly, 1000);
 			xe_mmio_write32(&gt->mmio, RING_IDLEDLY(hwe->mmio_base), idledly);
 		}
 	}
-- 
2.53.0




