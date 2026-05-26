Return-Path: <stable+bounces-254353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDhhLMiiFWqmWwcAu9opvQ
	(envelope-from <stable+bounces-254353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:40:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D525D6AD6
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 802B8317F5AF
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51263FAE11;
	Tue, 26 May 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kwqqAwf7"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7B3C8C7C;
	Tue, 26 May 2026 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802353; cv=none; b=kQuYcbT3V1OKpzkd6j5AuTeX2HKyoNhc2OsSigbVlbjnjQNeNtbpwBLX6ynX8Z8f+wieRXkqLwWZaeGRdrDoO/qfgr5bM8cnG3nJUiznmreomM0UPmSJeQ2k4+YlC2+wtU5wlG2nn5EUk72pSpiMKTXG2cVNKmR2sxrs0qDVb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802353; c=relaxed/simple;
	bh=Ik941EEpsfkXy+g/bTFD00wKe0sV7FctYE/8K4Vl0iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kPXUVq1U7uLALxExuM7zF5DHY1g0I0Zizeh2gN9LH7pgzucPYytixh2gzoSYq1LEcwg7keKKx2IkritpPwT3xipPOUvCdtsl74GASnJyTSJw00AaDkpg1OrdV9MaqnvT6ZLr4nTSf0k7Z5gQa7V8KeAjsUUnsjOAtpxZVVpHuHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kwqqAwf7; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=PSo2mZnrd+YTMNhrD5rxHDm0q19foH/SymQJKDqIgZM=;
	b=kwqqAwf74delaSBdV0iK2mLT+eFhwhDpexV78bJoEtAO0I8Y6WKOqxtY6UcM+E
	euO4ZBWHdvkgGzKoKnXo5EpuPmGlOtOR2nWQhApxak8oA6Z6voPx5WCK11MnQRds
	EwTo8mu9yhZxV/fwB+uh08cNFAvDXMNznm8P7udAoBUew=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3v0evoBVqYN9KDg--.14290S2;
	Tue, 26 May 2026 21:31:30 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	louis.chauvet@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2 6.18.y 0/5] drm/vkms: Backport generic vblank timer to fix ABBA deadlock
Date: Tue, 26 May 2026 21:31:18 +0800
Message-Id: <20260526133123.691465-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v0evoBVqYN9KDg--.14290S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary3Jw4fCw1DZw4kCF4rXwb_yoW8tw1fpF
	srGr9Iyr4UJF9a93ZxAan29343ZayxGrWvgr97twn8Zr1jyF17AF1jgr43XFZ8Xrs7Zr42
	qr92yry5ur1jkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeSoXUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-xI0GGoVoLLfOwAA3I
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254353-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 10D525D6AD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

This series backports the generic vblank timer infrastructure and 
converts the vkms driver to use it, fixing an ABBA deadlock.

Bug Context:
During local fuzzing with Syzkaller, an RCU preempt stall (soft lockup) 
was consistently observed in the vkms driver. The issue stems from the 
open-coded hrtimer in vkms attempting to acquire the vblank_time_lock 
(spinlock) from the timer's hardirq context, while the disable path 
holds the same lock and calls hrtimer_cancel(), resulting in a classic 
ABBA deadlock.

This 5-patch series is the complete upstream fix recommended by the DRM 
maintainers. It introduces the safe generic vblank timer to the DRM core 
and transitions vkms to it, cleanly resolving the lockup. 

Additionally, a lock dependency audit was conducted on other DRM drivers 
(i915/gvt, xe, msm) that utilize hrtimer_cancel. They were found to be 
structurally safe from this specific deadlock pattern, confirming this 
is a vkms-specific legacy issue.

Changes in v2:
- Added the missing Signed-off-by trailers from Mingyu Wang to properly 
  establish the chain of custody, as requested by Sasha Levin.
- Included the bug report context in the cover letter as suggested by 
  Maarten Lankhorst.
- The 5 patches remain identical to v1.

Thomas Zimmermann (5):
  drm/vblank: Add vblank timer
  drm/vblank: Add CRTC helpers for simple use cases
  drm/vkms: Convert to DRM's vblank timer
  drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks()
  drm/vblank: Fix kernel docs for vblank timer

 Documentation/gpu/drm-kms-helpers.rst    |  12 ++
 drivers/gpu/drm/Makefile                 |   3 +-
 drivers/gpu/drm/drm_atomic_helper.c      |   2 +-
 drivers/gpu/drm/drm_vblank.c             | 172 +++++++++++++++++++++-
 drivers/gpu/drm/drm_vblank_helper.c      | 176 +++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_crtc.c         |  83 +----------
 drivers/gpu/drm/vkms/vkms_drv.h          |   2 -
 include/drm/drm_modeset_helper_vtables.h |  12 ++
 include/drm/drm_vblank.h                 |  32 +++++
 include/drm/drm_vblank_helper.h          |  56 ++++++++
 10 files changed, 468 insertions(+), 82 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_vblank_helper.c
 create mode 100644 include/drm/drm_vblank_helper.h

-- 
2.34.1


