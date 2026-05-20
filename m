Return-Path: <stable+bounces-250798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKgnLlX4DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:07:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1318F595568
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0D0131B6D8D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296C3ED5C5;
	Wed, 20 May 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aUo9LyDj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3873EC2DB;
	Wed, 20 May 2026 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296340; cv=none; b=sf670JdwqN4BtGfOrgdR4JOvbyYllVOvRdkS83UgphLeI1VyA71vUQt2S6Rb6JBXqT1SvYJ5PQytUy3AGT+aBK0oUImD4uez2UMYj0In0NA8W2wRbC1o/9sCElHgxzgyrMFfQyzkxeaEXxsY1FozCBcpo/RCd2/xE3WC1KODD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296340; c=relaxed/simple;
	bh=tjN1GfEXSjpSirrWyMVrhFtB87UfWGrc0L8GNQgDh5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFCJ2UXsLplKslpH0to1i06RQ7UqeByw2OXlh1cexTnG186B86t+W8nKjmr/OB+vYt5MPZGXZx1b7INzR8w7Etcl+cxxbyvLG/mwdVdFuKEqmhoplcuYHhRVWpabetW57H01R4xWRx7MGuG969V6pYcdFpx0/KbIU6/jox6YyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aUo9LyDj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322D61F000E9;
	Wed, 20 May 2026 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296339;
	bh=7JaTWFr73dEemT97+GSlF7e85ny/7bjFT5Gz8U7LXDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aUo9LyDjrv5ifotRvAPHO2v3fCh79GUHGz/qMSLvUd98xJ4n7rxZTwgNy+gRRq7DW
	 BEpVtO1Qs8rDPUnSvvZNoW2+x0SYGLvPpe69mHVvpSAKfGns1fcATmdywKFUuW8GEY
	 boZf18YnGduVmX7djSkidcnNvN/oxoCzqwnQqitw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0762/1146] reset: amlogic: t7: Fix null reset ops
Date: Wed, 20 May 2026 18:16:52 +0200
Message-ID: <20260520162205.457487114@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250798-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliel.fr:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,pengutronix.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1318F595568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

[ Upstream commit 9797524ef2b69c6b187b55bd844eb72a8c1cbd99 ]

Fix missing reset ops causing kernel null pointer dereference.
This SOC's reset is currently not used yet.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
Fixes: fb4c31587adf ("reset: amlogic: add auxiliary reset driver support")
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/reset/amlogic/reset-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/amlogic/reset-meson.c b/drivers/reset/amlogic/reset-meson.c
index 84610365a823c..c303e8590dd68 100644
--- a/drivers/reset/amlogic/reset-meson.c
+++ b/drivers/reset/amlogic/reset-meson.c
@@ -42,6 +42,7 @@ static const struct meson_reset_param meson_s4_param = {
 };
 
 static const struct meson_reset_param t7_param = {
+	.reset_ops	= &meson_reset_ops,
 	.reset_num      = 224,
 	.reset_offset	= 0x0,
 	.level_offset   = 0x40,
-- 
2.53.0




