Return-Path: <stable+bounces-143240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B11EAB34C4
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF52E189E31A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E0426137F;
	Mon, 12 May 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Mb1NHEG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4A255247
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045246; cv=none; b=mZEo1/SgXNyRQaaOoi+l8bIDzve4mqfwCfUIeW5hii9OczpJfwDr+o17CF6obQFkXgLL+9Q7L/QrZw6inQbm8zQ6yWizYi48gxYlFarTSvXLXIBTkfPdDejEaFeLyf08ojOKnz9THwpawExXhBiQIfg2Y/XwXqCHMyuq8Qs80Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045246; c=relaxed/simple;
	bh=hqzAqdALPzJqvwmR1D0brhug/nDcrcPDUK1Z9qTCLJk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MEZaQsgxM9QBXMT29cevfOIDr6RobkGD66pyyhqtRPLW7lC9URNld2pH7QI0u8A82GOga7fwZZaNC/w0pQRNO3QSvSD424/HyaDLu9SNPlnft8QXqNKx0DLrLZBs/2b4W/WGUHEnbGDFoFdPCEsSCsSgSM7czeOK+BSZArM0rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Mb1NHEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66C7C4CEE7;
	Mon, 12 May 2025 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747045243;
	bh=hqzAqdALPzJqvwmR1D0brhug/nDcrcPDUK1Z9qTCLJk=;
	h=Subject:To:Cc:From:Date:From;
	b=1Mb1NHEG+5Xxj+IHpRLtXDE4JBzkxyMymeGXxZ7+vL9+wxU2CZLYBPKlnhGDZKY3T
	 gR+atowy3JeBySyH+Q/F+igR1BKN4Tgkt1MMnaHH2oXriqNmum1RoLn2I/y3+G3ic5
	 3iotxrN16IpvlQPG4Acij5L/A9vpOtXC/PYfYzAA=
Subject: FAILED: patch "[PATCH] iio: hid-sensor-prox: Restore lost scale assignments" failed to apply to 5.15-stable tree
To: lixu.zhang@intel.com,Jonathan.Cameron@huawei.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:20:30 +0200
Message-ID: <2025051230-unfold-exonerate-3e6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 83ded7cfaccccd2f4041769c313b58b4c9e265ad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051230-unfold-exonerate-3e6d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83ded7cfaccccd2f4041769c313b58b4c9e265ad Mon Sep 17 00:00:00 2001
From: Zhang Lixu <lixu.zhang@intel.com>
Date: Mon, 31 Mar 2025 13:50:20 +0800
Subject: [PATCH] iio: hid-sensor-prox: Restore lost scale assignments

The variables `scale_pre_decml`, `scale_post_decml`, and `scale_precision`
were assigned in commit d68c592e02f6 ("iio: hid-sensor-prox: Fix scale not
correct issue"), but due to a merge conflict in
commit 9c15db92a8e5 ("Merge tag 'iio-for-5.13a' of
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next"),
these assignments were lost.

Add back lost assignments and replace `st->prox_attr` with
`st->prox_attr[0]` because commit 596ef5cf654b ("iio: hid-sensor-prox: Add
support for more channels") changed `prox_attr` to an array.

Cc: stable@vger.kernel.org # 5.13+
Fixes: 9c15db92a8e5 ("Merge tag 'iio-for-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20250331055022.1149736-2-lixu.zhang@intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 76b76d12b388..1dc6fb7cf614 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -257,6 +257,11 @@ static int prox_parse_report(struct platform_device *pdev,
 
 	st->num_channels = index;
 
+	st->scale_precision = hid_sensor_format_scale(hsdev->usage,
+						      &st->prox_attr[0],
+						      &st->scale_pre_decml,
+						      &st->scale_post_decml);
+
 	return 0;
 }
 


