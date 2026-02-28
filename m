Return-Path: <stable+bounces-220680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K4cNBU/o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3821C6C71
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB2C53105264
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BB03F6242;
	Sat, 28 Feb 2026 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oipm+q6x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE23F5A4D;
	Sat, 28 Feb 2026 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300561; cv=none; b=C2TtMuHlN7hyK56hFx2HRlsX78DWhOCmnHr4BaWJ/AiL7r697+jc2H/bGlOw51l5F2VSfKZRssmCSiQglQAyHxetFJdnv/aySLLGoK3vnZJBIUCJewIWhPL9jsrDEIN89KFnoE+l5A7tccQuEXRAqV/RpHrbUt0CDs4XGHKxnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300561; c=relaxed/simple;
	bh=wiFr3cqew56q6DCv9ENOeggq/XEDhHnvSs/Luebh4zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg+x4dWtBFJkm8bnHR7JoK3FXWxiGgy01ngYy0FYbRHhbh5Vr3K0EQESmhWnBEW4djKPA5WhgV83T7Czdn1OhwoA6qpsZ6oct/CXc+G/gtuu1v0PvD+rihWCpuL6xVbXFwpe6zL9GdCVmcGZapEJwRi2qAYZZwewNpyhA+2rGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oipm+q6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069C1C19423;
	Sat, 28 Feb 2026 17:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300561;
	bh=wiFr3cqew56q6DCv9ENOeggq/XEDhHnvSs/Luebh4zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oipm+q6xqxYrd8jeTCc7jR83xxQ7cpxODvSxNgz7HcDDPtRcPFWqpJzyy6+XUEPl8
	 oKhg0MVqopSGuZFGgpV4wwSfjVgtjorTVzO7wv7igyR+lDQPSFdzcE4YICCg1Tl9du
	 p9T3N6OckL/jL779gp7QpfT+q/eMr2TRfsErgT620qnh9iptYL8NzPwhorDMmWLv+t
	 glA5CvC8hTpJS7Jg/K4LwhLIJ9IGGpVwZUIwKmJaVuIBL6Rgd2z5A4TPIRkaneGmZQ
	 ChUZi4SC3emFURJhgwnDIRKBt80fJx7aj8dQZnR8HEhBcOpWLDrkA2ip7ipMDdsdbu
	 TvwhCCqN2GF0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 601/844] dm-integrity: fix a typo in the code for write/discard race
Date: Sat, 28 Feb 2026 12:28:34 -0500
Message-ID: <20260228173244.1509663-602-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220680-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A3821C6C71
X-Rspamd-Action: no action

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit c698b7f417801fcd79f0dc844250b3361d38e6b8 ]

If we send a write followed by a discard, it may be possible that the
discarded data end up being overwritten by the previous write from the
journal. The code tries to prevent that, but there was a typo in this
logic that made it not being activated as it should be.

Note that if we end up here the second time (when discard_retried is
true), it means that the write bio is actually racing with the discard
bio, and in this situation it is not specified which of them should win.

Cc: stable@vger.kernel.org
Fixes: 31843edab7cb ("dm integrity: improve discard in journal mode")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 170bf67a2edd9..79d60495454a5 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2411,7 +2411,7 @@ static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map
 
 		new_pos = find_journal_node(ic, dio->range.logical_sector, &next_sector);
 		if (unlikely(new_pos != NOT_FOUND) ||
-		    unlikely(next_sector < dio->range.logical_sector - dio->range.n_sectors)) {
+		    unlikely(next_sector < dio->range.logical_sector + dio->range.n_sectors)) {
 			remove_range_unlocked(ic, &dio->range);
 			spin_unlock_irq(&ic->endio_wait.lock);
 			queue_work(ic->commit_wq, &ic->commit_work);
-- 
2.51.0


