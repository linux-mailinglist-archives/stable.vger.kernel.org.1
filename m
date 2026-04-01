Return-Path: <stable+bounces-232758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMj7NI/8zGnRYgYAu9opvQ
	(envelope-from <stable+bounces-232758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 13:07:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B2D379187
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 13:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39BE130989EA
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC363F786C;
	Wed,  1 Apr 2026 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5V5aRTm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F63264F4
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041353; cv=none; b=oAE7igodiy/1o9c7X7Xqc1vMdUgcoGBmh7QpLQo89+J+x7eckRFuQswgGdGnmoOJtG+zlHBi9XggD3BVbSLr4tXr7tldb4L2+U+IwiznsVD4GT99n8h4OlNV/kdn+vM1xpJEnmdnQjTVn11ibrakUuzP23XN/Ye0c2OnsKfm3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041353; c=relaxed/simple;
	bh=SbqRNhVI3Sgg9eZpNawZvYKHn4MdY9ZbL6RY8LFSIjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgkaSfGUzF8N1B4jR/I91TIJDfN6uDrBWQ4idGRcAXXSWpVSzayFGuzbXvWC6z+hOH8qgut+q2htzp9e+s9kKUzDp8VUvTRH418mbPq2WZlbQF6V+Q6Cz+HQZEIBvNdFe7B/HymVoedZ/Hu6jGykUeWjQNtiIdP6DWIoOkUd8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5V5aRTm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so590247a91.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775041351; x=1775646151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HirRrF/8RjBfg411Yn+GABwevBrUwvnGEoVcLWmnLPc=;
        b=n5V5aRTmgjSYRFS/JeajMKCd6eVvqsLLjjalILqW2n0U18iqBWgZHt7RU23L2RP0jd
         1g+AG9MtgVT4AG5U4p+mqtXpR/dCvNSl50YJjuSCq6eApt89SnTQV6zqwkqPfh8pS+R/
         WQQCCt3j8fSjrD4tRuUcxBe1goOS8PJotNXyJY98J1GE66kZUb7FCBHKMhAN7rs2ijtd
         tzcu3X17j1hhiQr2moYaTY742SuL9WSH5C7UmXQlFhxL/tTESRsuysVAbgJMezGecOQM
         s9fFun3mn0Wu3Q2Lrd4cGGAcG4btaQHvi3Wa1qVRhcDBn5LRgJX0iijtjUXPmxJ8374S
         ZtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775041351; x=1775646151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HirRrF/8RjBfg411Yn+GABwevBrUwvnGEoVcLWmnLPc=;
        b=RZin0DpsN27jJXiN38TT4471LYazl4xUUQAFbbzedite/ixLbbcuTD100jgty7BIV8
         mn9ocYQKIGyxvKHqLCcom3c25ISr7oKU79cmxuKwivKFZTRgzuwSTkFuFb7GgrQkXBW6
         znCJOJorG/Bee3fP5k4cFSkG4m6cg4G48pC9EhmzL/7OK6oI0Qr3W3z/77expz9l25SI
         ntWQvLob7JXJXMnem59vaSDXGKkxd1WqqHQD0CBIYbfDkJTCx4J5cbpiUVOtiakMx3Jj
         1mFfvZkbaPDE796UVsEUapwvO7lT8JhTWIAZRbHjeX8zIYHE4ngH8Wlp9nIpL5pbGjyx
         E5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWZebk1r7k0JlShyD/EdhQ9WYz4UZK5gTsTXnHfRdTtB2d1hDV9HQCT/zd6972SVXHzubXvry4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCoLtutc860rGUo3S1eqN61R3yq2fTy8LC6OOutMS5f3NoLeCa
	MMkHN6ztNQp0fuLsT/h6ZuY9USLAIQgTv8n5PPSFCOJDUxzJsYBwExLkHcynlANSmcU=
X-Gm-Gg: ATEYQzz4n1OEq53gVvxbeXw9VGeGgVJgMeNrR8/Xxrqq5o2YpNSxKRsUv9mBAuOaQs3
	IjZensQ8ihygYbAlwEDwGdQQ6UP8dmunF9ZgQVYUcaCf9rInsJ6vv1z5fqYDyBcbUKzVc6hFi+Q
	tVmJSmqeCwAsyZuKfGi6dgFcTBo/f+hWxNQn3xJw8xeWjbL8a1pH2bptTdI7l+kFbCZ+WESDqTl
	2zp/+6RmiuWRseGtvFhMSIaBJOn6nVU/TqFSJ1/qZ21pHU9iepzCfFca2KqhZhEJ4VuI9nK40fm
	G8ZBtkMraFH3UehErZW0fWDGfKfFJW+yoaA1DpKJDkhho34+O52fnTiOokLOO8CEScgkQ1uE74+
	S2SGSfak288JTQedGoXxMNdpbRs5bexo1lvZ2FDBG1BezaShmXhBxcEHM0aRs3Y2Mn0TuSvootH
	W5LzWB1aswElR6Oaw=
X-Received: by 2002:a17:90b:1d03:b0:35b:9d0c:a2f3 with SMTP id 98e67ed59e1d1-35dc7027dbemr2379083a91.15.1775041351018;
        Wed, 01 Apr 2026 04:02:31 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe977031sm4604626a91.17.2026.04.01.04.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:02:30 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: fix double free in create_space_info_sub_group() error path
Date: Wed,  1 Apr 2026 19:02:19 +0800
Message-ID: <20260401110219.1517804-1-lgs201920130244@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232758-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67B2D379187
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When kobject_init_and_add() fails, the call chain is:

create_space_info_sub_group()
-> btrfs_sysfs_add_space_info_type()
-> kobject_init_and_add()
-> failure
-> kobject_put(&sub_group->kobj)
-> space_info_release()
-> kfree(sub_group)

Then control returns to create_space_info_sub_group(), where:

btrfs_sysfs_add_space_info_type() returns error
-> kfree(sub_group)

Thus, sub_group is freed twice.

Keep parent->sub_group[index] = NULL for the failure path, but after
btrfs_sysfs_add_space_info_type() has called kobject_put(), let the
kobject release callback handle the cleanup.

Fixes: f92ee31e031c ("btrfs: introduce btrfs_space_info sub-group")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 fs/btrfs/space-info.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d7176eb2fcbf..f5d0f587b755 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -277,7 +277,6 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
 
 	ret = btrfs_sysfs_add_space_info_type(sub_group);
 	if (ret) {
-		kfree(sub_group);
 		parent->sub_group[index] = NULL;
 	}
 	return ret;
-- 
2.43.0


