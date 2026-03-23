Return-Path: <stable+bounces-228126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMdkFP5IwWlmSAQAu9opvQ
	(envelope-from <stable+bounces-228126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:06:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E52F3D7B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0B0B302C761
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1281F91F6;
	Mon, 23 Mar 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whhkCKHe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46661DF25C;
	Mon, 23 Mar 2026 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274202; cv=none; b=TYw77PYHpGilUhKRIXS9Zu7yS9116rmIj/sUK/7JoVIcr+Mi4Luew3esu6/zo5TJPIbZs439ibpDK2b0XoT+LvivBoVFf60+EZ3MEy7K32c/sNnI4rL68Wx4PCDCa/SCBtPtIbiqBYUcMkaPVJHbX9MCpBarWU6gqNQXx6Pcs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274202; c=relaxed/simple;
	bh=bSfoZTqHr25xWyL4fQLf8by0F8YFR6f4PnfODL77654=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCJs1cYifrd8KPzRJvZyZe+scEIJi3NFXZRWHpDVkChLRpOwGrbkmIPKa9B22Y1NyDg81bb6yYO3mrDstz0b3gwJZtA80v639gFT8xicoc73JtEpE3FSfQpH35YY1BbeTUTUUcePQtFq0UR2URlE/oVNuDsUqRyfwk6fOvLaAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whhkCKHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A54C4CEF7;
	Mon, 23 Mar 2026 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274201;
	bh=bSfoZTqHr25xWyL4fQLf8by0F8YFR6f4PnfODL77654=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=whhkCKHeb25BUQvcgPSQAHLxDBZQbrKbzcVsIn+MK2i+0zipzTCzJUrcTSnCyh01u
	 bmioOnSZOMOpo49cFyTRGZDIChKpAztRfSSKYtr0puO71lRmI3p7S1nkWzqijZpHAZ
	 B7csHn4/tJUfc2XtSSYnqhBmCiFJVM64VIsAAIds=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Tycho Andersen (AMD)" <tycho@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 142/220] crypto: ccp - Fix leaking the same page twice
Date: Mon, 23 Mar 2026 14:45:19 +0100
Message-ID: <20260323134509.050512167@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228126-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:email]
X-Rspamd-Queue-Id: B92E52F3D7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
index 0d90b5f6a4548..a554fe3de3fd2 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2408,10 +2408,8 @@ static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
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




