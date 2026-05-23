Return-Path: <stable+bounces-253973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOA6ENMGEmrDtQYAu9opvQ
	(envelope-from <stable+bounces-253973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 21:58:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8D5C0BB7
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 21:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D83630075F2
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0433A032;
	Sat, 23 May 2026 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj5/IQqD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571631AF2D
	for <stable@vger.kernel.org>; Sat, 23 May 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779565941; cv=none; b=dLB4FQ2aP3RN82RzBpB1/1/xZ33Sv+oMrbtcz07Qa7I0C/a2M30MPmVsD3CLrcuiDgFq4B69yGG4/uBvyKB/F3/4Ys3SGT9VqUqk5dmTjLGsy7fxWWAZAK48U7D/nSsnrfUQd6WujvfPDtnEsWtvkTsBohuN7OynZz6TODqb+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779565941; c=relaxed/simple;
	bh=Z3QflqX9mFs0gI1YMsicKWkDud29jtr5BUo6DFIcgr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I5PRTt4uMOVXRbZCw2MwJ98urwuKnCguyC1MYGsiThwwVOy9ceatHOpIhMAhvlT/9NE0KpSzb45Jgdhe42FI0pWa7Mb7nDes1TE67g+61kqhrcUU8GLJ3rnSl1iKgXVJ5Jg6OdhvWPpqyN8K+BHV6lqKBkwQGKHitK0mrJp/XuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj5/IQqD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso5995368a91.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779565939; x=1780170739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWrWJYufhREX3pTpYqP+nOLGz+ztZIkOJ8+XyiCxrpo=;
        b=Aj5/IQqDk+q9eesVuy8VRVmVqCzodHA5Pd6iDcTksGkcP10eC3HkAzFFp8zfw6z4v5
         lGhwbj87DlpHRESU6nxq/uKYmlQ2IVOz8SNMHJE61kUAjH4ZalpcCU/s7lS70bE+ZwZ1
         0H9EBjhAqtMtE6eTBgIoWZK5XDS0hN1DXevOjV+aC/ujOwLow27g/7qNhw/rDx9sr7TT
         uwMfDsyB4mHNYqdnuu3sPxGv1QkIBT7dDxUEl/2gg5E4vLDz2NZ5MJtYZ4MYHe+lTn4+
         m5KJKU1Hrt9WJg36ZZl2aPX6hCtW9c7QtLLEqvRNuPFX7QzWsGdkf1L9S+mLeBlfGo49
         mK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779565939; x=1780170739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWrWJYufhREX3pTpYqP+nOLGz+ztZIkOJ8+XyiCxrpo=;
        b=VFbb6uWggE/MVgjQCdJIZsFoS4aEa2eeCNIU4STkJs+3jjT0EnjFc2MHvk1O+vWagQ
         dhe91crYtpaeaUgqpllVNENlT+EHvR3rozKLzG78BSq/NuXYd/q6pp6RF3m4/M/zSIRV
         yB9oFwfk7Tuj61KMcrqm9LnZ/Xs1m7NB+xRJCFF0QshxxL17qKRzhlmsbhrie8lWDX+u
         bETB21UDRoin0WPFs7Rzs6L9vp6CFeG3xo39yx7ZjPgUu+7HRx7KeIpYNG/MT0y//Kmu
         3zCCtm4gLZ9XqD83v4NVu7HJUyUsRIshr77RxWGcxYQLK4A8mgESguuDXcXAY0nrDlfB
         /2fQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ntEb9WEKJf1NasLCp6SNqJBWxKuZO7HtfEy1gMaEL6sP5vULvd1BzEujPsMWzRahQKbZ7kOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5W2SZfbMCJCvt/Smk0SWB39rc5BCDIlVqWAr6aWktfbasCdC
	U2htMMqJroBtVDALMxh2kf6Tiyz2v9hun8xk0ueZYslfGBb6FkGONSEq
X-Gm-Gg: Acq92OFktlHEusfZJ5oTq2FkvKi/c8ti7bv3rcCb8BLGv6QcpRn2S6VhsCFcUazhb9q
	2VE0HhQ9uEHnc4HUuA+w8TMn+6GR07sE1lIBJDZEl2f5XIRWnfOBBZ50SDO8wBaULFAAUhX9L3u
	qPkUkYTJJpTkG34zNQ3T4RBYYJAvKzJca3WQOQ1oQ4FIvV7pf6Aa43mJY58yoHEIhI/OU0sp0Tt
	tU9jzo+4pjIzxnLkrk7OeXZf65zJQBG8VbGt72+Ulut6jgauLhijqKhF4XoAZh2pWfqe8O0pfTJ
	qjqgmhQDUMFA8jZiTsoZjxPhoxBWTHFgqIx3zOE596Db79CvDEz2jFjnHMfuEaqYt+HH90J3ppw
	8f+Q0EagT9mD99KC/CUjoYkACDlmqAAcB3HR7KxX2s2PXT8wQqyhxeefhWBcnDw6f+JTUAJ2A2A
	ibz9kpyRuvoGOyxMYWHWGSX0L3vxKXfx4y6Ntb1vZfbXpucJ2T9LRKd3Cxzd3Xgl7CIUul5TQRE
	wCM8CNsN2JQrblKokL2el68qZbQtTYsgz0cDMelr/CAkKtIUQT4trYIgqjoo4U2KSnuf/RQWXAo
	9QGUWR1qgpqdkglTQJIxPg==
X-Received: by 2002:a17:90b:1d44:b0:369:7944:d723 with SMTP id 98e67ed59e1d1-36a6bb5a6bfmr5964578a91.4.1779565939265;
        Sat, 23 May 2026 12:52:19 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7212aa06sm2993459a91.3.2026.05.23.12.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 12:52:17 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	tzimmermann@suse.de,
	Frank.Li@nxp.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/ethosu: fix IFM region index out-of-bounds in command stream parser
Date: Sat, 23 May 2026 19:51:59 +0000
Message-ID: <20260523195159.55801-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,kernel.org,suse.de,nxp.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253973-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 97E8D5C0BB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NPU_SET_IFM_REGION extracts the region index with param & 0x7f, giving
a maximum value of 127. However region_size[] and output_region[] in
struct ethosu_validated_cmdstream_info are both sized to
NPU_BASEP_REGION_MAX (8), giving valid indices [0..7].

Every other region assignment in the same switch uses param & 0x7:
  NPU_SET_OFM_REGION:  st.ofm.region  = param & 0x7;
  NPU_SET_IFM2_REGION: st.ifm2.region = param & 0x7;
  NPU_SET_WEIGHT_REGION: st.weight[0].region = param & 0x7;
  NPU_SET_SCALE_REGION:  st.scale[0].region  = param & 0x7;

The 0x7f mask on IFM is inconsistent and appears to be a typo.

feat_matrix_length() and calc_sizes() use the region index directly
as an array subscript into the kzalloc'd info struct:
  info->region_size[fm->region] = max(...);

A userspace caller supplying NPU_SET_IFM_REGION with param > 7 causes
a write up to 127*8 = 1016 bytes past the start of region_size[],
corrupting adjacent kernel heap data.

Fix by applying the same & 0x7 mask used by all other region
assignments.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index f526f4aedffd..80d4bc21c28f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -466,7 +466,7 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			st.ifm.broadcast = param;
 			break;
 		case NPU_SET_IFM_REGION:
-			st.ifm.region = param & 0x7f;
+			st.ifm.region = param & 0x7;
 			break;
 		case NPU_SET_IFM_WIDTH0_M1:
 			st.ifm.width0 = param;
-- 
2.53.0


