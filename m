Return-Path: <stable+bounces-210557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLt5BeTDb2lsMQAAu9opvQ
	(envelope-from <stable+bounces-210557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:05:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC194913B
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD0C47C0AE7
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5B743DA26;
	Tue, 20 Jan 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nHtlT1ph"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692601F1304
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921153; cv=none; b=IBaIMw6okOLDFUWVuz68c5fkoWz0zUMIFhDNS2j81G+uFjVxXzYSbp9BdqekWAYdww+98q02IPAbtUrC/qluotp3voWM6+5DSrshfTMBkarYsL7rusw0JUhMSgcDm16AGmmralgHeEZzgRHgXSydg1ipTGEnnFoSkhx3zeb+fdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921153; c=relaxed/simple;
	bh=cuL1B56TlRUvHvSctfLn/OK+DYnPscZnjnsPsUsYCC8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iyOFvkWXHQw38sd2wbvcxIcNI+AJd7HgZ+h57KYdDhT9dTldapvKKoYwSBEt5LBgHGPCS05dWVMWrxwlIixqctq+Gtb10mBJ6ZfN+6xOGT9nwVxffM4fwiBZucOEFbYCkSVFSMwiiko3fFzdkSgp6/N6aBAbTotyprqObhd4ELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nHtlT1ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B78AC16AAE;
	Tue, 20 Jan 2026 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768921152;
	bh=cuL1B56TlRUvHvSctfLn/OK+DYnPscZnjnsPsUsYCC8=;
	h=Subject:To:Cc:From:Date:From;
	b=nHtlT1ph6q+c8TyBQgEa5USKPQ52hvFxiUZ7T12M1Cqvq9LirlbSmfvt7Q1DdxH4Q
	 leMciGBb/qAhUKfDjlwmdB2cajECFmBelIZjDFQOIZVJ7J70W/RU0/2ZZwyMeidnj4
	 pi4mMoqBTznfi9jgv17M4gOrKC7OeaaSXcdjslXU=
Subject: FAILED: patch "[PATCH] drm/amd/display: Initialise backlight level values from hw" failed to apply to 6.12-stable tree
To: vivek@collabora.com,alexander.deucher@amd.com,superm1@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 15:59:10 +0100
Message-ID: <2026012010-maybe-province-85bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210557-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,collabora.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,amd.com:email,gregkh:email]
X-Rspamd-Queue-Id: 8CC194913B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 52d3d115e9cc975b90b1fc49abf6d36ad5e8847a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012010-maybe-province-85bf@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52d3d115e9cc975b90b1fc49abf6d36ad5e8847a Mon Sep 17 00:00:00 2001
From: Vivek Das Mohapatra <vivek@collabora.com>
Date: Mon, 12 Jan 2026 15:28:56 +0000
Subject: [PATCH] drm/amd/display: Initialise backlight level values from hw

Internal backlight levels are initialised from ACPI but the values
are sometimes out of sync with the levels in effect until there has
been a read from hardware (eg triggered by reading from sysfs).

This means that the first drm_commit can cause the levels to be set
to a different value than the actual starting one, which results in
a sudden change in brightness.

This path shows the problem (when the values are out of sync):

   amdgpu_dm_atomic_commit_tail()
   -> amdgpu_dm_commit_streams()
   -> amdgpu_dm_backlight_set_level(..., dm->brightness[n])

This patch calls the backlight ops get_brightness explicitly
at the end of backlight registration to make sure dm->brightness[n]
is in sync with the actual hardware levels.

Fixes: 2fe87f54abdc ("drm/amd/display: Set default brightness according to ACPI")
Signed-off-by: Vivek Das Mohapatra <vivek@collabora.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 318b1c36d82a0cd2b06a4bb43272fa6f1bc8adc1)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 936c3bc3f2d6..fae88ce8327f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5266,6 +5266,8 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	struct amdgpu_dm_backlight_caps *caps;
 	char bl_name[16];
 	int min, max;
+	int real_brightness;
+	int init_brightness;
 
 	if (aconnector->bl_idx == -1)
 		return;
@@ -5290,6 +5292,8 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	} else
 		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
 
+	init_brightness = props.brightness;
+
 	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)) {
 		drm_info(drm, "Using custom brightness curve\n");
 		props.scale = BACKLIGHT_SCALE_NON_LINEAR;
@@ -5308,8 +5312,20 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
 		drm_err(drm, "DM: Backlight registration failed!\n");
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
-	} else
+	} else {
+		/*
+		 * dm->brightness[x] can be inconsistent just after startup until
+		 * ops.get_brightness is called.
+		 */
+		real_brightness =
+			amdgpu_dm_backlight_ops.get_brightness(dm->backlight_dev[aconnector->bl_idx]);
+
+		if (real_brightness != init_brightness) {
+			dm->actual_brightness[aconnector->bl_idx] = real_brightness;
+			dm->brightness[aconnector->bl_idx] = real_brightness;
+		}
 		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
+	}
 }
 
 static int initialize_plane(struct amdgpu_display_manager *dm,


