Return-Path: <stable+bounces-218841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL1MO7hVnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:51:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A8E1900D3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A37B325DDC3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729FE275B15;
	Wed, 25 Feb 2026 01:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ina9+1pQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A0262FC0;
	Wed, 25 Feb 2026 01:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983724; cv=none; b=mdwX6tHHxL9U7VIjs5h9CCilST1fT6nEWl+3hlA+hRApmbXMWXYL/1+obJr4QSe2VtqHcMWvemCRtEaNYAU5trOHs68w5gUaJ4mxtiEilAQRvbSdosyhOEFCn+IoB1kw5bVJMfp56FN/1OhAEtObBxSxifDACx4oLl/s5WnLNkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983724; c=relaxed/simple;
	bh=SQQVDJx7frtQOaYh4YkCwHssOORnVKOvKxSK40SiErE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuNe9PDAKtiaG/kA+iigSpycBQNpBj2Vo7qM5B7YZB+OXUoJmbL9KEOcAn0TqoOvxXkUzWeCEN7Sp/zAnrW4njfr/949yRKQ0fLdmg3vL1OOrsg+c6Y23MG6KobMcJI746V6mDRM4BToe69SfxfLNLEc7RYRVQJszQF7ub3N5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ina9+1pQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD32AC2BC87;
	Wed, 25 Feb 2026 01:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983724;
	bh=SQQVDJx7frtQOaYh4YkCwHssOORnVKOvKxSK40SiErE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ina9+1pQhqT8+SsXmWFQIKVJ72Z26Wyx9GLzjHQSHm2oYvf0R6Mh2QuJXDJhX05fI
	 sUCskBTVdp4kQnLT4m0n4CAQvlH3UVl8AuA876sTmaDLxeV0DBhJ16+tIakX/0NlEM
	 IjlXh3+5t1+awBaJelW0GiwrAYxPkJr23rUH+iWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 020/641] erofs: get rid of raw bi_end_io() usage
Date: Tue, 24 Feb 2026 17:15:46 -0800
Message-ID: <20260225012349.461900919@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218841-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,lst.de:email]
X-Rspamd-Queue-Id: 24A8E1900D3
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 80d0c27a0a4af8e0678d7412781482e6f73c22c7 ]

These BIOs are actually harmless in practice, as they are all pseudo
BIOs and do not use advanced features like chaining.  Using the BIO
interface is a more friendly and unified approach for both bdev and
and file-backed I/Os (compared to awkward bvec interfaces).

Let's use bio_endio() instead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Stable-dep-of: bc804a8d7e86 ("erofs: handle end of filesystem properly for file-backed mounts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/fileio.c  | 2 +-
 fs/erofs/fscache.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index a47c6bab98ff9..e2eaa7119bd4f 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -35,13 +35,13 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 	if (rq->bio.bi_end_io) {
 		if (ret < 0 && !rq->bio.bi_status)
 			rq->bio.bi_status = errno_to_blk_status(ret);
-		rq->bio.bi_end_io(&rq->bio);
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
 			erofs_onlinefolio_end(fi.folio, ret, false);
 		}
 	}
+	bio_endio(&rq->bio);
 	bio_uninit(&rq->bio);
 	if (refcount_dec_and_test(&rq->ref))
 		kfree(rq);
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 362acf828279f..7a346e20f7b7a 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -185,7 +185,7 @@ static void erofs_fscache_bio_endio(void *priv, ssize_t transferred_or_error)
 
 	if (IS_ERR_VALUE(transferred_or_error))
 		io->bio.bi_status = errno_to_blk_status(transferred_or_error);
-	io->bio.bi_end_io(&io->bio);
+	bio_endio(&io->bio);
 	BUILD_BUG_ON(offsetof(struct erofs_fscache_bio, io) != 0);
 	erofs_fscache_io_put(&io->io);
 }
@@ -216,7 +216,7 @@ void erofs_fscache_submit_bio(struct bio *bio)
 	if (!ret)
 		return;
 	bio->bi_status = errno_to_blk_status(ret);
-	bio->bi_end_io(bio);
+	bio_endio(bio);
 }
 
 static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
-- 
2.51.0




