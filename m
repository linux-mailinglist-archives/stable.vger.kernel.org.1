Return-Path: <stable+bounces-3768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA1802438
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8091C208FF
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A80F505;
	Sun,  3 Dec 2023 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d9Ej1tou"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF76EAFF
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF65C433C8;
	Sun,  3 Dec 2023 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701610094;
	bh=fTkIgdOktyRBKuC7KJIXlpJCgnRMQTzx+sF+NBS44gc=;
	h=Subject:To:Cc:From:Date:From;
	b=d9Ej1touatz+kETtovs52NwX/yawgeHIHHrwj+IfQ7dw2ISujuJnroEFjWyy9ai1b
	 JY9IQ3kjuL4hO94GMiPsJ3lxAMT+dfNRkH8hgGoR00zYLXFPsgK97+xnwyiWPNGmDU
	 dspaaVo2GJK1JpLli+Aats1u5Jtd/DGWonYvi/Do=
Subject: FAILED: patch "[PATCH] drm/amd/display: Increase num voltage states to 40" failed to apply to 6.6-stable tree
To: alvin.lee2@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,samson.tam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:28:11 +0100
Message-ID: <2023120311-exporter-another-f868@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 67e38874b85b8df7b23d29f78ac3d7ecccd9519d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120311-exporter-another-f868@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

67e38874b85b ("drm/amd/display: Increase num voltage states to 40")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 67e38874b85b8df7b23d29f78ac3d7ecccd9519d Mon Sep 17 00:00:00 2001
From: Alvin Lee <alvin.lee2@amd.com>
Date: Wed, 8 Nov 2023 17:16:28 -0500
Subject: [PATCH] drm/amd/display: Increase num voltage states to 40

[Description]
If during driver init stage there are greater than 20
intermediary voltage states while constructing the SOC
BB we could hit issues because we will index outside of the
clock_limits array and start overwriting data. Increase the
total number of states to 40 to avoid this issue.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
index 2cbdd75429ff..6e669a2c5b2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
@@ -36,7 +36,7 @@
  * Define the maximum amount of states supported by the ASIC. Every ASIC has a
  * specific number of states; this macro defines the maximum number of states.
  */
-#define DC__VOLTAGE_STATES 20
+#define DC__VOLTAGE_STATES 40
 #define DC__NUM_DPP__4 1
 #define DC__NUM_DPP__0_PRESENT 1
 #define DC__NUM_DPP__1_PRESENT 1


