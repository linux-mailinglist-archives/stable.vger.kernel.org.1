Return-Path: <stable+bounces-248791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QESiH/5KB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:34:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0FD553799
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2806F301CF5A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53E3CF96B;
	Fri, 15 May 2026 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLBD0yVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDFB3C76A0;
	Fri, 15 May 2026 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862640; cv=none; b=bcIfjyy5X01ASlc0daRU5LmH840laiKomvK5kdbjdrWyb58IRxp7znv+j3U9hEXQ0rIOjtsi/4KfaUyzqH/sjWj0rf9fZ+V1jcdFlskSCrvg/QKCjPxxQwOgHgkMhclvqPZpOdFeb2QQwYZBgET0aJbooJyYPP42FKspWD3mVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862640; c=relaxed/simple;
	bh=CgMSpeCsmD5sSdVQz7PkXzKWiZ4kR+AdikxNd6G6jOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKqGNSQPExpbvQ0u9Rfdv2h0aYzc56Fk6o2/hETDRFJpLVSssayMBXXRNVheps8Gbf5NMpiVQU8QcMyHYlp7+wsnEWSAZySw/oSLmFgrKW0NsHMvhYbPVNl+20Sg4ZKJ7gjp+wxr8Ev7owfcF3Ytv1s6a6K7jAUZpexEsicZkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLBD0yVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2222CC2BCB0;
	Fri, 15 May 2026 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862640;
	bh=CgMSpeCsmD5sSdVQz7PkXzKWiZ4kR+AdikxNd6G6jOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gLBD0yVtsCsgYSFHmUUA1hIFeYh0BMcvObNp5p4hcG2+2M7h/8ZUPbvnIDD6RpeG5
	 VRpPdOTX7CgZKOHs+waYOiIqI3BUww26vNrAxmCfxmeIZ9yut6czPn1G7gBzpferqL
	 LOY/19cxsyBz1CtPgK6VtqvgIAPGOr9NVG9GUK3w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: [PATCH 7.0 124/201] drm/msm/gem: fix error handling in msm_ioctl_gem_info_get_metadata()
Date: Fri, 15 May 2026 17:49:02 +0200
Message-ID: <20260515154701.248054912@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A0FD553799
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248791-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,patchwork.freedesktop.org:url,qualcomm.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>

commit 47cbfe2608314b833ad61a65827d8fb363bc2d2d upstream.

msm_ioctl_gem_info_get_metadata() always returns 0 regardless of
errors. When copy_to_user() fails or the user buffer is too small,
the error code stored in ret is ignored because the function
unconditionally returns 0. This causes userspace to believe the
ioctl succeeded when it did not.

Additionally, kmemdup() can return NULL on allocation failure, but
the return value is not checked. This leads to a NULL pointer
dereference in the subsequent copy_to_user() call.

Add the missing NULL check for kmemdup() and return ret instead of 0.

Note that the SET counterpart (msm_ioctl_gem_info_set_metadata)
correctly returns ret.

Fixes: 9902cb999e4e ("drm/msm/gem: Add metadata")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Patchwork: https://patchwork.freedesktop.org/patch/714478/
Message-ID: <20260325114635.383241-1-yasuakitorimaru@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_drv.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -536,6 +536,11 @@ static int msm_ioctl_gem_info_get_metada
 	len = msm_obj->metadata_size;
 	buf = kmemdup(msm_obj->metadata, len, GFP_KERNEL);
 
+	if (!buf) {
+		msm_gem_unlock(obj);
+		return -ENOMEM;
+	}
+
 	msm_gem_unlock(obj);
 
 	if (*metadata_size < len) {
@@ -548,7 +553,7 @@ static int msm_ioctl_gem_info_get_metada
 
 	kfree(buf);
 
-	return 0;
+	return ret;
 }
 
 static int msm_ioctl_gem_info(struct drm_device *dev, void *data,



