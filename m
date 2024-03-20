Return-Path: <stable+bounces-28468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2780881071
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 12:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25E91C22E1C
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157D63B2BD;
	Wed, 20 Mar 2024 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="QQ/sZ5Xx"
X-Original-To: stable@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DB83B298;
	Wed, 20 Mar 2024 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932927; cv=none; b=mAw7DIKnC9YfWit7yK6sNW+9gPbqmhsIi2UL00mzmND+22m/VAMwc620o1jDeYZs8Zi1KKxHZhbVRJlpwLA9qJ34nANwThIQNJH1XtDnjhMlG2cVWDnPJ8tmv8Yn2ezBwn45KuW+2faXjGdwKCgrovDg/fZqailc56zkzzZq2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932927; c=relaxed/simple;
	bh=/Mf7ayfRptIPYf1l912/MT+uiDe4k/RTJV5IF4l5F5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEt0zNtVs9bXlhBnQ76m7Tej7l4BjFUoZ8hhHDjY77XE4d+z44/G177HOafhYXNwaCWOLBYz0mvEdYyeObYMhGUJcQRCv53JHPF0LDdzRL0T8vSALDDoHQlQkYuwlrebJAlnjATTQ/7RDvKIkz2XoZK8hCYlsvbQ6ekJdTuBzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=QQ/sZ5Xx; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1710932914;
	bh=/Mf7ayfRptIPYf1l912/MT+uiDe4k/RTJV5IF4l5F5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QQ/sZ5XxSexkc6olD8pvqKZbcXusVtWNm0EPZ5q8k3loqGxLngGx6B0e4guPyFmgO
	 h2qgbe+6RO2h4GPnFjSahMhjBFvdePvMwmaFWPlsGvoLi1lu2+srW8lsJP7GrZX/hx
	 9bcZ2X/mj1C0GbLb5Os3v98EKUIEAOd0BHqYNNpc=
To: dgilbert@interlog.com
Cc: linux-scsi@vger.kernel.org,
	Alexander Wetzel <Alexander@wetzel-home.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] scsi: sg: Avoid sg device teardown race
Date: Wed, 20 Mar 2024 12:08:09 +0100
Message-ID: <20240320110809.12901-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318175021.22739-1-Alexander@wetzel-home.de>
References: <20240318175021.22739-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sg_remove_sfp_usercontext() must not use sg_device_destroy() after
calling scsi_device_put().

sg_device_destroy() is accessing the parent scsi device request_queue.
Which will already be set to NULL when the preceding call to
scsi_device_put() removed the last reference to the parent scsi device.

The resulting NULL pointer exception will then crash the kernel.

Link: https://lore.kernel.org/r/20240305150509.23896-1-Alexander@wetzel-home.de
Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
Changes compared to V1:
Reworked the commit message

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


