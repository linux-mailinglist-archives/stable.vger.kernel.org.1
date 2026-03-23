Return-Path: <stable+bounces-229797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDlcCdlqwWnVSwQAu9opvQ
	(envelope-from <stable+bounces-229797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:31:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C18682F83C9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D731B303AC22
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF40284881;
	Mon, 23 Mar 2026 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m86UkgWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A312CDA5;
	Mon, 23 Mar 2026 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282890; cv=none; b=bnJOXTiB8v7xrUB9Xu3PeJhILHQwfu9vwj/E5rp/5q3cKqfDzxb7P81MLG5SPeQu4Do+PtMiFTqOwbp0M9Oz23LkvG0aURtYP7HR8jbtXoa2ugbXtORsKIfv15mIDpNpmDIsE/22c8ku1SWTKDEmxuMq4oSAktm04dPy6VqpvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282890; c=relaxed/simple;
	bh=O62EXnr1S+leVGCSh0Tohdlk8I2P/nKu6BMXcatzbkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyn6MXG4v122yrxQWI+nYsXKRTVJ/Sqa5GTGVPzzYwm89+8qs+uJx60bUuN3lYaDdTV935fsh+7BQoGp9Plb4tTiFpT+mO3ASsLrqaybLjHcrh3xAUptJMi2qcgETZ5CSPzpi3NBsBRNU+BXmF94XrMHVH261SvYmQuVqnEXTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m86UkgWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FCAC2BC9E;
	Mon, 23 Mar 2026 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282890;
	bh=O62EXnr1S+leVGCSh0Tohdlk8I2P/nKu6BMXcatzbkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m86UkgWHnIyK6Q9IgeJyKOrPw02I5TEGGIqe37241Wu0amIMWuiTuOeJu3snB4V8l
	 aF8UXJvi0T+9AxSnK/rPPAe7+dmkRd+ts+1geFxic7MeO7wGkDmGE7XiL46EF7Ye58
	 lc4V44lg+Sqb2rX87SEcZpaujlIP1anxyAoRAgXY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Natalie Vock <natalie.vock@gmx.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 322/481] drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink
Date: Mon, 23 Mar 2026 14:45:04 +0100
Message-ID: <20260323134532.947312890@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229797-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmx.de,amd.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:email,amd.com:email]
X-Rspamd-Queue-Id: C18682F83C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -165,7 +165,7 @@ struct dc_stream_state *dc_create_stream
 	if (sink == NULL)
 		return NULL;
 
-	stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
+	stream = kzalloc(sizeof(struct dc_stream_state), GFP_ATOMIC);
 	if (stream == NULL)
 		goto alloc_fail;
 



