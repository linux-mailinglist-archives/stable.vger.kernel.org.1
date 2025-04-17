Return-Path: <stable+bounces-132992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69911A91973
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870F4461726
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD34821B905;
	Thu, 17 Apr 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0QT7yUxS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0801FCFDB
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886013; cv=none; b=BJgWDnzhJROFm4CSVL6s16pKAlH4zJRxdwBTBX4pul9h8YIf7ZykviivxKeWY+2E+mhwvo5E47UGOMcGGiWgXOzpv+BH7UzBeqQkD4LCnXu4ZkomQSiCARcSsbQPfzVOz5FIjzhlZx8mgUfpz/P9XmDzh3SZYv7hL/HoKsRPrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886013; c=relaxed/simple;
	bh=k7aCkiqrmvBMmy+4LVMRcvhaIxbTpSNMJkQjtTTEkvw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UWKWBLs9w1+NWqT1mh9mXxYaKvFz0yHNou8hVqDHWmaDzgz8khp2svkC9FwdVlLbHBqVOJz8XYla5b0VZk0+os3W1dmy5b+cT2s/rdXbgnZSaI7uCvf9ffFVjJdojJCD/G23s9YqdVqYvj7bf8pjnaPyTwMfMnp6W45Kx0jmDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0QT7yUxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6365C4CEEA;
	Thu, 17 Apr 2025 10:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744886013;
	bh=k7aCkiqrmvBMmy+4LVMRcvhaIxbTpSNMJkQjtTTEkvw=;
	h=Subject:To:Cc:From:Date:From;
	b=0QT7yUxSrYqJXBtg1jhZQLxca/sYf8w9EIZxZLGrjmDIECym0ZjuYSwOWz8Q8quqQ
	 4zsd2B54rrYbVMTD87wPwWZwlV3h4yzgxmjs7bRdnLrXHPtqU2zcp5yCcPKPPkTYwy
	 ROl2zumT6fd9tA1ow/ChVxf59bkWBwrP9e2k61Io=
Subject: FAILED: patch "[PATCH] net: dsa: mv88e6xxx: fix internal PHYs for 6320 family" failed to apply to 6.6-stable tree
To: kabel@kernel.org,andrew@lunn.ch,kuba@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:33:30 +0200
Message-ID: <2025041730-universal-cannot-3a68@gregkh>
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
git cherry-pick -x 52fdc41c3278c981066a461d03d5477ebfcf270c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041730-universal-cannot-3a68@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52fdc41c3278c981066a461d03d5477ebfcf270c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Date: Mon, 17 Mar 2025 18:32:49 +0100
Subject: [PATCH] net: dsa: mv88e6xxx: fix internal PHYs for 6320 family
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix internal PHYs definition for the 6320 family, which has only 2
internal PHYs (on ports 3 and 4).

Fixes: bc3931557d1d ("net: dsa: mv88e6xxx: Add number of internal PHYs")
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: <stable@vger.kernel.org> # 6.6.x
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-7-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 74b8bae226e4..88f479dc328c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6242,7 +6242,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 5,
+		.num_internal_phys = 2,
+		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
@@ -6269,7 +6270,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 5,
+		.num_internal_phys = 2,
+		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,


