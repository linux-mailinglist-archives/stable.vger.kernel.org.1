Return-Path: <stable+bounces-238776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKM8M7Un5mnesgEAu9opvQ
	(envelope-from <stable+bounces-238776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:18:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDAC42B87E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E927301C3D8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5F239FCD6;
	Mon, 20 Apr 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="knbC9YXz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9A039FCA6
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690825; cv=none; b=JTweiDajDwK6rg09JtIZFg12zRNB1Pt/OUmSZeQTa2dBuRPn5DNb4iuU7nDeol/RXBCI3bO5I5ejtdpNPnoMJfY9bVXYSbK5w6DghMVO72HFSekLf58UgEJubEDPau+Xg8raDW4gLjdLtHhZRAxOtsngEwpPt5HDqVbc5+JTH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690825; c=relaxed/simple;
	bh=8Z4KNHHX1zer6RexfUDp5pkJg5K23DWqJP3kyzqRKFM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iOPFuBtFV89pOKiHsM6F8mDtS9OTyAi1H4k248nzDMFQTMNBYveFVhapgewQ+k0Zuq39v96A5t//M7EMFkZBIdRO+OTv9U3rAAyZIzsGlYqEGwgHnsayLPTxVVWvg90ZB8Xrj8Z4msK+F2HHCZ6/+Jzdfo/9UInyJ54KnONYMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=knbC9YXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7170C2BCB4;
	Mon, 20 Apr 2026 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776690825;
	bh=8Z4KNHHX1zer6RexfUDp5pkJg5K23DWqJP3kyzqRKFM=;
	h=Subject:To:Cc:From:Date:From;
	b=knbC9YXzKRjpCc0FpmHTLH+zHzKo1AL9AWPsjsmXUMpoSDieBww3TdrbMvUsl1zCF
	 lqGEdIjpWWlItpdzyk1w0iCMnaCHGz2hlL35MSkaILRNi80YksMpcJBtjTYzdDRTku
	 XbWm3+Omacy9Y1mytk1GnUgGGx2GFVZ9E0/B3cF8=
Subject: FAILED: patch "[PATCH] PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in" failed to apply to 6.1-stable tree
To: den@valinux.co.jp,Frank.Li@nxp.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Apr 2026 15:13:42 +0200
Message-ID: <2026042042-storeroom-specked-3d65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238776-lists,stable=lfdr.de];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[valinux.co.jp:query timed out];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,valinux.co.jp:email,gregkh:email,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 0FDAC42B87E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d799984233a50abd2667a7d17a9a710a3f10ebe2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042042-storeroom-specked-3d65@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d799984233a50abd2667a7d17a9a710a3f10ebe2 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Thu, 26 Feb 2026 17:41:40 +0900
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in
 epf_ntb_epc_cleanup

Disable the delayed work before clearing BAR mappings and doorbells to
avoid running the handler after resources have been torn down.

  Unable to handle kernel paging request at virtual address ffff800083f46004
  [...]
  Internal error: Oops: 0000000096000007 [#1]  SMP
  [...]
  Call trace:
   epf_ntb_cmd_handler+0x54/0x200 [pci_epf_vntb] (P)
   process_one_work+0x154/0x3b0
   worker_thread+0x2c8/0x400
   kthread+0x148/0x210
   ret_from_fork+0x10/0x20

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260226084142.2226875-4-den@valinux.co.jp

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 42c870ee3956..805353528967 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -942,6 +942,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
  */
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
+	disable_delayed_work_sync(&ntb->cmd_handler);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);


