Return-Path: <stable+bounces-250262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JekNAjlDWpz4gUAu9opvQ
	(envelope-from <stable+bounces-250262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:44:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 526775925ED
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83A5C306E2DC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357EC371056;
	Wed, 20 May 2026 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKQFENAw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA9D370D7C;
	Wed, 20 May 2026 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294952; cv=none; b=t5SFvzE56IabnCFKk1Jw/uXwt7hYaQQRdUIgI+O8Aua/pbDRyrRYW9qKGR6G+zEp9yM+W8YjjOdWI9+1aOjKn5ewdkbA29LraHO23oMBa+THO1Mg0PXnoNj18lmdEgMDETDfIyPIJVO9UohLpstQ8hn6TUSj0fy3OFcmTzQ1i/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294952; c=relaxed/simple;
	bh=szEPEwhGdBrLJBMoYuHZ6ZpJbA/dc9k+xu8JrZVQU1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bm3qIWWHspilmTudP5kMwqr+dmGhPTiPZINgWsEfwLNCOIgBrqxUXWK/BlPhFAUDSYz9trrIdvOqFc/KipgT5tiqJ9M83icW473x1Dczg7pqlqLCqaO+Qtj0NTVU306aX83MJNNCncDd9dNbuTmg+kQ2oc2K9L3TNMwSR6WWcOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKQFENAw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D7E1F00893;
	Wed, 20 May 2026 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294950;
	bh=6Yw0dOndZZ0X+cgl/UR53Yw2Qi+ZvStFwZxIO76Uc+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dKQFENAw9aJs51pfHvWJGbGJce6mVr7/0jiB2P/AvZ8VLjX6yzhFz3i/y3cTx1nlg
	 kEJn60p/jl7vM56jCUWNlTJV9bC9VlRw93jYeot54L1yKGdJgaXrityZWXwZ1xQJGj
	 aYc6UcIqyG6TF+8HzqhsTEqZcfSL7jSmhDI3BtOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Koichiro Den <den@valinux.co.jp>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0234/1146] PCI: endpoint: pci-epf-test: Dont free doorbell IRQ unless requested
Date: Wed, 20 May 2026 18:08:04 +0200
Message-ID: <20260520162153.544063054@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250262-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,valinux.co.jp:email]
X-Rspamd-Queue-Id: 526775925ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit e81fa70179aac6ac3a6636565d5d35968dca3900 ]

pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
doorbell virq, which can trigger "Trying to free already-free IRQ"
warnings when the IRQ was never requested or when request_threaded_irq()
failed.

Move free_irq() out of pci_epf_test_doorbell_cleanup() and invoke it
only after a successful request, so that free_irq() is not called for
an unrequested IRQ.

Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Link: https://patch.msgid.link/20260217063856.3759713-3-den@valinux.co.jp
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 33548935765e3..0e7cbcbebf0b4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -715,7 +715,6 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
 	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
 	struct pci_epf *epf = epf_test->epf;
 
-	free_irq(epf->db_msg[0].virq, epf_test);
 	reg->doorbell_bar = cpu_to_le32(NO_BAR);
 
 	pci_epf_free_doorbell(epf);
@@ -759,7 +758,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 					 &epf_test->db_bar.phys_addr, &offset);
 
 	if (ret)
-		goto err_doorbell_cleanup;
+		goto err_free_irq;
 
 	reg->doorbell_offset = cpu_to_le32(offset);
 
@@ -769,12 +768,14 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 
 	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
 	if (ret)
-		goto err_doorbell_cleanup;
+		goto err_free_irq;
 
 	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
 	return;
 
+err_free_irq:
+	free_irq(epf->db_msg[0].virq, epf_test);
 err_doorbell_cleanup:
 	pci_epf_test_doorbell_cleanup(epf_test);
 set_status_err:
@@ -794,6 +795,7 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
 	if (bar < BAR_0)
 		goto set_status_err;
 
+	free_irq(epf->db_msg[0].virq, epf_test);
 	pci_epf_test_doorbell_cleanup(epf_test);
 
 	/*
-- 
2.53.0




