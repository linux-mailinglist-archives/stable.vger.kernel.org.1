Return-Path: <stable+bounces-165260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0FB15C3E
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6D817A224
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1795C26CE18;
	Wed, 30 Jul 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UUr1DUnY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20C20E6;
	Wed, 30 Jul 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868428; cv=none; b=Qi1ThhT98i0ME2+PqdtvzeMOLTzlHr//paV+x9jmNdoYSzC3Ydn9k0aupq4kTGYHc+CgKFz3CyvA1qoKGAbIFqjDKj3F6PDoSwDB7GouBx6dW2j3jdnzJxJEeT4lyWWKQlfoxFlu2Dr1hJrk53BkQjDJlQy8T8TzBQp6Nc+GrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868428; c=relaxed/simple;
	bh=sJUb7jPLHZJINm1FicvBIKL+lU9Yr4EF+/DaijClnLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMVPFmxUlFmdpfeGfEcq+epX4Gu5je8UVcyMx53R512o2SoBcdMeT0p76LJSimoQQnkO5SK9/1NCo8kBXgJ74MLiQb4yN/quUXy47WwTlgXvj7Sf4cdyCdJyPAkbhqx8iCL8t0tQO1/A2SuyWKeD6KRbP6dcT7VIIH//b4ijTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UUr1DUnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F510C4CEF5;
	Wed, 30 Jul 2025 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868428;
	bh=sJUb7jPLHZJINm1FicvBIKL+lU9Yr4EF+/DaijClnLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUr1DUnYAV0JIyUoJrEENlmQuNZH4UfElA/8G9BL7x9G3n59CNTpfyDH+s4ge1DSB
	 RWURxmgPzZhStpFOzyeZ8zuazfs4vY26IZHWHA1GQWWOb5O6J3uv5QErw6KKLkpkJN
	 e02o0mRYy+L18Fv/Se9Uk8K0Di2Z6JZaKxi8WPwo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Xiwen <forbidden405@outlook.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 6.6 29/76] i2c: qup: jump out of the loop in case of timeout
Date: Wed, 30 Jul 2025 11:35:22 +0200
Message-ID: <20250730093227.971041407@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Xiwen <forbidden405@outlook.com>

commit a7982a14b3012527a9583d12525cd0dc9f8d8934 upstream.

Original logic only sets the return value but doesn't jump out of the
loop if the bus is kept active by a client. This is not expected. A
malicious or buggy i2c client can hang the kernel in this case and
should be avoided. This is observed during a long time test with a
PCA953x GPIO extender.

Fix it by changing the logic to not only sets the return value, but also
jumps out of the loop and return to the caller with -ETIMEDOUT.

Fixes: fbfab1ab0658 ("i2c: qup: reorganization of driver code to remove polling for qup v1")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
Cc: <stable@vger.kernel.org> # v4.17+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20250616-qca-i2c-v1-1-2a8d37ee0a30@outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-qup.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -452,8 +452,10 @@ static int qup_i2c_bus_active(struct qup
 		if (!(status & I2C_STATUS_BUS_ACTIVE))
 			break;
 
-		if (time_after(jiffies, timeout))
+		if (time_after(jiffies, timeout)) {
 			ret = -ETIMEDOUT;
+			break;
+		}
 
 		usleep_range(len, len * 2);
 	}



