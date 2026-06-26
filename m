Return-Path: <stable+bounces-268901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BzQnCXh7PmpoGwkAu9opvQ
	(envelope-from <stable+bounces-268901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:15:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F56CD569
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:15:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268901-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268901-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 233D630BE1E5
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8E3F44F7;
	Fri, 26 Jun 2026 13:13:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01F3F4DCC;
	Fri, 26 Jun 2026 13:13:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479601; cv=none; b=Dk23UbAZOM4/wpmhEbjr/SwHTcoqBzLrX8+g+89S+08DtNiuEGuEBw6IdQlhwWF1RwBrTOGjPWfyCFpIEorLnNB8Gete8ZnPpkDKF5vFKiGgdcEY+FhHdlMchEuN+PR0G0rlEdF9JYc+ZJ2yLOxtmyvSXhgyECQ6XJenjP9bF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479601; c=relaxed/simple;
	bh=yghLBSQTZS9kEHyuVgI/MF/OYvrlnW4IWjLAqGCgn+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sQPDMPJRp73+W2qzVfwkf/03fptmV7/71FlzjcBSUwvuxfSb7/w0eEdfJ+0Y6TG73Dx8TGYCycfptY+L+rrOtfrnyTuqtJmEL9pSg/dV0dVGxR7NagdqXeb9v6QVl7YfM8en60uCmWRt5XoTu1SP2DGIOUuGhJzp6odX5w7aB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowABHkcTmej5q09ppFQ--.22955S2;
	Fri, 26 Jun 2026 21:13:12 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drm: drm_mode_obj_get_properties_ioctl: DRM_MODESET_LOCK_ALL_BEGIN   retry leaks drm_mode_object reference
Date: Fri, 26 Jun 2026 21:13:08 +0800
Message-Id: <20260626131308.37604-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHkcTmej5q09ppFQ--.22955S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4fCr1UAr15tryrtF18Xwb_yoW8Xr48pr
	43K34jkrW0yrZ7KFs7CFWv9F9Yya129rWrGF1Sk3Wag3ZYyF1UZFy5ur4DtFy7tr93Jr1a
	qFnIyF9xAay7Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqeHgUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0KA2o+SxmZGAAAsF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268901-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D9F56CD569

The DRM_MODESET_LOCK_ALL_BEGIN macro retries the ioctl on -EDEADLK. Each
  retry re-executes drm_mode_object_find, overwriting the obj pointer
  without releasing the previous reference via drm_mode_object_put. The
  out_unref label only releases the final obj, leaking references from
  earlier retry iterations.

Cc: stable@vger.kernel.org
Fixes: 949619f32eee ("drm: Extract drm_mode_object.[hc]")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_mode_object.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 2d943a610b88..10fce40f7020 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -479,7 +479,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
 				      struct drm_file *file_priv)
 {
 	struct drm_mode_obj_get_properties *arg = data;
-	struct drm_mode_object *obj;
+	struct drm_mode_object *obj = NULL;
 	struct drm_modeset_acquire_ctx ctx;
 	int ret = 0;
 
@@ -487,7 +487,9 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
 		return -EOPNOTSUPP;
 
 	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
-
+	if (obj)
+		drm_mode_object_put(obj);
+
 	obj = drm_mode_object_find(dev, file_priv, arg->obj_id, arg->obj_type);
 	if (!obj) {
 		ret = -ENOENT;
-- 
2.39.5 (Apple Git-154)


