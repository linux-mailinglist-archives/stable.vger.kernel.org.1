Return-Path: <stable+bounces-62430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C382A93F174
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E4D1F232A8
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE351420CC;
	Mon, 29 Jul 2024 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IppkZ/DD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAED1411EB
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246402; cv=none; b=TXi49JLxozc4Ck4thFrFsKbQ42McA7BddhkT95CHAOUl85hdi0mTAE5o2gYv3fMfE3UIMXND94o5/t5cYblB40bNi7D9CovffP8lLHx5v9+27ZzoZiGGhyOEoqQ0pv9B+xkC3icNoB6pBVFIdBQFK8BPrmn8rxJ+Pm5RQslbJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246402; c=relaxed/simple;
	bh=61M1ztHRVqXuZrSqQzRwvQJQaSLinyMhKcZQfaYZjlM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DM5ZqfgQgiT8v7y22zupDqNkSc/uJOBqQobWB6x0IMVAKExli+e3lCT4ddaAxVqEzYURYTTBFI5YFelG0bYMGEzxdaVsjjvmRSW/1KttmuO9GSVippHVbmt/TXEy0EW88dLVyidQ++NfQJxINtrviqX+I10bcqlZOhWkjs65sC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IppkZ/DD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAA4C32786;
	Mon, 29 Jul 2024 09:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722246401;
	bh=61M1ztHRVqXuZrSqQzRwvQJQaSLinyMhKcZQfaYZjlM=;
	h=Subject:To:Cc:From:Date:From;
	b=IppkZ/DDCj5MMrtD/gH57p5ww3o733OIJUk1ZHNyUNxrxHKfTXV6rad+kHUgjYNxp
	 kOc7EDuwAgt+geXqB2BbKEyYpZej4HHh7w2coOZKgqS57V9w8uFYZwiHsQVVu214hO
	 XgJNz7GNS6ZQBwG9JgfJe0PWxTFThp6F1pVVJZ6g=
Subject: FAILED: patch "[PATCH] drm/i915/display: For MTL+ platforms skip mg dp programming" failed to apply to 6.10-stable tree
To: imre.deak@intel.com,gustavo.sousa@intel.com,mika.kahola@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 11:46:38 +0200
Message-ID: <2024072938-rectangle-freckles-e9c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x aaf9dc86bd806458f848c39057d59e5aa652a399
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072938-rectangle-freckles-e9c3@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

aaf9dc86bd80 ("drm/i915/display: For MTL+ platforms skip mg dp programming")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aaf9dc86bd806458f848c39057d59e5aa652a399 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Tue, 25 Jun 2024 14:18:40 +0300
Subject: [PATCH] drm/i915/display: For MTL+ platforms skip mg dp programming

For MTL+ platforms we use PICA chips for Type-C support and
hence mg programming is not needed.

Fixes issue with drm warn of TC port not being in legacy mode.

Cc: stable@vger.kernel.org

Signed-off-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240625111840.597574-1-mika.kahola@intel.com

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index bb13a3ca8c7c..6672fc162c4f 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -2096,6 +2096,9 @@ icl_program_mg_dp_mode(struct intel_digital_port *dig_port,
 	u32 ln0, ln1, pin_assignment;
 	u8 width;
 
+	if (DISPLAY_VER(dev_priv) >= 14)
+		return;
+
 	if (!intel_encoder_is_tc(&dig_port->base) ||
 	    intel_tc_port_in_tbt_alt_mode(dig_port))
 		return;


