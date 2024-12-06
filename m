Return-Path: <stable+bounces-99046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3FB9E6E07
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D99718830E9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B1201012;
	Fri,  6 Dec 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HCAf2GKy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45F200BB4
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487720; cv=none; b=pyEZE8AtevHarw/p1rk8wECGnZ7axF+6PNhAR2z/iMy3zPYk71GB9sZ82GQijiyyqCZ20j42o1NuRAyLXuNb0Avu3DiXJgxz6zjTgLqyZJ+16T1LlmOkhidkY1NY82HooJA0S5m2+lKE4B6lOiyW8bVV/zZ44I0juI2B4ZE0XZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487720; c=relaxed/simple;
	bh=1NZdA/iyoq4cWxSf5tFJ9bKSG6CdN1OTSaTFr4Ull3g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AORvY3AiNtQDTojgZHcQgS2HoErKV4lsGXvOwqvN58mxrACa9B6G62/czEAIZnEw7y0d+ClnbmXa3rt03C2vhsoyRgqwj9qUQWypcIYcuFyAIzCR32pVuDfJvLGmBbCc4Gt5BZYD1qyfGw0K3nsJP5Wed11176lskl7yMWjponM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HCAf2GKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D308C4CED1;
	Fri,  6 Dec 2024 12:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733487720;
	bh=1NZdA/iyoq4cWxSf5tFJ9bKSG6CdN1OTSaTFr4Ull3g=;
	h=Subject:To:Cc:From:Date:From;
	b=HCAf2GKyLfM28/FNJzObVVhHuPyVTpMjtQXpmvQFT0S/maN9F6HrHTbbj5Hgo1FGe
	 xoGg3Sts2g+DxjU0cz+Ngu9h2xzY8wvivrmOZi+Eaj8Yg1wVJdk3kr5gYJLUbn9kWZ
	 ufV/qkKoOths6a6lz2HgsJ7FL5Pb01oRw8yEDCJQ=
Subject: FAILED: patch "[PATCH] PCI: endpoint: Clear secondary (not primary) EPC in" failed to apply to 5.15-stable tree
To: quic_zijuhu@quicinc.com,bhelgaas@google.com,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:21:49 +0100
Message-ID: <2024120649-cranium-uncle-f7f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 688d2eb4c6fcfdcdaed0592f9df9196573ff5ce2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120649-cranium-uncle-f7f1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


