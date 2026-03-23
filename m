Return-Path: <stable+bounces-228349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF2KAbBLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 965902F4220
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEF8F318D82F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9B3B6341;
	Mon, 23 Mar 2026 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLnXleKl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBED3B38A3;
	Mon, 23 Mar 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274879; cv=none; b=ul9ubm7/++lNyRMnZkLW/fWUdwUe4vUIa9oi+JDcSmd8SbOQF41K/qUFATAkmyuyW2yoy+PZ2sCiKGwKmxdnuQFwiP1OR6ZJJlN9xv2hhOUhnOi4LzzKpgQOrnrNF62mtxh2xun5UMZKN/EUS3LZuNJxeYVSBmraip/ykLSvMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274879; c=relaxed/simple;
	bh=UA3anOYxWhoGPG4XUcIEldline2pHwySYfjtVijRn2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W63u2dmAdwC1s07ZRJ8RjEfA3aKNBY/Yg5s5cwtB22GdmhQB18X/A4PQ8Ys5hsUi3x/JobG3QV1P62jA7flucTE+XAvOT172Ocy8sL5DO5Fn3xJO2ZL6b8cXAZr0F/QGZA5aTlCQjd+G33o+oT3/BQYLmkBvckWribKWOykDp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cLnXleKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BA5C4CEF7;
	Mon, 23 Mar 2026 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274878;
	bh=UA3anOYxWhoGPG4XUcIEldline2pHwySYfjtVijRn2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLnXleKlCHLKbMdGLIPEAt0Lznc+FwhaJ611sI0UVnLlsPbE4HZQjXIRY117pZIq/
	 VUDDWieHd/rH0fwDO5bIKxrI/7NuxqVUstT2g9A29uF0K9pSuuH37W2sddquPR0JBs
	 wkIzW+G4T/JR7SuxASyYFtvu2siEF4LG9w830vZo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Tycho Andersen (AMD)" <tycho@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 142/212] crypto: ccp - Fix leaking the same page twice
Date: Mon, 23 Mar 2026 14:46:03 +0100
Message-ID: <20260323134508.262199537@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228349-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 965902F4220
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 5c52607c43c397b79a9852ce33fc61de58c3645c ]

Commit 551120148b67 ("crypto: ccp - Fix a case where SNP_SHUTDOWN is
missed") fixed a case where SNP is left in INIT state if page reclaim
fails. It removes the transition to the INIT state for this command and
adjusts the page state management.

While doing this, it added a call to snp_leak_pages() after a call to
snp_reclaim_pages() failed. Since snp_reclaim_pages() already calls
snp_leak_pages() internally on the pages it fails to reclaim, calling
it again leaks the exact same page twice.

Fix by removing the extra call to snp_leak_pages().

The problem was found by an experimental code review agent based on
gemini-3.1-pro while reviewing backports into v6.18.y.

Assisted-by: Gemini:gemini-3.1-pro
Fixes: 551120148b67 ("crypto: ccp - Fix a case where SNP_SHUTDOWN is missed")
Cc: Tycho Andersen (AMD) <tycho@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index b8da99bcb2432..86f5ed798d3c7 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2381,10 +2381,8 @@ static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
 		 * in Firmware state on failure. Use snp_reclaim_pages() to
 		 * transition either case back to Hypervisor-owned state.
 		 */
-		if (snp_reclaim_pages(__pa(data), 1, true)) {
-			snp_leak_pages(__page_to_pfn(status_page), 1);
+		if (snp_reclaim_pages(__pa(data), 1, true))
 			return -EFAULT;
-		}
 	}
 
 	if (ret)
-- 
2.51.0




