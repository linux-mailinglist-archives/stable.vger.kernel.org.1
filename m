Return-Path: <stable+bounces-53622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D03490D31F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7589D281A95
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE29155A32;
	Tue, 18 Jun 2024 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kl8Yft7z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089A155A27
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717645; cv=none; b=CI77goQiksG0rHTDszO/m40Amed+c/zh4OBXVYekuOwTI88GJGnNeDH4Z5sWrDDM2yT5lT23kqlJXvcaUIoXqfhgs2YU94TP25jfEDsB0cxCm4RJAgga6SqIy4fdWvlPA1FHxV3DlAWxRgftolzT+pnsXQnL5BrPv39Egk26HPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717645; c=relaxed/simple;
	bh=cwMDSthkbnZN7NkLEZFfj4rrV1ByG7hl5ZWp/hH+eFk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UsBbIPMGNbtI2M3o+4FIyOD5STKTkCRoPJFv/b6GFnFDBV27egC6/qNcr6GZnd91EB2qUDMlxCXyCEDTPkvBL9z9VxShPUb9nztjpXU2Lz7VRg1h+JQGYVz9fEFKQpeZqrHWJKhi5AkUATGaLkY2VctlmX3nLEHFbClxodvvOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kl8Yft7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50241C3277B;
	Tue, 18 Jun 2024 13:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717644;
	bh=cwMDSthkbnZN7NkLEZFfj4rrV1ByG7hl5ZWp/hH+eFk=;
	h=Subject:To:Cc:From:Date:From;
	b=kl8Yft7zyZPpRGJ6bvvkYKjuboT2pUAnFaUZtTnRYIO+erja1I3M6So5dQHAWxDPw
	 aiQgMfj+ApC9/OAtQJ13Wrwi/GprKmUhZg0ufE2YX3qG4qN8urbRzIGiU/H6Qo5xZf
	 RDd/L0LGXw6iJE7JkZwUAQhCgwKeH260YnBFi6K8=
Subject: FAILED: patch "[PATCH] x86/amd_nb: Check for invalid SMN reads" failed to apply to 4.19-stable tree
To: yazen.ghannam@amd.com,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 15:27:15 +0200
Message-ID: <2024061815-muppet-blurb-f050@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c625dabbf1c4a8e77e4734014f2fde7aa9071a1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061815-muppet-blurb-f050@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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
 


