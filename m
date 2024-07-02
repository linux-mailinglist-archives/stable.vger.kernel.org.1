Return-Path: <stable+bounces-56493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7167B92449D
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B84F1F21A43
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742941BE22F;
	Tue,  2 Jul 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X4NvVtS7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276C15B0FE;
	Tue,  2 Jul 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940367; cv=none; b=kc1//FmKAOq8VxXYk2i1OGc5n2g8BI03qBl2feQkYJeB/yb91NDIV4nMGTdacZQo5tTK0eNikc+SXQQ2iN5EL3UkvB/9XZOylNBL2afbbx85EFOCvgA7eLNVcFUNb78UIIiJZg9czaCRsGheQHDyb+12AxfM6As0Pnv8DpOA0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940367; c=relaxed/simple;
	bh=Q85C1RNF8qnPpICkywZJwXC//Mawe/1uk7QPV5anrjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guRflW8x1YpkF3SgL1rgGndSqX05q1GSLgTIgjgTruHGWV1vg2JEsF5EobRn09yR1mPqBlmOK79feM10pir6h+n8Jhbyua7ebF4pbcf/MWgRCcMDWt+3iNqQSsGwrD7VuRKdO6T37Z/8S+ibS4l5WFS9Yl8qRokdcYyKyh2TgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X4NvVtS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7DBC116B1;
	Tue,  2 Jul 2024 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940367;
	bh=Q85C1RNF8qnPpICkywZJwXC//Mawe/1uk7QPV5anrjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4NvVtS7Qhm7rE0Gc3gsG2nQPbUmSKnVKteXUpmYOraJYE38PbE4fjzv4BBFgVLI8
	 ZkZpn1IoQ5mwNCOuB5zMTpKQGu5MEtri5/NEWrMytqJuETTaYCz4BO8ZufSZZrsoMB
	 4Q9/ubcwo+JuI0AkxbgaP5jyi00fAWYFoJGRUc4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 133/222] i2c: testunit: discard write requests while old command is running
Date: Tue,  2 Jul 2024 19:02:51 +0200
Message-ID: <20240702170249.053011966@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit c116deafd1a5cc1e9739099eb32114e90623209c ]

When clearing registers on new write requests was added, the protection
for currently running commands was missed leading to concurrent access
to the testunit registers. Check the flag beforehand.

Fixes: b39ab96aa894 ("i2c: testunit: add support for block process calls")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-slave-testunit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-slave-testunit.c b/drivers/i2c/i2c-slave-testunit.c
index a5dcbc3c2c141..ca43e98cae1b2 100644
--- a/drivers/i2c/i2c-slave-testunit.c
+++ b/drivers/i2c/i2c-slave-testunit.c
@@ -121,6 +121,9 @@ static int i2c_slave_testunit_slave_cb(struct i2c_client *client,
 		break;
 
 	case I2C_SLAVE_WRITE_REQUESTED:
+		if (test_bit(TU_FLAG_IN_PROCESS, &tu->flags))
+			return -EBUSY;
+
 		memset(tu->regs, 0, TU_NUM_REGS);
 		tu->reg_idx = 0;
 		break;
-- 
2.43.0




