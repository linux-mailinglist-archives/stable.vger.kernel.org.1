Return-Path: <stable+bounces-172142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED857B2FD45
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0383F6282F2
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EB6278E47;
	Thu, 21 Aug 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I9bFfl9S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C5C241136
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786827; cv=none; b=i2tRftpHon0chK4HZfk8Oz5gnZlOavg6r9CYK8RbvGlhaGPkTxDEZ2cJ1LfkQKB7CbQgEvWjDa1X/A4/soTb6eX1PATpuBaRTTFho6HEEUqRIq0zJPajSOnwbpd4NtV2m88Ad1Q8hzuAmpPkiU/kxJewGO6cIq1IyxFlvp56aD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786827; c=relaxed/simple;
	bh=FB9jlphgBIQu/+E/FSmi2po/CYj8TPZEK6TCKyqq+ww=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TdaANszE1Nd6/N5FdrGFl/L/tUFXrJ6xN97dOiAYh3lcVq5Ji+ET7O8Yb76lqIS8nMvFINdLLeA3PhB9jcCdrCbOIK3msLMLfiiml7fAplxI2ccwmAlD0ziBE3ZVBqdMnz3DR9sLF6GmLqR4pKySsh4kt+VcSfDYx/XzcmBev1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I9bFfl9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634D9C4CEEB;
	Thu, 21 Aug 2025 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786826;
	bh=FB9jlphgBIQu/+E/FSmi2po/CYj8TPZEK6TCKyqq+ww=;
	h=Subject:To:Cc:From:Date:From;
	b=I9bFfl9SZdKViTZzKGRBzxeuPo1GuotehS6tuIP5XYys76vs8hrYLmrhnhJrrRgAm
	 pGpipB6kU0BxCaHZeUiClfdVkqx9n3cnzf4zZhuJ9XimemxC6Uozb7nUu2iEIdV+cB
	 JVUBJvyI25ziNSpf6j+KIwWH9SYFHURT+2RT+Z40=
Subject: FAILED: patch "[PATCH] drm/xe/bmg: Add one additional PCI ID" failed to apply to 6.12-stable tree
To: ravi.kumar.vodapalli@intel.com,matthew.auld@intel.com,shekhar.chauhan@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:33:38 +0200
Message-ID: <2025082138-spew-mardi-8760@gregkh>
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
git cherry-pick -x ccfb15b8158c11a8304204aeac354c7b1cfb18a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082138-spew-mardi-8760@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ccfb15b8158c11a8304204aeac354c7b1cfb18a3 Mon Sep 17 00:00:00 2001
From: "Vodapalli, Ravi Kumar" <ravi.kumar.vodapalli@intel.com>
Date: Fri, 4 Jul 2025 16:05:27 +0530
Subject: [PATCH] drm/xe/bmg: Add one additional PCI ID

One additional PCI ID is added in Bspec for BMG, Add it so that
driver recognizes this device with this new ID.

Bspec: 68090
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Vodapalli, Ravi Kumar <ravi.kumar.vodapalli@intel.com>
Reviewed-by: Shekhar Chauhan <shekhar.chauhan@intel.com>
Acked-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://lore.kernel.org/r/20250704103527.100178-1-ravi.kumar.vodapalli@intel.com

diff --git a/include/drm/intel/pciids.h b/include/drm/intel/pciids.h
index a0180d10e260..76f8d26f9cc9 100644
--- a/include/drm/intel/pciids.h
+++ b/include/drm/intel/pciids.h
@@ -846,6 +846,7 @@
 /* BMG */
 #define INTEL_BMG_IDS(MACRO__, ...) \
 	MACRO__(0xE202, ## __VA_ARGS__), \
+	MACRO__(0xE209, ## __VA_ARGS__), \
 	MACRO__(0xE20B, ## __VA_ARGS__), \
 	MACRO__(0xE20C, ## __VA_ARGS__), \
 	MACRO__(0xE20D, ## __VA_ARGS__), \


