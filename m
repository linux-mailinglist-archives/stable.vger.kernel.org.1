Return-Path: <stable+bounces-265321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0DPWNZaGMWqhlgUAu9opvQ
	(envelope-from <stable+bounces-265321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:23:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC7669311A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:23:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=1HauCdsr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265321-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-265321-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1429B302A40B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712D44BCBE;
	Tue, 16 Jun 2026 17:23:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9421477E36;
	Tue, 16 Jun 2026 17:23:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630610; cv=none; b=mVTfuT3ifOevKRBNBg2/KkYxgI3EN8lGTsq3ab04Bug5/YvyRShU4EmFhqnzq4adXLLP2p61I41x4fTWbw4ozQMD4FDstxsiRrYqspwTP4BZEaER1KURlCqsbCBz8eProzIiAmoOQG3vmMVRmS/e76B89kdLIYD6pNJOlodfymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630610; c=relaxed/simple;
	bh=fDbT9fhoekx/XHbsN/1Ak6Ql8ACzrtTHQvUbrW++2KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHyQMjBOh4WclrGjvm35HSUhwPyX02aXPyvXvlE2/WpvH1GofkHgs/KRO0rZS4xfkBWJ4Z0e30BQbCrkqNrNDNkfkoMfUEd8tHHWQwCLauvLvjdkPaLsftm/q2d1ZeP66Dkt8bHZ2czEQH98xmOn+JsCX7qf9iX8gLCcTGoO54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1HauCdsr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82321F000E9;
	Tue, 16 Jun 2026 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630609;
	bh=zlO0A9CyFOWpbyAEq1GoNrhfk7s2kkLV7lxIeCWbP0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1HauCdsrEgH5bmHCzNeYYrxSDP09AEQX2XnTdY8qb8TlZqf57phpTRgZ8bZJV2IvZ
	 RT2QLi5djy/bnJS3krnFmLS7VQ4/xWIOUstwhKfwrxGUJEzqBTDQqunCkjt5RWIwIH
	 Q2E9HAuPkRnxa9JpN5dUS1mHK+YzHAiooc0K68n0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 061/522] selftests/bpf: enhance align selftests expected log matching
Date: Tue, 16 Jun 2026 20:23:28 +0530
Message-ID: <20260616145128.646492345@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,suse.com];
	TAGGED_FROM(0.00)[bounces-265321-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andrii@kernel.org,m:ast@kernel.org,m:paul.chaignon@gmail.com,m:shung-hsi.yu@suse.com,m:sashal@kernel.org,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AC7669311A

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 6f876e75d316a75957f3d43c3a8c2a6fe9bc18b2 ]

Allow to search for expected register state in all the verifier log
output that's related to specified instruction number.

See added comment for an example of possible situation that is happening
due to a simple enhancement done in the next patch, which fixes handling
of env->test_state_freq flag in state checkpointing logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230302235015.2044271-4-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Note: Backport needed to fix the align selftest where some of the
  expected log messages can't be found. This is happening because
  commit 1a8a315f008a ("bpf: Ensure proper register state printing for
  cond jumps") was also backported to 6.1. ]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/align.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 8baebb41541dc7..b9277059256300 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -660,16 +660,22 @@ static int do_test_single(struct bpf_align_test *test)
 			 * func#0 @0
 			 * 0: R1=ctx(off=0,imm=0) R10=fp0
 			 * 0: (b7) r3 = 2                 ; R3_w=2
+			 *
+			 * Sometimes it's actually two lines below, e.g. when
+			 * searching for "6: R3_w=scalar(umax=255,var_off=(0x0; 0xff))":
+			 *   from 4 to 6: R0_w=pkt(off=8,r=8,imm=0) R1=ctx(off=0,imm=0) R2_w=pkt(off=0,r=8,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
+			 *   6: R0_w=pkt(off=8,r=8,imm=0) R1=ctx(off=0,imm=0) R2_w=pkt(off=0,r=8,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
+			 *   6: (71) r3 = *(u8 *)(r2 +0)           ; R2_w=pkt(off=0,r=8,imm=0) R3_w=scalar(umax=255,var_off=(0x0; 0xff))
 			 */
-			if (!strstr(line_ptr, m.match)) {
+			while (!strstr(line_ptr, m.match)) {
 				cur_line = -1;
 				line_ptr = strtok(NULL, "\n");
-				sscanf(line_ptr, "%u: ", &cur_line);
+				sscanf(line_ptr ?: "", "%u: ", &cur_line);
+				if (!line_ptr || cur_line != m.line)
+					break;
 			}
-			if (cur_line != m.line || !line_ptr ||
-			    !strstr(line_ptr, m.match)) {
-				printf("Failed to find match %u: %s\n",
-				       m.line, m.match);
+			if (cur_line != m.line || !line_ptr || !strstr(line_ptr, m.match)) {
+				printf("Failed to find match %u: %s\n", m.line, m.match);
 				ret = 1;
 				printf("%s", bpf_vlog);
 				break;
-- 
2.53.0




