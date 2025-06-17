Return-Path: <stable+bounces-152870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36A4ADCFCE
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D8C17C7DA
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08272EF64A;
	Tue, 17 Jun 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eG2mp9Ay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915D2EF641
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170191; cv=none; b=Zza+u5Jbyj+KNc/yS5NrceK41KszsXG438uq9tFKLuRb+CZmxVB+Pdfl41ha5h4PQ1H7vUFB2kWBJ1k3hTUMKkUQay26IwolJ02e2YjQOamUbWJWxQm7RRfVpmS2hg84RBVOyStlfMrdrngWbAOcFEMagm0pLGED2dyrb2U+6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170191; c=relaxed/simple;
	bh=YsOJq1Cp26dEREc1AKfVD3SceHcqhswi3GyRL01xDkk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=muDI8L8GEQAQllxACck0W3zYMTHMRKQBhcMZ1ZfDNfC5LJ3ovuZlingits5FzialICE8gf0fxj+ppyKUGL3khFrpR2txjNrQSp6X5FcyZpjE5retfK4g+6lsHKE+c9hNpP+zJdrT9oilZLGGPtw8wAtn9148vxjzni+O13MMbZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eG2mp9Ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990B5C4CEE7;
	Tue, 17 Jun 2025 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750170191;
	bh=YsOJq1Cp26dEREc1AKfVD3SceHcqhswi3GyRL01xDkk=;
	h=Subject:To:Cc:From:Date:From;
	b=eG2mp9AysvTFSZOxMIpRzxG5Dk547b8dr3aQOeDlxwMQhvQV04lSAIm2g8vDTjI/E
	 N0rT2L49nk0vNsgn9oI0nktVDN68jO0CxVCzxd6OySbEFS55fR8o1t4AzrlVvKsrjp
	 vgxezgFMUvVesG97mOS+wybBF1N7yUtt/dP5BDSM=
Subject: FAILED: patch "[PATCH] usb: usbtmc: Fix read_stb function and get_stb ioctl" failed to apply to 5.10-stable tree
To: dpenkler@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 16:23:07 +0200
Message-ID: <2025061707-conceded-outwit-2f2f@gregkh>
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
git cherry-pick -x acb3dac2805d3342ded7dbbd164add32bbfdf21c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061707-conceded-outwit-2f2f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From acb3dac2805d3342ded7dbbd164add32bbfdf21c Mon Sep 17 00:00:00 2001
From: Dave Penkler <dpenkler@gmail.com>
Date: Wed, 21 May 2025 14:16:55 +0200
Subject: [PATCH] usb: usbtmc: Fix read_stb function and get_stb ioctl

The usbtmc488_ioctl_read_stb function relied on a positive return from
usbtmc_get_stb to reset the srq condition in the driver. The
USBTMC_IOCTL_GET_STB case tested for a positive return to return the stb
to the user.

Commit: <cac01bd178d6> ("usb: usbtmc: Fix erroneous get_stb ioctl
error returns") changed the return value of usbtmc_get_stb to 0 on
success instead of returning the value of usb_control_msg which is
positive in the normal case. This change caused the function
usbtmc488_ioctl_read_stb and the USBTMC_IOCTL_GET_STB ioctl to no
longer function correctly.

Change the test in usbtmc488_ioctl_read_stb to test for failure
first and return the failure code immediately.
Change the test for the USBTMC_IOCTL_GET_STB ioctl to test for 0
instead of a positive value.

Fixes: cac01bd178d6 ("usb: usbtmc: Fix erroneous get_stb ioctl error returns")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
Link: https://lore.kernel.org/r/20250521121656.18174-3-dpenkler@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 740d2d2b19fb..08511442a27f 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -563,14 +563,15 @@ static int usbtmc488_ioctl_read_stb(struct usbtmc_file_data *file_data,
 
 	rv = usbtmc_get_stb(file_data, &stb);
 
-	if (rv > 0) {
-		srq_asserted = atomic_xchg(&file_data->srq_asserted,
-					srq_asserted);
-		if (srq_asserted)
-			stb |= 0x40; /* Set RQS bit */
+	if (rv < 0)
+		return rv;
+
+	srq_asserted = atomic_xchg(&file_data->srq_asserted, srq_asserted);
+	if (srq_asserted)
+		stb |= 0x40; /* Set RQS bit */
+
+	rv = put_user(stb, (__u8 __user *)arg);
 
-		rv = put_user(stb, (__u8 __user *)arg);
-	}
 	return rv;
 
 }
@@ -2199,7 +2200,7 @@ static long usbtmc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	case USBTMC_IOCTL_GET_STB:
 		retval = usbtmc_get_stb(file_data, &tmp_byte);
-		if (retval > 0)
+		if (!retval)
 			retval = put_user(tmp_byte, (__u8 __user *)arg);
 		break;
 


