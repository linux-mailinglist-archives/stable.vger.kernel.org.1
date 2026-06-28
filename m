Return-Path: <stable+bounces-269433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XgP1ETJuQGo6fgkAu9opvQ
	(envelope-from <stable+bounces-269433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 02:43:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940366D2E45
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 02:43:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nhslLRqX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269433-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269433-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 667C130160EA
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 00:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22EC18871F;
	Sun, 28 Jun 2026 00:43:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980881AA8
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:43:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782607407; cv=none; b=chtYAkPuH6QhgNmdLb5V0mK6s8PmuXinMklteGai5DRv1BX7vRFTsa6RmK25cDDFMlYa8D4oKD5w4DO5QRFCGT62TbU76p5soUzoNshStjUKrup7ytH7McFsAqsvchWn8RZN4k35SK6nMxrzZ77hGFYuojkuY69HcmxyI9eF4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782607407; c=relaxed/simple;
	bh=9wSyaoXnq89nLIWOctnPdcX2pwbON+qF3C0UyKebbrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cy5lTPoS9vOxVBgj5Dkdkx7yZsrr66VFarfVNYZKAKlZb0lmsrQI89sy2wYY99KKn/HZ6+2x0BCi9Ad9V5veY3bs9jV6Ys7NgAe7h7GpfCsUO37pdTt7NBPg6aJae+DO/DQSu5zRtpSniSkjyiAuga9XFlhGiiYMKrzcUbLJjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhslLRqX; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4626fdc829aso1358726f8f.3
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782607404; x=1783212204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/K0oyqX2HpaNhJgmG557ds5Wum+B6nCD3i5NrtHbg4=;
        b=nhslLRqXQYCRAfPRZo7wDBfGpb/+Wy2ztIQT0p0VIjJmJiXNjQB03tTTWrLLqCiOGI
         QQ/lQePwylF3N14T3RKwtwE4e1/I/axLJNM1H+HtVZMV/ieBpGhUoYTq8NWNzthg2MJu
         XdL6oUxlRR5Wt/XdBML+iKt5jaGnfFPI4rzCugQbh7ZgXsMa0VKuvB0XxQdbfWFUVrls
         aTWAi3rjO4c5W10/egsxMdmbcNvctwN4DZM1p0O2b0HsLq4v4yI4mW3EfNsPhlnj9cDh
         ibk6MZ2pnUpw/GzT3Y0dGvpua9RzNy0LQONbzXvcxxFWQRj6PkpQEkmZl1puwK7r3rkU
         xYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782607404; x=1783212204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/K0oyqX2HpaNhJgmG557ds5Wum+B6nCD3i5NrtHbg4=;
        b=DRhxfKdpv0DdjFsl5k3W72N3ZR80CxpkCILZ3jNJ4DiTOV8hRnZ4PfHkxg2l3LqaPs
         ZN6bLzcRGFE8OJzXlVdunoXnOERDFnB8gc4l+WYhFB+W0Ut455cnUi6cIfhf2JA/dxXG
         LA70COu1pBFg36rjKLHgsb4YiX+O1m1z2TRkkb1+F2r7fpnPFbwiszgm1lULBfCEIlx8
         xcJXfSXsXDLvYsq42shh8xPK8Hz5ntM3blmSSonN9FULEXGp+GcbWlSwfMTI1Xi/rWka
         OrLu+CfQvJWRk58cjP3DMTRAPM0mt/ol7YJEi7XHQMBm1N4vQcjDe0sRhr0xqvuueHwk
         E7jA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9lGWb9xqg5Qk1wr5rvkTeV/ALz5i+tzPA1xTbDZRelfjo6KHyAsprKEjY3eAgCwYvqTnCTWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCRgIzIZ393Jz2d2GCxBvwUsik+SaSTf32MBjyFMcGwA2eE8I
	GpDC8lAuCiomkXPXz/RTtrc50i8dhWgWne5ADUZS70Tcb9/I7jmv0qQk
X-Gm-Gg: AfdE7cmfvBo1lCFYMRV5kjGnY24bjVqKo3FhfYEmu2srlgkkMkU2i6T20kHlIGcMvbq
	U7t+m5K9xRtZxc9HHaVY2W5Gl8hSmHCnDCko2hKPV3AYfX2a9toebiGG8CAgSdjJOf2q6J4pZf5
	8HuMHEyV692pkLroD85Vs65kwvDywyQxHXyL+/1jW0/w62CqyBCQfSEsX2H57v46lAY8l9A6lRH
	1Wlqtjoi+nxK+ZQK36BHCk2euKyklyurFor3kgBC4uk3227OdF+tRM4yQkrQyR2XRGSnx+Wv0Nx
	q9BBaJBnMMV7UY6QMEl4j20tTTM/e20H7zhs6XLgL0m4ImoHsLJgRpPeT1Qkdw2TuXDZ2UF8K0W
	C8x81MQbIQcrZbJJ+N4RQ4OPKrFtK5ffiJ3XhlnLGf0wB8nx/yV3SZiJEW8HkHaL6tHaVMcfPTx
	x7RmGY2aCnKh4mTYdgG3p/Re0hBg==
X-Received: by 2002:a05:6000:1841:b0:472:22b4:fd55 with SMTP id ffacd0b85a97d-47222b5015cmr3741851f8f.13.1782607404584;
        Sat, 27 Jun 2026 17:43:24 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm8612218f8f.23.2026.06.27.17.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:43:24 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] tmpfs: zero unused folio tail for long symlinks
Date: Sun, 28 Jun 2026 02:43:14 +0200
Message-ID: <20260628004314.27370-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269433-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,bf5586280a66e9ccdfa9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 940366D2E45

shmem_symlink() marks the entire folio uptodate after copying only the
NUL-terminated link target. The remainder of the freshly allocated folio
is left uninitialized.

Reclaim may pass the whole folio to a swap compressor. KMSAN observed
sw842_compress() computing a checksum over the uninitialized tail. If
the folio is written to a swap device, those bytes can also leave the
kernel.

Zero the remainder of the folio before marking it uptodate and dirty.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bf5586280a66e9ccdfa9
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index b51f83c970bb..b06c1ae2f50c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4057,6 +4057,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			goto out_remove_offset;
 		inode->i_op = &shmem_symlink_inode_operations;
 		memcpy(folio_address(folio), symname, len);
+		folio_zero_range(folio, len, folio_size(folio) - len);
 		folio_mark_uptodate(folio);
 		folio_mark_dirty(folio);
 		folio_unlock(folio);
-- 
2.54.0


