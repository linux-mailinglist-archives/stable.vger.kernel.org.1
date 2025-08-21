Return-Path: <stable+bounces-172150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C894B2FD62
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3EC640497
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33D823A99D;
	Thu, 21 Aug 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qGqjwzf1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C41D8DFB
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786974; cv=none; b=WsTxgoizYRTwdmYAbPrrQU59OCek0UlQIfmF3o1WfI49FsR9A4PdbTgmV6/7vpv6g01T/q9Z+eQxUJqC8OpW5aejMCp8CHtunSEzY94SnYLfAXPt9ia5/6Ss2UOOgKvXfyXR8Is7R7hwBI7wKZHwFK0952jzYnsZZd7LCqG5IYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786974; c=relaxed/simple;
	bh=GtOscNPEpkFygA8DMcr9ibzyT7RJhSTPcTG5jqXsWOA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PTyG64TKJTVh8hZP6q5gvveXOKuW5CfsOwbKurysGU5cQmYouAA/Z2ndN6c1w2pJDtT8QicCkhlgXMwPAGA6PxOGTdHKLDgEzamGinAY78wcXGdG0+HC70phwqHvCkV/mAwFskuBlUO7ieE5vOupTrA/tLPRCXg78DrmbCHvHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qGqjwzf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E090C4CEEB;
	Thu, 21 Aug 2025 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786974;
	bh=GtOscNPEpkFygA8DMcr9ibzyT7RJhSTPcTG5jqXsWOA=;
	h=Subject:To:Cc:From:Date:From;
	b=qGqjwzf1It1IXQGett+RkNRryCF3PjZG6wS6tFuU5/JJSEqNI6vPFPmsCsAF/ks+h
	 0t7JwdgiSUnL06v1E6F+vaE9Y1Xn4N6flRBQ8Qy1N59REsJ+j0MImwQY1nSmlUNvGV
	 WMDnWi6Uv4ay5uNOeTsWBFoxHMtB2bMi4EZRxMFw=
Subject: FAILED: patch "[PATCH] drm/dp: Change AUX DPCD probe address from DPCD_REV to" failed to apply to 6.1-stable tree
To: imre.deak@intel.com,jani.nikula@intel.com,jani.nikula@linux.intel.com,stable@vger.kernel.org,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:35:50 +0200
Message-ID: <2025082150-fiddle-impure-4da2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a40c5d727b8111b5db424a1e43e14a1dcce1e77f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082150-fiddle-impure-4da2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a40c5d727b8111b5db424a1e43e14a1dcce1e77f Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Thu, 5 Jun 2025 11:28:46 +0300
Subject: [PATCH] drm/dp: Change AUX DPCD probe address from DPCD_REV to
 LANE0_1_STATUS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reading DPCD registers has side-effects in general. In particular
accessing registers outside of the link training register range
(0x102-0x106, 0x202-0x207, 0x200c-0x200f, 0x2216) is explicitly
forbidden by the DP v2.1 Standard, see

3.6.5.1 DPTX AUX Transaction Handling Mandates
3.6.7.4 128b/132b DP Link Layer LTTPR Link Training Mandates

Based on my tests, accessing the DPCD_REV register during the link
training of an UHBR TBT DP tunnel sink leads to link training failures.

Solve the above by using the DP_LANE0_1_STATUS (0x202) register for the
DPCD register access quirk.

Cc: <stable@vger.kernel.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250605082850.65136-2-imre.deak@intel.com

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index f2a6559a2710..dc622c78db9d 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -725,7 +725,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_probe(aux, DP_DPCD_REV);
+		ret = drm_dp_dpcd_probe(aux, DP_LANE0_1_STATUS);
 		if (ret < 0)
 			return ret;
 	}


