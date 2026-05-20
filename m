Return-Path: <stable+bounces-249981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB+GHGnJDWo33QUAu9opvQ
	(envelope-from <stable+bounces-249981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:47:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB1F58FFD2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 174DB3039247
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5733E95B3;
	Wed, 20 May 2026 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="waPjSnoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0143ED3DA
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288207; cv=none; b=erFKrc8cttkdFib+nayFMrz4f46uf6jF2w4mJVxyntApZjdTW02jBbdiXYVbjdiH7nvOseKKG7DjnfAXOQebObkCk0M0OsQ24+LH2lUIws2WTF/acCyc7hV0xHoJM+vjdzyZ+vwjwSyJkjelBJwz1oyyjurIfJX84P4JjLrArS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288207; c=relaxed/simple;
	bh=FlhLe5jDbuWHauNzXf/tZsgNnFJgYV+MZ+hk/h6//Pc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d8DjlmYn2IUlwQ2/TduG3yguczXRZW1fM3fmsHGRlseEuLDlhfBHZXrhAGXIhxVHKEQPN2XuNs2mvcnUorVWXufjaMrvrldv/DoLPSy/e5+5BkNdK4Usjh6FQE3K3jfXtJzysxmsfYV2CpLESOeY3QrQnBcsOD+soCv0yu5SVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=waPjSnoF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290C91F00893;
	Wed, 20 May 2026 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288205;
	bh=doinjKu8mzb3bfwv8j8p3fD7TSs3DyZb+FSIwDk6QTk=;
	h=Subject:To:Cc:From:Date;
	b=waPjSnoFNN2W8FXtumvU+klgrsBhbJyiQCCz3ZL8ibS9iFNcbOeDq0GNMpNhGC00a
	 Qey7nSOKOtmfiLOlVP+lGP0ip66hLyJQAcdgrb2sFV8Q4Y7WecO9ILw1j3HmBlIVUc
	 UrTNW97VlzBqvs9TDwJLBKZvAhN+JlA+A/F1WAdA=
Subject: FAILED: patch "[PATCH] media: rc: ttusbir: fix inverted error logic" failed to apply to 6.6-stable tree
To: oneukum@suse.com,hverkuil+cisco@kernel.org,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:43:16 +0200
Message-ID: <2026052016-negotiate-unclad-a517@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249981-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0CB1F58FFD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 646ebdd3105809d84ed04aa9e92e47e89cc44502
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052016-negotiate-unclad-a517@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 646ebdd3105809d84ed04aa9e92e47e89cc44502 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Fri, 10 Apr 2026 23:03:09 +0200
Subject: [PATCH] media: rc: ttusbir: fix inverted error logic

We have to report ENOMEM if no buffer is allocated.
Typo dropped a "!". Restore it.

Fixes: 50acaad3d202 ("media: rc: ttusbir: respect DMA coherency rules")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
index 3848ad3a6b85..db2f6698a6c0 100644
--- a/drivers/media/rc/ttusbir.c
+++ b/drivers/media/rc/ttusbir.c
@@ -191,7 +191,7 @@ static int ttusbir_probe(struct usb_interface *intf,
 	tt = kzalloc_obj(*tt);
 	buffer = kzalloc(5, GFP_KERNEL);
 	rc = rc_allocate_device(RC_DRIVER_IR_RAW);
-	if (!tt || !rc || buffer) {
+	if (!tt || !rc || !buffer) {
 		ret = -ENOMEM;
 		goto out;
 	}


