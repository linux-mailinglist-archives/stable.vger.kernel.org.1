Return-Path: <stable+bounces-218911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OmfIJZWnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632A190361
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 234BE30DC9EF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF54256C6C;
	Wed, 25 Feb 2026 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tBCYkvpA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F320285CA3;
	Wed, 25 Feb 2026 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983804; cv=none; b=F4/GPnFhEZnEUjG8PKc+upI8b6wm+UWzhg0RMsvlunK7Laedi2oS4tWWNd/8/Dv1NWTPi4R1LWKdksqUoJ3vHjsGmT6PUzAGf9xQmifAE1r2jg/sxyAzjdQkfPmi5TG7e8hqp4wTm/6dr+xKBlQuCqwEnpCNg2Y0aahB8zt7ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983804; c=relaxed/simple;
	bh=pdlg+sKLu2XZVZaVvzGNlTh2fZb8Gn1emEuEojWH6CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFHH4/yVlq2L9Yjot8gDh44bhNjYQaUHaA5PIlkRo5Kpw+5/BBcxyi91O89VaEPEucV7SEp42M3NxrQ2snWd5jlmUG18Sxe/uRcaj2xBFJJqkU15hrCYkk8tAJx/Srq+TjNPO488n4golNSWZyZtfEK1lNiCVMvNc1TSIikXVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tBCYkvpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6FDC116D0;
	Wed, 25 Feb 2026 01:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983804;
	bh=pdlg+sKLu2XZVZaVvzGNlTh2fZb8Gn1emEuEojWH6CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBCYkvpAriUS1SBQ86q2VKRzHz/U/G5hVCHtbpv2MExvWfLPReSorJQEMtqTt2rZI
	 YrFS7u9bYYcLf63eKJH3VcGPkyI/YrGZGy8IvYFmNGqb2ogdCF06alF/clHhXFMKfd
	 2lSOPbW2u6SkRAScSwnDlr9D8UwGHr9lL/mFy3HE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleks Todorov <aleksbgbg@google.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 047/641] OPP: Return correct value in dev_pm_opp_get_level
Date: Tue, 24 Feb 2026 17:16:13 -0800
Message-ID: <20260225012350.169896596@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218911-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 0632A190361
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleks Todorov <aleksbgbg@google.com>

[ Upstream commit 0b7277e02dabba2a9921a7f4761ae6e627e7297a ]

Commit 073d3d2ca7d4 ("OPP: Level zero is valid") modified the
documentation for this function to indicate that errors should return a
non-zero value to avoid colliding with the OPP level zero, however
forgot to actually update the return.

No in-tree kernel code depends on the error value being 0.

Fixes: 073d3d2ca7d4 ("OPP: Level zero is valid")
Signed-off-by: Aleks Todorov <aleksbgbg@google.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bba4f7daff8cb..775d4a36f2f54 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -241,7 +241,7 @@ unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 {
 	if (IS_ERR_OR_NULL(opp) || !opp->available) {
 		pr_err("%s: Invalid parameters\n", __func__);
-		return 0;
+		return U32_MAX;
 	}
 
 	return opp->level;
-- 
2.51.0




