Return-Path: <stable+bounces-74061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC5C971FB6
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844C31F23D64
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3F16DEA2;
	Mon,  9 Sep 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uMEHw0Iy"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7BD7494
	for <Stable@vger.kernel.org>; Mon,  9 Sep 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901150; cv=none; b=bypda6766cI5IkWXT7ztfuzyG2HGWNOOvAgDXe95krfgwWCUwTd6gx6jylHDczRI+krhlhJHnHC6dy4DljthFSxYsLd1AgK2sYWWHlWKnyC+gFtewb+setLf3GH+I9fTJge9++d9KbKMFZbaLtClC1CxcJryeCQdQfYGmgKP0Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901150; c=relaxed/simple;
	bh=wwdSeq9//Dvl9vb//HFuouN9+pShsNz48o5Rnlpwy5g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hfJ7s4k8i8OxopTgSU3FPJR96xomzDwGvt/sCZrovzn6ZI5owj4opRNmaCZPBqHU+a46RWEBLBEkLLk0CKaHrcnOjV7h4yL9sSwfbIbZd+dkyIerQZFchKS2hejsvNSEuZXGH4VsspIyegEHuNAr/bkUwL5hiPVxK1aE1peyzN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uMEHw0Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165B5C4CEC7;
	Mon,  9 Sep 2024 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725901150;
	bh=wwdSeq9//Dvl9vb//HFuouN9+pShsNz48o5Rnlpwy5g=;
	h=Subject:To:Cc:From:Date:From;
	b=uMEHw0Iy6f7MSzt3tjS3LtYij/RgguJqPJjOnKY6nqGd9qnXJ8DbeCPcoSw2kSawA
	 aTqySSXwO2687th+FRZpcK4WOR+uf8xuGsnhQmWWD975ODuGXP4vaAYdEwnbabwe9o
	 Au07/SRk2HoV5h+QiLhsRX7EMdErQ263emusJjuk=
Subject: FAILED: patch "[PATCH] iio: adc: ad7124: fix chip ID mismatch" failed to apply to 5.4-stable tree
To: mitrutzceclan@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dumitru.ceclan@analog.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 18:59:07 +0200
Message-ID: <2024090907-pancreas-remodeler-f80d@gregkh>
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
git cherry-pick -x 96f9ab0d5933c1c00142dd052f259fce0bc3ced2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090907-pancreas-remodeler-f80d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

96f9ab0d5933 ("iio: adc: ad7124: fix chip ID mismatch")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 96f9ab0d5933c1c00142dd052f259fce0bc3ced2 Mon Sep 17 00:00:00 2001
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
Date: Wed, 31 Jul 2024 15:37:22 +0300
Subject: [PATCH] iio: adc: ad7124: fix chip ID mismatch

The ad7124_soft_reset() function has the assumption that the chip will
assert the "power-on reset" bit in the STATUS register after a software
reset without any delay. The POR bit =0 is used to check if the chip
initialization is done.

A chip ID mismatch probe error appears intermittently when the probe
continues too soon and the ID register does not contain the expected
value.

Fix by adding a 200us delay after the software reset command is issued.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20240731-ad7124-fix-v1-1-46a76aa4b9be@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 3beed78496c5..c0b82f64c976 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -764,6 +764,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	if (ret < 0)
 		return ret;
 
+	fsleep(200);
 	timeout = 100;
 	do {
 		ret = ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);


