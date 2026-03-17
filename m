Return-Path: <stable+bounces-225830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOi7IqU9uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:40:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D32A910A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6AD5308510B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A8934A3A2;
	Tue, 17 Mar 2026 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CyH0TVM7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037633067A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747203; cv=none; b=ApLQJCvN8n3JJfivpM0/XOE1m/xp50ASKp7qGvJbrMl5YJQB5XvIsJltci17MVY/ZdEqk+hZukSzYoCfVlQCzZEZidYHu2F/qZcXRUjg9LOQnAKWc3lDUKHLIcenwebbvzFI/cyfdIbZpvB/2N3ryMFi9fcXbuG3tVBAhVzGmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747203; c=relaxed/simple;
	bh=NFitPmyIuevu2qyMFM8PhTDiHvkP5U8DuWrKl2MYlAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XuwB4xsiey6ex0djE3z1ZdHi3E54tJxWSPuLvOyoq6gVo8dXu6MFScLqS2d3AmMupPf3NeQ0oy1iVMt9qczrugKDIaPUiSe+iTcKULzwWIbp5OCDNpWY4kkEVlXRlClr7beh2T+I0GpnzNxYnlmAMkTGUcESApr3XYKIYq4MYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CyH0TVM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458FCC4CEF7;
	Tue, 17 Mar 2026 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773747202;
	bh=NFitPmyIuevu2qyMFM8PhTDiHvkP5U8DuWrKl2MYlAg=;
	h=Subject:To:Cc:From:Date:From;
	b=CyH0TVM72UQVtZMKdmzcBXKhqNG4JjEfuenDi9aVP8/crLYV0eFjZGaeVoHDum91B
	 d8oKaCt9b/QAELcW/mtAPiJbbLnT/34lfaawKNXxLFsHa7mh68nqCCzTi+bmJnnsGB
	 c8ZiVyr/GrfbljHQ6Sn81t6H8Q3X1hkT3rO203Uk=
Subject: FAILED: patch "[PATCH] nouveau/gsp: drop WARN_ON in ACPI probes" failed to apply to 6.12-stable tree
To: airlied@redhat.com,dakr@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:33:17 +0100
Message-ID: <2026031717-hydrant-dreaded-5b32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225830-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 914D32A910A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9478c166c46934160135e197b049b5a05753f2ad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031717-hydrant-dreaded-5b32@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9478c166c46934160135e197b049b5a05753f2ad Mon Sep 17 00:00:00 2001
From: Dave Airlie <airlied@redhat.com>
Date: Thu, 21 Nov 2024 11:46:01 +1000
Subject: [PATCH] nouveau/gsp: drop WARN_ON in ACPI probes

These WARN_ONs seem to trigger a lot, and we don't seem to have a
plan to fix them, so just drop them, as they are most likely
harmless.

Cc: stable@vger.kernel.org
Fixes: 176fdcbddfd2 ("drm/nouveau/gsp/r535: add support for booting GSP-RM")
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patch.msgid.link/20241121014601.229391-1-airlied@gmail.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index 7fb13434c051..a575a8dbf727 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -737,8 +737,8 @@ r535_gsp_acpi_caps(acpi_handle handle, CAPS_METHOD_DATA *caps)
 	if (!obj)
 		goto done;
 
-	if (WARN_ON(obj->type != ACPI_TYPE_BUFFER) ||
-	    WARN_ON(obj->buffer.length != 4))
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length != 4)
 		goto done;
 
 	caps->status = 0;
@@ -773,8 +773,8 @@ r535_gsp_acpi_jt(acpi_handle handle, JT_METHOD_DATA *jt)
 	if (!obj)
 		goto done;
 
-	if (WARN_ON(obj->type != ACPI_TYPE_BUFFER) ||
-	    WARN_ON(obj->buffer.length != 4))
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length != 4)
 		goto done;
 
 	jt->status = 0;
@@ -861,8 +861,8 @@ r535_gsp_acpi_dod(acpi_handle handle, DOD_METHOD_DATA *dod)
 
 	_DOD = output.pointer;
 
-	if (WARN_ON(_DOD->type != ACPI_TYPE_PACKAGE) ||
-	    WARN_ON(_DOD->package.count > ARRAY_SIZE(dod->acpiIdList)))
+	if (_DOD->type != ACPI_TYPE_PACKAGE ||
+	    _DOD->package.count > ARRAY_SIZE(dod->acpiIdList))
 		return;
 
 	for (int i = 0; i < _DOD->package.count; i++) {


