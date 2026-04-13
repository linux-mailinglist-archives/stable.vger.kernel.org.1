Return-Path: <stable+bounces-235957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KlVCZyn3GkEUgkAu9opvQ
	(envelope-from <stable+bounces-235957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:21:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F13E9071
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD868306F382
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1643A6EF4;
	Mon, 13 Apr 2026 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="CQVktpOz"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C13A6EEA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068141; cv=none; b=NE/1mMkIRnPb8i0FF3GIuswWD1icVtS09Kc95d1SJFaXvAaFZVExl/aZ1QdwhyD9TLuQY/QTzfzR2KaqYLmALAzSx4KlySJPVVSDJzffpdoUFRRofv8oexnHm9YNg7RvavOwcfF5WYskAwLOcwnrOfqkja9RxCNgZ1VJll+vPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068141; c=relaxed/simple;
	bh=/tefIa72QAAdvaLL7zPjym9ZM2g5JYQreqZruM+7q3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+02E0rbaUoMDo32s/XxLHHc2PsVWoGxcdC5mM4z3TphFsRoqOubYkdpC/+57xKpqgqQqMb2OwJhD/z1aCyQERBh4uqUBxR8JcZzA9O+akeHBkNa5Zdrrgz/w5rgeAER0l+4FG+DaV+Yzas8f0WbFfr+A4LOgFBNV9BzjBJNo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=CQVktpOz; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4fvKjs0271z88CG;
	Mon, 13 Apr 2026 10:06:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776067585;
	bh=/tefIa72QAAdvaLL7zPjym9ZM2g5JYQreqZruM+7q3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQVktpOzFi9CxaHdVlrwExV776NyJlG4QyTV6IpoPeSSPVevCjynTAXg3cQw08lTk
	 V2nU3BY35uhe3D5oYDjPfcLZG+SHBT+V2W8APDGxMI2kF9b4qOOqJOvK0ZLtd8ugrl
	 bq/WT6iI/btju00cYqtTFTCusBbxbM8AAiaC09N6oIvWOM+Y0UrfgscN0g0HYG831W
	 MSPi/a6fPVataogbwfdJUUjI8tljgGmkjetpyzDrmxZY3xbKjsO4CpI46g1+WPR5OJ
	 tbH7lWinCsG5nPvU/ufFH8ys2iQC/AI3fKcSUduqi1u+vYDvixXyWvgxr7pBt4NDNU
	 pFkuNM5ZUL2/w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4fvKjB3CKFz4yh4;
	Mon, 13 Apr 2026 10:05:50 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fvKjB0CG5z8svJ;
	Mon, 13 Apr 2026 10:05:50 +0200 (CEST)
Received: from luggage.fritz.box (unknown [IPv6:2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 8F892632D3;
	Mon, 13 Apr 2026 10:05:48 +0200 (CEST)
Authentication-Results: mxe9fb;
	spf=pass (sender IP is 2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160) smtp.mailfrom=linux@leemhuis.info smtp.helo=luggage.fritz.box
Received-SPF: pass (mxe9fb: connection is authenticated)
From: Thorsten Leemhuis <linux@leemhuis.info>
To: regressions@leemhuis.info
Cc: dri-devel@lists.freedesktop.org,
	gregkh@linuxfoundation.org,
	matt.fagnani@bell.net,
	regressions@lists.linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Maarten Lankhorst <dev@lankhorst.se>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH 6.1.y] Revert "drm: Fix use-after-free on framebuffers and
 property blobs when calling drm_dev_unplug"
Date: Mon, 13 Apr 2026 10:05:47 +0200
Message-ID: <20260413080547.3079663-1-linux@leemhuis.info>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9c667182-3a9e-4fa3-a568-1cb5b1b74106@leemhuis.info>
References: <9c667182-3a9e-4fa3-a568-1cb5b1b74106@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177606754901.3692969.13620999047659531436@mxe9fb.netcup.net>
X-NC-CID: E9ffI0a27T/UDCm6Rw2NvGctQwWJ3d4m+QfrUGuRA5KcZ31fui4=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235957-lists,stable=lfdr.de];
	DMARC_NA(0.00)[leemhuis.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,linuxfoundation.org,bell.net,lists.linux.dev,kernel.org,vger.kernel.org,lankhorst.se,linux.intel.com,roeck-us.net,ffwll.ch,leemhuis.info];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,leemhuis.info:dkim,leemhuis.info:email,leemhuis.info:mid,roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lankhorst.se:email,ffwll.ch:email,msgid.link:url];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6C3F13E9071
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maarten Lankhorst <dev@lankhorst.se>

commit 45ebe43ea00d6b9f5b3e0db9c35b8ca2a96b7e70 upstream.

This reverts commit 6bee098b91417654703e17eb5c1822c6dfd0c01d.

Den 2026-03-25 kl. 22:11, skrev Simona Vetter:
> On Wed, Mar 25, 2026 at 10:26:40AM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Fri, Mar 13, 2026 at 04:17:27PM +0100, Maarten Lankhorst wrote:
>>> When trying to do a rather aggressive test of igt's "xe_module_load
>>> --r reload" with a full desktop environment and game running I noticed
>>> a few OOPSes when dereferencing freed pointers, related to
>>> framebuffers and property blobs after the compositor exits.
>>>
>>> Solve this by guarding the freeing in drm_file with drm_dev_enter/exit,
>>> and immediately put the references from struct drm_file objects during
>>> drm_dev_unplug().
>>>
>>
>> With this patch in v6.18.20, I get the warning backtraces below.
>> The backtraces are gone with the patch reverted.
>
> Yeah, this needs to be reverted, reasoning below. Maarten, can you please
> take care of that and feed the revert through the usual channels? I don't
> think it's critical enough that we need to fast-track this into drm.git
> directly.
>
> Quoting the patch here again:
>
>>  drivers/gpu/drm/drm_file.c| 5 ++++-
>>  drivers/gpu/drm/drm_mode_config.c | 9 ++++++---
>>  2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>> index ec820686b3021..f52141f842a1f 100644
>> --- a/drivers/gpu/drm/drm_file.c
>> +++ b/drivers/gpu/drm/drm_file.c
>> @@ -233,6 +233,7 @@ static void drm_events_release(struct drm_file *file_priv)
>>  void drm_file_free(struct drm_file *file)
>>  {
>>  struct drm_device *dev;
>> +int idx;
>>
>>  if (!file)
>>  return;
>> @@ -249,9 +250,11 @@ void drm_file_free(struct drm_file *file)
>>
>>  drm_events_release(file);
>>
>> -if (drm_core_check_feature(dev, DRIVER_MODESET)) {
>> +if (drm_core_check_feature(dev, DRIVER_MODESET) &&
>> +drm_dev_enter(dev, &idx)) {
>
> This is misplaced for two reasons:
>
> - Even if we'd want to guarantee that we hold a drm_dev_enter/exit
>   reference during framebuffer teardown, we'd need to do this
>   _consistently over all callsites. Not ad-hoc in just one place that a
>   testcase hits. This also means kerneldoc updates of the relevant hooks
>   and at least a bunch of acks from other driver people to document the
>   consensus.
>
> - More importantly, this is driver responsibilities in general unless we
>   have extremely good reasons to the contrary. Which means this must be
>   placed in xe.
>
>>  drm_fb_release(file);
>>  drm_property_destroy_user_blobs(dev, file);
>> +drm_dev_exit(idx);
>>  }
>>
>>  if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
>> index 84ae8a23a3678..e349418978f79 100644
>> --- a/drivers/gpu/drm/drm_mode_config.c
>> +++ b/drivers/gpu/drm/drm_mode_config.c
>> @@ -583,10 +583,13 @@ void drm_mode_config_cleanup(struct drm_device *dev)
>>   */
>>  WARN_ON(!list_empty(&dev->mode_config.fb_list));
>>  list_for_each_entry_safe(fb, fbt, &dev->mode_config.fb_list, head) {
>> -struct drm_printer p = drm_dbg_printer(dev, DRM_UT_KMS, "[leaked fb]");
>> +if (list_empty(&fb->filp_head) || drm_framebuffer_read_refcount(fb) > 1) {
>> +struct drm_printer p = drm_dbg_printer(dev, DRM_UT_KMS, "[leaked fb]");
>
> This is also wrong:
>
> - Firstly, it's a completely independent bug, we do not smash two bugfixes
>   into one patch.
>
> - Secondly, it's again a driver bug: drm_mode_cleanup must be called when
>   the last drm_device reference disappears (hence the existence of
>   drmm_mode_config_init), not when the driver gets unbound. The fact that
>   this shows up in a callchain from a devres cleanup means the intel
>   driver gets this wrong (like almost everyone else because historically
>   we didn't know better).
>
>   If we don't follow this rule, then we get races with this code here
>   running concurrently with drm_file fb cleanups, which just does not
>   work. Review pointed that out, but then shrugged it off with a confused
>   explanation:
>
>   https://lore.kernel.org/all/e61e64c796ccfb17ae673331a3df4b877bf42d82.camel@linux.intel.com/
>
>   Yes this also means a lot of the other drm_device teardown that drivers
>   do happens way too early. There is a massive can of worms here of a
>   magnitude that most likely is much, much bigger than what you can
>   backport to stable kernels. Hotunplug is _hard_.

Back to the drawing board, and fixing it in the intel display driver
instead.

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: 6bee098b9141 ("drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Link: https://patch.msgid.link/20260326082217.39941-2-dev@lankhorst.se
[ Thorsten: adjust to the v6.6.y/v6.6.y backports of 6bee098b9141 ]
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 drivers/gpu/drm/drm_file.c        | 5 +----
 drivers/gpu/drm/drm_mode_config.c | 9 +++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git drivers/gpu/drm/drm_file.c drivers/gpu/drm/drm_file.c
index 3722c796e632f9..d6a0572984b540 100644
--- drivers/gpu/drm/drm_file.c
+++ drivers/gpu/drm/drm_file.c
@@ -239,7 +239,6 @@ static void drm_events_release(struct drm_file *file_priv)
 void drm_file_free(struct drm_file *file)
 {
 	struct drm_device *dev;
-	int idx;
 
 	if (!file)
 		return;
@@ -265,11 +264,9 @@ void drm_file_free(struct drm_file *file)
 
 	drm_events_release(file);
 
-	if (drm_core_check_feature(dev, DRIVER_MODESET) &&
-	    drm_dev_enter(dev, &idx)) {
+	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
 		drm_fb_release(file);
 		drm_property_destroy_user_blobs(dev, file);
-		drm_dev_exit(idx);
 	}
 
 	if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
diff --git drivers/gpu/drm/drm_mode_config.c drivers/gpu/drm/drm_mode_config.c
index 8c844bce4f28a5..8525ef8515406b 100644
--- drivers/gpu/drm/drm_mode_config.c
+++ drivers/gpu/drm/drm_mode_config.c
@@ -544,13 +544,10 @@ void drm_mode_config_cleanup(struct drm_device *dev)
 	 */
 	WARN_ON(!list_empty(&dev->mode_config.fb_list));
 	list_for_each_entry_safe(fb, fbt, &dev->mode_config.fb_list, head) {
-		if (list_empty(&fb->filp_head) || drm_framebuffer_read_refcount(fb) > 1) {
-			struct drm_printer p = drm_debug_printer("[leaked fb]");
+		struct drm_printer p = drm_debug_printer("[leaked fb]");
 
-			drm_printf(&p, "framebuffer[%u]:\n", fb->base.id);
-			drm_framebuffer_print_info(&p, 1, fb);
-		}
-		list_del_init(&fb->filp_head);
+		drm_printf(&p, "framebuffer[%u]:\n", fb->base.id);
+		drm_framebuffer_print_info(&p, 1, fb);
 		drm_framebuffer_free(&fb->base.refcount);
 	}
 

base-commit: 8e8fc038cad5988ede9f323677c28eb9a696026c
-- 
2.53.0


