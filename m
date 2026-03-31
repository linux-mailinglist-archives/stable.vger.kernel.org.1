Return-Path: <stable+bounces-231824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIuuHGD8y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:54:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 129BE36D645
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFBD33083DC1
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786FF42EEB1;
	Tue, 31 Mar 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B3oAFE0c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985840710B;
	Tue, 31 Mar 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975164; cv=none; b=k/lCgi7wagqkYUkCvKAtiM7MuzapA9ubxtbHf0z83ccWg9ZSR6OM3A1zpVrB/WhtwYSfuY7TFCADOasSM4mqYeGGTbYjPFza0/Bs82p7sJuT8xivNGbgqm5Ap32596Yxc7+4PIcS8J76ScjLY9L2dBoOpPHHBQwEITdxqIeg0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975164; c=relaxed/simple;
	bh=TXmNfJBRgxPMlpQJQ736JvStxQ056LG3WFvuX5i1N5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBWVu0WpNRoHCN5P6yjXrQPldP8FcjRPDm9QqUAYKtOv9UwiBIR/WbLHqIiBz+M5aZr2HLMXdP6XZOhsesN7Vb/BYtQ5WxXQ8DgDAgI8BxoloOKZb6jVtTCWHy3lT/S+4Z9M1gsblhjo1S957nAdJtXbep9MDaq0M6rijvVW65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B3oAFE0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F78C19423;
	Tue, 31 Mar 2026 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975164;
	bh=TXmNfJBRgxPMlpQJQ736JvStxQ056LG3WFvuX5i1N5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3oAFE0cpqHFu1kDO3PEPJWPh48wcnJmT06QA9+o+ielwVWwMnQCkT7EiX2JgstDR
	 q+AICCUEsCt+5iWS7ROyfF3REV1EFpKBku9/K/adDFe+6YUpDeBVuLn9XQMpN1KJnd
	 wjUJ97pKRTX9eANCNC4/4ePwbTbaLgsKEP9BiHuc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Buerg <buermarc@googlemail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 188/342] sysctl: fix uninitialized variable in proc_do_large_bitmap
Date: Tue, 31 Mar 2026 18:20:21 +0200
Message-ID: <20260331161805.918307816@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-231824-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,googlemail.com,kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 129BE36D645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Buerg <buermarc@googlemail.com>

[ Upstream commit f63a9df7e3f9f842945d292a19d9938924f066f9 ]

proc_do_large_bitmap() does not initialize variable c, which is expected
to be set to a trailing character by proc_get_long().

However, proc_get_long() only sets c when the input buffer contains a
trailing character after the parsed value.

If c is not initialized it may happen to contain a '-'. If this is the
case proc_do_large_bitmap() expects to be able to parse a second part of
the input buffer. If there is no second part an unjustified -EINVAL will
be returned.

Initialize c to 0 to prevent returning -EINVAL on valid input.

Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
Signed-off-by: Marc Buerg <buermarc@googlemail.com>
Reviewed-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2cd767b9680eb..c9389b50b8264 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -895,7 +895,7 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 	unsigned long bitmap_len = table->maxlen;
 	unsigned long *bitmap = *(unsigned long **) table->data;
 	unsigned long *tmp_bitmap = NULL;
-	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c;
+	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c = 0;
 
 	if (!bitmap || !bitmap_len || !left || (*ppos && SYSCTL_KERN_TO_USER(dir))) {
 		*lenp = 0;
-- 
2.53.0




