Return-Path: <stable+bounces-220616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM9SFyxAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:21:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 852F61C6E0B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D026732CDBFF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1923648B36D;
	Sat, 28 Feb 2026 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdybXHUi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07263E4C37;
	Sat, 28 Feb 2026 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300499; cv=none; b=aRL8dVsoOObiUX6zPJ4C/1ksO1G9qgVFfWRneqkCqT+TixTyGyxonsBUSiKEyUR2lh+6Wyx9wBhFU5rA7FsOGZzev90bjI8lOEM//0o7jRSPwkijPAf8cwHcEnFqgOR6G8IFNnJFeocol69Ry84gwux3BZj0m3ihu6Sz5UzDQE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300499; c=relaxed/simple;
	bh=N3whK/Qab7sabZq+ciegNfhuZ8/gv7147eDSqfVOTMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cneME1tAohqzIEOEg+9YGou1jU4SSrTf+WHMsxe6h/C2+Zpj26A2tO6qGGS9AVWhf/afvM745X20cAMBUmhar6CqDfBdjMFGHukNXbU3V7xyVQcLZFO9ZcsD/aoLa0cyl9cjrnFU8Ri9XbohDgQLOoUnaEyvFcUNq/h3LyzNTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdybXHUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DBBC2BC87;
	Sat, 28 Feb 2026 17:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300499;
	bh=N3whK/Qab7sabZq+ciegNfhuZ8/gv7147eDSqfVOTMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdybXHUivm5iwmm7UMzM/DaooU7TKbpFVB1BuoSNAPABA4/VYhDsD3qozRjFm5SUR
	 cwSx4w0Nos4wW+S4lwVB4LJRlMmAFb+1RZUbIp6x9lx7nXm0gdNDRnw0SH1hnkVkBU
	 BRobFmCXX+r52va2Agx4n8nMk0jYe78e35/YI7uRb0nX5uIC945NjNusaDyzIFzUS9
	 0hB/B8oNt+YIeWZzm0lowey1z0noKOkKn25xY4OfWvt9y9D0kbhCa/Kwwi3q55FOBC
	 Y8IlJyNuctDOanhvRAAhEEMrqXpGuXMemkv4KGoNx9Bm2T7psHum8OTmzvO7N6Gmjf
	 4y6GyXKIQvV9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 537/844] dm-verity: correctly handle dm_bufio_client_create() failure
Date: Sat, 28 Feb 2026 12:27:30 -0500
Message-ID: <20260228173244.1509663-538-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220616-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 852F61C6E0B
X-Rspamd-Action: no action

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit 119f4f04186fa4f33ee6bd39af145cdaff1ff17f ]

If either of the calls to dm_bufio_client_create() in verity_fec_ctr()
fails, then dm_bufio_client_destroy() is later called with an ERR_PTR()
argument.  That causes a crash.  Fix this.

Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
Cc: stable@vger.kernel.org
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-fec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index c79de517afee7..0ac98a620f3ac 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -534,9 +534,9 @@ void verity_fec_dtr(struct dm_verity *v)
 	mempool_exit(&f->output_pool);
 	kmem_cache_destroy(f->cache);
 
-	if (f->data_bufio)
+	if (!IS_ERR_OR_NULL(f->data_bufio))
 		dm_bufio_client_destroy(f->data_bufio);
-	if (f->bufio)
+	if (!IS_ERR_OR_NULL(f->bufio))
 		dm_bufio_client_destroy(f->bufio);
 
 	if (f->dev)
-- 
2.51.0


