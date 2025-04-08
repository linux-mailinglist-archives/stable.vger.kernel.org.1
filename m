Return-Path: <stable+bounces-129844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722FDA801C7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBDD880ED8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E7268FEF;
	Tue,  8 Apr 2025 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wnBgF5My"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C6268FDE;
	Tue,  8 Apr 2025 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112129; cv=none; b=gVeI3DESJo+DraqctldeELaJJ1LmNAxDTTiV1x4Ai/zpGEYTQvTQBAYYok6F0LrI9cMK+p2WObgVDXDd1dOQpgR3Qlce2Inx2g4KKsQcfK5B8gumIsDhGBoFRouvibUQkqFGL+5zDHn7ZnGTDgHZoaOmkcKfPgnGr+/cXKij3Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112129; c=relaxed/simple;
	bh=oWjYnZCZlf1fCIaiN4sz+LZA6/lM1A1Ct3vEL6ZLyIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZ1cexTxNWWbukUa4z7wCLRHx33qdrIxAwAfrMft5Ncso1fmu1WDfWU5f0gDH8EmhpjT4hpUmJYWrchFuKoaTEk7xOM+FEBCyNKTgEmPW2AAXmPo2I5K4H2GVb7/O86wfWDeZn+saSxZJYsAN16os1257o3HeCytFyMbXsIkq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wnBgF5My; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14387C4CEE5;
	Tue,  8 Apr 2025 11:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112128;
	bh=oWjYnZCZlf1fCIaiN4sz+LZA6/lM1A1Ct3vEL6ZLyIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wnBgF5MyxJEDNy75wK5CXqm0mp5n3p69ClQiEAWY0CLFCTCsft8Dr9Mw0mkRIQFdK
	 gnPQ3/jxGnBIkHCrdv4EkiFRwDjnIUKokl31Y69gF76l+2LAfn2bQ9pS9p6KuU3qqx
	 I24yfzkYfraSZI/pYjhTzaGzzl3S5pIQO0BTLh2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 6.14 687/731] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
Date: Tue,  8 Apr 2025 12:49:44 +0200
Message-ID: <20250408104930.247285594@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

commit 2ff0e408db36c21ed3fa5e3c1e0e687c82cf132f upstream.

Syzkaller has reported a warning in to_nfit_bus_uuid(): "only secondary
bus families can be translated". This warning is emited if the argument
is equal to NVDIMM_BUS_FAMILY_NFIT == 0. Function acpi_nfit_ctl() first
verifies that a user-provided value call_pkg->nd_family of type u64 is
not equal to 0. Then the value is converted to int, and only after that
is compared to NVDIMM_BUS_FAMILY_MAX. This can lead to passing an invalid
argument to acpi_nfit_ctl(), if call_pkg->nd_family is non-zero, while
the lower 32 bits are zero.

Furthermore, it is best to return EINVAL immediately upon seeing the
invalid user input.  The WARNING is insufficient to prevent further
undefined behavior based on other invalid user input.

All checks of the input value should be applied to the original variable
call_pkg->nd_family.

[iweiny: update commit message]

Fixes: 6450ddbd5d8e ("ACPI: NFIT: Define runtime firmware activation commands")
Cc: stable@vger.kernel.org
Reported-by: syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c80d8dc0d9fa81a3cd8c
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Link: https://patch.msgid.link/20250123163945.251-1-m.masimov@mt-integration.ru
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/nfit/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -485,7 +485,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 		cmd_mask = nd_desc->cmd_mask;
 		if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
 			family = call_pkg->nd_family;
-			if (family > NVDIMM_BUS_FAMILY_MAX ||
+			if (call_pkg->nd_family > NVDIMM_BUS_FAMILY_MAX ||
 			    !test_bit(family, &nd_desc->bus_family_mask))
 				return -EINVAL;
 			family = array_index_nospec(family,



