Return-Path: <stable+bounces-220536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MaLMXQ8o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:05:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CEF1C6973
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C9423071423
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E73D05FF;
	Sat, 28 Feb 2026 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgILu77i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDA3D05F5;
	Sat, 28 Feb 2026 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300419; cv=none; b=H4p8ZtJX9YrpOri6wPycxiXa00EOSASU2HdDtbaz1yuee5MYnPy8P10BmvB56QXWcDy9ES2QwccBQkVtJxnpANX663fk/UsstIGO3btFOiLEIpfl+VnABtVsovBtQR7I9qbAvbTaqjJklGr6flaoP5+YyBRsRM/YynVG5VvOkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300419; c=relaxed/simple;
	bh=Q8SaXWL93odJG0thtYeuDo3S//j8M8ja3rclt+aW2gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swu1DiLp+TPeV3pEhHZ/PF7LV/1r6oi9XkYrWRWn4jQMTjugzYQ6TAXWVIvfoaVnkyD1HrU2XbBI088hvpkPK2nPDyXsLsRkM+cOhylY6grEJNNSfXbSOztaETjJNxZWqv/4Ht7NfO+3pu75/TR88ZY6gF6brGEDX80DJJUXt8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgILu77i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941FCC19425;
	Sat, 28 Feb 2026 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300419;
	bh=Q8SaXWL93odJG0thtYeuDo3S//j8M8ja3rclt+aW2gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgILu77iEPCruMcv2g/txsGihyz6qbXM2c/VCLLgFYJGacq8V3tT3VSI1YGNdCaHy
	 9yV7fBROcadhkC5mMzJgYd6fMq8wMbookQVhDY4Iu9b5bz5ens3x/AIZVRH39ylVDv
	 8m1jHzixt3x8iq7YdRBpKg55SS2HF70w/cBdOqwjVeLXsy85Jyye9cqYi9IyysvwS5
	 fJbarVLKiRXo+rxjYt1ks//Te3SbQRnq0J0h4BUuFKqM24zd2Ln1BoNzMfY85CuVEk
	 doKhn1EqxXUQfD2wuyKiPU+2IqiIiabiKUQRmsJA3OhfPnIwWWCg4vzwraGZv2qzNI
	 dXce6AL3nJM7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ethan Tidmore <ethantidmore06@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 457/844] proc: Fix pointer error dereference
Date: Sat, 28 Feb 2026 12:26:10 -0500
Message-ID: <20260228173244.1509663-458-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220536-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22CEF1C6973
X-Rspamd-Action: no action

From: Ethan Tidmore <ethantidmore06@gmail.com>

[ Upstream commit f6a495484a27150fb85f943e1a7464da88c2a797 ]

The function try_lookup_noperm() can return an error pointer. Add check
for error pointer.

Detected by Smatch:
fs/proc/base.c:2148 proc_fill_cache() error:
'child' dereferencing possible ERR_PTR()

Fixes: 1df98b8bbcca ("proc_fill_cache(): clean up, get rid of pointless find_inode_number() use")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Link: https://patch.msgid.link/20260219221001.1117135-1-ethantidmore06@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4eec684baca9f..4c863d17dfb4c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2128,6 +2128,9 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	ino_t ino = 1;
 
 	child = try_lookup_noperm(&qname, dir);
+	if (IS_ERR(child))
+		goto end_instantiate;
+
 	if (!child) {
 		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 		child = d_alloc_parallel(dir, &qname, &wq);
-- 
2.51.0


