Return-Path: <stable+bounces-23167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880B285DF98
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EED31F245F6
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD08A7C08D;
	Wed, 21 Feb 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePqiRbDL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7307A708;
	Wed, 21 Feb 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525782; cv=none; b=Jcpu8P/qVGFGGihTt4Bc9PpvFKEn/6uzejQ9tug95B08OSi9Vv0Eqoxhfud0hsdg999Vtrg5JSFEOysqhb6ZKc+Yy5NLaHCK3/iaApSHIsPFOZ9+ZPlANfUCeVt4uzIlVNOoYjE6PXw14a4gg+V5GbKlAI7BvzB0DVqsamLl7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525782; c=relaxed/simple;
	bh=hPqkvdNuYyDaarKifzLEhqU7BTYMlnW/MJUUySPLpvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGQ6OtuN5m6wJmGK+iwpECLaa6NOA60RJU966ahVWdIx0cyFVFhdrdihYpaDyiGtVHEguYHxAUuywUFOx+t3Isd8iInaXmIDHUK957WQ54y3Qoo260dwl5WHDTwfA4a8R0PhanJbunHlETn72J0Yetvo7Uybrbge/XYVm4nrOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ePqiRbDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC247C433F1;
	Wed, 21 Feb 2024 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525782;
	bh=hPqkvdNuYyDaarKifzLEhqU7BTYMlnW/MJUUySPLpvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePqiRbDLx07dQfv91LQ9HcskcRMv1zFl/b01IM2nQnoigCbW/lYELPgamVJvraqQE
	 qXU3yhXBhdmNrdT7RY0Pmx1u3NUKA+XZHmfAzy4Spzv4Ehx2cdyAV8rpHyD8MlQVv1
	 Cv0o6PLpHuLGDGIm+zhvGb9erqU1/j0sYslSsWnU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+6b7c68d9c21e4ee4251b@syzkaller.appspotmail.com,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 224/267] nfc: nci: free rx_data_reassembly skb on NCI device cleanup
Date: Wed, 21 Feb 2024 14:09:25 +0100
Message-ID: <20240221125947.264158734@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

commit bfb007aebe6bff451f7f3a4be19f4f286d0d5d9c upstream.

rx_data_reassembly skb is stored during NCI data exchange for processing
fragmented packets. It is dropped only when the last fragment is processed
or when an NTF packet with NCI_OP_RF_DEACTIVATE_NTF opcode is received.
However, the NCI device may be deallocated before that which leads to skb
leak.

As by design the rx_data_reassembly skb is bound to the NCI device and
nothing prevents the device to be freed before the skb is processed in
some way and cleaned, free it on the NCI device cleanup.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Cc: stable@vger.kernel.org
Reported-by: syzbot+6b7c68d9c21e4ee4251b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000f43987060043da7b@google.com/
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/nci/core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1197,6 +1197,10 @@ void nci_free_device(struct nci_dev *nde
 {
 	nfc_free_device(ndev->nfc_dev);
 	nci_hci_deallocate(ndev);
+
+	/* drop partial rx data packet if present */
+	if (ndev->rx_data_reassembly)
+		kfree_skb(ndev->rx_data_reassembly);
 	kfree(ndev);
 }
 EXPORT_SYMBOL(nci_free_device);



