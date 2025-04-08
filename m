Return-Path: <stable+bounces-130681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463DAA805F8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D910C880272
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894C26B0B8;
	Tue,  8 Apr 2025 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qDbrsmW9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3726A097;
	Tue,  8 Apr 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114364; cv=none; b=M9Ir+3futsuwo3YqMnXGzlvc0YHCbsf+PjjYrxNU7tQepwxRQk/nPkf8Ha/ILo5CWWZFj7hJArLryiyqjn49nd41ur/tqzAk0jS9B4fjNAydAFfVUXI/oKeUwi8ay+EsY9uBGEhYBMevi9oTtSo/vtlPt8gy1POBDzdAifRtk4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114364; c=relaxed/simple;
	bh=AB/7GxWOCpz9bTirJD+Q5Jpm4AmaCPOUooL7jApvJ9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2vZ84+HFJbopIddorRvq3LTK1155j8J5D15yKDih6zSwq8XHCyLKLuxX7Bq3bj6x3u9sc2QfsNIvE76NUbKKXPkJpaKEVYNv9kxz5Oo/tVD9QmyWqXJ5ClDCqWATHhZKwnwI2kVZgeInS08a4Muj9CcnBESREDQdX08PgBntJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qDbrsmW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4E6C4CEE5;
	Tue,  8 Apr 2025 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114364;
	bh=AB/7GxWOCpz9bTirJD+Q5Jpm4AmaCPOUooL7jApvJ9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDbrsmW98K+0qLGPxjhXH7J8ZOA0lnpJv5OgLTLiAjocTqUBLalbmHPqvAUCwC99G
	 Pdzb+rdVEd6OMeba8bufCAqmX0skxdB5/rTdqBbOGmn29nQz001kqUirP+xYstQK6C
	 urXOBbOM4c1FQnSW6W0+XrgUHN6fBRy5eWGOT3PA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Stodden <dns@arista.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 078/499] PCI/ASPM: Fix link state exit during switch upstream function removal
Date: Tue,  8 Apr 2025 12:44:50 +0200
Message-ID: <20250408104853.172231203@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Stodden <daniel.stodden@gmail.com>

[ Upstream commit cbf937dcadfd571a434f8074d057b32cd14fbea5 ]

Before 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to
avoid use-after-free"), we would free the ASPM link only after the last
function on the bus pertaining to the given link was removed.

That was too late. If function 0 is removed before sibling function,
link->downstream would point to free'd memory after.

After above change, we freed the ASPM parent link state upon any function
removal on the bus pertaining to a given link.

That is too early. If the link is to a PCIe switch with MFD on the upstream
port, then removing functions other than 0 first would free a link which
still remains parent_link to the remaining downstream ports.

The resulting GPFs are especially frequent during hot-unplug, because
pciehp removes devices on the link bus in reverse order.

On that switch, function 0 is the virtual P2P bridge to the internal bus.
Free exactly when function 0 is removed -- before the parent link is
obsolete, but after all subordinate links are gone.

Link: https://lore.kernel.org/r/e12898835f25234561c9d7de4435590d957b85d9.1734924854.git.dns@arista.com
Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")
Signed-off-by: Daniel Stodden <dns@arista.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 28567d457613b..042ade95ff812 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1250,16 +1250,16 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	parent_link = link->parent;
 
 	/*
-	 * link->downstream is a pointer to the pci_dev of function 0.  If
-	 * we remove that function, the pci_dev is about to be deallocated,
-	 * so we can't use link->downstream again.  Free the link state to
-	 * avoid this.
+	 * Free the parent link state, no later than function 0 (i.e.
+	 * link->downstream) being removed.
 	 *
-	 * If we're removing a non-0 function, it's possible we could
-	 * retain the link state, but PCIe r6.0, sec 7.5.3.7, recommends
-	 * programming the same ASPM Control value for all functions of
-	 * multi-function devices, so disable ASPM for all of them.
+	 * Do not free the link state any earlier. If function 0 is a
+	 * switch upstream port, this link state is parent_link to all
+	 * subordinate ones.
 	 */
+	if (pdev != link->downstream)
+		goto out;
+
 	pcie_config_aspm_link(link, 0);
 	list_del(&link->sibling);
 	free_link_state(link);
@@ -1270,6 +1270,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		pcie_config_aspm_path(parent_link);
 	}
 
+ out:
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
 }
-- 
2.39.5




