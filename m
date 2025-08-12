Return-Path: <stable+bounces-167515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60364B2306E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE06177BDD
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117502FE57A;
	Tue, 12 Aug 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DyNWwWXP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE52868AF;
	Tue, 12 Aug 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021080; cv=none; b=DS8xs4HQGUODwzm4Xxdt86xUZjLmo5/NkyDeNsTL0wPHyjpuhJv+nim3PHWQGbHrGg8hLmMN/DZYMW5RSvPJ/PQE0PF8Z8okm5FzyWTcuYMjFXcdr/T1+897ah9EbCrFuhcWatWn9fqjnFPU2ED005DfDMy874NL+vcI7qmNzN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021080; c=relaxed/simple;
	bh=3HR+7pEFSima9heqlmjRGUHNhj/D0GLRlaZzaXin4GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMlc9eA3BwVtEQdu/p7cOgfs9KFlJju+YvudeI4kSOplZC+yMykRIvmfRscrGMndtZS6oeA/f1KyzadrYrNtr+NoenyQ33yBuhSGaRC6BJ3YHPCmIDg/LmLJYwnk92/Vm3DlyJaZ5yXD4loSf+sLXR0FfEolbSomPaeL8CYndo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DyNWwWXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C501C4CEF0;
	Tue, 12 Aug 2025 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021080;
	bh=3HR+7pEFSima9heqlmjRGUHNhj/D0GLRlaZzaXin4GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyNWwWXPnttUxC6a6+NfsMCb8umxpvyN8Oxua5DK4GD2nsliKKoPanKjIJo9jx2be
	 Gh+UwJ3sgu+KkmaNtq0LJlvH5YpK08x8rNS/vSfjaBe9ugtTH8Qisou4N8LaV+gcTt
	 VndP5dI1j6ziGJhkVnK2V+XsEfshaKFdningkjeI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Timothy Pearson <tpearson@raptorengineering.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 208/253] powerpc/eeh: Export eeh_unfreeze_pe()
Date: Tue, 12 Aug 2025 19:29:56 +0200
Message-ID: <20250812172957.675726693@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timothy Pearson <tpearson@raptorengineering.com>

[ Upstream commit e82b34eed04b0ddcff4548b62633467235672fd3 ]

The PowerNV hotplug driver needs to be able to clear any frozen PE(s)
on the PHB after suprise removal of a downstream device.

Export the eeh_unfreeze_pe() symbol to allow implementation of this
functionality in the php_nv module.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/1778535414.1359858.1752615454618.JavaMail.zimbra@raptorengineeringinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/eeh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 2e286bba2f64..82626363a309 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1130,6 +1130,7 @@ int eeh_unfreeze_pe(struct eeh_pe *pe)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(eeh_unfreeze_pe);
 
 
 static struct pci_device_id eeh_reset_ids[] = {
-- 
2.39.5




