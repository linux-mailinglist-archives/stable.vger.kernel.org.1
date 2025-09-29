Return-Path: <stable+bounces-181894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA0BA916B
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351773BD9BD
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC11A9FBD;
	Mon, 29 Sep 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SckUvXuM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B693016EE
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146212; cv=none; b=Xm7/Eaj/cHGxcUtGAZWfHkZ1ZqPfEF9pB5JHDriDTJvBpjRTQf+wuZk0OuLRxjKdKL+otHihLhonoKhTb30qweqfS/DjLs/MSR9I3/qT9ytjO1Qn5xJxFDz3PL+tjrwDOOuMGF2u52O6YNYzkxzcCv32XOr1q4S74RzgtpaS6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146212; c=relaxed/simple;
	bh=BMMk7UPM5jDD4Nc6fOBYtIWFGIXYtWOSpwQIH+tHvb8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EdwpBb3vMhBENBHIHoPo+PQqKUHurBa3m7Bbo+WTva6LvfmiU2YWhv4sVDnoXesc4E8Gy1i4rsINkytzQ+NMEco1CQAFKXBDcZ0FhMmkaJQ2TS0edOrG3vjth/k0LONVa/grM3C1H9J2peIidSGDl54cLckgT7SK7FwL+OCepFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SckUvXuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27CFC4CEF7;
	Mon, 29 Sep 2025 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759146212;
	bh=BMMk7UPM5jDD4Nc6fOBYtIWFGIXYtWOSpwQIH+tHvb8=;
	h=Subject:To:Cc:From:Date:From;
	b=SckUvXuMR8Zk66Ay4OLg1FUkuO4OnmSmhHpn9V2NX4JT6JKkxR8BLCP45nI6Zee9C
	 tADOqJCPpB2W0uDqD7KEO3pD8xjiZbxjTW4UgGnizWRAn5vdKPhhSdShYvU5aWJ+0z
	 sre2XY31Z7JtgzSi66elXqiYi5TUg3PiVvQF+ryA=
Subject: FAILED: patch "[PATCH] drm/ast: Use msleep instead of mdelay for edid read" failed to apply to 6.1-stable tree
To: nirmoyd@nvidia.com, airlied@redhat.com, jfalempe@redhat.com,
	kuohsiang_chou@aspeedtech.com, "mailto:csoto"@nvidia.com,
	stable@vger.kernel.org, tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 13:43:21 +0200
Message-ID: <2025092921-consensus-mystified-6396@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c7c31f8dc54aa3c9b2c994b5f1ff7e740a654e97
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092921-consensus-mystified-6396@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c7c31f8dc54aa3c9b2c994b5f1ff7e740a654e97 Mon Sep 17 00:00:00 2001
From: Nirmoy Das <nirmoyd@nvidia.com>
Date: Wed, 17 Sep 2025 12:43:46 -0700
Subject: [PATCH] drm/ast: Use msleep instead of mdelay for edid read

The busy-waiting in `mdelay()` can cause CPU stalls and kernel timeouts
during boot.

Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Carol L Soto csoto@nvidia.com<mailto:csoto@nvidia.com>
Fixes: 594e9c04b586 ("drm/ast: Create the driver for ASPEED proprietory Display-Port")
Cc: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.19+
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/r/20250917194346.2905522-1-nirmoyd@nvidia.com

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 19c04687b0fe..8e650a02c528 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -134,7 +134,7 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
 			 * 3. The Delays are often longer a lot when system resume from S3/S4.
 			 */
 			if (j)
-				mdelay(j + 1);
+				msleep(j + 1);
 
 			/* Wait for EDID offset to show up in mirror register */
 			vgacrd7 = ast_get_index_reg(ast, AST_IO_VGACRI, 0xd7);


