Return-Path: <stable+bounces-215308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN4kBHv2iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:00:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA151115AB
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DE2E312C3AD
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E66285073;
	Mon,  9 Feb 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jc5nDHfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4725DB1C;
	Mon,  9 Feb 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648372; cv=none; b=ZTP4xnRWUrerOEJFpnjvO5X6KSj/sIDaFMtzgbmzDzJSeIDitfx9NdYbnxRmwVSTvKcVkjbiYeTvWzBTYFkPhLd+vcIz205ar3+9aXpdSDsaTAawDNQnjZxBbEM2R73tjeux6xmdOLj7J7gbNMeEoM3HszuIJIyqKtz6H6Yr+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648372; c=relaxed/simple;
	bh=C90VQo7d4fPSd3uxRRSykOKPNwpzPiORI86T9hR0Oc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4SVEppSHMX3THw22EwxI7MI1oAG4fVIm6qleQpVNEENWY45BHIoU44TtDi6HhZs6YcHh8qHmhBhG5qTsydrjgwT46CKUD+e3HtIRy5TyxXqQq55tKz38M+F2jhsgMpdW/zlKLFW6+GumMg2sN9yZIyQqi4YKdbDBB5xA6NlRX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jc5nDHfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB014C116C6;
	Mon,  9 Feb 2026 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648372;
	bh=C90VQo7d4fPSd3uxRRSykOKPNwpzPiORI86T9hR0Oc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jc5nDHfM+H5hVLxEZoKh8JXe+gH1c6P14XPWbNbbGXfQTBJYkLXvuGLhqgpKh+IdQ
	 snNB3BjXAzvmnHaXK05FXGsyE8BEasklZZgYt0w5bgsTntC1mSk14gQPTEtTN9sYKc
	 pcVefvveo7boJ5rpk5vmh4QvAFxXlnXLJm2uGskY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carlos Llamas <cmllamas@google.com>
Subject: [PATCH 6.6 18/86] binderfs: fix ida_alloc_max() upper bound
Date: Mon,  9 Feb 2026 15:23:41 +0100
Message-ID: <20260209142305.433569215@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215308-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 5EA151115AB
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Llamas <cmllamas@google.com>

commit ec4ddc90d201d09ef4e4bef8a2c6d9624525ad68 upstream.

The 'max' argument of ida_alloc_max() takes the maximum valid ID and not
the "count". Using an ID of BINDERFS_MAX_MINOR (1 << 20) for dev->minor
would exceed the limits of minor numbers (20-bits). Fix this off-by-one
error by subtracting 1 from the 'max'.

Cc: stable@vger.kernel.org
Fixes: 3ad20fe393b3 ("binder: implement binderfs")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Link: https://patch.msgid.link/20260127235545.2307876-2-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binderfs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -130,8 +130,8 @@ static int binderfs_binder_device_create
 	mutex_lock(&binderfs_minors_mutex);
 	if (++info->device_count <= info->mount_opts.max)
 		minor = ida_alloc_max(&binderfs_minors,
-				      use_reserve ? BINDERFS_MAX_MINOR :
-						    BINDERFS_MAX_MINOR_CAPPED,
+				      use_reserve ? BINDERFS_MAX_MINOR - 1 :
+						    BINDERFS_MAX_MINOR_CAPPED - 1,
 				      GFP_KERNEL);
 	else
 		minor = -ENOSPC;
@@ -421,8 +421,8 @@ static int binderfs_binder_ctl_create(st
 	/* Reserve a new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
 	minor = ida_alloc_max(&binderfs_minors,
-			      use_reserve ? BINDERFS_MAX_MINOR :
-					    BINDERFS_MAX_MINOR_CAPPED,
+			      use_reserve ? BINDERFS_MAX_MINOR - 1 :
+					    BINDERFS_MAX_MINOR_CAPPED - 1,
 			      GFP_KERNEL);
 	mutex_unlock(&binderfs_minors_mutex);
 	if (minor < 0) {



