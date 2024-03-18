Return-Path: <stable+bounces-28379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1938187EF4F
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 18:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496091C22323
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2986155C2D;
	Mon, 18 Mar 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="ATWdd76z"
X-Original-To: stable@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035255C07;
	Mon, 18 Mar 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784635; cv=none; b=I8BwmyOhv9Mmhab7ZJBgF+tvGc2GXaxgz4QpOHhJ1EHBu0QPbszth37nDzjIRZLzPdJ8lQl5EUA0DS/dIse3ho2qdbFPEZMzp2P4IqI3Wj0TiVMkJ6Te03DXjqB/D3DVfnsrqZ91KMpWbHGeEV1yQN2nGjBABT2/lRFBK82QAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784635; c=relaxed/simple;
	bh=L2evQN5hchRpmpuD1kDjEc+oowkVG5gjUMnrP7XqBN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJBlYHOvvOzlei5xITCtPamfli0bsZTid7QHoWHM0V6KZFjsrwSscpCE5tA67KXFsBCqks8+Svr1w3ljdlV8S3d40byrFZgtzaIWqapyqN+A6j35oNPHiV4Czx2TD21QwVAzdqIUjYTaBMUSzChPPyOBEAOwSodl/6YgEtcp5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=ATWdd76z; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1710784235;
	bh=L2evQN5hchRpmpuD1kDjEc+oowkVG5gjUMnrP7XqBN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ATWdd76ziQ3MMYtAhOd4HUEDBKBNDBH1IpnmB2NKrKnWSRgdvtzvNTb1WUpzk5VtC
	 tEtXcsaEdxGsvJJKZ/axy7zlpH0oB9WJF6N7WXj+Tu75g4xa4afLoEsL1k4IiikIlg
	 ECL8+rlKTYCgnjYkHEUUlIdahwrOKWZWphqbQ510=
To: dgilbert@interlog.com
Cc: linux-scsi@vger.kernel.org,
	Alexander Wetzel <Alexander@wetzel-home.de>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: sg: Avoid sg device teardown race
Date: Mon, 18 Mar 2024 18:50:21 +0100
Message-ID: <20240318175021.22739-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305150509.23896-1-Alexander@wetzel-home.de>
References: <20240305150509.23896-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sg_remove_sfp_usercontext() must not use sg_device_destroy() after
calling scsi_device_put().

sg_device_destroy() is accessling the device queue. Which will be set to
NULL if scsi_device_put() removes the last reference to the sg device.

Link: https://lore.kernel.org/r/20240305150509.23896-1-Alexander@wetzel-home.de
Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---

This is my best shot for a real fix of the issue.
I confirmed with printk's that I get the NULL pointer freeze ony when
scsi_device_put() is deleting the last reference to the device.
In the cases where it's not crashing there is still a reference left
after the call.

I don't see any obvious down side of simply swapping the calls.
The alternative would by my first patch, just without the WARN_ON.

Alexander
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 86210e4dd0d3..80e0d1981191 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2232,8 +2232,8 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 			"sg_remove_sfp: sfp=0x%p\n", sfp));
 	kfree(sfp);
 
-	scsi_device_put(sdp->device);
 	kref_put(&sdp->d_ref, sg_device_destroy);
+	scsi_device_put(sdp->device);
 	module_put(THIS_MODULE);
 }
 
-- 
2.44.0


