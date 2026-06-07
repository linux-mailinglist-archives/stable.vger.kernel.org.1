Return-Path: <stable+bounces-261713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WevvJ/JNJWp0GgIAu9opvQ
	(envelope-from <stable+bounces-261713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:54:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A506501D6
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:54:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tbGDcWOB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261713-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261713-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D80A303B596
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98860308F38;
	Sun,  7 Jun 2026 10:52:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E32E3AF1;
	Sun,  7 Jun 2026 10:52:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829564; cv=none; b=a3uxjIiwGzf0xOHMhUqksCeZcVINkcqj7Rkp+a9j1AkeRgTdcO/i/skIjK8yBjIB1Ge1+WwWbocYUMAjKlUC+8x2QoykSvCEx0XiVI+dsSP2gYUc0bg6wBde+eETYT0yPYnYNtm+p0ZSFFVE9zJsyPi0/EIRTgUCn7K6r8HejMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829564; c=relaxed/simple;
	bh=iBn8xnGReTDV8PX3SnIiyWBMktcynjWHfJicdjrzqQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBLSQLCdfkeUot05TsUFP41esn+KA4IVWlN8ihwzeDx3cgV9R0r+TEQVchHMFAnWT0mB/TuwHdOjIU6H08zi1D41PCKX3vNv7qIUslAuozKQuI7IxTAY34OSRuxQd5RYbqWDumubYN6SlUQO5ICvECkkhuXGF9GF7ALxP5w+/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tbGDcWOB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CC31F00893;
	Sun,  7 Jun 2026 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829563;
	bh=O3Xw0hgBE1FJ7Y9b7cqcTRC2xkbaWYIFtPeDB33nC1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tbGDcWOB29ajg041zsqT12ZOf6uBQfsufEPp4qHNXmmlfaXK54NnFY9/O0gQXBTYE
	 jK10oUrnwbEBtopFo0xAwTUm6ZiV75gxJVEmFIP1Y0pkrtSCt1an4VMyg1GSS1kc1/
	 qh4oxVOKvb2LkwA1GBX3wHisBgNRczXY3rBW69Bo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhenghang Xiao <kipreyyy@gmail.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH 7.0 290/332] drm/gem: fix race between change_handle and handle_delete
Date: Sun,  7 Jun 2026 12:00:59 +0200
Message-ID: <20260607095738.700475098@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261713-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kipreyyy@gmail.com,m:airlied@redhat.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44A506501D6

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenghang Xiao <kipreyyy@gmail.com>

commit 7164d78559b0ff29931a366a840a9e5dd53d4b7c upstream.

drm_gem_change_handle_ioctl leaves the old handle live in the IDR
during the window between spin_unlock(table_lock) and the final
spin_lock(table_lock). A concurrent drm_gem_handle_delete on the old
handle succeeds in this window, decrements handle_count to 0, and frees
the GEM object while the new handle's IDR entry still references it.

NULL the old handle's IDR entry before dropping table_lock so that any
concurrent GEM_CLOSE on the old handle sees NULL and returns -EINVAL.
Restore the old entry on the prime-bookkeeping error path.

Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patch.msgid.link/20260526085313.26791-1-kipreyyy@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_gem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1047,6 +1047,7 @@ int drm_gem_change_handle_ioctl(struct d
 	       goto out_unlock;
        }
 
+	idr_replace(&file_priv->object_idr, NULL, args->handle);
 	spin_unlock(&file_priv->table_lock);
 
 	if (obj->dma_buf) {
@@ -1055,6 +1056,7 @@ int drm_gem_change_handle_ioctl(struct d
 		if (ret < 0) {
 			spin_lock(&file_priv->table_lock);
 			idr_remove(&file_priv->object_idr, handle);
+			idr_replace(&file_priv->object_idr, obj, args->handle);
 			spin_unlock(&file_priv->table_lock);
 			goto out_unlock;
 		}



