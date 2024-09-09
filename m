Return-Path: <stable+bounces-73969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D8B970EB2
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEE7B21078
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033EF1AC8B0;
	Mon,  9 Sep 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFvK/2Cd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC21F95E
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865104; cv=none; b=e8xy4wjWrkZDzqlM1046Mr4WYgMBkY3IdGrpUYIcHe0xhbbCXjptwBC1hpueOuph0OuWmeGL2e1ZNpg9Cy1ejv7krsje5XrfoL1YsbJZCbayCg1eN/5HuzcyeQijKNZTtGlrXLb3u1o7lfepxU7EToTOFThi6dJ2E0zM3HpIhb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865104; c=relaxed/simple;
	bh=Gy2KYjEQEz+PEOmIDkB5lL+8j/CRrj4aPZRXNrgLbYA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aoQ2h13IMz2Z+9+zEWUdfF/Ma5TVqYvAQ6L5qVP4bUO0CfVg6fuHiA6t8zar/c4Dv5ca7kQeeaQclND0wYm4iJbyVo4nUgiYbPy8Q/oly/c9aIDEnIto5kRHpwehpen5THnJOVswP7m++DHKRrXMCEeJr6Dp6VQyPcCAavRLrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFvK/2Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061FDC4CEC5;
	Mon,  9 Sep 2024 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725865104;
	bh=Gy2KYjEQEz+PEOmIDkB5lL+8j/CRrj4aPZRXNrgLbYA=;
	h=Subject:To:Cc:From:Date:From;
	b=bFvK/2CdP5OMbBE7ohuaclQqLuVF5G/9bTeocuXPaM9qMmK1Nf/UuXonNNxTS5mHY
	 phKS+1v8XTLye2rjQZWymzPRqlOXPXrmteKsUFgHmaDDOi2XdA3OcstK7NBzbmxVLK
	 dDsFhKkmebXkTpTeImzxZ5HxAloFn5KoT+h+XLKM=
Subject: FAILED: patch "[PATCH] nvmem: u-boot-env: error if NVMEM device is too small" failed to apply to 6.6-stable tree
To: git@johnthomson.fastmail.com.au,gregkh@linuxfoundation.org,rafal@milecki.pl,srinivas.kandagatla@linaro.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 08:58:21 +0200
Message-ID: <2024090921-cycling-overfed-49be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8679e8b4a1ebdb40c4429e49368d29353e07b601
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090921-cycling-overfed-49be@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

8679e8b4a1eb ("nvmem: u-boot-env: error if NVMEM device is too small")
6bafe07c9306 ("nvmem: u-boot-env: improve coding style")
a832556d23c5 ("nvmem: u-boot-env: use nvmem device helpers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8679e8b4a1ebdb40c4429e49368d29353e07b601 Mon Sep 17 00:00:00 2001
From: John Thomson <git@johnthomson.fastmail.com.au>
Date: Mon, 2 Sep 2024 15:25:08 +0100
Subject: [PATCH] nvmem: u-boot-env: error if NVMEM device is too small
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Verify data size before trying to parse it to avoid reading out of
buffer. This could happen in case of problems at MTD level or invalid DT
bindings.

Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
Cc: stable <stable@kernel.org>
Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
[rmilecki: simplify commit description & rebase]
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20240902142510.71096-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 936e39b20b38..593f0bf4a395 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -176,6 +176,13 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
 		break;
 	}
+
+	if (dev_size < data_offset) {
+		dev_err(dev, "Device too small for u-boot-env\n");
+		err = -EIO;
+		goto err_kfree;
+	}
+
 	crc32_addr = (__le32 *)(buf + crc32_offset);
 	crc32 = le32_to_cpu(*crc32_addr);
 	crc32_data_len = dev_size - crc32_data_offset;


