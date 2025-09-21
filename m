Return-Path: <stable+bounces-180819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D037FB8DFB0
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 18:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6013BED32
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D37C23ABB6;
	Sun, 21 Sep 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="j9eLME9Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TqM51bi2"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0113249E5;
	Sun, 21 Sep 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472155; cv=none; b=gs+tQQguZImNe1RPZuKdP65b7gDIBUQW0IF+6yVwgw5tH9iL0his2TwfOMNA3O3n2FFjWU36EsP4jHyIDgkroCu1ie2qr6vr9/c6zEw+3+uxFazOQlOPf1A6SmfPFi2fCKVDbJPk/zrmy6VoQ3CkhPgDy6HMHVkBnK1GUa8SQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472155; c=relaxed/simple;
	bh=iuDUp1tb6aupbRwQK0GfuVyzN8+SslVdwHtjchfinB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W5J38WZVGbcRXAI0KTvlwjrbfVinrGmG4ZX9BqNexWpo6J5EI45rwHjbITeRHjc/L4TUc2j2eMd2o8ZQB50AjVcqybgPYcRrIDPJiQbjPkJNPJgpqKGDSCJ+3Fe36zCfW9m5GdCG4ZDgzkZuqjfLiQdEKs71RNH6StZhu3ISXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=j9eLME9Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TqM51bi2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A24587A0011;
	Sun, 21 Sep 2025 12:29:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 21 Sep 2025 12:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1758472152; x=1758558552; bh=WdNTOPpdVrK9P8u9jRJTdDiUUMVvKBOw
	ULXLYZcXJu8=; b=j9eLME9Y7nWi0s1EHw0wfRabUNFi8aulnOQorjWbbstzDf8q
	4+x8BzOSRKzmy9nCwrYh0a7oD92muzWkR0TPph3Lb0Vmi4++L9b9YQz+sOM5vK+D
	f+YD18dO80EBPkdTTShynrOTpfTRmTlO9NI6MHjfCafvxaRQBvQngxyNZru7vBvI
	PLQSP0cHnPCEq5Vulv+rkOa+SNWrRVX6b81YMI3Fa71OJxHunnpYDs6DvpVqILZ/
	zXDNsZ2OOl991uQG7wmI46nfwZnUYTAPnPvs79fmvPOyCsreZIhf9lueuR4QvLYr
	o44f1RSn55c410K5kWHNmt2Jpbi0XGasIPzzIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758472152; x=1758558552; bh=WdNTOPpdVrK9P8u9jRJTdDiUUMVv
	KBOwULXLYZcXJu8=; b=TqM51bi2IKXztUWG4FcVpjVAHDKS4JfekjWKnsyOdJ6B
	1JkGpLGDuYqGBp1QYDtjzXM6aNKdrn/2hRFYtlKLhkrVX6MnPhQLbmy/kS3/fc39
	koabU7ZymSeb3WfMUbkL/8FRvqt2OMfTgfJGNj1+Bd6EBdjvEEQy70FwoyDH/VYO
	+6Q6DL3UbLhYEMd2KGrQELuQTwNW7PwsnsmIdHLw6Cp+CR1qt/vCfHEhSrHC83nc
	MJUH+xz8Nepmb7Ak5uI35ip6eIukTPO9XHE8L8YvDJz5LnaDm+OMrGAm08dSSIvL
	eu4+Kww0Cjqy/4E2g3QIbBtYnuP1cAZnXGIJJqMByg==
X-ME-Sender: <xms:2CfQaHaLncbhGF1yYBKzqVtCdsgCXN3f2yvlxjvFq68BS7sM0SLpvA>
    <xme:2CfQaC9M9Hg_KXxF3Asr4BH0NJ-glvd6ieB8QTifaXIKCEGjUWDwwldykHnUCnM-I
    bYRYOYsW5cigw>
X-ME-Received: <xmr:2CfQaObicG33mKIb4jNBgW1oRob_2rJB3TF3ZHtvdFsoKCtVXtEF1Q7mTCBTi9Hm1zYFsv85FB_WByzQhDoYHole0x7BrTZW7zQPREAm4tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehheeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepofgrrhgvkhcuofgr
    rhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvihhsih
    gslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepkeekieevkeeu
    heefgeevjeevveeutdejieevgeeuhfdvffeuteeftdduvdeuteevnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrd
    gtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhr
    tghpthhtohepjhhgrhhoshhssehsuhhsvgdrtghomhdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsshhtrggsvghllhhinhhi
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopeholhgvkhhsrghnughrpghthihshhgthh
    gvnhhkohesvghprghmrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlrdhjrdifhihsohgt
    khhisehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlh
    hlohesrghmugdrtghomhdprhgtphhtthhopeigvghnqdguvghvvghlsehlihhsthhsrdig
    vghnphhrohhjvggtthdrohhrgh
X-ME-Proxy: <xmx:2CfQaEdBaNUM9KhKyyhy5jtU73qmJzvaTgr4ILJbj2MTKm8PVHeeqA>
    <xmx:2CfQaDltm6NZYqbMkoiLA5RCv_jGu9u9toeaJfeggaeQEnaX3QLJVQ>
    <xmx:2CfQaM0u3USCnbFzj_mYcRFpUWPgzhHPzLw1LYrLuMqb7C-EJtFvQg>
    <xmx:2CfQaEeE9Yh98U3EFLUcSGNRlokX5uOha2QTNjoFL-QS2m1o0lAlLw>
    <xmx:2CfQaENqCA9253hZxtRn2UEjSXEHf_VPMs9NXuGelV5UeHSIj5CD-PMo>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Sep 2025 12:29:10 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	=?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>,
	stable@vger.kernel.org,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR INTERFACE)
Subject: [PATCH] xen: take system_transition_mutex on suspend
Date: Sun, 21 Sep 2025 18:28:47 +0200
Message-ID: <20250921162853.223116-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Xen's do_suspend() calls dpm_suspend_start() without taking required
system_transition_mutex. Since 12ffc3b1513eb moved the
pm_restrict_gfp_mask() call, not taking that mutex results in a WARN.

Take the mutex in do_suspend(), and use mutex_trylock() to follow
how enter_state() does this.

Suggested-by: Jürgen Groß <jgross@suse.com>
Fixes: 12ffc3b1513eb "PM: Restrict swap use to later in the suspend sequence"
Link: https://lore.kernel.org/xen-devel/aKiBJeqsYx_4Top5@mail-itl/
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Cc: stable@vger.kernel.org # v6.16+
---
 drivers/xen/manage.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index b4b4ebed68daf..f78d970949c0a 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -11,6 +11,7 @@
 #include <linux/reboot.h>
 #include <linux/sysrq.h>
 #include <linux/stop_machine.h>
+#include <linux/suspend.h>
 #include <linux/freezer.h>
 #include <linux/syscore_ops.h>
 #include <linux/export.h>
@@ -101,10 +102,16 @@ static void do_suspend(void)
 
 	shutting_down = SHUTDOWN_SUSPEND;
 
+	if (!mutex_trylock(&system_transition_mutex))
+	{
+		pr_err("%s: failed to take system_transition_mutex\n", __func__);
+		goto out;
+	}
+
 	err = freeze_processes();
 	if (err) {
 		pr_err("%s: freeze processes failed %d\n", __func__, err);
-		goto out;
+		goto out_unlock;
 	}
 
 	err = freeze_kernel_threads();
@@ -160,6 +167,8 @@ static void do_suspend(void)
 
 out_thaw:
 	thaw_processes();
+out_unlock:
+	mutex_unlock(&system_transition_mutex);
 out:
 	shutting_down = SHUTDOWN_INVALID;
 }
-- 
2.51.0


