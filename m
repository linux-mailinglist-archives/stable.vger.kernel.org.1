Return-Path: <stable+bounces-220116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ3SJvQoo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE71C50B8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 536363072C09
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AB47F2E9;
	Sat, 28 Feb 2026 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joOAxSd+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A947F2DD;
	Sat, 28 Feb 2026 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300027; cv=none; b=ZqPr5+VO8OQ63KnThwhIF/CEGEkCulQjl1jRzxzgsDn3U3pN2t/4/945ZHZr6X9uoM5Tx2ltCb1nJQAq6W+o3xVlfT+r83nSZzxexjH4Xki7iQn37gO7eIfWJ4DhwF25NVhbBu4RwfDszz9jKT3eIxQEX/edfq53Ogs6hZQ2KSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300027; c=relaxed/simple;
	bh=L7r/ZydBdbS3/Kljjcw3TA4m/2thEk7br8YIHdiykkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHSh4TOcgEgfGu7/ZwvwjbHDCTT0BKpV0MICqtGPHolds7Ph0zaJwZqZYRMt0g1zSlBo6lvLnh0+n6b7fv2CsJyL5KmhZdm3395wxhZD1D+aqdvGx2Uv2ZGtxvTYHmiRMV5Hu+wqLnow9KJCAiXTMqLBPSEnIW22z1XK9RLiaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joOAxSd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF67C19425;
	Sat, 28 Feb 2026 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300027;
	bh=L7r/ZydBdbS3/Kljjcw3TA4m/2thEk7br8YIHdiykkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joOAxSd+18RFQNMSpiu+tFsoWGkhYTlr9c1QilVdhK1oI5L7ECnP7lwvVaM1YXtPV
	 Yo6hx2wRJKm7Ly8iMfmg2Nt5XcRsJEZjSyk/0wLqAMFASBDrAkDPhg48+85H/M5OSh
	 lZWJuF4t/TcIetS83mnQJVczu/7yZhMuVCa9Djk+XxgNYMYSyfUXW7F5T2tH1fGESf
	 thszKNLKNbs3JRZ+0pDEHr4bOZAi1/jHITn1fXb3CJgFzqYHb7latt18cnXM5I/kwR
	 AojUe6kXfL7f+uqYcSIh24ZvjMMomCrDeEV7zfN5fd+Oeu3RLnk5JdMhMfOhmPTW2R
	 swsi5anE/nnWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Deepakkumar Karn <dkarn@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 038/844] fs/buffer: add alert in try_to_free_buffers() for folios without buffers
Date: Sat, 28 Feb 2026 12:19:11 -0500
Message-ID: <20260228173244.1509663-39-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220116-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40DE71C50B8
X-Rspamd-Action: no action

From: Deepakkumar Karn <dkarn@redhat.com>

[ Upstream commit b68f91ef3b3fe82ad78c417de71b675699a8467c ]

try_to_free_buffers() can be called on folios with no buffers attached
when filemap_release_folio() is invoked on a folio belonging to a mapping
with AS_RELEASE_ALWAYS set but no release_folio operation defined.

In such cases, folio_needs_release() returns true because of the
AS_RELEASE_ALWAYS flag, but the folio has no private buffer data. This
causes try_to_free_buffers() to call drop_buffers() on a folio with no
buffers, leading to a null pointer dereference.

Adding a check in try_to_free_buffers() to return early if the folio has no
buffers attached, with WARN_ON_ONCE() to alert about the misconfiguration.
This provides defensive hardening.

Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
Link: https://patch.msgid.link/20251211131211.308021-1-dkarn@redhat.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c5710229..28e4d53f17173 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2948,6 +2948,10 @@ bool try_to_free_buffers(struct folio *folio)
 	if (folio_test_writeback(folio))
 		return false;
 
+	/* Misconfigured folio check */
+	if (WARN_ON_ONCE(!folio_buffers(folio)))
+		return true;
+
 	if (mapping == NULL) {		/* can this still happen? */
 		ret = drop_buffers(folio, &buffers_to_free);
 		goto out;
-- 
2.51.0


