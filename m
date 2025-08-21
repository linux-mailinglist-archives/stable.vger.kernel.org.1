Return-Path: <stable+bounces-172152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 553A0B2FCDB
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01F944E5E1B
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE33B1D8DFB;
	Thu, 21 Aug 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNmVDey4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD8F15990C
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786980; cv=none; b=PSEcRv337XC1ZTz3di9l5QwazGUVOpL728zPeF8Uy41O++UgjjAXyV8L+Lvcj1JoXx7+MsW1NVs8ER4i6YECJ1jHsZA0S9y7D4MLZ2uAELQUfaMFy6TooU+TWY4t0LeU3x3o3y4fZDvAc62thDN9t1dP3ZXFwgQYg2piRGinJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786980; c=relaxed/simple;
	bh=LUH52tmXzyetDNdjA9dXsrHBKSYfhAn6pJ+emQAhEto=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KgucorkHd4CW7BNojqtB/NPOM8OOCUASnKY8Al2Arg/M0s4TiUrCto10RS9oc8424McxxZVdPBX02k2cIIbKaYlbokW6LjaGC/clSnqimUCx+BQUIiCJ4e1i168sh6Muu0wu2pCjLe+19ZLtlD3dcqKV61AGyLHBdbYcjg39ik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNmVDey4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DBEC4CEED;
	Thu, 21 Aug 2025 14:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786980;
	bh=LUH52tmXzyetDNdjA9dXsrHBKSYfhAn6pJ+emQAhEto=;
	h=Subject:To:Cc:From:Date:From;
	b=cNmVDey4B4U23ER3vLHYkDgdEg+m6QxzqWPG0TqikEkTklC2MAIOHBIDsiua/Olz2
	 DHV3fw0wcNk+hIbu2mB41BDEmlXqlk2rYFeRWIl8Locfvb+tSAEdSjTOhgg8cmsKxT
	 BmcpzibD0k6Xn+vlWYcHMS3Q89JBICCg0kjBv7Ew=
Subject: FAILED: patch "[PATCH] drm/dp: Change AUX DPCD probe address from DPCD_REV to" failed to apply to 5.15-stable tree
To: imre.deak@intel.com,jani.nikula@intel.com,jani.nikula@linux.intel.com,stable@vger.kernel.org,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:35:51 +0200
Message-ID: <2025082151-chase-quilt-9ad4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a40c5d727b8111b5db424a1e43e14a1dcce1e77f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082151-chase-quilt-9ad4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


