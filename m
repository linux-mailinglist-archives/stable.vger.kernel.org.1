Return-Path: <stable+bounces-135022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9993A95E0E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD8C177E5B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A71F5402;
	Tue, 22 Apr 2025 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="khHLzKC0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43551F3FE8
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302991; cv=none; b=RgqyiLZz8hcZWIWUXU6btM2T14ODZj2Uiayi/86IQvVvT+fhTgx24ejBi2CRGyMUth7MZbTLtBKKJyLMvf5DW17xti2Btwmu01RTkHtHAugcIm8fCF5fdH9OhzUj8NH+Yz2iqWElaJA2hNZKlB9CAVJSi41beo1MNLpg7lXDldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302991; c=relaxed/simple;
	bh=/7eC4oVA/b3FsJrVYmvVSGdTFN064w10uLml9r45W+c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=le264M4FL1zgAq2iwKQrCjrOMxOESWiMCZjNCHOC64tG52DM1bP9FLddAa7KBTpPqPs/xhS4Rgxz+Rp9K2DZo+KcHkY9TftmtjNFqDjvJOLyE+i5CxLzQUl8NwgRU/Iwqu32KQqbnF3SB6zHv9wj0s7Uml6d8GRLs1eleGCAsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=khHLzKC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E1CC4CEE9;
	Tue, 22 Apr 2025 06:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745302991;
	bh=/7eC4oVA/b3FsJrVYmvVSGdTFN064w10uLml9r45W+c=;
	h=Subject:To:Cc:From:Date:From;
	b=khHLzKC0JT0BonYQZOCiDRVlCTsqBpI0RszXI1D30ajhloLdUpJRFvcWI5+kbmirt
	 6gJH/VxXstac9CnAsnviVM3r5WNsZWr3oJ9feIX/+J1XxZzUvtWwUbFHsV0kAfLTxp
	 tBr2GXFQE/+j7g8fiIJpk9CNs/NdbkICsDlQnbU0=
Subject: FAILED: patch "[PATCH] drm/xe/bmg: Add one additional PCI ID" failed to apply to 6.12-stable tree
To: matthew.d.roper@intel.com,Clinton.A.Taylor@intel.com,lucas.demarchi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:23:08 +0200
Message-ID: <2025042208-appealing-ointment-0556@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5529df92b8e8cbb4b14a226665888f74648260ad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042208-appealing-ointment-0556@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5529df92b8e8cbb4b14a226665888f74648260ad Mon Sep 17 00:00:00 2001
From: Matt Roper <matthew.d.roper@intel.com>
Date: Tue, 25 Mar 2025 15:47:10 -0700
Subject: [PATCH] drm/xe/bmg: Add one additional PCI ID

One additional BMG PCI ID has been added to the spec; make sure our
driver recognizes devices with this ID properly.

Bspec: 68090
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Clint Taylor <Clinton.A.Taylor@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://lore.kernel.org/r/20250325224709.4073080-2-matthew.d.roper@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
(cherry picked from commit cca9734ebe55f6af11ce8d57ca1afdc4d158c808)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/include/drm/intel/pciids.h b/include/drm/intel/pciids.h
index 4736ea525048..d212848d07f3 100644
--- a/include/drm/intel/pciids.h
+++ b/include/drm/intel/pciids.h
@@ -850,6 +850,7 @@
 	MACRO__(0xE20C, ## __VA_ARGS__), \
 	MACRO__(0xE20D, ## __VA_ARGS__), \
 	MACRO__(0xE210, ## __VA_ARGS__), \
+	MACRO__(0xE211, ## __VA_ARGS__), \
 	MACRO__(0xE212, ## __VA_ARGS__), \
 	MACRO__(0xE215, ## __VA_ARGS__), \
 	MACRO__(0xE216, ## __VA_ARGS__)


