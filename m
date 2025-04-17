Return-Path: <stable+bounces-132978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD6A91901
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7867B46163A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D438022FE07;
	Thu, 17 Apr 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ug+Ct71H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F2922DFBC
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884900; cv=none; b=dFP6sNY6X9xJHR7lMq5RJht2Qz4I+T865LN8TGMTjaJRBWEOFWbmYACY8jNda4V1lxVHJJAKFkjh6ZamYT8BTQKXg8sZROPZPZ1ZVz4vB0jcjVC5Rnf2N6CAAT/lqOQS4T5VsgCSgCup00+q3jFvh0h/EC7+kAz2yGpzK5ebGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884900; c=relaxed/simple;
	bh=/kyxhl7pdNKqLMCuyw5PRYKGIJvVLzDBy0D97hZNKco=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RvprLaL8tIBC9/MQS0ogYYYJYdDlZMSmsmB7HGOsQ5EdaPmJPEVmPrIFEV3WPEH8T3/cVXEIul/6jr7hy0UWj29V+4GRE/W4br7HKlAlMUw0CwJ9UT9evrdN8n8y/71Nai9z23UEfXejnIqEGyyyBqoLt1x2gyuCQnn9sHGa+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ug+Ct71H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92352C4CEE4;
	Thu, 17 Apr 2025 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884900;
	bh=/kyxhl7pdNKqLMCuyw5PRYKGIJvVLzDBy0D97hZNKco=;
	h=Subject:To:Cc:From:Date:From;
	b=Ug+Ct71HDp/bRJ9jPu+Pcay1S2g4OPo4i+BTYY9zct7pwbtaocDddDkL/agVmJLCm
	 DDRDx4b5Og/fHLfVceprM9fRIBhsveiXasC0WY/yuTWWBsQ6enLBHYaOWCfjgncb+l
	 nGvlQUxbJVUjdeQaZNpmRxDMHJPNcIVTNQqU2/I4=
Subject: FAILED: patch "[PATCH] media: ov08x40: Add missing ov08x40_identify_module() call on" failed to apply to 6.12-stable tree
To: hdegoede@redhat.com,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:14:49 +0200
Message-ID: <2025041749-empty-subscribe-ec60@gregkh>
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
git cherry-pick -x ebf185efadb71bd5344877be683895b6b18d7edf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041749-empty-subscribe-ec60@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


