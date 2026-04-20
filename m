Return-Path: <stable+bounces-239477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPHwA8RL5mkgugEAu9opvQ
	(envelope-from <stable+bounces-239477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:52:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6DB42EAC8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFE5A30065EE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08DA333445;
	Mon, 20 Apr 2026 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1mFLE2BN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A582D978C;
	Mon, 20 Apr 2026 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700353; cv=none; b=n8g4J6/VLjWyHxjirQZeVYlDfU+WwqkTdgKZgEbqGuj66+ML2WzWi0sX6KXrSdmuFP0eGoSLblStzf03yz35DUkF9PfDVGZQOhiF3RS4AKeCE3wTnGwX4Ce+Jnexexr5GpR4MUCEcpCHJwO/UvpezUfL8e4qSemklh+JF/GAFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700353; c=relaxed/simple;
	bh=6C6Y1NVlJSLe4od0PMuE5eb+aVYRgzXsbgER/06CCwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pf9pi91USa/XbNQhSSOs6kETHaRkqkY1/fDozyhEynO+Nbrcs658tWhxKaIEwpFJiHFIvrS39eT4V/Z8ya4hxDegZFj1ZUCGrQoNvARKOAWltxE3wlzZzUbk41u8CrAc9hsFnBhZNav1fDBRkOnTQuiuYn2NARyOStkBEolDW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1mFLE2BN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393E8C19425;
	Mon, 20 Apr 2026 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700353;
	bh=6C6Y1NVlJSLe4od0PMuE5eb+aVYRgzXsbgER/06CCwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1mFLE2BNr/wTjJK2Os8ADir2csuoLnKdpRNwE5bBDHyg4I7j5v34AG6L5ISVVpZgo
	 laQ5FaVCEQYTBI3T8KfJFfOME7PBzkG6nmxn4xq9GHvL15xR+kuojqSmcSfh0jQ83R
	 zUFK+4SMtFG1cNIdYNxEVzS3mmoOlnoJUC2aznm0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d23888375c2737c17ba5@syzkaller.appspotmail.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 138/220] crypto: af_alg - Fix page reassignment overflow in af_alg_pull_tsgl
Date: Mon, 20 Apr 2026 17:41:19 +0200
Message-ID: <20260420153938.993728494@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239477-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,d23888375c2737c17ba5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,apana.org.au:email]
X-Rspamd-Queue-Id: BC6DB42EAC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 31d00156e50ecad37f2cb6cbf04aaa9a260505ef ]

When page reassignment was added to af_alg_pull_tsgl the original
loop wasn't updated so it may try to reassign one more page than
necessary.

Add the check to the reassignment so that this does not happen.

Also update the comment which still refers to the obsolete offset
argument.

Reported-by: syzbot+d23888375c2737c17ba5@syzkaller.appspotmail.com
Fixes: e870456d8e7c ("crypto: algif_skcipher - overhaul memory management")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/af_alg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 7373f7dd8f417..8953e2ffd55ce 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -705,8 +705,8 @@ void af_alg_pull_tsgl(struct sock *sk, size_t used, struct scatterlist *dst)
 			 * Assumption: caller created af_alg_count_tsgl(len)
 			 * SG entries in dst.
 			 */
-			if (dst) {
-				/* reassign page to dst after offset */
+			if (dst && plen) {
+				/* reassign page to dst */
 				get_page(page);
 				sg_set_page(dst + j, page, plen, sg[i].offset);
 				j++;
-- 
2.53.0




