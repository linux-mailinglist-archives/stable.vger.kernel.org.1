Return-Path: <stable+bounces-139601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A4AA8D3C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A53B4510
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345B419995E;
	Mon,  5 May 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QtKXMBMp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F5176AC8
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430986; cv=none; b=U985mBQ8xMTjd/EEq1/oOMDvDnL1pzQAsd2ZeI8lN91vsXWsYRGXta1h4xHoBGXE8FkXGd6bMh9eadZwkFByCjepzizR8oyYEHO5NdB9vvaH2drfZNtJpu+rDxvJztn7xmkiBLmWgByMAvlV848cLdZGVvxcByWPRfoWgYrkPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430986; c=relaxed/simple;
	bh=aeTD8MbET6jgKesQoiMImsrmfG0a/8Ti0FXX34+FDPw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LabBRnFrt5edDSQVeWRg5/DAjDx8vuMgoHOb+l+Mcj4vPlyBPSWjsPSL0b/MXK50RyVrWZvsy9goUdzasCw5AH2M+m29VizjC+vKZRwgZMMl092Juca6xj0EPmrgxckRuqG+4PArReBpFW47zxc1/7Ah2PBQFRG28FdcamiXssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QtKXMBMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07387C4CEE4;
	Mon,  5 May 2025 07:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746430985;
	bh=aeTD8MbET6jgKesQoiMImsrmfG0a/8Ti0FXX34+FDPw=;
	h=Subject:To:Cc:From:Date:From;
	b=QtKXMBMpi9T85M7Lku5ip+55m5iC31pOxkQSc/hqnmaoDzLbOvcxcZWNRpXJ5PffW
	 SSdT0FDU3hbvWoMfirWsqZ+R5pBg4vX0/xdYo+UBMcZqEkgR9NvJVx/DhIAxX0tgHy
	 RDLaHb7nIiikC8I5JDhEby2ND7i9FK7HAQU9km8I=
Subject: FAILED: patch "[PATCH] iommu/amd: Fix potential buffer overflow in" failed to apply to 5.4-stable tree
To: Pavel.Paklov@cyberprotect.ru,jroedel@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:43:02 +0200
Message-ID: <2025050502-aqueduct-contented-b9f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8dee308e4c01dea48fc104d37f92d5b58c50b96c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050502-aqueduct-contented-b9f9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8dee308e4c01dea48fc104d37f92d5b58c50b96c Mon Sep 17 00:00:00 2001
From: Pavel Paklov <Pavel.Paklov@cyberprotect.ru>
Date: Tue, 25 Mar 2025 09:22:44 +0000
Subject: [PATCH] iommu/amd: Fix potential buffer overflow in
 parse_ivrs_acpihid

There is a string parsing logic error which can lead to an overflow of hid
or uid buffers. Comparing ACPIID_LEN against a total string length doesn't
take into account the lengths of individual hid and uid buffers so the
check is insufficient in some cases. For example if the length of hid
string is 4 and the length of the uid string is 260, the length of str
will be equal to ACPIID_LEN + 1 but uid string will overflow uid buffer
which size is 256.

The same applies to the hid string with length 13 and uid string with
length 250.

Check the length of hid and uid strings separately to prevent
buffer overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ca3bf5d47cec ("iommu/amd: Introduces ivrs_acpihid kernel parameter")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Paklov <Pavel.Paklov@cyberprotect.ru>
Link: https://lore.kernel.org/r/20250325092259.392844-1-Pavel.Paklov@cyberprotect.ru
Signed-off-by: Joerg Roedel <jroedel@suse.de>

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index dd9e26b7b718..14aa0d77df26 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3664,6 +3664,14 @@ static int __init parse_ivrs_acpihid(char *str)
 	while (*uid == '0' && *(uid + 1))
 		uid++;
 
+	if (strlen(hid) >= ACPIHID_HID_LEN) {
+		pr_err("Invalid command line: hid is too long\n");
+		return 1;
+	} else if (strlen(uid) >= ACPIHID_UID_LEN) {
+		pr_err("Invalid command line: uid is too long\n");
+		return 1;
+	}
+
 	i = early_acpihid_map_size++;
 	memcpy(early_acpihid_map[i].hid, hid, strlen(hid));
 	memcpy(early_acpihid_map[i].uid, uid, strlen(uid));


