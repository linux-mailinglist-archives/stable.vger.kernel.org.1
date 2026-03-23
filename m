Return-Path: <stable+bounces-228694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACJlCs1mwWlESwQAu9opvQ
	(envelope-from <stable+bounces-228694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:14:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9BA2F7C4E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B2553222A81
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFA3B2FD5;
	Mon, 23 Mar 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="om8Nb5lC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA043ACA62;
	Mon, 23 Mar 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276873; cv=none; b=fIeSvGPmpiQ/jM42DlcT5AziTwagR453zdGnen08IykaROdkqmKNrJCUMkyyWWFNwKz1EfFEBTyopEVAw+pd4DGl7ZgHSU7tnXG6+y4ZpFp+6EE2JZ1kytTYZOekuDzA4+H+cA1pLaUaA4m0rwRrajWVln6aaEqF8aurSTYuRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276873; c=relaxed/simple;
	bh=4P6uS8pDdwkNlKjeCJJw0lzMcDaMuwxpwMHPZ6UAN1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpkmpdI4Mq2q7uxr8Sa+d7J8uGKlLE1zyj5dx3Sq4zJDM4d4jjqFTgZvcA/UxdIXKz8wEEMz7jJ58LZAWwops2yr+A7afcNngSUtONtm402/93qly0o2m9bZpLLCUcaNjxUStQ7wzW7H2UCCQ9CvAVIL394f/8bqUlgAildrpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=om8Nb5lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA9EC4CEF7;
	Mon, 23 Mar 2026 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276873;
	bh=4P6uS8pDdwkNlKjeCJJw0lzMcDaMuwxpwMHPZ6UAN1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=om8Nb5lCxjR/Y+QXRYE2Jhz9CDx5ldIEGbE/Xs5r1VlUS2gb4TnxoPXdKNvjUGd4b
	 ktGvcEiIYGQaTGahyqaCnivsKsY7OpDNDQdbPhn+4ub9yrFyqRdRadQHhOoGZvFMJu
	 DE2FXOieJglznq/xfneGJtokkQUKlsBVvqcVc+rs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Natalie Vock <natalie.vock@gmx.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 234/460] drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink
Date: Mon, 23 Mar 2026 14:43:50 +0100
Message-ID: <20260323134532.247208477@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228694-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmx.de,amd.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,gmx.de:email,amd.com:email]
X-Rspamd-Queue-Id: 8B9BA2F7C4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Natalie Vock <natalie.vock@gmx.de>

[ Upstream commit 28dfe4317541e57fe52f9a290394cd29c348228b ]

This can be called while preemption is disabled, for example by
dcn32_internal_validate_bw which is called with the FPU active.

Fixes "BUG: scheduling while atomic" messages I encounter on my Navi31
machine.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b42dae2ebc5c84a68de63ec4ffdfec49362d53f1)
Cc: stable@vger.kernel.org
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -167,7 +167,7 @@ struct dc_stream_state *dc_create_stream
 	if (sink == NULL)
 		return NULL;
 
-	stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
+	stream = kzalloc(sizeof(struct dc_stream_state), GFP_ATOMIC);
 	if (stream == NULL)
 		goto alloc_fail;
 



