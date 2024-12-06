Return-Path: <stable+bounces-99045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBC29E6E05
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAB11624D1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8BD20100D;
	Fri,  6 Dec 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l7g6zgzc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EA1D63DF
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487712; cv=none; b=sq4AfeHAN7uSzi0H7FMqGHoYWKMFHIqupfDbRPjJrQ8aR/TKv5Myz8pDncYuyLnvQw2nv1XagiZbqK7j9eUPVOJF8a2MbzOknh7KatFfRXfcxAZ6PIzPQJEJVUOKU5o4i5Xu647cxjSWrVkUP47F2510zGBXPPydkQj/z3OM6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487712; c=relaxed/simple;
	bh=R6suaYukc0zvF8L3VIQGMRxqiOc1tQDwFO1Fsb3w9vU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RImpXJD55PuB7yt01XSKtJw3GCXJq2qky8tOUXLaIhDPhkwAQiqgCGNCcSmOqnogUSFdHE9o8IQ3wj1++Vu+JQTHHiNpl9BSt+uOF5Ich1EL3OvRQmhAsLJ/q+T0bnI4HLAKQsUKrx0BZ6uiTNg7Xplv9wm5jIBKwstbwoOBq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l7g6zgzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4AEC4CED1;
	Fri,  6 Dec 2024 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733487711;
	bh=R6suaYukc0zvF8L3VIQGMRxqiOc1tQDwFO1Fsb3w9vU=;
	h=Subject:To:Cc:From:Date:From;
	b=l7g6zgzcZUgHrRDgHRapo1bKUspfr/v/+ilv98+F+n+yhoPnNBggtIxtn49KGq1q7
	 F18tE5/GeIuvjezl5OjcHw4KEXyIrKOndnZOwL8wpweQKtvXQZT5Dat/Dz/o4wOd5q
	 S0QKWrFmwM2Q67K9lQsTwxCEE6EY63DM1slUVrgw=
Subject: FAILED: patch "[PATCH] PCI: endpoint: Clear secondary (not primary) EPC in" failed to apply to 6.1-stable tree
To: quic_zijuhu@quicinc.com,bhelgaas@google.com,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:21:48 +0100
Message-ID: <2024120648-rigging-lying-eda9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 688d2eb4c6fcfdcdaed0592f9df9196573ff5ce2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120648-rigging-lying-eda9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 688d2eb4c6fcfdcdaed0592f9df9196573ff5ce2 Mon Sep 17 00:00:00 2001
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Thu, 7 Nov 2024 08:53:09 +0800
Subject: [PATCH] PCI: endpoint: Clear secondary (not primary) EPC in
 pci_epc_remove_epf()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In addition to a primary endpoint controller, an endpoint function may be
associated with a secondary endpoint controller, epf->sec_epc, to provide
NTB (non-transparent bridge) functionality.

Previously, pci_epc_remove_epf() incorrectly cleared epf->epc instead of
epf->sec_epc when removing from the secondary endpoint controller.

Extend the epc->list_lock coverage and clear either epf->epc or
epf->sec_epc as indicated.

Link: https://lore.kernel.org/r/20241107-epc_rfc-v2-2-da5b6a99a66f@quicinc.com
Fixes: 63840ff53223 ("PCI: endpoint: Add support to associate secondary EPC with EPF")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[mani: reworded subject and description]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 21af2dbacc33..bed7c7d1fe3c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -746,18 +746,18 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 	if (IS_ERR_OR_NULL(epc) || !epf)
 		return;
 
+	mutex_lock(&epc->list_lock);
 	if (type == PRIMARY_INTERFACE) {
 		func_no = epf->func_no;
 		list = &epf->list;
+		epf->epc = NULL;
 	} else {
 		func_no = epf->sec_epc_func_no;
 		list = &epf->sec_epc_list;
+		epf->sec_epc = NULL;
 	}
-
-	mutex_lock(&epc->list_lock);
 	clear_bit(func_no, &epc->function_num_map);
 	list_del(list);
-	epf->epc = NULL;
 	mutex_unlock(&epc->list_lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_remove_epf);


