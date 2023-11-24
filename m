Return-Path: <stable+bounces-783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A27F7C8A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31512B21503
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A0239FDD;
	Fri, 24 Nov 2023 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="flD55XhC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E9C39FD4;
	Fri, 24 Nov 2023 18:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F72C433C7;
	Fri, 24 Nov 2023 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849765;
	bh=RDdsUnznNwLNc/A5S2KTg/qlNJL49Vd6W+xOa6ENrVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flD55XhC99OadHwDul0khIcQsulxhE8W1olr1gstezMhIwDO6PnZ/Ke9cYnacRYKa
	 VGr1tuuWB6bV3njbp/ykJHINfwFx+AAdfVOWKyx44x4XS7DhdN+BtBerG/rxXfshUw
	 dUHjpztthUEFLrNntTV9wnoREWXqYeJFVcP6yxNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.6 312/530] powercap: intel_rapl: Downgrade BIOS locked limits pr_warn() to pr_debug()
Date: Fri, 24 Nov 2023 17:47:58 +0000
Message-ID: <20231124172037.534773437@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit a60ec4485f1c72dfece365cf95e6de82bdd74300 upstream.

Before the refactoring the pr_warn() only triggered when
someone explicitly tried to write to a BIOS locked limit.
After the refactoring the warning is also triggering during
system resume. The user can't do anything about this so
printing scary warnings doesn't make sense

Keep the printk but make it pr_debug() instead of pr_warn()
to make it clear it's not a serious issue.

Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits support")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: 6.5+ <stable@vger.kernel.org> # 6.5+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/powercap/intel_rapl_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -892,7 +892,7 @@ static int rapl_write_pl_data(struct rap
 		return -EINVAL;
 
 	if (rd->rpl[pl].locked) {
-		pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
+		pr_debug("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
 		return -EACCES;
 	}
 



