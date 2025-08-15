Return-Path: <stable+bounces-169694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C783B27627
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 04:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7693A9852
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5524229ACC2;
	Fri, 15 Aug 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYZCVBj3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3F29AAF3;
	Fri, 15 Aug 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225270; cv=none; b=nmu/f6XyDUW3YU2u6By4H1+Jfcvwp/gMt7Q8jjbMXVlK6D+k6J47bLWiYg8yZLKVeWRcmZkbMn0tGpKOqxcwiFP6+yR1h48I6gGKD66Wtxc3bDnLDh5tyNdPPGixDnI7s5PcB8MsgtWsHGMsL2iPdOEMdKRDZDhjutHaf7vtU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225270; c=relaxed/simple;
	bh=WOkfKQC4WAjGci8A3ZUdsKmLH/c07Chzph9ljFleBWE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tI3C1734KsNfoXaacWeO1muCgkWf7aSqnTl/xfakAQNZ/QqVqJ1mHKMh0lSJ+KKaGqG/K/nY9zYhXU5A7Vo1S41t8RBd3RzqK5X5ZpEvoIR4SPDhyoGyqdIo8Dm/nNSZ25vByPxn+wDijKmIUHYM/kjlPfoEW7k8NLCPnlFwRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYZCVBj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE176C4CEF1;
	Fri, 15 Aug 2025 02:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755225269;
	bh=WOkfKQC4WAjGci8A3ZUdsKmLH/c07Chzph9ljFleBWE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jYZCVBj3QbQRwwzIlG3zEx8I4DbzsTQe/cBTbdpK96XjO5A0WHmKki8GL2UuYS6wr
	 nYpsNOHjacxdqFTOIbYR0whEXiGFoiAYpIwYFsMd4CFPXcJ6sGxjqebOAb/tv+1Ckb
	 XOIc0PGhXtvnc5ULL1JbicB71fqcsVPj5kw89kPmwC5ahieaM2chtFoZGAf/4Tz1iA
	 02lL60Tln5jdEPN4f5uOwv+zFjYBpXICZD2+K4PxKawsLyBaxkduGZ4QmEtuooLeU1
	 sPjTn3383CDBfTxZxWbMtYbZjru9/5w+Uq9+lY1Yky1KyI+y8WwSoUfhj3dQGfP2bl
	 6AdlAZ825PASw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB893CA0ED1;
	Fri, 15 Aug 2025 02:34:29 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH 0/2] Fixes for maxim tcpc contaminant detection logic
Date: Thu, 14 Aug 2025 19:34:08 -0700
Message-Id: <20250814-fix-upstream-contaminant-v1-0-801ce8089031@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKCcnmgC/x2MQQqDMBAAvyJ77kKyoLX9SulhiWvdQ1ZJUhGCf
 zd4HJiZClmSSoZ3VyHJrllXa+AfHYSF7SeoU2MgR70bHeGsB/63XJJwxLBa4ajGVtAPL++EngM
 FhpZvSZp7rz/f87wAiqpoo2oAAAA=
X-Change-ID: 20250802-fix-upstream-contaminant-16910e2762ca
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, RD Babiera <rdbabiera@google.com>, 
 Kyle Tso <kyletso@google.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755225269; l=688;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=WOkfKQC4WAjGci8A3ZUdsKmLH/c07Chzph9ljFleBWE=;
 b=kK7Du+pE7rMDWYGp31Blr5Vm6EadjFMHsK2roZUl+5IhWaPHLdacfMjsxdTaXDrc3e6QNNdVk
 ttUrzC/U+sODYQQf5pGyOKXpoRmiTfezbp3Q1lDT5b9UBId5SD7jdUW
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

Add fixes to the CC contaminant/connection detection logic to improve
reliability and stability of the maxim tcpc driver.

---
Amit Sunil Dhamne (2):
      usb: typec: maxim_contaminant: disable low power mode when reading comparator values
      usb: typec: maxim_contaminant: re-enable cc toggle if cc is open and port is clean

 drivers/usb/typec/tcpm/maxim_contaminant.c | 58 ++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci_maxim.h       |  1 +
 2 files changed, 59 insertions(+)
---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250802-fix-upstream-contaminant-16910e2762ca

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



