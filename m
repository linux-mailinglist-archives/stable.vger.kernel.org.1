Return-Path: <stable+bounces-247923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LzaMj9EB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:05:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B5552A79
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A360830B0193
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537F305667;
	Fri, 15 May 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="snc87FyL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95918282F1A;
	Fri, 15 May 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860420; cv=none; b=qAMbjLuCpA2faD4WW19LvblOpNHd34XdwBk8TdI5Qv5sf7IpD2u49D5brvSuMh8FT8Dbb0tTtF+KOJY0ju/87j2eD5TZ/vAEq3MpWOW8aw8jzFQ47l+dmYfMpu2egW1UOedhqrWtMi9rWQodukemOGuXK7J/P/mM93DWIVSyWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860420; c=relaxed/simple;
	bh=WoF8dBhOsxgebnM7XdzphgansWI7K0vI7QxckTnekD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA5SCqPvhD/iqiIaKlDOInp+9BdnJWPZhgVFwpbJ1gmwfcVCXFGGQzksd8IYdOwxcGKULqZiaQc0aMjq0nrE5ZAPJzA8WCv+GlSL5R8jKkWhb4LUpgHHdsEd/TNdBMwR3T2OEmKbbf1Mn1LEiPt2uxj4USF/GcWUNe3JNPpjGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=snc87FyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3FFC2BCB0;
	Fri, 15 May 2026 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860420;
	bh=WoF8dBhOsxgebnM7XdzphgansWI7K0vI7QxckTnekD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=snc87FyLLsb1ZycIQYCbxdiGFKJiwy7GXCROsIHHvuszrcYMKe41Ax3CTQrJe0KWb
	 3MeX4NYTKsIPcMxuLt7e4E35NwQ+6Jp9Av7Q7lFPEK7qxuWHJy27/CGPz3FqPkkdhA
	 kHX5iFnCyKhRtm544MSg6XB7jRU6BxncZrSW5Acg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12 082/144] drm/xe/bo: Fix bo leak on unaligned size validation in xe_bo_init_locked()
Date: Fri, 15 May 2026 17:48:28 +0200
Message-ID: <20260515154655.426928030@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 481B5552A79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247923-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

commit 09a8f3c1c11977a6e10c167f26dd298790b31c32 upstream.

When type is ttm_bo_type_device and aligned_size != size, the function
returns an error without freeing a caller-provided bo, violating the
documented contract that bo is freed on failure.

Add xe_bo_free(bo) before returning the error.

Fixes: 4e03b584143e ("drm/xe/uapi: Reject bo creation of unaligned size")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260408175255.3402838-2-shuicheng.lin@intel.com
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
(cherry picked from commit 601c2aa087b6f21014300a3f107a08ee4dde7bdf)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_bo.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1334,8 +1334,10 @@ struct xe_bo *___xe_bo_create_locked(str
 		alignment = SZ_4K >> PAGE_SHIFT;
 	}
 
-	if (type == ttm_bo_type_device && aligned_size != size)
+	if (type == ttm_bo_type_device && aligned_size != size) {
+		xe_bo_free(bo);
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (!bo) {
 		bo = xe_bo_alloc();



