Return-Path: <stable+bounces-172306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C15B30E7D
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53F7AC28F7
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438862135AD;
	Fri, 22 Aug 2025 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CbQcA3ed"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247620B80D
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842729; cv=none; b=JY+afpejwB4rbjsk0NRF5EFfa9IJlSXYGplYOY8B/XoKGhGdGEx89Zaxx5ZZSzBm734SwHYqAIY/RJA54MpHAnQXjVC/xIN2s9E4ihMU6bPLFjvbxealMh4nEweA3uzeMj8VAMY1Ota2xG4VaypzMXwIPEYeIc+JjAW32fmbNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842729; c=relaxed/simple;
	bh=EYPBwqm/3D395R5pi4LsPfEqIESU8cWFhdOsMO0TjDU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tsAobG8La2Akzj0CAw7V9nn0pahN5e2jXN1I7d9p34vgnRW/EH0ZQpYCvp1FXZk7Ap4UkUUTHT/2Ry1wxq/c9Yord6tTVYIqLDs6VEXRgB2l+jMwEfrOV2OGyToKuhoHvB1LEnHdbPpaK2RzPc6KVNeSedfaGrxIo1J1RJrvsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CbQcA3ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15577C4CEF1;
	Fri, 22 Aug 2025 06:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755842728;
	bh=EYPBwqm/3D395R5pi4LsPfEqIESU8cWFhdOsMO0TjDU=;
	h=Subject:To:Cc:From:Date:From;
	b=CbQcA3ed+ZQ1LKRFnFAV2EFeJtNsqvzVJHI8JLoe0Vw6WQQIMfxEm7vh5toZ6dgX5
	 5mP00CO1xDNTDJ6Ij44hF7DOQbt5j/+DhhoVIXd9Fi2d4WvH1d6dDSv+0044vKsOBw
	 nCMSm2jqb0fRU6kMVaD/vzyCWA5A0feeH1ax33K0=
Subject: FAILED: patch "[PATCH] selftests: mptcp: pm: check flush doesn't reset limits" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 08:05:03 +0200
Message-ID: <2025082203-populate-sublease-ef51@gregkh>
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
git cherry-pick -x 452690be7de2f91cc0de68cb9e95252875b33503
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082203-populate-sublease-ef51@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


