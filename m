Return-Path: <stable+bounces-246511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOhvLhJvA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:18:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA44527492
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6829D30EF6F2
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB1A356741;
	Tue, 12 May 2026 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVDSZfwJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56A33ADBA;
	Tue, 12 May 2026 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609414; cv=none; b=cg49k1POs9JMbck0lTyXclK1r/Pfnt5FaCk6J0nzhhy23IsQYl4qjVcI1rVSDbw/hCL9ctP5eYRGnBzOijTWXyFI9mJPeFqQGo+sHt2AljEUQAzTcxCRJtsxqgdSvpNGu3EeDQeEtLhzK+O4onaET0KDRnBS0ftPVRUyl2yG1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609414; c=relaxed/simple;
	bh=9pmw+mWZNKigYH7rjiS9+2Nu8JS9HFf90xGTx1LyGr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5e19ielg1/6i2P4nYl7GAb+5Lh8eOCxy4Tsj+zxGn+xxIt2aPGAAE2TNKmAxxKBVoMDW4rZf6lt1JxsZxJQIafe8iyGsrukeRNyXrUGOZiPwY06tBhdLHG5oFxk9bjs9ykYjknmTuTvOqPOjT99UOhCWrK9bHIAS4r3F+ifG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVDSZfwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0682EC2BCB0;
	Tue, 12 May 2026 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609414;
	bh=9pmw+mWZNKigYH7rjiS9+2Nu8JS9HFf90xGTx1LyGr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVDSZfwJ5c00nryI76R8VSB7l049S7XHXR7rIS5IqpTHfwQkjWgOnVxL51AKUBHX/
	 f4N8/zrc4xWRHrrWRkgfD9ScVhJfnw0jZ0wnWSmoJNf1TFhmyLggxh5qSCFTnVOgn5
	 t5XVHz6LPMkmvzyIqwDgCR1zRGJlGt1IPSFskaqA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shubhankar Mishra <shubhankarm@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 7.0 186/307] dm-verity-fec: fix corrected block count stat
Date: Tue, 12 May 2026 19:39:41 +0200
Message-ID: <20260512173944.041956189@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7AA44527492
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246511-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

commit 48640c88a8ddd482b6456fcbc084b08dd2bac083 upstream.

dm_verity_fec::corrected seems to have been intended to count the number
of corrected blocks.  However, it actually counted the number of calls
to fec_decode_bufs() that corrected at least one error.  That's not the
same thing.  For example, in low-memory situations correcting a single
block can require many calls to fec_decode_bufs().

Fix it to count corrected blocks instead.

Fixes: ae97648e14f7 ("dm verity fec: Expose corrected block count via status")
Cc: Shubhankar Mishra <shubhankarm@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-verity-fec.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -163,11 +163,9 @@ error:
 	if (r < 0 && neras)
 		DMERR_LIMIT("%s: FEC %llu: failed to correct: %d",
 			    v->data_dev->name, (unsigned long long)rsb, r);
-	else if (r > 0) {
+	else if (r > 0)
 		DMWARN_LIMIT("%s: FEC %llu: corrected %d errors",
 			     v->data_dev->name, (unsigned long long)rsb, r);
-		atomic64_inc(&v->fec->corrected);
-	}
 
 	return r;
 }
@@ -439,6 +437,7 @@ int verity_fec_decode(struct dm_verity *
 	}
 
 	memcpy(dest, fio->output, 1 << v->data_dev_block_bits);
+	atomic64_inc(&v->fec->corrected);
 
 done:
 	fio->level--;



