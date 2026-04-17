Return-Path: <stable+bounces-238443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJCRAaPk4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:43:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599C418174
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3017D305AD54
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB133793C8;
	Fri, 17 Apr 2026 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qemNqOvZ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B6A316189;
	Fri, 17 Apr 2026 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411651; cv=none; b=SyTWbzYtf0IqheCGF9g2O833+7ZTkc7mWmfd2JZpI+ElmvCw1np7uzLzVtgiNgrZG6Th7k+G2U7GJ465q/Sfi4D4QHB/X26JU1gn4qjPd630YBWsrQOjbzDoGaR8X0rEAu0imMApJ6lkpzZyGt2uLoD3cPt7WbHxU08f7Uu7Jho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411651; c=relaxed/simple;
	bh=F/yR7j6WJjB6ZZPwjfbH5F7sRfTka8hqO+JIeTsVRKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VI8Oc8zHns88mG6zc7eHLxKLI+oImKsCRF4kJ4gA5xBi2T64TnywNz3l3hwDmpnnftrAXwKd/DcX7pBEtMFPZgkATxK5LCRBf8EGh/jJWgnsddLKXi042uYtc2OPL64junn9ikjwnCiblr8PkEQlkzYa2qt62uJjmffVRQUAADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qemNqOvZ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=ec9J7I0MAhcvubfbKVPQh0qJjmz98punS+lUBUOQvEk=;
	b=qemNqOvZLZ2bEWie0GNABtQH6q+lsvgF5hecAyAY7etKfqtoWV6ddman19xiCB
	b7e+uE53ucGEl30ZieUCbsHn2NtQ0bBa9HeeDrNOU28wQCcmwcuiOxq3+5Rc2w97
	AeLifdiT/OjfuE3T09W/du8MhdR8bFqCGXhFef6tKWEEw=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDHpCra4+FpGWiTAA--.26143S2;
	Fri, 17 Apr 2026 15:40:10 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Pan Xinhui <Xinhui.Pan@amd.com>,
	Robert Garcia <rob_garcia@163.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yifan Zha <Yifan.Zha@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
Date: Fri, 17 Apr 2026 15:40:10 +0800
Message-Id: <20260417074010.1607496-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHpCra4+FpGWiTAA--.26143S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWDuF4fXr1fCF4ftFW5ZFb_yoWkZrc_GF
	Z5JrZ8Zw42yFnYvw1xua1avry0v3yrArs5Gw42qa9YgFykZryrJ34kGwn8Xr4fursxCF9r
	J3W3WF18JF98CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_BT5DUUUUU==
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAhsCbWnh49vqnwAA3z
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238443-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,163.com,ffwll.ch,linuxfoundation.org,lists.freedesktop.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[163.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7599C418174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 5d55ed19d4190d2c210ac05ac7a53f800a8c6fe5 ]

Those can be triggered trivially by userspace.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Modified to gfx_v11_0.c only. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 37f793f7d4d2..6e3a32779168 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5380,8 +5380,6 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 	u32 header, control = 0;
 
-	BUG_ON(ib->flags & AMDGPU_IB_FLAG_CE);
-
 	header = PACKET3(PACKET3_INDIRECT_BUFFER, 2);
 
 	control |= ib->length_dw | (vmid << 24);
-- 
2.34.1


