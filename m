Return-Path: <stable+bounces-214596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMrPCsx1hWngBwQAu9opvQ
	(envelope-from <stable+bounces-214596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 06:02:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D09FA32C
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 06:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 537A930309AF
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 05:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88572E6CA8;
	Fri,  6 Feb 2026 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KukJk880"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A22E2DD2;
	Fri,  6 Feb 2026 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770354114; cv=none; b=Qs8eZcuJ7l7um783eD8ZZGl9e8M1t0ZHwEdejYUs4cJ2sbEw+kPmZCtJb05t20xKbpHwK13fiDUz1ee7gAwi1lWvEKGKFExZfQgrTjiyWb0KJlUvFb3By6WUxgDdD+VDK/AXiQrsqo+XlxeVjpX9pTVzq5hX0qXynGQPbEHPusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770354114; c=relaxed/simple;
	bh=awsnYHluhMYiSyOtcwgGx116nbhXaUrMrdS3ZQpowTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReQ0Fecd0QzWmPS31Zc/vmB7R7B8GNFuxfzcCprDK45dHO7zlsETQnvCqx5fTwIIRcVVpYODoVxABsTHJ0eXGr7WTpU0t3bSGl4IUdIe73K5/2FVUibma3ryokvtsWuK7eq1ezg7xavl+jyleWvBuw/B27rS1R0EFI+0/mNlsVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KukJk880; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1745DC16AAE;
	Fri,  6 Feb 2026 05:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770354114;
	bh=awsnYHluhMYiSyOtcwgGx116nbhXaUrMrdS3ZQpowTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KukJk880K6NnbRiGcQFsNjp8X07faD28UcXBZDbAECOYIy/jSDdG7AEYTGhh9YFaf
	 alGeSBJN8Wl4Dyu/dHP/uC8l5nFTn6Xb7mhRcAyHppQ2kZ9VBak/5JO+/050vv+V2/
	 VgAC+cOTUrkWCifdB6c5W/IFJuqbHhpUWFHhbNHvMsnYtsO56EHhBgPpGsKOXJHic7
	 7lExmnphPv0JVb0mrSMbIq4Tx3t2FnASQTMZVlLQqq7EjtAHPJjw0KhBGuFtEnbrt5
	 NtTbQsJeIWjaJ9pnE9yshT+nhImeGNOaZr5WirjathqMwuOSjTPWtkj7toivfcDJGC
	 PAnP0YedhLT+A==
From: Eric Biggers <ebiggers@kernel.org>
To: dm-devel@lists.linux.dev,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 01/22] dm-verity-fec: correctly reject too-small FEC devices
Date: Thu,  5 Feb 2026 20:59:20 -0800
Message-ID: <20260206045942.52965-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206045942.52965-1-ebiggers@kernel.org>
References: <20260206045942.52965-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214596-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97D09FA32C
X-Rspamd-Action: no action

Fix verity_fec_ctr() to reject too-small FEC devices by correctly
computing the number of parity blocks as 'f->rounds * f->roots'.
Previously it incorrectly used 'div64_u64(f->rounds * f->roots,
v->fec->roots << SECTOR_SHIFT)' which is a much smaller value.

Note that the units of 'rounds' are blocks, not bytes.  This matches the
units of the value returned by dm_bufio_get_device_size(), which are
also blocks.  A later commit will give 'rounds' a clearer name.

Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/md/dm-verity-fec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 7583607a8aa62..5c276d0fc20c0 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -623,11 +623,11 @@ int verity_fec_ctr_alloc(struct dm_verity *v)
  */
 int verity_fec_ctr(struct dm_verity *v)
 {
 	struct dm_verity_fec *f = v->fec;
 	struct dm_target *ti = v->ti;
-	u64 hash_blocks, fec_blocks;
+	u64 hash_blocks;
 	int ret;
 
 	if (!verity_fec_is_enabled(v)) {
 		verity_fec_dtr(v);
 		return 0;
@@ -704,12 +704,11 @@ int verity_fec_ctr(struct dm_verity *v)
 		return PTR_ERR(f->bufio);
 	}
 
 	dm_bufio_set_sector_offset(f->bufio, f->start << (v->data_dev_block_bits - SECTOR_SHIFT));
 
-	fec_blocks = div64_u64(f->rounds * f->roots, v->fec->roots << SECTOR_SHIFT);
-	if (dm_bufio_get_device_size(f->bufio) < fec_blocks) {
+	if (dm_bufio_get_device_size(f->bufio) < f->rounds * f->roots) {
 		ti->error = "FEC device is too small";
 		return -E2BIG;
 	}
 
 	f->data_bufio = dm_bufio_client_create(v->data_dev->bdev,
-- 
2.52.0


