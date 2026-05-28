Return-Path: <stable+bounces-255784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFk0DzalGGrClggAu9opvQ
	(envelope-from <stable+bounces-255784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:27:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFFB5F8B88
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84D013083C6C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553C329C48;
	Thu, 28 May 2026 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iKBzUb2F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A233F5BE;
	Thu, 28 May 2026 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999873; cv=none; b=nlc+PZe7xK6dBduZt8W/erh6VbLnLx2J9JFp3/+888TbYamFzU2Yrz4jKrcHj5+uZtcH4n3WC5ewzHVhucV4xDQwWMg+om72D/ndszaKrBJ0cJLpe7fW21owIJfrjQhltfKung2n0QiTeqAxCLe7g5VrcJevGbpxWFyXSgLUi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999873; c=relaxed/simple;
	bh=zKfmAQMqZbX19PpShB27uX0FnzWfpLufeDbckc/a1vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R51WShiuvw8N1CpGsyabXYUUMOrM7kzxwo1gsy04Eik3U8MjL6Sa9PxlE/XqzNNF+yrYfBYQ/IT3oKknsEx/XgIIU3bXeA40tcdOl9p1SciH44+QrAOaj8NvbwW6BUUx6EaCsekxjyr1yfOrXyr0m1ncZbpTTBFEuonJWAV2oFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iKBzUb2F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23AD1F000E9;
	Thu, 28 May 2026 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999872;
	bh=O43rqhar/ADmg1TYHh90jdRXrlzkvavKeUZV/1/GI00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iKBzUb2F0aASf9j261Mnjm1nwAIwGNoWDMbetCArHXXBnbVTKMme84vd6a2xnEVKY
	 MoUrFyMmbnr7s8YT3W+Sd6Ko5OUyCtQgFDkHsW8xyNvTnBXVC9r2WTSNLi9W/vqihX
	 nkASXDp41HL3anSdgoDvQHs0IfulaMUR3STJTID4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junyoung Jang <graypanda.inzag@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 220/377] fs/statmount: fix slab out-of-bounds write in statmount_mnt_idmap
Date: Thu, 28 May 2026 21:47:38 +0200
Message-ID: <20260528194644.764001402@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-255784-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1AFFB5F8B88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junyoung Jang <graypanda.inzag@gmail.com>

[ Upstream commit a3bf0f28d4ba16e1f35f8c983bb04426b87e2a78 ]

statmount_mnt_idmap() writes one mapping with seq_printf() and then
manually advances seq->count to include the NUL separator.

If seq_printf() overflows, seq_set_overflow() sets seq->count to
seq->size. The manual seq->count++ changes this to seq->size + 1.
seq_has_overflowed() then no longer detects the overflow. The corrupted
count returns to statmount_string(), which later executes:

    seq->buf[seq->count++] = '\0';

This causes a 1-byte NULL out-of-bounds write on the dynamically
allocated seq buffer.

Fix this by checking for overflow immediately after seq_printf().

Fixes: 37c4a9590e1e ("statmount: allow to retrieve idmappings")
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
Link: https://patch.msgid.link/20260504112649.1862936-1-graypanda.inzag@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/mnt_idmapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index a37991fdb194d..3640230a4d43b 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -375,6 +375,8 @@ int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_
 			continue;
 
 		seq_printf(seq, "%u %u %u", extent->first, lower, extent->count);
+		if (seq_has_overflowed(seq))
+			return -EAGAIN;
 
 		seq->count++; /* mappings are separated by \0 */
 		if (seq_has_overflowed(seq))
-- 
2.53.0




