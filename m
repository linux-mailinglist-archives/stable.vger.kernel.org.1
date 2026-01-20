Return-Path: <stable+bounces-210478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH4uMztCcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:04:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EAF5035D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60C98749EE3
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E63ECBF2;
	Tue, 20 Jan 2026 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSc1M5YB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190303D332A
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904989; cv=none; b=U49iYY6Ht3Nfo5RiOEVcDTgCRWcoFAYw5sy0HS9UUqRChyEWoWVFxfgk68Quygnh2Do91ZFvOTHgqR4tMwrfButNL69JLqyli7bK3G2o3SYBIHk8+IBVXQ3qNrRJ9Jkl3w5pAJa5IesaUFvrGUIX77FAhOArfdKjAwcTiptm/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904989; c=relaxed/simple;
	bh=JkvS9XHeAI6rhzdCoBFQiNvDoRXd1IvkZEMluID2Vzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RWCyVcnX2ocjP97gJRRBZDyjZ0YljExVhVmR8BVDkvLqVodL6JrOQjLEkdJWCeHatsQRUrZDDQumFEBrBbvyiwFRdFjjSpr8sEMp+bZ3Kwbo2DJBaPxQZe21+wth+5d3xOWhim7JK1WbGZqRV7ACONLN/dr/oZBYTxXBKqUJ7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSc1M5YB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801d98cf39so23306165e9.1
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 02:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768904985; x=1769509785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E83MMmphRzSQxZiwG/Y3pisB0LvG+BkMYMOQJFTTWtY=;
        b=SSc1M5YBjBMUGaWNdcNYS3un15vsejhAicxOYSjCgz+XomtDVBUnI5KIyZ9VLQvFJ5
         EmSvjZfymazTfXeWF/ZPNPzqf1trsA8PrLVKNVQEc5M8MpAwK88Si2Qoc+rTqFnk8wJt
         PylhOXtCAkaYpTxwtCViNB3QbcL5mKEfdj83vk2lQlA9/irYxU1jmWKOk9Agf05fjQZm
         GfMjWEI4uUTAdzueqAlJ1wJvXRLcTtu8I6/wxDLrxQ07Eopgq2hQCyLCk+rV3HJArOoG
         VF5F76Ip0CJ5WpL2bUqH7QBTXPc185ao4oqcI/PYeZWtkzjJYRCntjG254j+GtZ9jBr5
         PAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904985; x=1769509785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E83MMmphRzSQxZiwG/Y3pisB0LvG+BkMYMOQJFTTWtY=;
        b=MPMkEHAmNq16R7LbWuRnfNDmNeo13vM1qB78TgIka7nZCzH0X/TiGtalqkp8H40ZW5
         Gu2pY70ngtiNGGMMOuxFhBiIPuocxn1fe+XtuhZW8lezys0hcjUyvKebOCVwwaK1WWDq
         uTnQeYLcgUx6lnuz/MO9U2QfGymIMillwR8W9Y3RFDVMZbF5uCjakl4E7DBsIV6ocmFm
         rYFJsgL6MdcjkECbZrTVwlxJiGe7XdE8stlZ37JE2Wryek9WIIyNp7zvKERPg3GVhMQN
         c+ksZCb+gOYJ97CI0IPRUUXJpSxcCUej0OnjqAbTod9oUmC7Vl6yPT8qq3/3ObZHrjEr
         gWyw==
X-Forwarded-Encrypted: i=1; AJvYcCUuRCqqoToy2CPLxWj/5XF1R6jX55z6esDT0qAzMqaqtOkikfQ29XMzAFi1i5vvXU/sy0AHDBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vn0/diOKTgjWt8vJu6LwXoKpGcBgjIYs4JzZeswqZE8XCOI9
	oLryhQqUyLKpZqKR8mVy/McrHhFBX0vBpXYLyVT2Tknf9uBFchyHndNqJ9QHYjij
X-Gm-Gg: AY/fxX7bq0HLQj+aDQSQ8cYgGkoqXa77PruKGuqgJqq7cHMHt5HFDv4GnRwg4x1kAWW
	fDek3tcIviQ1qTqXwhRdsSxOX9o8t/S327LfAR3LIgrSBldGpGwwM0nyt/exBYZYcXemWtm93Cm
	xOQCIYukODlEMhtHinHHm0fu1NuVm5oTIX3RxtsjimR4sOy+1uwfZmx/pbPVzV1mFlqj1kM8xRm
	ymGg9K8+EliOv+SWvhiWx/Mz0CYAAh8JfkJ3YoFbpBNRThI0lEcv0cU1+RRP34UIVFhJAEiQ5T+
	aOFpPCHJaFRUdt9PPY7t82P6M5vEt8HBenC8N5fPN5Vo9700vbHek/g7GHaVhDiOrHLGAh5/73E
	wrVzGcu1inkX1aE9hOewke05ZawFR+lij7jTeisTOeDCPKQ7L7xooqVIxpp0dxPaMFWYKCx9hPW
	fZNNHuWNBPO27Ww7mT678+Dp58hhejqDiMBw==
X-Received: by 2002:a05:600c:3509:b0:47a:94fc:d057 with SMTP id 5b1f17b1804b1-4801eab54e2mr146879285e9.2.1768904984848;
        Tue, 20 Jan 2026 02:29:44 -0800 (PST)
Received: from localhost.localdomain ([185.99.26.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6dasm29123855f8f.32.2026.01.20.02.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:29:44 -0800 (PST)
From: Berk Cem Goksel <berkcgoksel@gmail.com>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	andreyknvl@gmail.com,
	Berk Cem Goksel <berkcgoksel@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_free()
Date: Tue, 20 Jan 2026 13:28:55 +0300
Message-Id: <20260120102855.7300-1-berkcgoksel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-210478-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FROM_NEQ_ENVFROM(0.00)[berkcgoksel@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ev.data:url]
X-Rspamd-Queue-Id: 47EAF5035D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When snd_usb_create_mixer() fails, snd_usb_mixer_free() frees
mixer->id_elems but the controls already added to the card still
reference the freed memory. Later when snd_card_register() runs,
the OSS mixer layer calls their callbacks and hits a use-after-free read.

Call trace:
  get_ctl_value+0x63f/0x820 sound/usb/mixer.c:411
  get_min_max_with_quirks.isra.0+0x240/0x1f40 sound/usb/mixer.c:1241
  mixer_ctl_feature_info+0x26b/0x490 sound/usb/mixer.c:1381
  snd_mixer_oss_build_test+0x174/0x3a0 sound/core/oss/mixer_oss.c:887
  ...
  snd_card_register+0x4ed/0x6d0 sound/core/init.c:923
  usb_audio_probe+0x5ef/0x2a90 sound/usb/card.c:1025

Fix by calling snd_ctl_remove() for all mixer controls before freeing
id_elems. We save the next pointer first because snd_ctl_remove()
frees the current element.

Fixes: 6639b6c2367f ("[ALSA] usb-audio - add mixer control notifications")
Cc: stable@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>
---
Tested on 6.18.5 with KASAN:

[   11.274050] ==================================================================
[   11.274798] BUG: KASAN: slab-use-after-free in get_ctl_value+0x63f/0x820
[   11.275503] Read of size 4 at addr ffff888003c2a438 by task kworker/1:3/96

[   11.276469] CPU: 1 UID: 0 PID: 96 Comm: kworker/1:3 Not tainted 6.18.5 #2 PREEMPT(voluntary)
[   11.276485] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   11.276504] Workqueue: usb_hub_wq hub_event
[   11.276562] Call Trace:
[   11.276582]  <TASK>
[   11.276589]  dump_stack_lvl+0x55/0x70
[   11.276616]  print_report+0xcb/0x610
[   11.276666]  ? get_ctl_value+0x63f/0x820
[   11.276669]  kasan_report+0xb8/0xf0
[   11.276678]  ? get_ctl_value+0x63f/0x820
[   11.276684]  get_ctl_value+0x63f/0x820
[   11.276688]  ? kasan_save_stack+0x34/0x50
[   11.276692]  ? kasan_save_stack+0x24/0x50
[   11.276697]  ? kasan_save_track+0x14/0x30
[   11.276699]  ? __kasan_kmalloc+0x7f/0x90
[   11.276701]  ? snd_mixer_oss_build_test+0x13a/0x3a0
[   11.276720]  ? snd_mixer_oss_notify_handler+0x356/0x880
[   11.276737]  ? snd_card_register+0x4ed/0x6d0
[   11.276776]  ? try_to_register_card+0x124/0x290
[   11.276836]  ? usb_audio_probe+0x5ef/0x2a90
[   11.276850]  ? usb_probe_interface+0x26c/0x920
[   11.276888]  ? __pfx_get_ctl_value+0x10/0x10
[   11.276890]  ? __device_attach_driver+0x160/0x320
[   11.276925]  ? bus_for_each_drv+0x101/0x190
[   11.276931]  ? __device_attach+0x198/0x3a0
[   11.276935]  ? bus_probe_device+0x123/0x170
[   11.276940]  ? device_add+0xcfd/0x1440
[   11.276965]  ? usb_set_configuration+0xa7c/0x18c0
[   11.276969]  ? usb_generic_driver_probe+0x7b/0xb0
[   11.276982]  ? usb_probe_device+0xaa/0x2e0
[   11.276985]  ? really_probe+0x1c6/0x6a0
[   11.276986]  ? __driver_probe_device+0x248/0x310
[   11.276988]  ? driver_probe_device+0x48/0x210
[   11.276991]  ? __device_attach_driver+0x160/0x320
[   11.276993]  get_min_max_with_quirks.isra.0+0x240/0x1f40
[   11.277007]  ? __pfx_get_min_max_with_quirks.isra.0+0x10/0x10
[   11.277010]  ? kasan_unpoison+0x27/0x60
[   11.277026]  ? __kasan_slab_alloc+0x30/0x70
[   11.277029]  ? __kmalloc_cache_noprof+0x128/0x500
[   11.277050]  mixer_ctl_feature_info+0x26b/0x490
[   11.277053]  ? __kasan_kmalloc+0x7f/0x90
[   11.277056]  snd_mixer_oss_build_test+0x174/0x3a0
[   11.277058]  ? __pfx_snd_mixer_oss_build_test+0x10/0x10
[   11.277060]  ? driver_probe_device+0x48/0x210
[   11.277062]  ? snd_ctl_find_id+0x75/0x510
[   11.277076]  snd_mixer_oss_build_test_all+0xbf/0x610
[   11.277078]  ? __pfx_snd_mixer_oss_build_test_all+0x10/0x10
[   11.277080]  ? __pfx_snd_mixer_oss_test_id.isra.0+0x10/0x10
[   11.277082]  ? kasan_save_track+0x14/0x30
[   11.277085]  snd_mixer_oss_build_input+0xfe/0xca0
[   11.277088]  ? kasan_save_track+0x14/0x30
[   11.277090]  ? __pfx_snd_mixer_oss_build_input+0x10/0x10
[   11.277092]  ? __kmalloc_node_track_caller_noprof+0x1c3/0x600
[   11.277097]  ? kstrdup+0x36/0x90
[   11.277109]  ? kstrdup+0x4f/0x90
[   11.277110]  snd_mixer_oss_notify_handler+0x356/0x880
[   11.277112]  ? snd_info_card_register+0x11a/0x1a0
[   11.277131]  snd_card_register+0x4ed/0x6d0
[   11.277134]  ? __pfx_snd_card_register+0x10/0x10
[   11.277136]  ? _raw_spin_lock_irqsave+0x85/0xe0
[   11.277172]  try_to_register_card+0x124/0x290
[   11.277174]  ? __pfx_try_to_register_card+0x10/0x10
[   11.277176]  ? pm_runtime_enable+0x1cc/0x2a0
[   11.277190]  ? usb_driver_claim_interface+0x15e/0x3d0
[   11.277192]  usb_audio_probe+0x5ef/0x2a90
[   11.277196]  ? __pfx_usb_audio_probe+0x10/0x10
[   11.277198]  ? _raw_spin_lock_irqsave+0x85/0xe0
[   11.277200]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   11.277202]  ? ktime_get_mono_fast_ns+0x87/0x300
[   11.277243]  usb_probe_interface+0x26c/0x920
[   11.277247]  really_probe+0x1c6/0x6a0
[   11.277248]  ? __pfx___device_attach_driver+0x10/0x10
[   11.277250]  __driver_probe_device+0x248/0x310
[   11.277252]  ? usb_match_id.part.0+0xe3/0x150
[   11.277256]  driver_probe_device+0x48/0x210
[   11.277257]  ? __pfx___device_attach_driver+0x10/0x10
[   11.277259]  __device_attach_driver+0x160/0x320
[   11.277261]  bus_for_each_drv+0x101/0x190
[   11.277264]  ? __pfx_bus_for_each_drv+0x10/0x10
[   11.277266]  __device_attach+0x198/0x3a0
[   11.277268]  ? __pfx___device_attach+0x10/0x10
[   11.277271]  ? kobject_get+0x54/0xf0
[   11.277290]  bus_probe_device+0x123/0x170
[   11.277291]  device_add+0xcfd/0x1440
[   11.277293]  ? __pfx_device_add+0x10/0x10
[   11.277295]  ? mutex_unlock+0x7d/0xd0
[   11.277297]  ? __pfx_mutex_unlock+0x10/0x10
[   11.277299]  ? kasan_save_track+0x14/0x30
[   11.277301]  usb_set_configuration+0xa7c/0x18c0
[   11.277305]  usb_generic_driver_probe+0x7b/0xb0
[   11.277307]  usb_probe_device+0xaa/0x2e0
[   11.277308]  really_probe+0x1c6/0x6a0
[   11.277311]  ? __pfx___device_attach_driver+0x10/0x10
[   11.277313]  __driver_probe_device+0x248/0x310
[   11.277315]  driver_probe_device+0x48/0x210
[   11.277317]  ? __pfx___device_attach_driver+0x10/0x10
[   11.277319]  __device_attach_driver+0x160/0x320
[   11.277322]  bus_for_each_drv+0x101/0x190
[   11.277323]  ? __pfx_bus_for_each_drv+0x10/0x10
[   11.277325]  __device_attach+0x198/0x3a0
[   11.277328]  ? __pfx___device_attach+0x10/0x10
[   11.277330]  ? kobject_get+0x54/0xf0
[   11.277332]  bus_probe_device+0x123/0x170
[   11.277335]  device_add+0xcfd/0x1440
[   11.277338]  ? __pfx_device_add+0x10/0x10
[   11.277340]  ? add_device_randomness+0xb2/0xe0
[   11.277355]  usb_new_device+0x7b9/0x1060
[   11.277359]  hub_event+0x2000/0x3e40
[   11.277361]  ? __pfx_hub_event+0x10/0x10
[   11.277363]  ? _raw_spin_lock_irqsave+0x85/0xe0
[   11.277368]  ? mutex_unlock+0x7d/0xd0
[   11.277369]  ? _raw_spin_lock_irq+0x80/0xe0
[   11.277383]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[   11.277386]  ? __pm_runtime_suspend+0x78/0x1c0
[   11.277399]  process_one_work+0x5c2/0xfd0
[   11.277446]  worker_thread+0x78d/0x1240
[   11.277450]  ? __kthread_parkme+0x95/0x170
[   11.277460]  ? __pfx_worker_thread+0x10/0x10
[   11.277462]  kthread+0x331/0x630
[   11.277481]  ? __pfx_kthread+0x10/0x10
[   11.277484]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[   11.277486]  ? finish_task_switch.isra.0+0x142/0x610
[   11.277505]  ? __pfx_kthread+0x10/0x10
[   11.277507]  ret_from_fork+0x11c/0x1c0
[   11.277545]  ? __pfx_kthread+0x10/0x10
[   11.277547]  ret_from_fork_asm+0x1a/0x30
[   11.277567]  </TASK>

[   11.338943] Allocated by task 96:
[   11.339324]  kasan_save_stack+0x24/0x50
[   11.339765]  kasan_save_track+0x14/0x30
[   11.340193]  __kasan_kmalloc+0x7f/0x90
[   11.340615]  snd_usb_create_mixer+0xe9/0x18a0
[   11.341108]  usb_audio_probe+0x5d8/0x2a90
[   11.341555]  usb_probe_interface+0x26c/0x920
[   11.342036]  really_probe+0x1c6/0x6a0
[   11.342447]  __driver_probe_device+0x248/0x310
[   11.342952]  driver_probe_device+0x48/0x210
[   11.343416]  __device_attach_driver+0x160/0x320
[   11.343926]  bus_for_each_drv+0x101/0x190
[   11.344367]  __device_attach+0x198/0x3a0
[   11.344803]  bus_probe_device+0x123/0x170
[   11.345245]  device_add+0xcfd/0x1440
[   11.345648]  usb_set_configuration+0xa7c/0x18c0
[   11.346145]  usb_generic_driver_probe+0x7b/0xb0
[   11.346647]  usb_probe_device+0xaa/0x2e0
[   11.347080]  really_probe+0x1c6/0x6a0
[   11.347536]  __driver_probe_device+0x248/0x310
[   11.348031]  driver_probe_device+0x48/0x210
[   11.348490]  __device_attach_driver+0x160/0x320
[   11.348991]  bus_for_each_drv+0x101/0x190
[   11.349433]  __device_attach+0x198/0x3a0
[   11.349869]  bus_probe_device+0x123/0x170
[   11.350310]  device_add+0xcfd/0x1440
[   11.350712]  usb_new_device+0x7b9/0x1060
[   11.351146]  hub_event+0x2000/0x3e40
[   11.351543]  process_one_work+0x5c2/0xfd0
[   11.351997]  worker_thread+0x78d/0x1240
[   11.352421]  kthread+0x331/0x630
[   11.352788]  ret_from_fork+0x11c/0x1c0
[   11.353212]  ret_from_fork_asm+0x1a/0x30

[   11.353835] Freed by task 96:
[   11.354171]  kasan_save_stack+0x24/0x50
[   11.354599]  kasan_save_track+0x14/0x30
[   11.355023]  __kasan_save_free_info+0x3b/0x60
[   11.355505]  __kasan_slab_free+0x43/0x70
[   11.355945]  kfree+0xd4/0x460
[   11.356285]  snd_usb_create_mixer+0xb06/0x18a0
[   11.356778]  usb_audio_probe+0x5d8/0x2a90
[   11.357221]  usb_probe_interface+0x26c/0x920
[   11.357696]  really_probe+0x1c6/0x6a0
[   11.358103]  __driver_probe_device+0x248/0x310
[   11.358597]  driver_probe_device+0x48/0x210
[   11.359057]  __device_attach_driver+0x160/0x320
[   11.359561]  bus_for_each_drv+0x101/0x190
[   11.360003]  __device_attach+0x198/0x3a0
[   11.360436]  bus_probe_device+0x123/0x170
[   11.360887]  device_add+0xcfd/0x1440
[   11.361286]  usb_set_configuration+0xa7c/0x18c0
[   11.361789]  usb_generic_driver_probe+0x7b/0xb0
[   11.362286]  usb_probe_device+0xaa/0x2e0
[   11.362722]  really_probe+0x1c6/0x6a0
[   11.363130]  __driver_probe_device+0x248/0x310
[   11.363615]  driver_probe_device+0x48/0x210
[   11.364116]  __device_attach_driver+0x160/0x320
[   11.364626]  bus_for_each_drv+0x101/0x190
[   11.365068]  __device_attach+0x198/0x3a0
[   11.365505]  bus_probe_device+0x123/0x170
[   11.365955]  device_add+0xcfd/0x1440
[   11.366357]  usb_new_device+0x7b9/0x1060
[   11.366798]  hub_event+0x2000/0x3e40
[   11.367200]  process_one_work+0x5c2/0xfd0
[   11.367650]  worker_thread+0x78d/0x1240
[   11.368079]  kthread+0x331/0x630
[   11.368445]  ret_from_fork+0x11c/0x1c0
[   11.368872]  ret_from_fork_asm+0x1a/0x30

[   11.369496] The buggy address belongs to the object at ffff888003c2a400
                which belongs to the cache kmalloc-192 of size 192
[   11.370834] The buggy address is located 56 bytes inside of
                freed 192-byte region [ffff888003c2a400, ffff888003c2a4c0)

[   11.372322] The buggy address belongs to the physical page:
[   11.372935] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3c2a
[   11.373782] anon flags: 0x100000000000000(node=0|zone=1)
[   11.374367] page_type: f5(slab)
[   11.374731] raw: 0100000000000000 ffff8880010413c0 0000000000000000 dead000000000001
[   11.375572] raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
[   11.376404] page dumped because: kasan: bad access detected

[   11.377213] Memory state around the buggy address:
[   11.377746]  ffff888003c2a300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   11.378528]  ffff888003c2a380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   11.379313] >ffff888003c2a400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   11.380093]                                         ^
[   11.380694]  ffff888003c2a480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   11.381471]  ffff888003c2a500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   11.382249] ==================================================================

Reproducer (needs CONFIG_USB_RAW_GADGET, CONFIG_USB_DUMMY_HCD):

//Use-after-free read in get_ctl_value() through OSS mixer

#define _GNU_SOURCE
#include <endian.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

#define UDC_NAME_LENGTH_MAX 128

struct usb_raw_init {
    uint8_t driver_name[UDC_NAME_LENGTH_MAX];
    uint8_t device_name[UDC_NAME_LENGTH_MAX];
    uint8_t speed;
};

struct usb_raw_event {
    uint32_t type;
    uint32_t length;
    uint8_t data[0];
};

struct usb_raw_ep_io {
    uint16_t ep;
    uint16_t flags;
    uint32_t length;
    uint8_t data[0];
};

#define USB_RAW_IOCTL_INIT _IOW('U', 0, struct usb_raw_init)
#define USB_RAW_IOCTL_RUN _IO('U', 1)
#define USB_RAW_IOCTL_EVENT_FETCH _IOR('U', 2, struct usb_raw_event)
#define USB_RAW_IOCTL_EP0_WRITE _IOW('U', 3, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP0_READ _IOWR('U', 4, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_CONFIGURE _IO('U', 9)
#define USB_RAW_IOCTL_VBUS_DRAW _IOW('U', 10, uint32_t)
#define USB_RAW_IOCTL_EP0_STALL _IO('U', 12)

static uint8_t dev_desc[] = {
    // Device descriptor
    0x12, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x08,
    0xe4, 0x08, 0x63, 0x01, 0x40, 0x00, 0x01, 0x02, 0x03, 0x01,
    // Config descriptor
    0x09, 0x02, 0x7e, 0x00, 0x03, 0x01, 0x2f, 0x40, 0x02,
    // Interface 0 (Audio Control)
    0x09, 0x04, 0x00, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00,
    // AC Header
    0x0a, 0x24, 0x01, 0x04, 0x00, 0x28, 0x00, 0x02, 0x01, 0x02,
    // Feature Unit (malformed)
    0x09, 0x24, 0x06, 0x06, 0x01, 0x01, 0x1e, 0xea, 0x80,
    // Input Terminal
    0x0c, 0x24, 0x02, 0x01, 0x04, 0x02, 0x01, 0x00, 0x88, 0x8d, 0x7f, 0x09,
    // Output Terminal
    0x09, 0x24, 0x03, 0x03, 0x01, 0x04, 0x01, 0x06, 0x09,
    // Interface 1 alt 0
    0x09, 0x04, 0x01, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00,
    // Interface 1 alt 1
    0x09, 0x04, 0x01, 0x01, 0x01, 0x01, 0x02, 0x00, 0x00,
    // Endpoint
    0x09, 0x05, 0x01, 0x09, 0x08, 0x00, 0x09, 0xef, 0xf4,
    0x07, 0x25, 0x01, 0x08, 0x09, 0x03, 0x00,
    // Interface 2 alt 0
    0x09, 0x04, 0x02, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00,
    // Interface 2 alt 1
    0x09, 0x04, 0x02, 0x01, 0x01, 0x01, 0x02, 0x00, 0x00,
    // Endpoint
    0x09, 0x05, 0x82, 0x09, 0x00, 0x04, 0x03, 0xf8, 0x03,
    0x07, 0x25, 0x01, 0x00, 0x01, 0x4a, 0xb1
};

static uint8_t default_string[] = { 0x04, 0x03, 0x09, 0x04 };

int main(void) {
    int fd = open("/dev/raw-gadget", O_RDWR);
    if (fd < 0) {
        perror("open /dev/raw-gadget");
        return 1;
    }

    struct usb_raw_init init = {0};
    strcpy((char*)init.driver_name, "dummy_udc");
    strcpy((char*)init.device_name, "dummy_udc.0");
    init.speed = 2; // USB_SPEED_FULL

    if (ioctl(fd, USB_RAW_IOCTL_INIT, &init) < 0) {
        perror("USB_RAW_IOCTL_INIT");
        return 1;
    }

    if (ioctl(fd, USB_RAW_IOCTL_RUN, 0) < 0) {
        perror("USB_RAW_IOCTL_RUN");
        return 1;
    }

    // Handle USB enumeration
    for (int i = 0; i < 20; i++) {
        struct {
            struct usb_raw_event event;
            uint8_t data[256];
        } ev = {0};
        ev.event.length = sizeof(ev.data);

        if (ioctl(fd, USB_RAW_IOCTL_EVENT_FETCH, &ev) < 0)
            break;

        if (ev.event.type != 2) // USB_RAW_EVENT_CONTROL
            continue;

        struct {
            struct usb_raw_ep_io io;
            uint8_t data[256];
        } resp = {0};

        uint8_t bRequestType = ev.data[0];
        uint8_t bRequest = ev.data[1];
        uint16_t wValue = ev.data[2] | (ev.data[3] << 8);
        uint16_t wLength = ev.data[6] | (ev.data[7] << 8);

        if (bRequestType == 0x80 && bRequest == 6) { // GET_DESCRIPTOR
            uint8_t desc_type = wValue >> 8;
            if (desc_type == 1) { // DEVICE
                memcpy(resp.data, dev_desc, 18);
                resp.io.length = 18 < wLength ? 18 : wLength;
            } else if (desc_type == 2) { // CONFIG
                int len = sizeof(dev_desc) - 18;
                memcpy(resp.data, dev_desc + 18, len);
                resp.io.length = len < wLength ? len : wLength;
            } else if (desc_type == 3) { // STRING
                memcpy(resp.data, default_string, 4);
                resp.io.length = 4 < wLength ? 4 : wLength;
            } else {
                ioctl(fd, USB_RAW_IOCTL_EP0_STALL, 0);
                continue;
            }
            ioctl(fd, USB_RAW_IOCTL_EP0_WRITE, &resp);
        } else if (bRequestType == 0x00 && bRequest == 9) { // SET_CONFIGURATION
            ioctl(fd, USB_RAW_IOCTL_VBUS_DRAW, 2);
            ioctl(fd, USB_RAW_IOCTL_CONFIGURE, 0);
            resp.io.length = 0;
            ioctl(fd, USB_RAW_IOCTL_EP0_READ, &resp);
            break; // Done - bug should trigger during card registration
        } else {
            ioctl(fd, USB_RAW_IOCTL_EP0_STALL, 0);
        }
    }

    usleep(500000);
    close(fd);
    return 0;
}

 sound/usb/mixer.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 3af71d42b9b9..29c2e46801df 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2946,10 +2946,23 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 
 static void snd_usb_mixer_free(struct usb_mixer_interface *mixer)
 {
+	struct usb_mixer_elem_list *list, *next;
+	int id;
+
 	/* kill pending URBs */
 	snd_usb_mixer_disconnect(mixer);
 
-	kfree(mixer->id_elems);
+	/* Unregister controls first, snd_ctl_remove() frees the element */
+	if (mixer->id_elems) {
+		for (id = 0; id < MAX_ID_ELEMS; id++) {
+			for (list = mixer->id_elems[id]; list; list = next) {
+				next = list->next_id_elem;
+				if (list->kctl)
+					snd_ctl_remove(mixer->chip->card, list->kctl);
+			}
+		}
+		kfree(mixer->id_elems);
+	}
 	if (mixer->urb) {
 		kfree(mixer->urb->transfer_buffer);
 		usb_free_urb(mixer->urb);
-- 
2.34.1


