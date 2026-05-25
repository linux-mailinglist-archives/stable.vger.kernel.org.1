Return-Path: <stable+bounces-254139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OI/L+dLFGpeMQcAu9opvQ
	(envelope-from <stable+bounces-254139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:17:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 261FF5CAFA0
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58F0B3010D93
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90ED383C84;
	Mon, 25 May 2026 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ViIADVMJ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73E357D0B;
	Mon, 25 May 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715042; cv=none; b=QnVazqOeF4otlxGJv+rHamM5k6BkyFVkaGb5jXEhlEXdWfd7RHdNVupG+R7XGFe0+tn3+CooFpmh78YLvURRbWYxRu4lngHH29fWr+8a704/bijWAi759WlgnduO6+YGGHg1UJ0rBthiuZLSrCTwdlOVoNwZviHHvaMpt/huyWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715042; c=relaxed/simple;
	bh=6NLJbUHriJcEPTHc/gZJQ9HqrSvmrLir58qBUwmC6K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V0GyIkWHPFsPKzNmykbZ6LLTsbkurcvd7eGIVtUfBQ2cea3rRPzjOPNIHpfvXzpmYi8zXKd0oLzfinMXeWVNnmq/ES3R1YEX/sc9oRuOzlGjL0pDDB+mMx91/lm5WVZjohTI/QJDGzcJowTSkklN9oC5fgt8QtdvW8AAiFw2Lok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ViIADVMJ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rc
	ojwpS/HH3aFSbpC+5s77qh50pJ7oQ8VBYS0FcRMdM=; b=ViIADVMJK3C/AOjGlo
	Dcx1Y51s2m8Z+gon422bl0ZtGWgdx3oVnXFug1Y8Oe6XCXC3Ib2xvpSg7q+sVSvr
	3ezztEVwQsCcKFbsePkNweXYsXIFQ+FKAYGm0woorvrTVDP+Yly0B74Fedj3AJxD
	CGkdqomKiBMpTF77maX4Ht+h4=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCn6zidSxRqC7WEDQ--.19334S2;
	Mon, 25 May 2026 21:16:21 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	louis.chauvet@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH 6.18.y 0/5] drm/vkms: Backport generic vblank timer to fix ABBA deadlock
Date: Mon, 25 May 2026 21:16:05 +0800
Message-Id: <20260525131610.608273-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
References: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn6zidSxRqC7WEDQ--.19334S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFykWF1rGF1kur43KF1Utrb_yoW8uF48pF
	sxJryayr45JFZxJwnxAFs7Z3W5ZayrXrWkKr9rK3s5Zw1FyF17AF18Jw43WFWUJrnrZr42
	qrnFyr1Uur1UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5_-PUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-wWbf2oUS6UmKAAA3A
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254139-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xidian.edu.cn:email]
X-Rspamd-Queue-Id: 261FF5CAFA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Hi Greg and all,

This patch series backports the generic DRM vblank timer infrastructure
and converts the vkms driver to use it, specifically targeting the 
6.18.y stable branch.

During local fuzzing with Syzkaller, an RCU preempt stall (ABBA deadlock)
was consistently observed in the 6.18.y vkms driver. This deadlock occurs
between the legacy drm_vblank_disable_and_save() function and the
vkms_vblank_simulate() hrtimer callback. 

A previous localized patch was submitted to address this in 6.18.y using
hrtimer_try_to_cancel. However, as discussed with Greg KH and Maarten
Lankhorst on the mailing list, the correct and most maintainable approach
is to backport the mainline commits that inherently resolve this by
removing the custom vkms hrtimer entirely.

Following Maarten's roadmap, this series cherry-picks the exact
dependency chain from mainline to introduce the drm_vblank_helper
infrastructure and migrate vkms to it. 

The series applies smoothly to 6.18.y and completely resolves the soft
lockup in the fuzzing environment.

Thanks,
Mingyu Wang

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


