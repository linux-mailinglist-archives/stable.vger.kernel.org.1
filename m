Return-Path: <stable+bounces-239523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K6ZNFVl5mkKvwEAu9opvQ
	(envelope-from <stable+bounces-239523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:41:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC3431D5F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA6D5323AAFD
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903333262B;
	Mon, 20 Apr 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kbPeaFbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5242D77E5;
	Mon, 20 Apr 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700471; cv=none; b=rv4fUwXLVYS6nU3AXRLD8KUrsBQQhBpFhPv3PZ4UoFoH0J41lT9L0K7m3oDMJBcJ9AVg4VOdMeeF1HzhJurdVLWeHiqAfigIpszH9VyOQxLCDPceUS6JqR0uKg3bvLYJXWk+dRkv/j5SoV7PWI0vlv2T7fM+ezOokwro7fIWOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700471; c=relaxed/simple;
	bh=bgCfQLsR/Pac7MaUn7ZsnTGSHAfEDic9d8w8uLtFQio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T46pYAfv+1+kucliZOiUXmQRce5zfFp26Z3xDHOL02oobW7A/oF5cVR70BD9TGZtqTW5fWRFtGJnAwALECPg6WsSa6JjNq8rdq43CZjN/EQKcLJFLIrtkn3OWakwhLc5B0W9EFg0j627V+xCOtVcviMVDmaGplyaI9CDAWJG2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kbPeaFbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D771BC19425;
	Mon, 20 Apr 2026 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700471;
	bh=bgCfQLsR/Pac7MaUn7ZsnTGSHAfEDic9d8w8uLtFQio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbPeaFbpluZ31byZ2bnQO8dU7G56KAgAiJ2Z3+wmFEBBvsuCdd1BW6enCQvJfAkfO
	 w+wGyNVE+7xGitK42f57lW2BLgjoIw3Lkx0B+6SJffKp33tVK+eYE/OvvgA3icrFrr
	 XODhCsZUxVxpwHTzoaYvA7aFy2Xmdp2azLhfvec4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Koichiro Den <den@valinux.co.jp>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 6.19 186/220] PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
Date: Mon, 20 Apr 2026 17:42:07 +0200
Message-ID: <20260420153940.723609498@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239523-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 3DAC3431D5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Koichiro Den <den@valinux.co.jp>

commit 0da63230d3ec1ec5fcc443a2314233e95bfece54 upstream.

epf_ntb_epc_destroy() duplicates the teardown that the caller is
supposed to perform later. This leads to an oops when .allow_link fails
or when .drop_link is performed. The following is an example oops of the
former case:

  Unable to handle kernel paging request at virtual address dead000000000108
  [...]
  [dead000000000108] address between user and kernel address ranges
  Internal error: Oops: 0000000096000044 [#1]  SMP
  [...]
  Call trace:
   pci_epc_remove_epf+0x78/0xe0 (P)
   pci_primary_epc_epf_link+0x88/0xa8
   configfs_symlink+0x1f4/0x5a0
   vfs_symlink+0x134/0x1d8
   do_symlinkat+0x88/0x138
   __arm64_sys_symlinkat+0x74/0xe0
  [...]

Remove the helper, and drop pci_epc_put(). EPC device refcounting is
tied to the configfs EPC group lifetime, and pci_epc_put() in the
.drop_link path is sufficient.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260226084142.2226875-2-den@valinux.co.jp
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -764,19 +764,6 @@ static void epf_ntb_mw_bar_clear(struct
 }
 
 /**
- * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- *
- * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
- */
-static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
-{
-	pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
-	pci_epc_put(ntb->epf->epc);
-}
-
-
-/**
  * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  * @barno: Checked bar number
@@ -1526,7 +1513,7 @@ static int epf_ntb_bind(struct pci_epf *
 	ret = epf_ntb_init_epc_bar(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to create NTB EPC\n");
-		goto err_bar_init;
+		return ret;
 	}
 
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
@@ -1566,9 +1553,6 @@ err_epc_cleanup:
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-err_bar_init:
-	epf_ntb_epc_destroy(ntb);
-
 	return ret;
 }
 
@@ -1584,7 +1568,6 @@ static void epf_ntb_unbind(struct pci_ep
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-	epf_ntb_epc_destroy(ntb);
 
 	pci_unregister_driver(&vntb_pci_driver);
 }



