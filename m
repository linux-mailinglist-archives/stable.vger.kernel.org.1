Return-Path: <stable+bounces-218091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DDLEYFQnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AA018EC1C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2E1C30F7251
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E89E21D596;
	Wed, 25 Feb 2026 01:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r9ReYZtq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162B242D9B;
	Wed, 25 Feb 2026 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982866; cv=none; b=JE+mkqvF5RRz+SOHU/nTTaNIpg9g5pyut12KsGVh29z3KzMKEPQzdNAhoyFaHUOd7sqgeGp9I2ZmsapN7vZqoxTKT1UXAQ9DNGnG1aMTdapPGv4iRnNgKCdBExRZyQodMP6Odaa5N16BEL4Si+aabjPWNDWqKxwCORGcMIDTh6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982866; c=relaxed/simple;
	bh=MIxCQIRuxXe1Jsp+jyCPeJ7sxhblefW/qNUFcgtDjms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWnLfg2QywF73jelSmwWhkY92oncqzeZTuema1DYED9rnnN3TLaOnvs4YLFlbaI/7pydkR/117NcH354exF07KsXawCyznDVbj0d5nFc7VOrbkw8PU1fxrOd4ogka/0F3tOodEdnjMGdCcH1ZA5w6F5OOlZKKHGayhue+bMFN/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r9ReYZtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0BFC116D0;
	Wed, 25 Feb 2026 01:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982865;
	bh=MIxCQIRuxXe1Jsp+jyCPeJ7sxhblefW/qNUFcgtDjms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r9ReYZtqTI2sS3m2COFhbbSwnVuYDVN/tsdOM/hVn4GCaAGIxh3bMKiZ2vyRQoTje
	 YaR+9zb+eDtrZgce1xRwcSt1/bHHxwqX2z0JZLeHQ501DNbwvJOcVapvZeuCJ5ZoUW
	 kmr1hJNvaMGb2YGlYR5srv7BHyFkeFvkdQH7lFAE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 052/781] iomap: fix submission side handling of completion side errors
Date: Tue, 24 Feb 2026 17:12:41 -0800
Message-ID: <20260225012400.976240627@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218091-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B0AA018EC1C
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 4ad357e39b2ecd5da7bcc7e840ee24d179593cd5 ]

The "if (dio->error)" in iomap_dio_bio_iter exists to stop submitting
more bios when a completion already return an error.  Commit cfe057f7db1f
("iomap_dio_actor(): fix iov_iter bugs") made it revert the iov by
"copied", which is very wrong given that we've already consumed that
range and submitted a bio for it.

Fixes: cfe057f7db1f ("iomap_dio_actor(): fix iov_iter bugs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/direct-io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8e273408453a9..6ec4940e019c6 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -442,9 +442,13 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
-		if (dio->error) {
-			iov_iter_revert(dio->submit.iter, copied);
-			copied = ret = 0;
+
+		/*
+		 * If completions already occurred and reported errors, give up now and
+		 * don't bother submitting more bios.
+		 */
+		if (unlikely(data_race(dio->error))) {
+			ret = 0;
 			goto out;
 		}
 
-- 
2.51.0




