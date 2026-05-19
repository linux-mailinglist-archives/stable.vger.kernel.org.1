Return-Path: <stable+bounces-249461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDQiMP33C2o3SgUAu9opvQ
	(envelope-from <stable+bounces-249461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:41:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C34F5777F9
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2CC73033197
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 05:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2B533F595;
	Tue, 19 May 2026 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0dbQHl7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28533F5B1
	for <stable@vger.kernel.org>; Tue, 19 May 2026 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169268; cv=none; b=cTJwwp1T+PG4Aac5oYDDnIJ51IIBPjQOUW6hg0N0HNQK31qLCVBWMGuBAXzLSoa3YjPQMxpON0T9uQ8wVwM+VFfSWtM0rMumfbSgUSwN5+W/GZnrTrqE8wyH4wV5c9OphUiFYY1T+5PLVW4Qr8AQAoNh6zi0b2uB0u9xwMF0Sy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169268; c=relaxed/simple;
	bh=xj2PXqco0OYgzWLRRPhtDZOD1JPYK8pxo4cMRYsLjhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogzKOhF7iZU1gI+HZqvwI2TBEvqsNmZd5oFeL9BcoSJZhEHThZeMJz8f3+qNohAhFc9XnjPT9CVVIGNXBi3ub6VuDv2UJbOFXprKslHmCbmf7CAcNN+bGAqypdcH8D/JZrs8PsIKpg1ZsSolW3LXtRRvcL+kIbV0Ib6tpKlAVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0dbQHl7; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7c7fc722b50so21428317b3.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 22:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779169266; x=1779774066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxEHYRPXPUF5CcnWUlQth343O/vG0e4EfUADmNe/YLQ=;
        b=H0dbQHl7i+rdo104I/RZyAWkBIsHuw8ULQbRdUpzqa701rSDxIPA8ZkI2F3Ka2o84/
         KcLZvLJ6b8yD/yQ97V8v3Pn1CK55AVXfHYlGh2uCjFW9B90rNDHdhs+oam60ChkBf5O2
         FElM3NXIlLpMgINQNOm8vtZi86vEPJj45iGbKsxQCvF+a9WhZCXdgaRUbJZUAI9pRYmy
         pdYNNxJyUKgdNY2oEJjfXJspRxORx8jYL5R4HRid5205iYL4Dy5J+NVL3cnFeQXynbL2
         WbctmJ3k/okvl3xaw6aCu7wH4xhtwHIioxaNm7zoiIrFp2FDpWXETVhYfM3iFO84zCbO
         T5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779169266; x=1779774066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxEHYRPXPUF5CcnWUlQth343O/vG0e4EfUADmNe/YLQ=;
        b=qCsK94Gk6PrCSJhV3+D6byg0s2xCdBcpERJR/hLGRrBF6HUWsO2aIeqpbOYgSUUumb
         iWRLD5maws3oxgl1mCezJq0r+0OrpPl0ESAteEZTA9R18okeUhldBmTug4ee15QsPFCC
         HfOVxvD/tDjE37rzDxMbJxbzm8kMnWHDdUKLbR/8uUvwy4G46lHxRLs02vh+8bz2rZGs
         MC1+BYncvlZOkZJj90KaNb867aClb8d0WgCNmZznTjXh7fZsUJFhehrmKMy7H6j9YTVB
         iIf2fWT+rlB0mDZ6/XhD3uKaI8wbluODjkHGdIqv/igPW9HkTZSk7FCtYSJUtAdpwsmO
         aXyg==
X-Forwarded-Encrypted: i=1; AFNElJ9zgErZcn2fzehbx8Drb+yId/jLODTE/b4vxTxHUnXyHkd6ilk/8uX4MQLHFbf/faMT+owImn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxHSbwxIRhS5cTAbDFgsukd6YYg9TYUE8GHJlnVZyNcqVZjB8
	qWqp9oAWVKopMuaKH9Z0ijDvf57KgcclwccLDrKk2KpuEddJiCrQ0JQC
X-Gm-Gg: Acq92OFUHZytIhp87EylBG4HvqeV5PMLOVmN4z9jfl9j1ZYCkQZmPZTP0Xp+nS2p7Rg
	uzR2/N4W4xqsOAqxdSExj0RaQ0BZHBKUqy7kFhVvSM1lmisx39GkWbxs0AEWHjfP4t1dYZ/Zn0F
	dzQVb7Ya3FS5zaugfTnWwBlbMx/Qi4kgs1ol6tsq5Q2tzOPC7Mox/FK363GmPNb9YXwqbBcHAvr
	zttrpZMbA1YwOy9h2nTZkiCKDVe7nqeOSjHjGmblJ6xhrGVV/PMpF/PQVe7HBLwz/D99EtQUkxs
	AawjKX623399cCehhc7BkVkhCVcz2LaFReVvP4ANKpNH9nfp8ucLKvwk7DoGsBNMkwYpq2R42QB
	4/ADZ6p8QXssQE/5kuny8UTK5RNbhPWeNeOzYDkgsYeyqsMuGu57ej6PqdsTH++RcskJdOJKfO3
	5Ef+9ulfG6ijt9nH9K4mQ=
X-Received: by 2002:a05:690c:e159:20b0:7ba:ded4:df53 with SMTP id 00721157ae682-7c95b82a65cmr144251357b3.32.1779169265906;
        Mon, 18 May 2026 22:41:05 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0dafdsm32141597b3.30.2026.05.18.22.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 22:41:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] fuse: re-lock request before returning from fuse_ref_folio()
Date: Mon, 18 May 2026 22:28:07 -0700
Message-ID: <20260519052807.1924269-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519052807.1924269-1-joannelkoong@gmail.com>
References: <20260519052807.1924269-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249461-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4C34F5777F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fuse_ref_folio() unlocks the request but does not re-lock it before
returning. fuse_chan_abort() can end the request and the async end
callback (eg fuse_writepage_free()) can free the args while the
subsequent copy chain logic after fuse_ref_folio() accesses them,
leading to use-after-free issues.

Fix this by locking the request in fuse_ref_folio() before returning.

Fixes: c3021629a0d8 ("fuse: support splice() reading from fuse device")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 37b11b89ce1b..a9385d3597cc 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1227,7 +1227,7 @@ static int fuse_ref_folio(struct fuse_copy_state *cs, struct folio *folio,
 	cs->nr_segs++;
 	cs->len = 0;
 
-	return 0;
+	return lock_request(cs->req);
 }
 
 /*
-- 
2.52.0


