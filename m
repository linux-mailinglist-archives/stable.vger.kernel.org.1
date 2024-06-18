Return-Path: <stable+bounces-53624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3540A90D4AE
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F42B2B423
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246CA155A5C;
	Tue, 18 Jun 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AXv5wy8G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A1155A27
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717650; cv=none; b=Eq40xsBHKg1mZrfHMnIvCSH7FzQFCU3QflVIiDdIDGvvdNfM4nsW1y3axBWr2hcNb9i3WnjpcZhebhZ4XxQK6rKsAr/OD8B1Pcgv4HFkvfcPpaQUWOEx+6xdC8gzVVyYDFqnsxeeXjHlP/gqr8BAnYxtoPZAH15zXa/5eGcgxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717650; c=relaxed/simple;
	bh=ALIgzWWBcuaFGlsDn/v7YJRHT0efxuZPNs5omaLvqzM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Oy6ArnigKAgKXC7k01uamklOLoggT/d79Vs6AX4IDJKM997kJX80cxEJPIREcRuX4YUmvMQbVd7qiZBvIRnMGDCK7lK9Kwdy2h7SVofP6jT8d01ecqAsq6dyYRt/efaxVrpzYpunPTZ1hhB/uB3f1GdpKsHfWZbWjDtog3JJujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AXv5wy8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACAAC3277B;
	Tue, 18 Jun 2024 13:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717650;
	bh=ALIgzWWBcuaFGlsDn/v7YJRHT0efxuZPNs5omaLvqzM=;
	h=Subject:To:Cc:From:Date:From;
	b=AXv5wy8G4lPe2n4ECswBjYTDembH6KXymFGA45r5v9VUiJoOKRqYd3zlBx1P9RPGH
	 bDXbw+9KPJcekqTOnzm0o8kst2whE7Wes+CrN5IRdWNMeDsxW76sGfW+32ZLbF44eZ
	 FK/e2MOkg2mgVIcYlqqS5BO15Q8Vtef5pUsi+gJc=
Subject: FAILED: patch "[PATCH] x86/amd_nb: Check for invalid SMN reads" failed to apply to 5.10-stable tree
To: yazen.ghannam@amd.com,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 15:28:06 +0200
Message-ID: <2024061804-gravel-flatness-2f43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c625dabbf1c4a8e77e4734014f2fde7aa9071a1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061804-gravel-flatness-2f43@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

c625dabbf1c4 ("x86/amd_nb: Check for invalid SMN reads")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c625dabbf1c4a8e77e4734014f2fde7aa9071a1f Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 3 Apr 2023 16:42:44 +0000
Subject: [PATCH] x86/amd_nb: Check for invalid SMN reads

AMD Zen-based systems use a System Management Network (SMN) that
provides access to implementation-specific registers.

SMN accesses are done indirectly through an index/data pair in PCI
config space. The PCI config access may fail and return an error code.
This would prevent the "read" value from being updated.

However, the PCI config access may succeed, but the return value may be
invalid. This is in similar fashion to PCI bad reads, i.e. return all
bits set.

Most systems will return 0 for SMN addresses that are not accessible.
This is in line with AMD convention that unavailable registers are
Read-as-Zero/Writes-Ignored.

However, some systems will return a "PCI Error Response" instead. This
value, along with an error code of 0 from the PCI config access, will
confuse callers of the amd_smn_read() function.

Check for this condition, clear the return value, and set a proper error
code.

Fixes: ddfe43cdc0da ("x86/amd_nb: Add SMN and Indirect Data Fabric access for AMD Fam17h")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230403164244.471141-1-yazen.ghannam@amd.com

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 3cf156f70859..027a8c7a2c9e 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -215,7 +215,14 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 int amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	return __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(node, address, value, false);
+
+	if (PCI_POSSIBLE_ERROR(*value)) {
+		err = -ENODEV;
+		*value = 0;
+	}
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(amd_smn_read);
 


