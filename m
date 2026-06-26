Return-Path: <stable+bounces-268960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OeW4FoeVPmoPIgkAu9opvQ
	(envelope-from <stable+bounces-268960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:06:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A29306CE4D7
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:06:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268960-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268960-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84955308AE06
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17EC35201E;
	Fri, 26 Jun 2026 15:02:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94EB352009;
	Fri, 26 Jun 2026 15:02:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486156; cv=none; b=Uw3HqCzlN9av9L+DXEDZkX3VgN5443qdGpNBEmzxDmFbpOR3dckUZfLZV5oiZ1oSV9JQZMuLyEyGP2tv9O+Y32qUjy8yDi7A2zh1PeOhPK5B3SSwEf1BoRxs2DGDXQjVxsg76z5t5ItRo5jQWEl4OxFTmahk0GjgLuqGGqNV2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486156; c=relaxed/simple;
	bh=G4E8d0QJL4W+tNeZpcGyCVKPFNWB/5nM5d0dhD8n4vI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=THg8BRP7SIlPTPAaV4y8SToU4HpN53df3hhCxkZbIhzqupgTR6jm7X+qWAJQkZqeRRDVLEzo4l0RlTj9004Jz2vrTeh55FAbX1wMgESvtgZqR8ffzax9WT58heU6EJmjRyylciyDggt6Nt/Yc7vdYoI1s0fDvcJdVopI6JvkFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAB3GtOBlD5qi1BrAw--.4034S2;
	Fri, 26 Jun 2026 23:02:27 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Zack Rusin <zack.rusin@broadcom.com>,
	dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/vmwgfx: vmw_simple_resource_create_ioctl: fix base object   refcount leak on ttm_base_object_init failure
Date: Fri, 26 Jun 2026 23:02:24 +0800
Message-Id: <20260626150224.49792-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3GtOBlD5qi1BrAw--.4034S2
X-Coremail-Antispam: 1UD129KBjvJXoWrurWrJFyDJFy5AFyxXw4xWFg_yoW8Jr1Dpr
	4fJrW3Gry5JrWIqrZrAa1kJFs7A3Wq9F4rKFyFkwsxZ3Wqvr9rJws8CrZ0vF1DCrZ3Ar4a
	qr1kArWkuFyDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUgXocUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYKA2o+h0EmQQAAs8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-268960-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zack.rusin@broadcom.com,m:dri-devel@lists.freedesktop.org,m:bcm-kernel-feedback-list@broadcom.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:thellstrom@vmware.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[broadcom.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vmware.com,vger.kernel.org,iscas.ac.cn];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A29306CE4D7

ttm_base_object_init unconditionally acquires a base object reference via
  kref_init. When it fails, the error path only calls
  vmw_resource_unreference but never calls ttm_base_object_unref to release
  the base object reference, causing a refcount leak.

Add ttm_base_object_unref in the error path to properly release the base
  object reference when ttm_base_object_init fails.

Cc: stable@vger.kernel.org
Fixes: 0b8762e997df ("drm/ttm, drm/vmwgfx: Move the lock- and object functionality to the vmwgfx driver")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
index 0d51b4542269..05f0f5544142 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
@@ -176,6 +176,7 @@ vmw_simple_resource_create_ioctl(struct drm_device *dev, void *data,
 
 	if (ret) {
 		vmw_resource_unreference(&tmp);
+		ttm_base_object_unref(&usimple->base);
 		goto out_err;
 	}
 
-- 
2.39.5 (Apple Git-154)


