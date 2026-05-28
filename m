Return-Path: <stable+bounces-255383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLHmBnqiGGqblggAu9opvQ
	(envelope-from <stable+bounces-255383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:15:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 698845F833D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C227B324ACD5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB9304BB3;
	Thu, 28 May 2026 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wIwATVcc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5C339866;
	Thu, 28 May 2026 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998755; cv=none; b=m1mnrkWzloJa01VQtqGlfPvUQieuefUCXBkBhhRvk9FW5071sCoyO8/pcjc3BkYo0GIWjkbFoOZKXLwAc3nqAbtrN9EtfsJx+1OmLhPwQOrFDMFsN3aQYgULhvxyZo3SR690lggma6R1geDloHcP4+EGEGHGNOLilaCD6PDHHMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998755; c=relaxed/simple;
	bh=lcI3xrupcZ3HBoCZdt+RNktnad4A+FY+ONrurCrSxag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXwaKwsMmf4NgKJuLYYQP3A3BM5ygrM6l+ZwvZXxi7Z9vpUEnEka0ZtrOWmhi8Bt904FAfLNIgFTbsKbg0N0JGxCk1Qeko3OHuj5MS1ibPlEEBnC+r9RllTLia2AbUOUys6wcExzl6xv+MxFLbPM137Fd6Iq5DrfCCfEByR+Ks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wIwATVcc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD2D1F000E9;
	Thu, 28 May 2026 20:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998754;
	bh=MahcfbPtcAETO6R6ZFBlejMB3ILzcwxigDFe88XWnoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wIwATVcc5HOeNk68KwXhQUjm6GlMBCXv4MdgZilqMQaz/X88hblUhtCyR6/w//I1c
	 UxbjCUaK2KQRxivZ+LczOXqT89k/5iotqRI7zaq4QgN/lAiuldMIWhCHNJxtTmQeQN
	 uJLEyANy9u1zBpTiFOguiImUgJc/4IvM3EWvHa9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 287/461] block: dont overwrite bip_vcnt in bio_integrity_copy_user()
Date: Thu, 28 May 2026 21:46:56 +0200
Message-ID: <20260528194655.509567624@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lst.de,kernel.dk,kernel.org];
	TAGGED_FROM(0.00)[bounces-255383-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,lst.de:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel.dk:email]
X-Rspamd-Queue-Id: 698845F833D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 637ad3a56a3b889527d1dacea6fea2a8bd648140 ]

bio_integrity_add_page() already sets bip_vcnt to 1 for the bounce
segment. Overwriting it with nr_vecs breaks bip_vcnt <= bip_max_vcnt
on WRITE (bip_max_vcnt is 1), so the gap-merge checks in block/blk.h
read past the bip_vec[] flex array. On READ the read is in bounds
but lands on a saved user bvec instead of the bounce.

The line was added for split propagation, but bio_integrity_clone()
doesn't copy bip_vcnt and BIP_CLONE_FLAGS excludes BIP_COPY_USER.

Fixes: 3991657ae707 ("block: set bip_vcnt correctly")
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260511215151.346228-1-devnexen@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index a319362217037..5a316d8bc5efa 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -244,7 +244,6 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 	}
 
 	bip->bip_flags |= BIP_COPY_USER;
-	bip->bip_vcnt = nr_vecs;
 	return 0;
 free_bip:
 	bio_integrity_free(bio);
-- 
2.53.0




