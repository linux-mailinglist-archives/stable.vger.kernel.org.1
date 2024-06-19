Return-Path: <stable+bounces-53710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9165590E5C3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DF41F21BBA
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1DB79945;
	Wed, 19 Jun 2024 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bGgElyFJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DB5FBB1
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786198; cv=none; b=bj+WNoCRRp8k2NvBRkXVEDjUuZntDPXjuyeh+65u5y9lQIO9trdXmAxFFDzgep9pYH9h9DaDtz6d/poOwsZmcRyJB9ECyvLywYkz8mv05l6b6D8EWP9hWJZ510hbOEbu9pKx0o4gMNUXi+wuCof8jfXB2SuhomDNdmbbYkYF1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786198; c=relaxed/simple;
	bh=EGelt+fHcCiJxUL3yl2Q8jF3fHHP+vf4r8WF2rxCWnU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sGcJ9F0XVwpveyKOAtZalEo1t838nT6ZNPdiQX1p8+j7JQxL5XVsgVarkOsDhAWd6mCQmvefVW1Jsq+1zD1Ozc1SxqasLMFn9meh9eZvVZGAiJlSa9G73k6+dYYb2jh+NqzeQ/3tQL/mWoqyJt/UBZrFMmJFWsAvPC//rkdaqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bGgElyFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF052C2BBFC;
	Wed, 19 Jun 2024 08:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786198;
	bh=EGelt+fHcCiJxUL3yl2Q8jF3fHHP+vf4r8WF2rxCWnU=;
	h=Subject:To:Cc:From:Date:From;
	b=bGgElyFJe/V5cPnQpOkJ6/7c3mTuz2eRrKVTQDuWzdabZzSYYxC429U04Q7D3nA0n
	 WSWIIFvVLBpTD9eJvnvrHq/nf4xbqZJ80OPOgufyK6pCdPC0RJ9w2I5W4hLdt1Y112
	 h/gmKsDOnsXJzQmJxPDehy0E7CpuJVib3sWL1YDE=
Subject: FAILED: patch "[PATCH] drm/ast: Set DDC timeout in milliseconds" failed to apply to 5.10-stable tree
To: tzimmermann@suse.de,airlied@redhat.com,jfalempe@redhat.com,maarten.lankhorst@linux.intel.com,mripard@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:36:25 +0200
Message-ID: <2024061925-devouring-nursing-e427@gregkh>
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
git cherry-pick -x c0cd6925856f661e1a37278660ccae551cef7077
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061925-devouring-nursing-e427@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

c0cd6925856f ("drm/ast: Set DDC timeout in milliseconds")
42f4980da575 ("drm/ast: Rename struct ast_i2c_chan to struct ast_ddc")
0a7f04b433fc ("drm/ast: Move DDC code to ast_ddc.{c,h}")
e14ab3037383 ("drm/ast: Allocate instance of struct ast_i2c_chan with managed helpers")
c0af492c872b ("drm/ast: Remove struct ast_{vga,sil165}_connector")
d66cdb638a49 ("drm/ast: Fail probing if DDC channel could not be initialized")
ed8d84530ab0 ("Merge tag 'i2c-for-6.8-rc1-rebased' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0cd6925856f661e1a37278660ccae551cef7077 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 3 Apr 2024 12:31:28 +0200
Subject: [PATCH] drm/ast: Set DDC timeout in milliseconds

Compute the i2c timeout in jiffies from a value in milliseconds. The
original values of 2 jiffies equals 2 milliseconds if HZ has been
configured to a value of 1000. This corresponds to 2.2 milliseconds
used by most other DRM drivers. Update ast accordingly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 312fec1405dd ("drm: Initial KMS driver for AST (ASpeed Technologies) 2000 series (v2)")
Cc: Dave Airlie <airlied@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.5+
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240403103325.30457-2-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/ast/ast_ddc.c b/drivers/gpu/drm/ast/ast_ddc.c
index b7718084422f..3e156a6b6831 100644
--- a/drivers/gpu/drm/ast/ast_ddc.c
+++ b/drivers/gpu/drm/ast/ast_ddc.c
@@ -153,7 +153,7 @@ struct ast_ddc *ast_ddc_create(struct ast_device *ast)
 
 	bit = &ddc->bit;
 	bit->udelay = 20;
-	bit->timeout = 2;
+	bit->timeout = usecs_to_jiffies(2200);
 	bit->data = ddc;
 	bit->setsda = ast_ddc_algo_bit_data_setsda;
 	bit->setscl = ast_ddc_algo_bit_data_setscl;


