Return-Path: <stable+bounces-238723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMg6H1ft5WnxpAEAu9opvQ
	(envelope-from <stable+bounces-238723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:09:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC79428A9B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA204300351F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351FC3845CB;
	Mon, 20 Apr 2026 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8XPhyDJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tInwUF9D"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1E30EF97
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675707; cv=none; b=uwLmiUlcuyqhb8nundWuUJZG4aAW4aDxWe6H9Wt0JvOlCRynEe+Gdp7Nf4fqcey7PBOwnKyE0nvbc/2kiUBWEeUknT5rxdfUZ6Rl52Z7dhcLiq2D7UQE3wvxWEcjI9X0pqhMRCXDlLpqTG0HXL4fk64VgdwG40rXhPs6qOX4iwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675707; c=relaxed/simple;
	bh=V/Jtl//8CLGHqFrgZDH2CVGljpJr2maDlNy9JvCsxZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gl/eYB+xtVK/+cbFlh9SB1wkOcdfXB5z7p45IwSfs5o71IF6Jpa41GUB5knnPJXcInYS6XOerI6MGudUr8nSOLZZx08DB9jvTlhlbQC002EIJgNB54O9bqEltZQNN39dNwljSzJRRwI/yj2mFxpwlWgUpRSAcrgLQrEJ2LLdJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8XPhyDJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tInwUF9D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776675704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gqkbOMppUZI/mnfihhZglDkygJ5RC7Zg7E8StFuzWbk=;
	b=e8XPhyDJElufNhEJlyQjxt++MvWNs2fy+QusNHRDxMWS/3KEPFUhRxDgez06sZCQdonBaF
	GqiHySL5fJVWl0Ly8SizL8vDw0Sy5ioUYgXaN2gLmzaIF8qZyzoH75dZQvdMiNMRzUwTny
	YAnPewGQI7Rnv3lgmfMLD7jzlM5kQd4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-LDVvL3rzPa2kUMeSkd1Puw-1; Mon, 20 Apr 2026 05:01:43 -0400
X-MC-Unique: LDVvL3rzPa2kUMeSkd1Puw-1
X-Mimecast-MFC-AGG-ID: LDVvL3rzPa2kUMeSkd1Puw_1776675702
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7757463eso2101078f8f.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776675702; x=1777280502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqkbOMppUZI/mnfihhZglDkygJ5RC7Zg7E8StFuzWbk=;
        b=tInwUF9DnFS3hUP1aF33jy2LVyxIYXi/eLobNbz25QAk5laufqe+gMrxzsgcZmF4DR
         xwPuoypzZVYn3/sguqGwRddhNER6POekbkqqsnRiGMKmEunmoGOEDE6cbUfPho1FO3GY
         tSwCp4z5NSKPCm3Cb/OlRibqOpoaro7YOR5kcaBEharNvCDv3Y1rJ31DwV09oSl9QfGu
         rX+5AYyFB8++kKSMvQ8kXukxhWTouS0crrucW6esJj1Yz8vMgMfu2Jt2c5nZZZewPq/s
         +BQZSAJQY//UexTXi1+3ZtPVcxqVhpPrkIK10ccnFCg53L80aJ4HeJyx6riQqdl2ELZW
         Lekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776675702; x=1777280502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqkbOMppUZI/mnfihhZglDkygJ5RC7Zg7E8StFuzWbk=;
        b=ItMozdNNMUlnAaUaRvhURmk381Jg+sVOcTyX5kG1ZfQViVJzduvqSfp+yzoS0LC2b9
         YFSpzeIS4pjnS+1ruEuwiSZnVuDolB/bAArIIBRsu0Pd7Qu7fXza6bnK7KZmCOaA6c6v
         ztRYYsigH9hFGqQSu7mibLCsSp3PB+zYCEiPQXHHNAXldOK1bWgvIaHR5PuXhAgQ2W0M
         FyMS29ll7vBF119YWXJlIfFa5wpesnLnmFBtJZzoN4ulni7g5/y4/Hl+55K1JE5Z6Rqp
         3/uUf8bbPbg+58rSZ+c69xF/kSBemVEIhoxx9H6T4RbgZ3vDDIYSb8ZmsNjsTvkyA34O
         m0zg==
X-Forwarded-Encrypted: i=1; AFNElJ+3jUDUS0+645gu3nl85tmY6g6rmWQQzjrGwjwh9PpeEv74qzv//6hx1j86CwSoQpisF8EXEjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6pWHs9mCZurwGmV6jS2veI7JzEuOWh5rFNEtKj05ods/favs
	F4DdB+1l9EKRxBncpWDX7bs6iCKiozjRi+okFGdo0Zx0saOzI2WQgKUVp1OH3nIK5oF03Z6vGjQ
	vilEiAnxF1Zcuw/uWcOxA8TRJ4PjKoJN/moVSMJIbpxV6mKCLQwa4CZ+k0b4dqUAmZA==
X-Gm-Gg: AeBDiet2JEVCBldvLMNLO5w8K7k1+1nj1+N8CLCsWxK5xjw3+PYxyYF/zNdtOJjE/18
	8S3RxD5LDCWBKmfDhTwgbqCfxwoNwKHqF0hhWEeG52UMuJC63wA14W5RSDF7SdP94cLk7Fr08H4
	OcpdbvavCkanzEaCpoKA9FsYSyBi0xgXI5Q6Aul0U+KSv/wKJSeJboOGWuO+Od7h9GjvMv+7Yii
	Sym12nNZp5+tkLzz5VNS8aGURDWjTMVkN0MkP4LE6IzRkoXfZktFLnYmbE/Ar+PRfD3QEGjMQuj
	m6Eqp3nVX/etVp3PkgdTCP6t9CULXqId/c8PWoQ+ntOoikyHAP2a/LpzW3G+YgXAjmGPc0xDax4
	Xkryx38Fg8amUG72JmzDz4McYTRV6Fr6YAnTeyywW5jAP60zqG5oIBnuvfRCbD8ao+CgKPY/Vlv
	pbTkpT5sajy2lNeA==
X-Received: by 2002:a05:6000:2a0d:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43fe407df74mr12676662f8f.15.1776675701701;
        Mon, 20 Apr 2026 02:01:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2a0d:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43fe407df74mr12676605f8f.15.1776675700918;
        Mon, 20 Apr 2026 02:01:40 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-153-35.pool.digikabel.hu. [188.142.153.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a18csm31153195f8f.20.2026.04.20.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:01:40 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Samuel Page <sam@bynar.io>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	Zijun Hu <nightu@northwestern.edu>
Subject: [PATCH] fuse: reject oversized dirents in page cache
Date: Mon, 20 Apr 2026 11:01:37 +0200
Message-ID: <20260420090139.662772-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[northwestern.edu:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238723-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[bynar.io,vger.kernel.org,gmail.com,northwestern.edu];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.916];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[mszeredi@redhat.com,stable@vger.kernel.org];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[northwestern.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bynar.io:email]
X-Rspamd-Queue-Id: EAC79428A9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Samuel Page <sam@bynar.io>

fuse_add_dirent_to_cache() computes a serialized dirent size from the
server-controlled namelen field and copies the dirent into a single
page-cache page. The existing logic only checks whether the dirent fits
in the remaining space of the current page and advances to a fresh page
if not. It never checks whether the dirent itself exceeds PAGE_SIZE.

As a result, a malicious FUSE server can return a dirent with
namelen=4095, producing a serialized record size of 4120 bytes. On 4 KiB
page systems this causes memcpy() to overflow the cache page by 24 bytes
into the following kernel page.

Reject dirents that cannot fit in a single page before copying them into
the readdir cache.

Fixes: 69e34551152a ("fuse: allow caching readdir")
Cc: stable@vger.kernel.org # v6.16+
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Zijun Hu <nightu@northwestern.edu>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/readdir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c88194e52d18..db5ae8ec1030 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -41,6 +41,10 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	unsigned int offset;
 	void *addr;
 
+	/* Dirent doesn't fit in readdir cache page?  Skip caching. */
+	if (reclen > PAGE_SIZE)
+		return;
+
 	spin_lock(&fi->rdc.lock);
 	/*
 	 * Is cache already completed?  Or this entry does not go at the end of
-- 
2.53.0


