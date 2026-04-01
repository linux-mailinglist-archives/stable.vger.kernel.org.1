Return-Path: <stable+bounces-232659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id t8B8DnyNzGnVTwYAu9opvQ
	(envelope-from <stable+bounces-232659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:14:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F67374267
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A49DF301E9A0
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57C36DA14;
	Wed,  1 Apr 2026 03:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwecOi1B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62176FBF
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013233; cv=none; b=GFZzZLJarnP8IOt7BLlfS4w+GSp5+dddj7cHe/7eFzrf9swsunehbWYc3YQaKBr8GTNyKel16x6EBqNGgHWlA+B/Ctil6JJ3nFoBHiKjZVfM1Y7xpZ5wcf25KKXkc27ufOpIcnrswxsE7siQwg+HO9TeCkfBw2HVrVMkpHapc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013233; c=relaxed/simple;
	bh=3qmKi+7NGTPmsMSzwTSl7l4uTJjqFPzwWq1vjBmZtio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PIC7T0GeD0YJRgQXguOIZq0aIXD+G2QGo7zM4lJOSBQ0uFg04D25m0Z9IMM7p44b6c4XrwBerdi+ioYWnmJ9QcvZ+teGI8OX3ZnhgmUmbCE7mUoqWBznSGrIHi+0F4QGHt/ALcYIA5TOpwxQzSvUUFHl4ygUncUzmKjJ0r46B4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwecOi1B; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3880325a91.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775013230; x=1775618030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfmezofCFYRgZ5OFemKApUxmmUyvqX/ZDRNGUel5g18=;
        b=UwecOi1BkDsrv7hCzMJqB2BGQHO+1WvQqkufTt5CXODXslXsz+4WtnMUleRJzkh33Z
         +o2rjx5HR2qXZJRupu8+hD//e9iGbtwpwjQrH1w/7Rcryp1R1wZrY3NoYnLhmSsMUxmC
         COsVTUj3/ux6SLUPNOkd+dWm7b2TZTGNqhaOD/f3UTBsfJRIZzDceuBVZ5KaGOR+CWWq
         52Ay+i5IvmSasj4cY+pS7hE4p6Y5dmdNsogDHiN+LUSljN0JAEH3JuPg5oP9teXPNOfe
         umlJU/02wF53yYY1PAeiac+75Kbh71QWNPSgIpAcO5LECd+Crscv3/YklLpH86neyaX3
         seHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775013230; x=1775618030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfmezofCFYRgZ5OFemKApUxmmUyvqX/ZDRNGUel5g18=;
        b=n6Y7S4kKX198PzxBMSPuvXE5rfLnc3EIXAs8H/GckOCvUKJKsgbmmdPMrgLtHQPLnP
         SoJgnGJtTfEoDylhm3PyeaesDVNM0p9ye0Egx62/HI8a/UsIzCIVk4XTpBlU1OxyY4qH
         rI+SXUniAL74Z72WMz/dnLuSyRh6J3y6t+xcWPX40qb2bC7cZNBnnqsIGwrUWn8+YClS
         hOMvIdoLnPDveo/jrre2uuex621QFlHMBd/CQtEiwZZkYubiOs6vlG2CslKsXQTNjxO9
         ojPYFLvT+T4aFwV0J4zcRfr1FqUGMw0GQuzV0A+daXcv4sfxEbmG7J1CJXIEfVp/RtOl
         tk2A==
X-Forwarded-Encrypted: i=1; AJvYcCWfEL/sW6nhlE28o9GewJRMBHAFse1ZOfubeKHxW4+dudTUlqYM4OOyB3qmPzen8/4Azq2V5Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZqw3bnJ4OHlXR5ytb8YkLPFS7ObAD+PHjIGIyFJjFck+FEyQT
	HGznjqG1c4jfksMaJwGBQjVPhlljj7HFFoNH+sq+JHITfya1sOmNNJVR
X-Gm-Gg: ATEYQzz47kC5cq8d3r/r4cP4b33C6AA3+abxLo+ZraU4q9OLCfDnlUnAVSLWJeCG4AH
	IYhYO8p0gBN9v6jEEEg/+bD3MSzA+4Fs8OX73dWYQcf0yNe5GrOfw1v4ycTiZDvtZHZu0L58UWg
	AbnwJbnWSfdSafpm+8QpO7rmKGUv1lfdprM/GG4IAgB/VPXbcaYByFFPCxwFgBhilG2oWMyGyOp
	UFJldrIAJ2JquZFtx3NtOq6NFlNxGU7cHgh9SnpfNtd8PBlCsUzXgVuSkn/UqPsgXNWu2Iz9AXU
	mTlu8oOdO6p/qj6wKVdmhuJWUV95c236W2IBiZ9fH0MHwSzg9QyLle/0zcp2o+xjDZWFiv1uyqW
	Pt725sLC2a3NNn92EguRP6bo0cpmddeunHCt9VmN5GQE4K3/t30n8SLcIwrSwbEvWfaFQhVTASf
	0pbAXBRO8R/mWqBg5FRvKgtg==
X-Received: by 2002:a17:90b:1350:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-35dc6e2d00dmr1661679a91.2.1775013229891;
        Tue, 31 Mar 2026 20:13:49 -0700 (PDT)
Received: from lgs.. ([2408:8417:e10:5f85:653:6a84:ffc9:685c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76b986ec97sm1659337a12.30.2026.03.31.20.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:13:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: fix double free in create_space_info() error path
Date: Wed,  1 Apr 2026 11:13:39 +0800
Message-ID: <20260401031339.1418417-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232659-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[fb.com,suse.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7F67374267
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When kobject_init_and_add() fails, btrfs_sysfs_add_space_info_type()
calls kobject_put(&space_info->kobj).

The kobject release callback space_info_release() frees space_info,
but the current error path in create_space_info() then calls
kfree(space_info) again, causing a double free.

Keep the direct kfree(space_info) for the earlier failure path, but
after btrfs_sysfs_add_space_info_type() has called kobject_put(), let
the kobject release callback handle the cleanup.

Fixes: a11224a016d6d ("btrfs: fix memory leaks in create_space_info() error paths")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3f08e450f796..d7176eb2fcbf 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -311,7 +311,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	ret = btrfs_sysfs_add_space_info_type(space_info);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	list_add(&space_info->list, &info->space_info);
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
-- 
2.43.0


