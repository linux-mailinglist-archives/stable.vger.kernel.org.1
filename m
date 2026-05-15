Return-Path: <stable+bounces-247921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLyvLh5EB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:04:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E12A552A34
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49FD430234C8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5DA3FF1DE;
	Fri, 15 May 2026 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="idwRZkwy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208C3FF1DA;
	Fri, 15 May 2026 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860415; cv=none; b=TxcomrEMmqjK7ta2YBX6H5D74SjlRQ7vn2DWfJrc1uBA1QzX3u1UR2YD+TXe7QuSPHRkWT4hsY2hWwG8y8IejICJ86vyIPh4YvgMZfK9HVEllLf+x4wlz5Vm9O0fh6RDiziEm9xbS6P3bNF+TZ+e6UHUDaHPTLOHJqBlHnp/A7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860415; c=relaxed/simple;
	bh=IYHQX7eLVtXpIUIwSZFOXlfvJsEoBPS/eHSEAPmUmQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFHTJxI1fEGDO1psiH43phYnxhPvJKzyuVrWB2cuY02AtxmZv6cxczLG8pyahXUhub85aiR4GZy1jdkwP6vKdf0RDxq9uByIFYMKqDiBU1hROqEiSjSl7BmBEqgRkGsSG9/RYp/OIHj56zm/zNuSODPbVIOmqk98HRcDrb2nFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=idwRZkwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ACCC2BCB0;
	Fri, 15 May 2026 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860415;
	bh=IYHQX7eLVtXpIUIwSZFOXlfvJsEoBPS/eHSEAPmUmQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idwRZkwyJ9JdKy3trCaQ5hIVHvZKUNhQRobzXEVtrxJGlJqA2yusOxa9AGfA48HjA
	 lEt3D+oMvtKC4jHqlhHJY1rB948nbOJImIOQ003znAenyKtzT9ZooO7H5IJdvDCq5a
	 yf9uC/T9qEn9YuwYCBYjzDfshNCw6V/fcEkmcc6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12 080/144] drm/xe/bo: Fix bo leak on GGTT flag validation in xe_bo_init_locked()
Date: Fri, 15 May 2026 17:48:26 +0200
Message-ID: <20260515154655.383652165@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4E12A552A34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247921-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

commit 1d0adf2fd94fb0c0037c643fadd8f2cf3cffc009 upstream.

When XE_BO_FLAG_GGTT_ALL is set without XE_BO_FLAG_GGTT, the function
returns an error without freeing a caller-provided bo, violating the
documented contract that bo is freed on failure.

Add xe_bo_free(bo) before returning the error.

Fixes: 5a3b0df25d6a ("drm/xe: Allow bo mapping on multiple ggtts")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260408175255.3402838-3-shuicheng.lin@intel.com
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
(cherry picked from commit 3fbd6cf43cac7b60757f3ce3d95195d3843a902c)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_bo.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1312,8 +1312,10 @@ struct xe_bo *___xe_bo_create_locked(str
 	}
 
 	/* XE_BO_FLAG_GGTTx requires XE_BO_FLAG_GGTT also be set */
-	if ((flags & XE_BO_FLAG_GGTT_ALL) && !(flags & XE_BO_FLAG_GGTT))
+	if ((flags & XE_BO_FLAG_GGTT_ALL) && !(flags & XE_BO_FLAG_GGTT)) {
+		xe_bo_free(bo);
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (flags & (XE_BO_FLAG_VRAM_MASK | XE_BO_FLAG_STOLEN) &&
 	    !(flags & XE_BO_FLAG_IGNORE_MIN_PAGE_SIZE) &&



