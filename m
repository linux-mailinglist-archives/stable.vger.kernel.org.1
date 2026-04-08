Return-Path: <stable+bounces-235022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAFrMAKk1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:52:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274F3C1D11
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBF9C300AB0B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4638736D;
	Wed,  8 Apr 2026 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w0OZo3/1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F002727F3;
	Wed,  8 Apr 2026 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674369; cv=none; b=KHopsw9T5LMW05hwZVQwoJXqL/MF5WPAINIeQzwkc655Ic8+OCAAWesjfaQ4fpJlbWc4EJrZlRvNxBh7t6CGp5duW6XLKqRXRfJ8/nZIbaK1IcHBBs2LPaOhu5FSH2PzkJidCa7PKTjOKgxPMHTT8jrl/wZ7G5Uj1cVwaq3c7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674369; c=relaxed/simple;
	bh=mUiiZ6xlMGZw+KZ9MKp8CySRkxU7O6CN6o96jvhglX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOJ/Y3i75uThnpXAJ1DtK8oAlowWWeLH5ybYQUgfstSo65p3g4Pt0SKRfJheFjzh+y66dh/jYsuiWje8WxKSTNK3hvfJrVLycvydT0DLU92Fz2foFkfH1Y68lSZ78bLp3n9UC/tBAStz8v0cer+FI/q01UfNHG1WgxEsMA2rMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w0OZo3/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77960C19421;
	Wed,  8 Apr 2026 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674368;
	bh=mUiiZ6xlMGZw+KZ9MKp8CySRkxU7O6CN6o96jvhglX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w0OZo3/1qwWwKeJrtXlggzsIGZjAkuED68bdW3WwaqDnwlFoefD4JedmZbAoH75v2
	 lQgbM+n+rwH22Kl27Dty7QtoBH8XwLCxuLMRdTEsRWb19QDmlPANwI6pTvMX3znNSy
	 Q+KbYKG9rL0RDkZWPeqRsPQ0/WIzRO/+N9RMhT78=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 038/311] crypto: deflate - fix spurious -ENOSPC
Date: Wed,  8 Apr 2026 20:00:38 +0200
Message-ID: <20260408175940.837604208@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235022-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,apana.org.au:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7274F3C1D11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 6d89f743e57cb34e233a8217b394c7ee09abf225 ]

The code in deflate_decompress_one may erroneously return -ENOSPC even if
it didn't run out of output space. The error happens under this
condition:

- Suppose that there are two input pages, the compressed data fits into
  the first page and the zlib checksum is placed in the second page.

- The code iterates over the first page, decompresses the data and fully
  fills the destination buffer, zlib_inflate returns Z_OK becuse zlib
  hasn't seen the checksum yet.

- The outer do-while loop is iterated again, acomp_walk_next_src sets the
  input parameters to the second page containing the checksum.

- We go into the inner do-while loop, execute "dcur =
  acomp_walk_next_dst(&walk);". "dcur" is zero, so we break out of the
  loop and return -ENOSPC, despite the fact that the decompressed data
  fit into the destination buffer.

In order to fix this bug, this commit changes the logic when to report
the -ENOSPC error. We report the error if the destination buffer is empty
*and* if zlib_inflate didn't make any progress consuming the input
buffer. If zlib_inflate consumes the trailing checksum, we see that it
made progress and we will not return -ENOSPC.

Fixes: 08cabc7d3c86 ("crypto: deflate - Convert to acomp")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/deflate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/crypto/deflate.c b/crypto/deflate.c
index a3e1fff55661b..8df17e7880c9b 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -164,18 +164,21 @@ static int deflate_decompress_one(struct acomp_req *req,
 
 		do {
 			unsigned int dcur;
+			unsigned long avail_in;
 
 			dcur = acomp_walk_next_dst(&walk);
-			if (!dcur) {
-				out_of_space = true;
-				break;
-			}
 
 			stream->avail_out = dcur;
 			stream->next_out = walk.dst.virt.addr;
+			avail_in = stream->avail_in;
 
 			ret = zlib_inflate(stream, Z_NO_FLUSH);
 
+			if (!dcur && avail_in == stream->avail_in) {
+				out_of_space = true;
+				break;
+			}
+
 			dcur -= stream->avail_out;
 			acomp_walk_done_dst(&walk, dcur);
 		} while (ret == Z_OK && stream->avail_in);
-- 
2.53.0




