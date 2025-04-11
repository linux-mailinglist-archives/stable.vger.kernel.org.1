Return-Path: <stable+bounces-132191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C6A850FD
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 03:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A27189E43F
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 01:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F774270EB4;
	Fri, 11 Apr 2025 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XqOdX6U3"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03462147E6;
	Fri, 11 Apr 2025 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333753; cv=none; b=rHp7M/mEOWhRFir/r/oT9h+HdQ/IMEcKSisycz/qMmmrgoVdSvKJrXR/ui/C3p9D6RF4xR4YW+Mz604elrgeSuez/bnT+d/WuF5ZZ0+2a9fi4D2ttuLlRXr1IcbKQtDcvX1zcWquQNerwjUXJJGSlH0aOjMDCC6KQnVsRJf/3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333753; c=relaxed/simple;
	bh=zZLrOshl7jtZigXcVzuG4B997DqzO0hNq3/wxtw6lag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B5AzL7TroAvWew0QS6Hq96HDjldpC9+PWKjnM1UnT4Hz0BY/H7hnaIqf/lYzJN1nXDiYpFYtde6RcSiNp1qE3HvWZSWV0LWC1vocjQR9Btjy7r2+3RrH8v9qIIAkErI7R7UgQ75JFMq4yjDxdXRWjWoHAlSirDT3Xm7PwoNzqi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XqOdX6U3; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1744333747;
	bh=owww72mo7rRa4HGyljLXSQgsg6KGAlIxseqdPKYlAm0=;
	h=From:Subject:Date:To:Cc;
	b=XqOdX6U3Cq0OakPdb4QSUC556jn3yncHePtbEtu0jYQLrwHC7TKOeZ0RPYiMGHHvW
	 TN0bxeNNvhlBtp8tXolu6w0pxB+HhyYZ45q3WtAOZW5BZTCpFjl3cIl/AImVPxYzBY
	 +tf2NTr8dXALLFL4N+70njc+TxSuzcXFxRqqHgp+q+hm772phcDm4IBaKG/iKOJj6g
	 Jys/+azHbxTEL3e+t8R5XJN3hW1BGC7ea8rXFNmoMAGI/l8iu5GcSCuTHE4FaW9AIK
	 fn07ZDMEA+xhsjsK2Tw8+Pn1c3SciinO7Dkp1vZnUNujcZCmD1vgZUjxMVbdgD/dQJ
	 hJYJLUonN45MA==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8D5237D705;
	Fri, 11 Apr 2025 09:09:04 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH 0/7] soc: aspeed: lpc-snoop: Miscellaneous fixes
Date: Fri, 11 Apr 2025 10:38:30 +0930
Message-Id: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI5r+GcC/y2M0QrCMBAEf6Xccw/SxELxV8SHkKx6IEnMWRFK/
 91DfZxZZjdSdIHScdio4yUqtRhM40DpFssVLNmYvPOzO7iJozYg870l1lJr44u8oYw5+2UJOYY
 YyOLW8R2sPZ1/3PFY7f/5l/v+AWm6cWJ9AAAA
X-Change-ID: 20250401-aspeed-lpc-snoop-fixes-e5d2883da3a3
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Henry's bug[1] and fix[2] prompted some further inspection by
Jean.

This series provides fixes for the remaining issues Jean identified, as
well as reworking the channel paths to reduce cleanup required in error
paths. It is based on the tree at[3].

Lightly tested on an AST2600 EVB. Further testing on platforms
designed around the snoop device appreciated.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=219934
[2]: https://lore.kernel.org/all/20250401074647.21300-1-bsdhenrymartin@gmail.com/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/arj/bmc.git/log/?h=aspeed/drivers

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
Andrew Jeffery (7):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled
      soc: aspeed: lpc-snoop: Ensure model_data is valid
      soc: aspeed: lpc-snoop: Constrain parameters in channel paths
      soc: aspeed: lpc-snoop: Rename 'channel' to 'index' in channel paths
      soc: aspeed: lpc-snoop: Rearrange channel paths
      soc: aspeed: lpc-snoop: Lift channel config to const structs

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 149 ++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 61 deletions(-)
---
base-commit: f3089a4fc24777ea2fccdf4ffc84732b1da65bdc
change-id: 20250401-aspeed-lpc-snoop-fixes-e5d2883da3a3

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


