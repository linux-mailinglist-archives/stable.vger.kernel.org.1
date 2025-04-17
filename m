Return-Path: <stable+bounces-132977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A346EA91900
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675D44613B2
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA022F39C;
	Thu, 17 Apr 2025 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pvNLIKpZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0147422FDEB
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884892; cv=none; b=H4DbZ+T4tqbBDl+9i+plc5J5k9fIXFhIa9h8bkCatKf+292fPnb337m1vDz4TrFm8qWxVPSixwIjHToBIy7JGGN15ibNOj2vXVGgkcChCbQwphJ/P4OOcwwTkrYpbvbgv8DHfOVH3zXk5QUZhBLHz0hZlLS27CqoPJ1k3KmSAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884892; c=relaxed/simple;
	bh=9Ist18JTse0kQpqOCJYgCAtBYEjLHDV7TbVCYxrqrjY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lK0IXjros+HsCWmTrZdE4lycsWHXgZkUCf32NJ6sUbYDzOwZHIrf0v55S19qxpe+2/AgETvz1HWx2BxsA1ozP41mC7LbLWcoLK/P8kyxo5KuGNS2Ma4kKqo+TO9WThoqWxk+BaHKylDBJmmjAG/D0KoqS2jzn7QKkI6FgJ7HLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pvNLIKpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3554C4CEE4;
	Thu, 17 Apr 2025 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884891;
	bh=9Ist18JTse0kQpqOCJYgCAtBYEjLHDV7TbVCYxrqrjY=;
	h=Subject:To:Cc:From:Date:From;
	b=pvNLIKpZqbyTGF2AZu+Uu1zQRaWNTVuYeC0jvezwoc1UtAScGu5NjnRQ6glbBahyS
	 zHEQr8YW3tsfyvNsXk11KvKI0Rg0Hh1tazgKXAG4YxAq907BcftxPGoOKGhaoh+6rb
	 Z8eR4AEx69ImyxwNvoNaLkAIZV6LZp+CsFML/zu8=
Subject: FAILED: patch "[PATCH] media: ov08x40: Add missing ov08x40_identify_module() call on" failed to apply to 6.14-stable tree
To: hdegoede@redhat.com,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:14:48 +0200
Message-ID: <2025041748-barricade-unmanaged-b631@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x ebf185efadb71bd5344877be683895b6b18d7edf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041748-barricade-unmanaged-b631@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

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


