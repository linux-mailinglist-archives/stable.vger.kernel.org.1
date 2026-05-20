Return-Path: <stable+bounces-251676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKgyGNnyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BDD59468C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C30B43036089
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DAF3C870E;
	Wed, 20 May 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O09Geuuh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC13D75D3;
	Wed, 20 May 2026 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298603; cv=none; b=g+noGNOIJUnEUqn93RUci1bypIJvqm55NhrB8iEB8hg0Vry1I2hWYFOrA23Pz37HfwJLUsz0AYl6jtITxx3ngyfiD6pJfdKUxvqeKEYbDSGqvAePrzdJjpjf6PW/5uxWPbBBy8O3Eq8o74N+vNRES9oeYUt8lR8XIDgJSprScpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298603; c=relaxed/simple;
	bh=jd5TmXz5twlb4vH+nd15yStkFzebxatyRDkoujRNxDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TImEzlaDQajP6STwjmHKHnqfUzvFXii9Izb/SBwcgQiGGB6d1TYQZdmsOLKExwKXwHtfMLe7jRMzz67WngW6Yic/benG7SRulqz3P6hogRkKkqhAfxfcz9STXpAPmEsEAVYurqXj8/vTsBuq7+lttXFed9zHHyxwouz/xnqR0Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O09Geuuh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF3C1F000E9;
	Wed, 20 May 2026 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298601;
	bh=WCNapPG+bJoKfbXNg5P7gYsE6L6ySBZV4fCtiJc3bbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O09GeuuhWptteEpPZgjGU/ZQd6RXHR7hrr+JZVx5/REQNx5JFVE/Dc7V2wdhQfICW
	 UpJPfJ49seUoqBeDfxZYjwjfjwJhT/BYg/WHV8KneFFORYudLujqFPcHmsLww+LOVq
	 rZlRfzURUXFiqGm8hjBtet4w0skS6tkTtrpoyx2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 472/957] cxl/pci: Check memdev driver binding status in cxl_reset_done()
Date: Wed, 20 May 2026 18:15:55 +0200
Message-ID: <20260520162144.762136121@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[zohomail.com:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251676-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: E9BDD59468C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Ming <ming.li@zohomail.com>

[ Upstream commit e8069c66d09309579e53567be8ddfa6ccb2f452a ]

cxl_reset_done() accesses the endpoint of the corresponding CXL memdev
without endpoint validity checking. By default, cxlmd->endpoint is
initialized to -ENXIO, if cxl_reset_done() is triggered after the
corresponding CXL memdev probing failed, this results in access to an
invalid endpoint.

CXL subsystem can always check CXL memdev driver binding status to
confirm its endpoint validity. So adding the CXL memdev driver checking
inside cxl_reset_done() to avoid accessing an invalid endpoint.

Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
Link: https://patch.msgid.link/20260314-fix_access_endpoint_without_drv_check-v2-4-4c09edf2e1db@zohomail.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd100ac31672d..c78d7d88744bf 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1104,6 +1104,9 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	 * that no longer exists.
 	 */
 	guard(device)(&cxlmd->dev);
+	if (!cxlmd->dev.driver)
+		return;
+
 	if (cxlmd->endpoint &&
 	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
 		dev_crit(dev, "SBR happened without memory regions removal.\n");
-- 
2.53.0




