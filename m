Return-Path: <stable+bounces-256563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIEwIeNUGWrTvQgAu9opvQ
	(envelope-from <stable+bounces-256563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:57:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D655FF9A5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A602308A6A3
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC401353ED9;
	Fri, 29 May 2026 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSVB7Sfe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54583A9625
	for <stable@vger.kernel.org>; Fri, 29 May 2026 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044821; cv=none; b=LsdjlAhnSU7p2Zf2HZriHtY47+kkyaXoO8EwS4tgmRGCyIZ/Tn+AtBgcg2Byp5j3jqMV5SBvRolU52/KkysG5PR5+m3U/hgnZnXwRPRKNPX4/tqM5TsQFD6dSUgtIa9KxXmieNAi142W3Vh31Z/of0RESz2VrDm5GYfOIcX86PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044821; c=relaxed/simple;
	bh=FyoHFrGRRI+aMqGck5x5ii339plHkAlI7euqWoBRry0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIULFlS5FF1yjEPDJwFAiRZGlApsd9YRjEFv4C7atDzO+b0KJ6IAbPJT0QI/j5knQxCGKpRGSdN3i765PfZnum4CqVOMfv2c6eOF4Zeju70iV5pbJ+7pYfzG2rzIJjQqq/NEtltp4hAd6GAwWoUWNIPxIO8XucuwFS2F/rtNpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSVB7Sfe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso44010375e9.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 01:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780044818; x=1780649618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2R3/HY+TZwDP536xdY5FCSiiUr5tHBZfz6LP9l2pe1g=;
        b=aSVB7Sfe35R4QxQ1xTmw1BTV1sk/8MzCzJfMGmrQ6b/C6wOUMDRwMKhh3SkdNRqsGU
         r4TX8OSfoa/BrYm/t3qCIn/jS76W/HTgjz9IlWs9jKxZFUCGv1xnq8SqREMBz5Q8ODsw
         Rt5yI/H7jOBmnKiv1B8Ehlx5mz0+10LGPUVc/8+GOYIRXo0mxiZrcjd6RwxZTICy6mJb
         iaviRjKcB5WO9xRgqYccuVZA4r3Tht1OFX7Z3TnN4zxdp1mSwZxCrbMHqURQQfwpRcJZ
         6+Fb1YTQ1EZYw6SMMMbGgfOwjGdxPtCPpn9Ymjga7/Bw5KxVXQXfU+ichOtMhfsWJTWL
         pXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780044818; x=1780649618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R3/HY+TZwDP536xdY5FCSiiUr5tHBZfz6LP9l2pe1g=;
        b=pXr/ged1tDO1RO89MpRhPy7h+t4zV+TLM45lqjKduFsQz1AYjTk+NrffIK9uiwiUc7
         d7AVUQqY4osMdNtLcXduFc3Imc/HR6Z3qOhtpLUcRphQY0UvYz93mW+4H1ONe7FpH4BD
         V2GKlfJWyQw6kEQo069mSq+uxS/2Mx7D8WtE9Fiwb24yZ/1QekPWBv7Lr0bI9SMmrHct
         qt2xULLaqEiOsulGZs7DAwiVQvGLXGwnw4xn6MJeLStGhsiIFEUuGWbws4sfNpdgLuzQ
         iBk+7vOfSqtsYmzSFCtRXXYqXli/jYEJEZIEavY5dqp24HNhl2g2cUJLhlthRKCWIyYP
         AoJg==
X-Gm-Message-State: AOJu0Yw08cId1TuN/SieJOeHl5SapvyvYhjqJYHlt5qBRhluV0E/afu+
	sM46Lk/JfLKGM8LwPpu9YqTjA4DGcfk3FdUhOBa65SqwKx3nrFKQFn4oo7HvwQH9JT72zQ==
X-Gm-Gg: Acq92OGeYzaI8IAuy2iE8wrQXpDARwsQ3KUZfbvQf9PH8ikYSY5YWtx17HVb5Qllrug
	0ZOpmoeycAHZbh4Ncjwr6FwdoFN/Q+RPTJWlkEUOoyiVnF08xNYZhiWE9ZUcUEY9Zn67hGMbR4R
	2BqfnPXjTniPr6WAH6UCeMduwugBuk1/TIS6ov4o6afAmeOZVu5844iy2hLUnsWF55nlBfEWA7s
	l1zohLrg/0eJy8AueiFjKnyhE322qtPi34M3CmUVwcifmYAoY5/iXtSHWZiq6nhFRMstmMcvrny
	FSXW79YFGJmXn8KAy4/GggEnnosaOn5pJdZQQBWxwyWvhntlbyaKmv7JCfydqASGZa9cEOtVYSX
	oxovJbSF4Kti6DQXMJlPHrjAe5S1q2y70OuYlVlNK46oDSzLzRGnmz42X3e+yXu4QxttyWvAgq6
	8Q41quSuc5fxf5s2gCAl0KurJnWtHKF25U0+32HbIMIQ==
X-Received: by 2002:a05:600c:6a8b:b0:490:778:4fec with SMTP id 5b1f17b1804b1-4909c0d3a70mr21125185e9.33.1780044817504;
        Fri, 29 May 2026 01:53:37 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909dff2a80sm29453685e9.3.2026.05.29.01.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:53:36 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	"kernelci . org bot" <bot@kernelci.org>,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: [PATCH 6.12.y] block: make bio_integrity_map_user() static inline
Date: Fri, 29 May 2026 10:53:34 +0200
Message-ID: <20260529085334.937482-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,kernel.dk,samsung.com,vger.kernel.org,intel.com,kernelci.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256563-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxoid@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernelci.org:url,kernelci.org:email,kernel.dk:email,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 12D655FF9A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jens Axboe <axboe@kernel.dk>

If CONFIG_BLK_DEV_INTEGRITY isn't set, then the dummy helper must be
static inline to avoid complaints about the function being unused.

Fixes: fe8f4ca7107e ("block: modify bio_integrity_map_user to accept iov_iter as argument")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411300229.y7h60mDg-lkp@intel.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit 546d191427cf5cf3215529744c2ea8558f0279db)

The same build break is now reported on stable-rc/linux-6.12.y by KernelCI.

Verified the upstream cherry-pick applies cleanly on top of 97928cc88900a
(Linux 6.12.92-rc1) and that block/bdev.o + block/fops.o compile cleanly
afterwards with i386_defconfig (which leaves CONFIG_BLK_DEV_INTEGRITY
unset). Without the fix both files trip:

  include/linux/bio-integrity.h:101:12: error: 'bio_integrity_map_user' defined but not used [-Werror=unused-function]

Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://lore.kernel.org/all/178000554419.7114.5687032601791586484@330cfa3079ca/
Closes: https://lore.kernel.org/all/178000194591.7095.11275948264529325340@330cfa3079ca/
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 include/linux/bio-integrity.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index be91479b2c42d..53f6dbd2816e0 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -98,7 +98,7 @@ static inline void bioset_integrity_free(struct bio_set *bs)
 {
 }
 
-static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
+static inline int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	return -EINVAL;
 }

base-commit: 97928cc88900a9fb07a4dddbd1db19eb0ce55c56
-- 
2.43.0


