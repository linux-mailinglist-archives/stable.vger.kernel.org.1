Return-Path: <stable+bounces-133133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC792A91E6D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB5A460849
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B924E4CB;
	Thu, 17 Apr 2025 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cWQuv+xy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288F24E01F
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897487; cv=none; b=p0PL9IVs3CSR6f3Dgwx8Y2Y9QpsklFLBlJU5RQZH/N2crOR4hIKhTSSljCggsLCmsCSny/drAZCOD1JUN9vmgR7/F2Eh9L1Eguq3DkvTD2glQRP+enlhYSkXJc1YRAzLeXnYsWFY797R9FSoyhFmRELCOhJ+nZFCnI95E0Q8dyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897487; c=relaxed/simple;
	bh=EApgw9az7mGjO0yv6FhyT+ygTFSzwDMTfr2B4NJ9tFg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V3sgMBbWObnTehOkbdRV4buIsJrcXD9eRKUX485cAkvFl+quBpWTHUJ5qItJUP9W8iHA1dSXKYI2zeyKVVUa89rjEol4zBW8Nyl8p59HZY0LxX6o2jiZWFyga8Slab637QsTsl8H80P9xbjzgr/HLt8vM/t3gt5VX6uXBKuEp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cWQuv+xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52B2C4CEEA;
	Thu, 17 Apr 2025 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897487;
	bh=EApgw9az7mGjO0yv6FhyT+ygTFSzwDMTfr2B4NJ9tFg=;
	h=Subject:To:Cc:From:Date:From;
	b=cWQuv+xyhC867XkvjdIOUX60RaO+PilOmYVFuICGPhvSzYQcl8QkEkuvfF2IwZlXJ
	 DCpdcNvwee822BxBSJMOknPHmXGSlqIZH1GXMY0JyjFIMNvNRH0Bmw63ps/VMyNzeD
	 Ggkh0R6goLM/NbJVW4CfzGRxJRR4pNmRIQCGvgqc=
Subject: FAILED: patch "[PATCH] misc: pci_endpoint_test: Avoid issue of interrupts remaining" failed to apply to 6.6-stable tree
To: hayashi.kunihiko@socionext.com,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:40:36 +0200
Message-ID: <2025041736-gory-twistable-216a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f6cb7828c8e17520d4f5afb416515d3fae1af9a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041736-gory-twistable-216a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6cb7828c8e17520d4f5afb416515d3fae1af9a9 Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 25 Feb 2025 20:02:48 +0900
Subject: [PATCH] misc: pci_endpoint_test: Avoid issue of interrupts remaining
 after request_irq error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After devm_request_irq() fails with error in pci_endpoint_test_request_irq(),
the pci_endpoint_test_free_irq_vectors() is called assuming that all IRQs
have been released.

However, some requested IRQs remain unreleased, so there are still
/proc/irq/* entries remaining, and this results in WARN() with the
following message:

  remove_proc_entry: removing non-empty directory 'irq/30', leaking at least 'pci-endpoint-test.0'
  WARNING: CPU: 0 PID: 202 at fs/proc/generic.c:719 remove_proc_entry +0x190/0x19c

To solve this issue, set the number of remaining IRQs to test->num_irqs,
and release IRQs in advance by calling pci_endpoint_test_release_irq().

Cc: stable@vger.kernel.org
Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/20250225110252.28866-3-hayashi.kunihiko@socionext.com
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a3d2caa7a6bb..9e56d200d2f0 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -259,6 +259,9 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 		break;
 	}
 
+	test->num_irqs = i;
+	pci_endpoint_test_release_irq(test);
+
 	return ret;
 }
 


