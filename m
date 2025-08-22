Return-Path: <stable+bounces-172305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A095B30E78
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708D45E3E6E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21C2224AFC;
	Fri, 22 Aug 2025 06:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y9ATVyNX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29B221269
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842725; cv=none; b=Ej5OEwqDGurSmN/13t2BsoJQCjVbx0Sk9slDrAQBdRQHFMXJAU5caw7nlPOx26IRlpo6mfiJpE72JpHvZXqiiwqA60yk+IqTar4FmpU6CyjqmkPcr5ay8ke1D+O88no4NqCzhM861P4OUXNOn3ORUK1sEpsC1AZyrb7jB6ExHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842725; c=relaxed/simple;
	bh=/HofUspUjcZfeqDY51kj1BoBYsA6xX9hh38RSCsB/4g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bjEH4hsuU9Nii2bIWoHxTS0H/Hrpn4revjaPX4fjOGlN5pTCHb08IYOeX21mApCjOW6659jfjG6w7SRZLRrMJR2IHG+fVCqtJYXZpYyRF3Nkp+rOiwdhXy9jAz3v2qmPr2tDl/aZ/60Oe/yDR6q2L9RrG6cT2a9igp4Z8dFe/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y9ATVyNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9632FC4CEF1;
	Fri, 22 Aug 2025 06:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755842725;
	bh=/HofUspUjcZfeqDY51kj1BoBYsA6xX9hh38RSCsB/4g=;
	h=Subject:To:Cc:From:Date:From;
	b=Y9ATVyNX6O2ux+nx+fFlEn0knUOLXQN/ztPtPn08KMLBXC7F9r2meqAF2GVVuVDPb
	 cuRKWlFPLDvt2g1fZ5EkhIT7PJu1zAOU8ZVPf5tnNhfRk4gYSgrJaEGDbrbgcfnWYx
	 oHqW8ZCI+DO0gxaci70CrYsbhHpvnPrilsQK6mIM=
Subject: FAILED: patch "[PATCH] selftests: mptcp: pm: check flush doesn't reset limits" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 08:04:57 +0200
Message-ID: <2025082257-decal-riverboat-5ede@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 452690be7de2f91cc0de68cb9e95252875b33503
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082257-decal-riverboat-5ede@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 452690be7de2f91cc0de68cb9e95252875b33503 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Aug 2025 19:28:21 +0200
Subject: [PATCH] selftests: mptcp: pm: check flush doesn't reset limits

This modification is linked to the parent commit where the received
ADD_ADDR limit was accidentally reset when the endpoints were flushed.

To validate that, the test is now flushing endpoints after having set
new limits, and before checking them.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-3-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 2e6648a2b2c0..ac7ec6f94023 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -198,6 +198,7 @@ set_limits 1 9 2>/dev/null
 check "get_limits" "${default_limits}" "subflows above hard limit"
 
 set_limits 8 8
+flush_endpoint  ## to make sure it doesn't affect the limits
 check "get_limits" "$(format_limits 8 8)" "set limits"
 
 flush_endpoint


