Return-Path: <stable+bounces-169812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B59B285DA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ED4608656
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC8125522B;
	Fri, 15 Aug 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqSG2YOr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81243212561;
	Fri, 15 Aug 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282736; cv=none; b=R9jmHjRglkD0xqXdwlRaAy3lpGr4e/6LF0cCjZjhgCIy51mafUSU8dCQjOKIbuAGLUSK4Xg59JagwFKTJvOABGVLWJEtv9bboWmiwQyNq5uipybjCb3phjT6ZgZjREEwewGWFd+4pP+J2bwCvYsRKN/G77sHQgnUpT8Yx6og6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282736; c=relaxed/simple;
	bh=9z3lCu74Prxu4L02rJ9U7O515gDUwPsAhghQTM6Eae4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EZyVH5c/P8tHBKR8UxokOqa/F/QpbqK567J3LRmAwXKbMvGoSmVTBPhQWyvy10f8Td8szxCaTXw4vNR2n8qp2vb9r8bF4lxthRuY6HPCuqioWNByMMlbD/7ZFgfR9QHcqAc7iAdG58slcytDwMZK8cmAylWItwCqKUGHpnmKz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqSG2YOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CA4FC4CEEB;
	Fri, 15 Aug 2025 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755282736;
	bh=9z3lCu74Prxu4L02rJ9U7O515gDUwPsAhghQTM6Eae4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=SqSG2YOrYL5NUd3HwxO0mqK/L80rUt2WxZUdKPANXTWz2L17zHbjFKpJ+6tdmKTWq
	 LjyXOedVmO0QAE10VSbn4seVjSymXez3xG+N1+AlywKGXfKXoWB1LjzcRcmAWm8nx0
	 kWYu0moE8ichREh0rZsOdWzWXNupS7/xJcVBIHHExYHtHiLYTsUjzYmeVm2bOCkmwH
	 3ooUq0mPLfe1DtK73vJrJtChTVpAPbmZg6Wxayq+ekZ5O2MD7EaTUDvyunRKtEuJZ7
	 MRg8Edca0j1+jKqigr/hzO2SQosP1nYxzREmlHWqf0pKg1+tkPnrhXkZYCM2e2ulWI
	 XBcmZB2A1o5eA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D99BCA0EE6;
	Fri, 15 Aug 2025 18:32:16 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH v2 0/2] Fixes for maxim tcpc contaminant detection logic
Date: Fri, 15 Aug 2025 11:31:50 -0700
Message-Id: <20250815-fix-upstream-contaminant-v2-0-6c8d6c3adafb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABZ9n2gC/3WNwQ6CMBBEf4Xs2TW7VbFw8j8Mh6au0ERa0laiI
 fy7lXj1+CYzbxZIEp0kaKsFoswuueALqF0FdjC+F3S3wqBInUiTwrt74XNKOYoZ0Qafzei88Rm
 5bphEnWtlDZT5FKV0N/W1Kzy4lEN8b08zf9OflI//pTMjoSa2okk3dOBLH0L/kL0NI3Trun4Ap
 7q6N8EAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755282735; l=964;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=9z3lCu74Prxu4L02rJ9U7O515gDUwPsAhghQTM6Eae4=;
 b=Bfs56Qain5NfOqRZiiIJtu4ekQ+VVRIl0m0t7N1+x6vcxbjSKyqEoK6EXWZ5uJr/H1IreLjqr
 Vr02/CkUb2pBZVM5X2fjzY3k2Z+FUCc7/nGe7h/nKAx0okOQQqr3wu8
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

Add fixes to the CC contaminant/connection detection logic to improve
reliability and stability of the maxim tcpc driver. This patchset has
been tested on a PD Tester.

---
Changes in v2:
- Fix improperly formatted patch for stable inclusion. Tagged every
  patch in patchset for stable.
- Link to v1: https://lore.kernel.org/r/20250814-fix-upstream-contaminant-v1-0-801ce8089031@google.com

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



