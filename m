Return-Path: <stable+bounces-181314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83057B93090
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D2E1907A4E
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8C62F0C64;
	Mon, 22 Sep 2025 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tqt85W+0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03A2F0C5C;
	Mon, 22 Sep 2025 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570227; cv=none; b=OzpoyZRFrcjUumM4mztw9pff6Jjuffz9vWuKhETT0Dqv+arr6swPqTc/7/nAE5me1t4BqYxJpApscKsBPJ/yL6W7VstlwgOB6T3rmkA/0A8SE1Arn8DIKlo3TDrLRB2M15cQ8+rnHvaKxGYLvaqcm2AmrjLvXi3Y21jkgAXr7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570227; c=relaxed/simple;
	bh=EK2Ub3BW78SbjX00dZ9laMja90tBZw1eDmAN6fOiTFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUnm9GUzX+MY/41FfvftOv4WPY1nqIzO2Vs5AsYOii1VnXFo3Khl4TCqN2f1YN+ORxQNf7mT28w/9WAQx145svSJ88d9ASwgyvDFPN6JTK55EfRZISlTaH/Ce1JMgNSnQpCnU/9b+QPvoAfjpZGRz6tLcksNPHtQz8XWs7nUjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tqt85W+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9695C4CEF0;
	Mon, 22 Sep 2025 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570227;
	bh=EK2Ub3BW78SbjX00dZ9laMja90tBZw1eDmAN6fOiTFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqt85W+0FKb92GUFFsc2/fAdmjIWZnspkV72bjs3xOUHxdIltmmkncnBvLJfhzk1O
	 VoN53XKH+ZC2zDz8Nxf/2EW50HSYYASBysLXBtnoZZB7bEXhweUSbo2Snd9r45bxXh
	 A6dl6nk7It0IiOW5q4TlBV9RumnMeciqVwExGK3I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.16 056/149] dm-raid: dont set io_min and io_opt for raid1
Date: Mon, 22 Sep 2025 21:29:16 +0200
Message-ID: <20250922192414.288006730@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit a86556264696b797d94238d99d8284d0d34ed960 upstream.

These commands
 modprobe brd rd_size=1048576
 vgcreate vg /dev/ram*
 lvcreate -m4 -L10 -n lv vg
trigger the following warnings:
device-mapper: table: 252:10: adding target device (start sect 0 len 24576) caused an alignment inconsistency
device-mapper: table: 252:10: adding target device (start sect 0 len 24576) caused an alignment inconsistency

The warnings are caused by the fact that io_min is 512 and physical block
size is 4096.

If there's chunk-less raid, such as raid1, io_min shouldn't be set to zero
because it would be raised to 512 and it would trigger the warning.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-raid.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3810,8 +3810,10 @@ static void raid_io_hints(struct dm_targ
 	struct raid_set *rs = ti->private;
 	unsigned int chunk_size_bytes = to_bytes(rs->md.chunk_sectors);
 
-	limits->io_min = chunk_size_bytes;
-	limits->io_opt = chunk_size_bytes * mddev_data_stripes(rs);
+	if (chunk_size_bytes) {
+		limits->io_min = chunk_size_bytes;
+		limits->io_opt = chunk_size_bytes * mddev_data_stripes(rs);
+	}
 }
 
 static void raid_presuspend(struct dm_target *ti)



