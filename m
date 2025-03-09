Return-Path: <stable+bounces-121575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8BCA58315
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8BB3ABFB4
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13821A3158;
	Sun,  9 Mar 2025 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ocMg/uFC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F119F128
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741516387; cv=none; b=aQputv9+PGXYkapqnVgT/PgbwwUODMj7mh7uUwMocgFAFggRBhtKu26KktNm7PWGclVQfkIHHqnu4ouCTnHQX+5aqXhYSJXM9eGupvP4ZnLp6FuDRvl9F0GSWsO0LGE3XAQI5NePQ9oVimjFCd0EpjF1v32y4I1dAkHFyFgXnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741516387; c=relaxed/simple;
	bh=/aKoDcfU4QdTizTqDE+kNtesD/IU2Y+6Q2ZBi2V8XgA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fVQ5PZM/2OCCuAwqiei2jhZswCbouiJxzbRUNNsb/JaW5YMVkcbOezMldV9yFG5E3hXNb3FrgYoP/8GofibBVUxxLeefpjGZBSmTGlWxthTan0r93j7d7EywDzrqRg2PiV85uyrvdWAZ7DVUMhw7xE6oeJRw9L3SvJwYV80oniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ocMg/uFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DB7C4CEE5;
	Sun,  9 Mar 2025 10:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741516386;
	bh=/aKoDcfU4QdTizTqDE+kNtesD/IU2Y+6Q2ZBi2V8XgA=;
	h=Subject:To:Cc:From:Date:From;
	b=ocMg/uFCtP3VZagDlwMuXLXCFhFmYxMN+X9ZUXByuWJYn3zbjWD9GX8CcBf+ScDxH
	 R9UVNBf7NvNNsN8eZn4QVzU5eCUHvcexvYyK701dgtMyTgPfXvCIgA9SZoEhMUTxr3
	 RivtunsKYJdRIJG8NQlJ6CsuTO66Xwr0Pt02w05w=
Subject: FAILED: patch "[PATCH] drm/i915/mst: update max stream count to match number of" failed to apply to 5.4-stable tree
To: jani.nikula@intel.com,imre.deak@intel.com,rodrigo.vivi@intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 11:31:32 +0100
Message-ID: <2025030932-imbecile-rerun-13a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d1039a3c12fffe501c5379c7eb1372eaab318e0a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030932-imbecile-rerun-13a8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d1039a3c12fffe501c5379c7eb1372eaab318e0a Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 26 Feb 2025 15:56:26 +0200
Subject: [PATCH] drm/i915/mst: update max stream count to match number of
 pipes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We create the stream encoders and attach connectors for each pipe we
have. As the number of pipes has increased, we've failed to update the
topology manager maximum number of payloads to match that. Bump up the
max stream count to match number of pipes, enabling the fourth stream on
platforms that support four pipes.

Cc: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250226135626.1956012-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 15bccbfb78d63a2a621b30caff8b9424160c6c89)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index a65cf97ad12d..86d6185fda50 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1867,7 +1867,8 @@ intel_dp_mst_encoder_init(struct intel_digital_port *dig_port, int conn_base_id)
 	/* create encoders */
 	mst_stream_encoders_create(dig_port);
 	ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, display->drm,
-					   &intel_dp->aux, 16, 3, conn_base_id);
+					   &intel_dp->aux, 16,
+					   INTEL_NUM_PIPES(display), conn_base_id);
 	if (ret) {
 		intel_dp->mst_mgr.cbs = NULL;
 		return ret;


