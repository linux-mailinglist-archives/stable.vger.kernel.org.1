Return-Path: <stable+bounces-131245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E55A808C1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3300C4C7C6D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D9B26FA57;
	Tue,  8 Apr 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VdQR/wL4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE6C269882;
	Tue,  8 Apr 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115876; cv=none; b=dIR+dIVThV6IHXrUr0TgtdGmLRexRp33WYdw3W7ePxULCDo3GS/zWwpxMsvnv7Ajit5IuBaY3Fne9NQivIuDM1o8zRqjUxPp1v4DqZxY8JUbXc4fLzgFC1ranitiSeVroG0MheEI7KP6GFNCBD1k1Rzr/PbbI/rj5zZCULvTeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115876; c=relaxed/simple;
	bh=bc1WiDrg3QT+isVk8e4Zx3muIybg2W6paJ3Vw43kp7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5rk4xHKVvRwjH1cesxrWYy1Ls3qLIissxSUCpv4xKsFffn7DpiWEZD0Puyl1NbSwHzVLztzj0YBwrvqvZqjMZ28i7PYfTeBn2nCXWPG4I7C8wO2TA7YbG2x//+7rLyEl0VCpmGyNYc1B0KCeq5EmKtWqFR8vVznrbTxF9WTZlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VdQR/wL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF1FC4CEE5;
	Tue,  8 Apr 2025 12:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115876;
	bh=bc1WiDrg3QT+isVk8e4Zx3muIybg2W6paJ3Vw43kp7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VdQR/wL4s6EI53XIB1gnuF3wSW5u+JPWhBxMhVmaMrALDOHas42Z1SW1RLVAwi22m
	 mUiuuZ+qA65X9xdkfyT3RAnBI7UIi7HForm/1AJmmT1QbAv9JPU3aUKNDZjUthc8Fv
	 svasWJpPQDYCiCqObNarIY/ENGKtb3LdBxG67mSw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Guan <guanwentao@uniontech.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 137/204] HID: i2c-hid: improve i2c_hid_get_report error message
Date: Tue,  8 Apr 2025 12:51:07 +0200
Message-ID: <20250408104824.318058490@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit 723aa55c08c9d1e0734e39a815fd41272eac8269 ]

We have two places to print "failed to set a report to ...",
use "get a report from" instead of "set a report to", it makes
people who knows less about the module to know where the error
happened.

Before:
i2c_hid_acpi i2c-FTSC1000:00: failed to set a report to device: -11

After:
i2c_hid_acpi i2c-FTSC1000:00: failed to get a report from device: -11

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 0b05bb1e4410e..8a7ac016b1abe 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -261,7 +261,7 @@ static int i2c_hid_get_report(struct i2c_hid *ihid,
 			     ihid->rawbuf, recv_len + sizeof(__le16));
 	if (error) {
 		dev_err(&ihid->client->dev,
-			"failed to set a report to device: %d\n", error);
+			"failed to get a report from device: %d\n", error);
 		return error;
 	}
 
-- 
2.39.5




