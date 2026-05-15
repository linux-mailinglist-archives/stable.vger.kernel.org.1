Return-Path: <stable+bounces-248819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJvmJe5SB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:07:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 293365547B7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03E6531E93A5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C13F9285;
	Fri, 15 May 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZB9B5B9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF5326939;
	Fri, 15 May 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862713; cv=none; b=Y+Ub8dhct1jxqAYU6T0WXdxYhzNgTmYt5dwgp/Sh47j599MatpG044sdJLDlgPp/l2nsq/hp8PcwFkR0z7KYn9zhc6Uh/pud3IoiZosjq/vtV+EXEws9c0PBtnHCFgxwvtcoKnrZVHvDy64+PUOyEF6sQCcWPDHuR1ktU84HAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862713; c=relaxed/simple;
	bh=4JsyWznSmNAqRwUQMEFjANdrSdQTNhLwVpKo56+9T44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fl4dLMZmJ6RnzzWueGi08PGA2xHiKKFYTObDTVwb955IKhO7S0pkvwPa7HfF10PBoz9igl3v47q8MltbcrbcwoGyUzaiV9PiydZWlgJ72jO59hfz9Rneuvl8XA3Mzv0vVLRecKwdwtrb6lSUk1dLiKNfbshZCaQ/1ftG6IKxQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZB9B5B9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E10BC2BCB0;
	Fri, 15 May 2026 16:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862712;
	bh=4JsyWznSmNAqRwUQMEFjANdrSdQTNhLwVpKo56+9T44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZB9B5B9HrU3KFviT0ZJb/J8xojweFV6PTXLwYz9QSLCjCWuWxA13ok8mOChSGUhV
	 NQhi1SGdBnYiRgVsq8QYnd4d2W5P+TYOiAMyh7L4zRmgXZUFmEwPVIDsHnH1RDXvMN
	 oyFNwE3sPx2XQ7mXDggzgqAYBzT2+ANVi2F+PUNE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Francis <David.Francis@amd.com>,
	Puttimet Thammasaeng <pwn8official@gmail.com>,
	Vitaly Prosyak <Vitaly.Prosyak@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Christian Koenig <Christian.Koenig@amd.com>,
	Dave Airlie <airlied@redhat.com>,
	Dave Airlie <airlied@gmail.com>
Subject: [PATCH 7.0 154/201] drm: Set old handle to NULL before prime swap in change_handle
Date: Fri, 15 May 2026 17:49:32 +0200
Message-ID: <20260515154701.908468871@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 293365547B7
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,amd.com,gmail.com,ffwll.ch,redhat.com];
	TAGGED_FROM(0.00)[bounces-248819-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francis, David <David.Francis@amd.com>

commit 5e28b7b94408897e41c63477aabc9e1db439bc8c upstream.

There was a potential race condition in change_handle. The ioctl
briefly had a single object with two idr entries; a concurrent
gem_close could delete the object and remove one of the handles
while leaving the other one dangling, which could subsequently
be dereferenced for a use-after-free.

To fix this, do the same dance that gem_close itself does.
(f6cd7daecff5 drm: Release driver references to handle before making it available again)
First idr_replace the old handle to NULL. Later, if the prime
operations are successful, actually close it.

create_tail required a similar dance to avoid a similar problem.
(bd46cece51a3 drm/gem: Fix race in drm_gem_handle_create_tail())
It idr_allocs the new handle with NULL, then swaps in the correct
object later to avoid races. We don't need to do that here, since
the only operations that could race are drm_prime, and
change_handle holds the prime lock for the entire duration.

v2: cleanups of error paths

Signed-off-by: David Francis <David.Francis@amd.com>
Co-authored-by: Dave Airlie <airlied@gmail.com>
Reported-by: Puttimet Thammasaeng <pwn8official@gmail.com>
Tested-by: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org
Cc: Christian Koenig <Christian.Koenig@amd.com>
Fixes: 53096728b8910 ("drm: Add DRM prime interface to reassign GEM handle")
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_gem.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1001,7 +1001,7 @@ int drm_gem_change_handle_ioctl(struct d
 				struct drm_file *file_priv)
 {
 	struct drm_gem_change_handle *args = data;
-	struct drm_gem_object *obj;
+	struct drm_gem_object *obj, *idrobj;
 	int handle, ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_GEM))
@@ -1024,8 +1024,29 @@ int drm_gem_change_handle_ioctl(struct d
 	mutex_lock(&file_priv->prime.lock);
 
 	spin_lock(&file_priv->table_lock);
+
+       /* When create_tail allocs an obj idr, it needs to first alloc as NULL,
+	* then later replace with the correct object. This is not necessary
+	* here, because the only operations that could race are drm_prime
+	* bookkeeping, and we hold the prime lock.
+	*/
 	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
 			GFP_NOWAIT);
+
+       if (ret < 0) {
+	       spin_unlock(&file_priv->table_lock);
+	       goto out_unlock;
+       }
+
+       idrobj = idr_replace(&file_priv->object_idr, NULL, handle);
+       if (idrobj != obj) {
+	       idr_replace(&file_priv->object_idr, idrobj, handle);
+	       idr_remove(&file_priv->object_idr, args->new_handle);
+	       spin_unlock(&file_priv->table_lock);
+	       ret = -ENOENT;
+	       goto out_unlock;
+       }
+
 	spin_unlock(&file_priv->table_lock);
 
 	if (ret < 0)
@@ -1037,6 +1058,8 @@ int drm_gem_change_handle_ioctl(struct d
 		if (ret < 0) {
 			spin_lock(&file_priv->table_lock);
 			idr_remove(&file_priv->object_idr, handle);
+			idrobj = idr_replace(&file_priv->object_idr, obj, handle);
+			WARN_ON(idrobj != NULL);
 			spin_unlock(&file_priv->table_lock);
 			goto out_unlock;
 		}



