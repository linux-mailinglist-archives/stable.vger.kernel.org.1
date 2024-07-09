Return-Path: <stable+bounces-58562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A72F92B7A0
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC16FB25209
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1785214F138;
	Tue,  9 Jul 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zONbl3Qe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6CD27713;
	Tue,  9 Jul 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524312; cv=none; b=EQ9sZlKo4te9oN3INYFq9FbKhWwUOs2tw440WJgQXseazRUmUCFOPSS2ZI3JoULEEMLKSMGYyVxppfp5ZpDuRS8Vm8+sNfg3r3VqxSuOv0qhZYtXBsnjI1PvN5NJKkYzoP3mDyyUNxwzUU7pS7v5Pg+1EeiH38MyYKDxNX+JKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524312; c=relaxed/simple;
	bh=1e9XU8Yo1mIailta5e2cD/gezjzqYWOr5ROB4hfHW5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOrdlEmwW3/x7DhF0PFTFeKC6y8a+u5txLcEj4H/QqLeGwmVTU3VoK1nCSf0mnteeOwiIUa1/C/nxvhp+R+4grt+Chw52tPVVIQIxoZTM6Klouk5I/oQnBAqtLAxBQA1fBLE7RN1/8+a07PI16k+H1CmcDW8YU/gOr+oyzP1lDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zONbl3Qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5320EC3277B;
	Tue,  9 Jul 2024 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524312;
	bh=1e9XU8Yo1mIailta5e2cD/gezjzqYWOr5ROB4hfHW5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zONbl3Qe5fxa9VdDnDtbTxsuE2KUh3yDdRLScbCK8clqONd/CbOYSGjHAFHgEdVPZ
	 7WWJOf3zifzSUTmZnM0jrybJnGtakOcRmIRHlATFZmMICid83DkqRuMj8JDI8BlU9Q
	 CtdFNF/ruzPSmJjFofnrTKDVysIkOR4zxXVnavV4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.9 142/197] scsi: mpi3mr: Use proper format specifier in mpi3mr_sas_port_add()
Date: Tue,  9 Jul 2024 13:09:56 +0200
Message-ID: <20240709110714.449324513@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 9f365cb8bbd0162963d6852651d7c9e30adcb7b5 upstream.

When building for a 32-bit platform such as ARM or i386, for which size_t
is unsigned int, there is a warning due to using an unsigned long format
specifier:

  drivers/scsi/mpi3mr/mpi3mr_transport.c:1370:11: error: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Werror,-Wformat]
   1369 |                         ioc_warn(mrioc, "skipping port %u, max allowed value is %lu\n",
        |                                                                                 ~~~
        |                                                                                 %u
   1370 |                             i, sizeof(mr_sas_port->phy_mask) * 8);
        |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the proper format specifier for size_t, %zu, to resolve the warning for
all platforms.

Fixes: 3668651def2c ("scsi: mpi3mr: Sanitise num_phys")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20240514-mpi3mr-fix-wformat-v1-1-f1ad49217e5e@kernel.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpi3mr/mpi3mr_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/mpi3mr/mpi3mr_transport.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_transport.c
@@ -1366,7 +1366,7 @@ static struct mpi3mr_sas_port *mpi3mr_sa
 			continue;
 
 		if (i > sizeof(mr_sas_port->phy_mask) * 8) {
-			ioc_warn(mrioc, "skipping port %u, max allowed value is %lu\n",
+			ioc_warn(mrioc, "skipping port %u, max allowed value is %zu\n",
 			    i, sizeof(mr_sas_port->phy_mask) * 8);
 			goto out_fail;
 		}



