Return-Path: <stable+bounces-59308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF149931180
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59B21C22127
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5AF186E53;
	Mon, 15 Jul 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cjOaTwqM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66B186E34
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036601; cv=none; b=GexskYNA0l6u88SJ/vzf/Nfxw8CKV/SzK9W/sZBWiNLfiJ6oecKfYu4nr/hWwXr8pGrN0Ypw+T3+U3mnUYMuncgyf45sTtN8yehr9QvTkPo2odYRRZskGTATWV00SBU9A0f7kMcy2/awN1zn1nHtm7w0FkRTnFIEO6x0T8uU5Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036601; c=relaxed/simple;
	bh=b5Urt2ufocAjcnOHjQvrr3SJXJaDQclieWrQ0WJsQuU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CThX6bNxuNH1lbZeslrHDkjc6bUgWTsWSIWehGzaExqwx0LjMkAMn3xciL2n7CcmJFxjDkj6UN2rauE731NSW3UfzBXs0twH2Vx0OR6IWWP85kOh/3BohIzEc3KuVrsvEXt42qzOj6NXVefCQsCk900s1k0YB7WCtrat1m6u/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cjOaTwqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFE2C32782;
	Mon, 15 Jul 2024 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721036601;
	bh=b5Urt2ufocAjcnOHjQvrr3SJXJaDQclieWrQ0WJsQuU=;
	h=Subject:To:Cc:From:Date:From;
	b=cjOaTwqMtQbdkde3s0//ohy8gsKCRt3kraZgKjmDS2gzrkyDTYEotoo1/TAqKsx04
	 F+O28KjpyRB/HBhMv1SudZdgGnfy+Rw8twXiViv+BOAzTQDYRqNMD40JiCJdppVUbG
	 DpmzwQMKSWCKMcyN7O5eDifVXxYtK1xYClnQ6b3g=
Subject: FAILED: patch "[PATCH] thermal: gov_power_allocator: Return early in manage if" failed to apply to 6.9-stable tree
To: nfraprado@collabora.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 11:43:18 +0200
Message-ID: <2024071517-deepen-remedial-db3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x aaa18ff54b97706b84306b6613630262706b1f6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071517-deepen-remedial-db3b@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

aaa18ff54b97 ("thermal: gov_power_allocator: Return early in manage if trip_max is NULL")
ca0e9728d372 ("thermal: gov_power_allocator: Eliminate a redundant variable")
41ddbcc6fd2c ("thermal: gov_power_allocator: Use .manage() callback instead of .throttle()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aaa18ff54b97706b84306b6613630262706b1f6b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
Date: Tue, 2 Jul 2024 17:24:56 -0400
Subject: [PATCH] thermal: gov_power_allocator: Return early in manage if
 trip_max is NULL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit da781936e7c3 ("thermal: gov_power_allocator: Allow binding
without trip points") allowed the governor to bind even when trip_max
is NULL. This allows a NULL pointer dereference to happen in the manage
callback.

Add an early return to prevent it, since the governor is expected to not do
anything in this case.

Fixes: da781936e7c3 ("thermal: gov_power_allocator: Allow binding without trip points")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://patch.msgid.link/20240702-power-allocator-null-trip-max-v1-1-47a60dc55414@collabora.com
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 45f04a25255a..1b2345a697c5 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -759,6 +759,9 @@ static void power_allocator_manage(struct thermal_zone_device *tz)
 		return;
 	}
 
+	if (!params->trip_max)
+		return;
+
 	allocate_power(tz, params->trip_max->temperature);
 	params->update_cdevs = true;
 }


