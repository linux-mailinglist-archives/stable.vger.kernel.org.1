Return-Path: <stable+bounces-273175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dX4cFm/BUGph4gIAu9opvQ
	(envelope-from <stable+bounces-273175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 11:54:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBAE7394C5
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 11:54:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q+4J0Pd6;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273175-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273175-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F83A3046365
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1DC3F7A92;
	Fri, 10 Jul 2026 09:33:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC73F7869;
	Fri, 10 Jul 2026 09:33:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676007; cv=none; b=JVm2vj99ngmsTIwJ5d/yl4o3ywq3ZdNzr9kOkPQa79h4VCitbbnrfNCrU2a7OCSvwsnqpLnnlpEcWtVdRS19na6fp/w3yy7y+YT6Y0WEEE8sGBCAYjO+ndBoP2fYDv+3RIA0qkCjnaGZ3ehR/wItIyzDSiStW1po/MrphSrADRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676007; c=relaxed/simple;
	bh=AYPobXhR7tlhSW9eVD0N+FrhRjSI1w+57SYynhHowac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQj1QBHAG1klVJE4h24F8NyZeAYcy4Ugz0PiQB4VYiNHai2PSPWooLUuq0rbemxouVDl+43hlpcVmbKRi5jaYaHhc5kO3jMQetKBmHOtgll9TTD7ynryqdU9ydaSxV4BBXQLSVt5Tvt6qg/baIcxUufzLkqb6kBzjox35pyX3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+4J0Pd6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE32E1F000E9;
	Fri, 10 Jul 2026 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676005;
	bh=677B5n0kvLgyERJskeE3rTX4vg8H2agSafboCd79Yqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q+4J0Pd6ng6ubEjGKldN+ZwnNlaXTHRBG4JDGidI/IFXx3AiPc5GYSSB8dqilObCI
	 DeHusH9lngPlqGDv761pwm/nPtfB6CWlhryRuw+077asKZRErtQv6fvHr72V2kTk/v
	 lTp5Rds+eFiZylc4Mm5T/eVoIyIZ6FvpDf/HPEq6cFC3j6XmOpsVvitO0Xh1aCcVyi
	 dNY2OgZ5fNVud9Ry28m7d2TiJU99WLMgTPI1U4w6/yGfodxj0ugFp1XCfFTc9I3xbl
	 R2ZPBJJcG5inqt1O082blA2cwCARQCitjSa1VN+rwp47B0vFqeEj0x+EPMoKVTHsZG
	 3dScYBrQpxFQA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:03 +0200
Subject: [PATCH v3 02/24] binfmt_misc: use exe_file_deny_write_access() for
 the interpreter clone
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-2-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AYPobXhR7tlhSW9eVD0N+FrhRjSI1w+57SYynhHowac=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7InL7jz/42a2SStPxL6X2XHSW85+ePiljGFT9Txrg
 bv3P65N6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIyS1GhrfvXG0CXqa2Pbya
 Yz0xyGbdMT9D3hi3XalnlC5MimI3sGdkuJ7Zb3wooV30yU21FsXU91d4//5jvvooLC1mWnLtg56
 r7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273175-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,kvack.org,gmail.com,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-fsdevel@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:linux-mm@kvack.org,m:farid.m.zakaria@gmail.com,m:jannh@google.com,m:stable@vger.kernel.org,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EBAE7394C5

For MISC_FMT_OPEN_FILE entries load_misc_binary() clones the
registered interpreter file and denies write access to the clone via
plain deny_write_access(). The clone is installed as
bprm->interpreter and later released by the exec machinery through
exe_file_allow_write_access() which skips the i_writecount increment
for files with FMODE_FSNOTIFY_HSM set.

The deny and allow side can therefore come to different conclusions
when pre-content watches are in play: if a pre-content watch is added
to the interpreter after registration every subsequent exec through
that entry takes a write denial on the clone that is never paired
with a write allowance, driving the interpreter inode's i_writecount
further down with each exec and leaving the interpreter unwritable
even after the entry and all its users are gone.

Take the write denial via exe_file_deny_write_access() so both sides
of the pairing base their decision on the same file mode, and
propagate failure instead of silently ignoring it: an interpreter
that is concurrently open for writing now fails the exec with
ETXTBSY, exactly like an interpreter freshly opened via open_exec()
would.

Fixes: 0357ef03c94e ("fs: don't block write during exec on pre-content watched files")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index de50a7468b07..24142859658c 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -252,8 +252,14 @@ static int load_misc_binary(struct linux_binprm *bprm)
 
 	if (fmt->flags & MISC_FMT_OPEN_FILE) {
 		interp_file = file_clone_open(fmt->interp_file);
-		if (!IS_ERR(interp_file))
-			deny_write_access(interp_file);
+		if (!IS_ERR(interp_file)) {
+			int err = exe_file_deny_write_access(interp_file);
+
+			if (err) {
+				fput(interp_file);
+				interp_file = ERR_PTR(err);
+			}
+		}
 	} else {
 		interp_file = open_exec(fmt->interpreter);
 	}

-- 
2.53.0


