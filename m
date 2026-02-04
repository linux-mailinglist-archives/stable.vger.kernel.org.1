Return-Path: <stable+bounces-213779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHPpFT9lg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:26:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6133E8950
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 437F330BF610
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD1C421F0E;
	Wed,  4 Feb 2026 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="plsfismU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EAD41B357;
	Wed,  4 Feb 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217484; cv=none; b=a7s8Ld8Jk06PbFbJmb28oN1K+yU+h9ZvczTkq2rSFTBUOzGp6CRaNXGYrwRLl/J7rsm2x3+Ey1ElzDjtxyem3Dn0yr4Aj/JWCZ8dvWYLjC45mT8I6NZxvlweKKO+F5MvR3+9La9nFzUmjeeAQaWSQviZOKFD5fDMFSREKCLGsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217484; c=relaxed/simple;
	bh=UGabwtwBUgOXxuqkwwMDqc0A0Kl/4mpemoAP11FUdWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBDF6Oiz9eJj9TkPxuFX9NFPSzwSbg+UUMoYPVvPt9YSf7GzxafRs6V3VDEda5ZnfzPaj2V2RYGQcqqC5cTx6xKWjpDf6ZgFgSsFTvxbEZDQFWGKKUn2l43VNbgwmJqYzsz0FOD0piasa2snczfkWGlYkvQRQ+wRIiZWqF7pmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=plsfismU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31407C4CEF7;
	Wed,  4 Feb 2026 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217483;
	bh=UGabwtwBUgOXxuqkwwMDqc0A0Kl/4mpemoAP11FUdWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plsfismUiCwpl3NKEO+QXG3fM5Uj6oPS4rSQkMNhRdvjvfDZ40ThjnkX1Kwi5QVv+
	 Pe8lt0l2aDuoEa/BFRui0ml1NmUW8kDiEO5WlU8iJV1zz4r9Od44i6WSUlKRrmF8ZO
	 jPagofHolPJxlKjutH59pUqyXsu5ci07gAnfEdHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Thomas Graf <tgraf@suug.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/280] textsearch: describe @list member in ts_ops search
Date: Wed,  4 Feb 2026 15:36:43 +0100
Message-ID: <20260204143910.686302760@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suug.ch,davemloft.net,linux-foundation.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-213779-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,davemloft.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,suug.ch:email]
X-Rspamd-Queue-Id: B6133E8950
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bagas Sanjaya <bagasdotme@gmail.com>

[ Upstream commit f26528478bb102c28e7ac0cbfc8ec8185afdafc7 ]

Sphinx reports kernel-doc warning:

WARNING: ./include/linux/textsearch.h:49 struct member 'list' not described in 'ts_ops'

Describe @list member to fix it.

Link: https://lkml.kernel.org/r/20251219014006.16328-4-bagasdotme@gmail.com
Fixes: 2de4ff7bd658 ("[LIB]: Textsearch infrastructure.")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Thomas Graf <tgraf@suug.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/textsearch.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/textsearch.h b/include/linux/textsearch.h
index 6673e4d4ac2e1..4933777404d61 100644
--- a/include/linux/textsearch.h
+++ b/include/linux/textsearch.h
@@ -35,6 +35,7 @@ struct ts_state
  * @get_pattern: return head of pattern
  * @get_pattern_len: return length of pattern
  * @owner: module reference to algorithm
+ * @list: list to search
  */
 struct ts_ops
 {
-- 
2.51.0




