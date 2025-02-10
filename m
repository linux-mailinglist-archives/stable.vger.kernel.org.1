Return-Path: <stable+bounces-114582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D4A2EEF2
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C08018853C9
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A32309BF;
	Mon, 10 Feb 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mwBJ3Z/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969E22FDF9
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195717; cv=none; b=HFGUI5monUYQ4dTelhz9d6BDCkm4/YFQ8YYzp1eszpa5FJ2KloHyA17mL0hiOrY4s2lTENau3SczXQmJoDuBIg1sCdsi28ZPz2VQaQK8SOBSfoknaYCFB8ZWyGTX7POeLPWMlD+nvWF6dqq50j2/QpAkmY+cLrnZHTd9YxdBb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195717; c=relaxed/simple;
	bh=IL5R5wDz62ITKGq+EzMytmgnzmZOTqxlnZIvxY7ZbBo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UEVzvk1WI7/p6jEN/ac+H4k66cAGmEibHi2pp+AdQxKsRgaicka0SxvaFq/VMyfX7zZmlwkOXWhRnrOr5C1Gj6jHGciSK8LOA02ivsqn8uZzW2Bp5abgJWYhgJd7IbjEqkjcv/hcY0k3XDvut43BCNX6nR9GkFPsS2Tqg2wmrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mwBJ3Z/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC008C4CED1;
	Mon, 10 Feb 2025 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195714;
	bh=IL5R5wDz62ITKGq+EzMytmgnzmZOTqxlnZIvxY7ZbBo=;
	h=Subject:To:Cc:From:Date:From;
	b=mwBJ3Z/7JSXMo+8HuP6d0xfErzBC07pvywMBbMloRY7khhD/2tajy1l7IkPhi/+Ts
	 jtYznG2S0cW8sLkh+QM2VlYZIFCYix759O8u4H6P5FcaOKtvBQN4A2FsIUxMareLCS
	 U/LfgoJG8VtXBwy6xiujCOkhWB9wYH6yHB2WgrM4=
Subject: FAILED: patch "[PATCH] PCI: Avoid putting some root ports into D3 on TUXEDO Sirius" failed to apply to 6.1-stable tree
To: wse@tuxedocomputers.com,ggo@tuxedocomputers.com,kwilczynski@kernel.org,mario.limonciello@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:55:11 +0100
Message-ID: <2025021011-blade-viselike-e35c@gregkh>
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
git cherry-pick -x b1049f2d68693c80a576c4578d96774a68df2bad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021011-blade-viselike-e35c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1049f2d68693c80a576c4578d96774a68df2bad Mon Sep 17 00:00:00 2001
From: Werner Sembach <wse@tuxedocomputers.com>
Date: Tue, 14 Jan 2025 23:23:54 +0100
Subject: [PATCH] PCI: Avoid putting some root ports into D3 on TUXEDO Sirius
 Gen1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") sets the
policy that all PCIe ports are allowed to use D3.  When the system is
suspended if the port is not power manageable by the platform and won't be
used for wakeup via a PME this sets up the policy for these ports to go
into D3hot.

This policy generally makes sense from an OSPM perspective but it leads to
problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with a
specific old BIOS. This manifests as a system hang.

On the affected Device + BIOS combination, add a quirk for the root port of
the problematic controller to ensure that these root ports are not put into
D3hot at suspend.

This patch is based on

  https://lore.kernel.org/linux-pci/20230708214457.1229-2-mario.limonciello@amd.com

but with the added condition both in the documentation and in the code to
apply only to the TUXEDO Sirius 16 Gen 1 with a specific old BIOS and only
the affected root ports.

Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20250114222436.1075456-1-wse@tuxedocomputers.com
Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: <stable@vger.kernel.org> # 6.1+

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 0681ecfe3430..f348a3179b2d 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1010,4 +1010,34 @@ DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_suspend);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_resume);
 DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_suspend);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_resume);
+
+/*
+ * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
+ * may cause problems when the system attempts wake up from s2idle.
+ *
+ * On the TUXEDO Sirius 16 Gen 1 with a specific old BIOS this manifests as
+ * a system hang.
+ */
+static const struct dmi_system_id quirk_tuxeo_rp_d3_dmi_table[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "APX958"),
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "V1.00A00_20240108"),
+		},
+	},
+	{}
+};
+
+static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
+{
+	struct pci_dev *root_pdev;
+
+	if (dmi_check_system(quirk_tuxeo_rp_d3_dmi_table)) {
+		root_pdev = pcie_find_root_port(pdev);
+		if (root_pdev)
+			root_pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
 #endif /* CONFIG_SUSPEND */


