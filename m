Return-Path: <stable+bounces-212268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIeKMIwwemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:51:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72554A491A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CD9930DDDCC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5696023EAB7;
	Wed, 28 Jan 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DkdjNgWJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD62FD699;
	Wed, 28 Jan 2026 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614948; cv=none; b=A4PREyI7trD2KKs3iQ59CmHlUdRTou+7c7QivtuXb9yEkxjOMQG3sKqZKwYp7RUrJSQIeJPihIBD6y/nar9whE7HSfzGKtg3JtuU63q4uKThBI4D06ef8xWEVQG8Qru9S9UsTegkGudeJ7RqAESBE2g0Nc1WRDgDCBkanfPprQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614948; c=relaxed/simple;
	bh=vnSHbUAhtpZPzTK+XA3XzN6P+DJfS15I/zkfnnfDPGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILAOPkRtFx2n12iVuphsN3dSYIlXxk8dkvF1SdZZ66MvX4/dguQWHKROCbIDd+o17IrGVanWeWErDVAjCaXkW73Dtmeyz4ycsdellhXG7qOSti6kdLBbdETu8U81OUFSMWpC0rzgExcsfdAHUYVu9I4k2xjCEYssc6pV0FqACMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DkdjNgWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D69C4CEF7;
	Wed, 28 Jan 2026 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614948;
	bh=vnSHbUAhtpZPzTK+XA3XzN6P+DJfS15I/zkfnnfDPGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkdjNgWJM+77mQZszIauGiCPSUxQu5Jb5Hg8YtJ6B0UyTb0ii5AWT9NWCkjM26N54
	 zRA2aqFR7JqIdU3JuX57l68rlgXhfGp/MdlEzToSJrJWvQ+/uE+oIReDXPwQBNvzxR
	 OJ8MI7KPggw76xEtGWPLTLEEE4/iCWP/PgVovgDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 033/169] tools: ynl: Specify --no-line-number in ynl-regen.sh.
Date: Wed, 28 Jan 2026 16:21:56 +0100
Message-ID: <20260128145335.213201331@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212268-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,p:email]
X-Rspamd-Queue-Id: 72554A491A
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 68578370f9b3a2aba5964b273312d51c581b6aad ]

If grep.lineNumber is enabled in .gitconfig,

  [grep]
  lineNumber = true

ynl-regen.sh fails with the following error:

  $ ./tools/net/ynl/ynl-regen.sh -f
  ...
  ynl_gen_c.py: error: argument --mode: invalid choice: '4:' (choose from user, kernel, uapi)
  	GEN 4:	net/ipv4/fou_nl.c

Let's specify --no-line-number explicitly.

Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260115172533.693652-3-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/net/ynl/ynl-regen.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index a37304dcc88e1..7bfe773dce1bf 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -21,7 +21,7 @@ files=$(git grep --files-with-matches '^/\* YNL-GEN \(kernel\|uapi\|user\)')
 for f in $files; do
     # params:     0       1      2     3
     #         $YAML YNL-GEN kernel $mode
-    params=( $(git grep -B1 -h '/\* YNL-GEN' $f | sed 's@/\*\(.*\)\*/@\1@') )
+    params=( $(git grep --no-line-number -B1 -h '/\* YNL-GEN' $f | sed 's@/\*\(.*\)\*/@\1@') )
     args=$(sed -n 's@/\* YNL-ARG \(.*\) \*/@\1@p' $f)
 
     if [ $f -nt ${params[0]} -a -z "$force" ]; then
-- 
2.51.0




