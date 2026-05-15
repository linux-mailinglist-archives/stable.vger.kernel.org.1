Return-Path: <stable+bounces-247420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INujFUzLBmrynwIAu9opvQ
	(envelope-from <stable+bounces-247420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:29:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF27B54A940
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E0EF3096281
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D203E0257;
	Fri, 15 May 2026 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T00NAi+B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1D311942
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829749; cv=none; b=Da8dSF+LSsvTE+eayRhbx+Ypavp8D2LMWnaPNw/blfSjGHB1oJzbacdikdFtowyC7XJ8ITtbcXiiOG/YGQLFe9QVDNALz4LYsdRZo+WwIhCdO3Br9JuAhhK6VARXaklq2RWRb2oZtzsGDusAC19DID12Df06ql6V2yUc/Z047qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829749; c=relaxed/simple;
	bh=kYEGa8wVSKHzU5NXTTkkyfvYajbLh7+Fzlxm2M0Y1bw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AWtwKk/VSN7fgwjpl35zG74UtR8ay+Zsv0x1Kxv1wbIpWaZ79Q6QjVvnqVT3Yj1WxpUI4RBirQR+5/qwe68VfB+qIXmdOh9NYdkZ5WpfR+lfzdjxlgLrNF4LXi7EVyrzZQD2GnrO4T8tBir/WB8c4FhX+4P3Pn69Y5g704gb8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T00NAi+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC42C2BCB8;
	Fri, 15 May 2026 07:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778829748;
	bh=kYEGa8wVSKHzU5NXTTkkyfvYajbLh7+Fzlxm2M0Y1bw=;
	h=Subject:To:Cc:From:Date:From;
	b=T00NAi+BZ9gW+/v3aT8buYXD9lwn6xt6wU15OBcWyHegnNogALt745CcIhEdCaexn
	 R2jgjgGC0HNQCzoRIk44iowrM5EpVFfIvCMUKYpNwwabxpn1PNMZnVdWE//pCSQQnR
	 lGdqkbkkb0p+3VAoDdVf9jafakA6E/HpT3+tbbcE=
Subject: FAILED: patch "[PATCH] media: omap3isp: drop the use count of v4l2 pipeline" failed to apply to 5.10-stable tree
To: lihaoxiang@isrc.iscas.ac.cn,mchehab+huawei@kernel.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:22:29 +0200
Message-ID: <2026051529-footsore-gazing-f5bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF27B54A940
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247420-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,huawei];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,intel.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9da49bd9d4224035cff39b40d7395310abb10201
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051529-footsore-gazing-f5bd@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9da49bd9d4224035cff39b40d7395310abb10201 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Mon, 26 Jan 2026 09:44:12 +0800
Subject: [PATCH] media: omap3isp: drop the use count of v4l2 pipeline

In isp_video_open(), drop the use count of v4l2
pipeline if vb2_queue_init() fails.

Fixes: 8fd390b89cc8 ("media: Split v4l2_pipeline_pm_use into v4l2_pipeline_pm_{get, put}")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/drivers/media/platform/ti/omap3isp/ispvideo.c b/drivers/media/platform/ti/omap3isp/ispvideo.c
index 64e76e3576a8..b946c8087c77 100644
--- a/drivers/media/platform/ti/omap3isp/ispvideo.c
+++ b/drivers/media/platform/ti/omap3isp/ispvideo.c
@@ -1403,6 +1403,7 @@ static int isp_video_open(struct file *file)
 
 	ret = vb2_queue_init(&handle->queue);
 	if (ret < 0) {
+		v4l2_pipeline_pm_put(&video->video.entity);
 		omap3isp_put(video->isp);
 		goto done;
 	}


