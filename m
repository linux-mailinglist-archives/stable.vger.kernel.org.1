Return-Path: <stable+bounces-132979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93617A91905
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689B418954F9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25531D89E4;
	Thu, 17 Apr 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXZzMqSN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09922DFBC
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884903; cv=none; b=eeigzi3iDN8TesfsfT4k1g55yPklAMNe5LUyU7XNmUzWbDA/pLtDxZFIg/mr7r3wAN3rpMIzUm/IsRMRJ8wdA/3XUF7Jx1JPHiADO+dFxMeEyH9MvRTCfcZ4oxZFVGp0ObOdH4fsjLhjG8rHjF1EO1fwAZUuWdNcOa54kAcIBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884903; c=relaxed/simple;
	bh=JLstRiasqsCOrP+jxqnPcNAnWQwLrhJyF45WSCJdntw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JUdEeivS0sXjzJASrWzE95pCYajKYB5JO354mo8pm1Dvqd3hd/jtuthQgse3ZFYpWXAPs747P2rX+qU2nQQ0j/zBclbDwAwI4A2xV/9t994/2gFcSlZCuCVXLzl7exjIPT0RFS3MZAqH4ue5XYRVLkt3ys0yWatI8pFqdxdlBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXZzMqSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD069C4CEE4;
	Thu, 17 Apr 2025 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884903;
	bh=JLstRiasqsCOrP+jxqnPcNAnWQwLrhJyF45WSCJdntw=;
	h=Subject:To:Cc:From:Date:From;
	b=dXZzMqSNnOekEsDd1qMpkLpFhLdJKqtFq7YJFR1sGQH3qxb2KGw0a5uw1yokJPfmz
	 NYN6A5edqm/C9oNt9EnMIS5P0Jk5c9/EvIr0kAq5+J6d6AYrAHow0X7+dQKBK6mOHM
	 8lot6Hb2nw/whgw6LdA9sUR5fWj1nRhEL5toDwb4=
Subject: FAILED: patch "[PATCH] media: ov08x40: Add missing ov08x40_identify_module() call on" failed to apply to 6.13-stable tree
To: hdegoede@redhat.com,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:14:49 +0200
Message-ID: <2025041749-dutiful-periscope-c1aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x ebf185efadb71bd5344877be683895b6b18d7edf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041749-dutiful-periscope-c1aa@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ebf185efadb71bd5344877be683895b6b18d7edf Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 20 Dec 2024 15:41:28 +0100
Subject: [PATCH] media: ov08x40: Add missing ov08x40_identify_module() call on
 stream-start

The driver might skip the ov08x40_identify_module() on probe() based on
the acpi_dev_state_d0() check done in probe().

If the ov08x40_identify_module() call is skipped on probe() it should
be done on the first stream start. Add the missing call.

Note ov08x40_identify_module() will only do something on its first call,
subsequent calls are no-ops.

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Fixes: b1a42fde6e07 ("media: ov08x40: Avoid sensor probing in D0 state")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
index 39430528f54f..7d00740222c1 100644
--- a/drivers/media/i2c/ov08x40.c
+++ b/drivers/media/i2c/ov08x40.c
@@ -1973,6 +1973,10 @@ static int ov08x40_set_stream(struct v4l2_subdev *sd, int enable)
 		if (ret < 0)
 			goto err_unlock;
 
+		ret = ov08x40_identify_module(ov08x);
+		if (ret)
+			goto err_rpm_put;
+
 		/*
 		 * Apply default & customized values
 		 * and then start streaming.


