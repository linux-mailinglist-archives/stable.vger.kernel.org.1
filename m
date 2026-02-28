Return-Path: <stable+bounces-220864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDXSDTxFo2kB/AQAu9opvQ
	(envelope-from <stable+bounces-220864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:42:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9363F1C7498
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE983310E1E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D830241DDDB;
	Sat, 28 Feb 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd/ItxcL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60241DDD2;
	Sat, 28 Feb 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300749; cv=none; b=pR0bOnBLUFLHxD4Z4EIFSa71O/VdMmg5DiDCIzFnkInaQEVEq/mQVGpUEJvm6eym3yfOZjVlZaEoQ+A9hHwmypDo4RpRAGKAkePz+k5WRV8VxJFzwcELSo4dOUw/S9DIdY6jwPx/8T40s1NVpFjPf2JiweO7g2bmLFSgAqwDwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300749; c=relaxed/simple;
	bh=JgNDxt1J+KIqE4bkKNZgfOq0qnpsrOurMpn2qfVfZXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw1YBGfBe3O+GxdG+s3Z7epOANlPxxYjX2Wbt+eGyofxHXxSVo4wyTeHz1F8rg6o/opJhHj+rmA9z3TKMMKABtKRU8a5zoIRXFO2KrsOgydz4qdo/5x6k3eDzL1q2Xg2fQ0ku5EYwbHu2NYS56ScEDM4/vFs5FHirLNWwd5XJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd/ItxcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A543AC116D0;
	Sat, 28 Feb 2026 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300749;
	bh=JgNDxt1J+KIqE4bkKNZgfOq0qnpsrOurMpn2qfVfZXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bd/ItxcL013tjaCNMY68RxXItt4of43FPAZ2u9h5useHRk8hvvC1a2N/a+e8KmM2c
	 E5qMY8FDKWgFvzsbEBc1xbTGF2gIMy63TSFeXurxu6gUAHE5t6Js4JCYOzcypPs0PB
	 BOEfqt8UAvXO9ei2qpsvf0adDVTggFiFuO48AdyTgSczNm3Eyi0HfbxrnL5GWHYd4f
	 XpM1x2JpD+5INIZ1ZptKspiZmLohU7Dy2BqJeZ0lz173DlXlEmcKDctKFAKDVPEaPk
	 0d+FBiagO71PDUKDCZjHym8Zfv5a6hpo2AX6Uo9uKSZeSzwdFVP3/Gn910oaJc+DV/
	 cS2ejWk3fGTFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sam Edwards <cfsworks@gmail.com>,
	Sam Edwards <CFSworks@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 785/844] ceph: do not propagate page array emplacement errors as batch errors
Date: Sat, 28 Feb 2026 12:31:38 -0500
Message-ID: <20260228173244.1509663-786-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220864-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9363F1C7498
X-Rspamd-Action: no action

From: Sam Edwards <cfsworks@gmail.com>

[ Upstream commit 707104682e3c163f7c14cdd6b07a3e95fb374759 ]

When fscrypt is enabled, move_dirty_folio_in_page_array() may fail
because it needs to allocate bounce buffers to store the encrypted
versions of each folio. Each folio beyond the first allocates its bounce
buffer with GFP_NOWAIT. Failures are common (and expected) under this
allocation mode; they should flush (not abort) the batch.

However, ceph_process_folio_batch() uses the same `rc` variable for its
own return code and for capturing the return codes of its routine calls;
failing to reset `rc` back to 0 results in the error being propagated
out to the main writeback loop, which cannot actually tolerate any
errors here: once `ceph_wbc.pages` is allocated, it must be passed to
ceph_submit_write() to be freed. If it survives until the next iteration
(e.g. due to the goto being followed), ceph_allocate_page_array()'s
BUG_ON() will oops the worker.

Note that this failure mode is currently masked due to another bug
(addressed next in this series) that prevents multiple encrypted folios
from being selected for the same write.

For now, just reset `rc` when redirtying the folio to prevent errors in
move_dirty_folio_in_page_array() from propagating. Note that
move_dirty_folio_in_page_array() is careful never to return errors on
the first folio, so there is no need to check for that. After this
change, ceph_process_folio_batch() no longer returns errors; its only
remaining failure indicator is `locked_pages == 0`, which the caller
already handles correctly.

Cc: stable@vger.kernel.org
Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/addr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index faecd9025ee9c..3cfe3df6e6a22 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1369,6 +1369,7 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
+			rc = 0;
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
 			break;
-- 
2.51.0


