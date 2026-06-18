Return-Path: <stable+bounces-267098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7kyZGi/RM2obGwYAu9opvQ
	(envelope-from <stable+bounces-267098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:06:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A81DD69F9D5
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:06:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="aJg/Ih3P";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267098-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267098-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C6A0302AC1B
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C9386C10;
	Thu, 18 Jun 2026 11:05:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49E3B2FED;
	Thu, 18 Jun 2026 11:05:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780754; cv=none; b=nnH15z3w2wGLn+5kWVz5TlBQSp9kZdeo+hIAskszY38MtZQE9jjYD4mfbmpP634bUiXfo6+cd2DXHQ8TLQKyqW30YGeFbk2lmOgkt4GuX8srbZWScrqj1dEjFMJFawXon6Y2dMPqeoIcgacIGR/V3AdZuWRm86Ptd1FqTtlv10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780754; c=relaxed/simple;
	bh=6wXnEDck6P59SvTHVD9C7VlKsJ5sdP/VHcUX+2+6JY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axY2MOwOK23FvzF4ingDPFVaXq2gB7o1lkFTkgAxHCM7kNxUu56g2aJTAs7iz+7oXp1dg6tBiCE9YiZQO13Y4ZW3ClsEFGwvaa9C5VENLYLJces8CLUD87P6DigllVvliNdLnM3K2ZI3s//4E66MN4GpeHb0PWSPIZvqW2txlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aJg/Ih3P; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gg
	0v4mNICq66S4WjgqT9Dzd0uw6VSyp4kHXR3khbLzk=; b=aJg/Ih3Pa18N/nWZAx
	0s0iTZ8+bJH/bXNherApom2TT970bn8Mc/2T5lUn6Puhq7whiEWqvwEx20gc3tH3
	YyBF7i5aEVIOH7yTb98JbgSPaIHW0V/zNmeQZsegbeX66vXYqkTG+hml+sWmlr5U
	Hk4LrbgMy0kUlVj+kcLVVqaHo=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3t77P0DNqfkKHEA--.18129S4;
	Thu, 18 Jun 2026 19:04:53 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	hansg@kernel.org,
	matthew.d.roper@intel.com,
	vivek.kasireddy@intel.com
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/i915/dsi: fix i2c adapter reference leak in i2c_adapter_lookup()
Date: Thu, 18 Jun 2026 19:04:46 +0800
Message-ID: <20260618110446.518501-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t77P0DNqfkKHEA--.18129S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4Dtr1xJw15Gw13Jw13Arb_yoW8Gry7pr
	ZrWF4UCrWYqF9aqay7AF1UuFW7uayIy34rKFZ7Cw13u3Wkuw18JryFyrW0gFyDWa9rXa1D
	tFnrJ3yUKFyjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pES_MPUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9RXQ22oz0NWmMQAA3g
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jani.nikula@linux.intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:tursulin@ursulin.net,m:airlied@gmail.com,m:simona@ffwll.ch,m:hansg@kernel.org,m:matthew.d.roper@intel.com,m:vivek.kasireddy@intel.com,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:make_ruc2021@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,kernel.org];
	FORGED_SENDER(0.00)[make_ruc2021@163.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux-foundation.org,163.com];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[make_ruc2021@163.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_FROM(0.00)[bounces-267098-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A81DD69F9D5

i2c_adapter_lookup() acquires a reference on the i2c adapter through
i2c_acpi_find_adapter_by_handle() but not releases it.  Each
invocation of this ACPI resource callback leaks one device reference,
potentially leading to resource exhaustion over repeated driver
load/unload cycles.

Calling path: i2c_acpi_find_adapter_by_handle() -> bus_find_device()
-> get_device.

Found by code review.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Cc: stable@vger.kernel.org
Fixes: 8cbf89db2941 ("drm/i915/dsi: Parse the I2C element from the VBT MIPI sequence block (v3)")
---
Changes in v2:
- Changed email to trigger CI, no code change.
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index fe12041e913c..2097c5d17cb7 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -460,8 +460,10 @@ static int i2c_adapter_lookup(struct acpi_resource *ares, void *data)
 		return 1;
 
 	adapter = i2c_acpi_find_adapter_by_handle(adapter_handle);
-	if (adapter)
+	if (adapter) {
 		intel_dsi->i2c_bus_num = adapter->nr;
+		put_device(&adapter->dev);
+	}
 
 	return 1;
 }
-- 
2.43.0


