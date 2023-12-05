Return-Path: <stable+bounces-4538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5117F8047E8
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03661F2190B
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B179F2;
	Tue,  5 Dec 2023 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nk8GKkJW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A36AC2;
	Tue,  5 Dec 2023 03:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D747C433C7;
	Tue,  5 Dec 2023 03:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747821;
	bh=hDWfAfk7rYx6swDAda+kMYWzM+SjeTJg0UE02X4NTc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nk8GKkJWmS+bQJ3HV3pmAyTt6dzwFxazIkcUdBwIG7576xEzZ2HO0j/5b7UUPUrYC
	 eJPHNYdQ9TT6zM+E5lDqAeBrBYgk6vDkIRzhNh/kErqgSZ1K0GFYNP7iLzjBboUIiB
	 JYJ8+7mrvvdfWwJGFsVpQ1VaTwxBj5fcT+vhueDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herb Wei <weihao.bj@ieisystem.com>,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 12/94] net: usb: ax88179_178a: fix failed operations during ax88179_reset
Date: Tue,  5 Dec 2023 12:16:40 +0900
Message-ID: <20231205031523.589258314@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031522.815119918@linuxfoundation.org>
References: <20231205031522.815119918@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

[ Upstream commit 0739af07d1d947af27c877f797cb82ceee702515 ]

Using generic ASIX Electronics Corp. AX88179 Gigabit Ethernet device,
the following test cycle has been implemented:
    - power on
    - check logs
    - shutdown
    - after detecting the system shutdown, disconnect power
    - after approximately 60 seconds of sleep, power is restored
Running some cycles, sometimes error logs like this appear:
    kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Failed to write reg index 0x0001: -19
    kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x0001: -19
    ...
These failed operation are happening during ax88179_reset execution, so
the initialization could not be correct.

In order to avoid this, we need to increase the delay after reset and
clock initial operations. By using these larger values, many cycles
have been run and no failed operations appear.

It would be better to check some status register to verify when the
operation has finished, but I do not have found any available information
(neither in the public datasheets nor in the manufacturer's driver). The
only available information for the necessary delays is the maufacturer's
driver (original values) but the proposed values are not enough for the
tested devices.

Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Reported-by: Herb Wei <weihao.bj@ieisystem.com>
Tested-by: Herb Wei <weihao.bj@ieisystem.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Link: https://lore.kernel.org/r/20231120120642.54334-1-jtornosm@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ax88179_178a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index ea9c8361bf464..84dc9fb2b1f3f 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1594,11 +1594,11 @@ static int ax88179_reset(struct usbnet *dev)
 
 	*tmp16 = AX_PHYPWR_RSTCTL_IPRL;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
-	msleep(200);
+	msleep(500);
 
 	*tmp = AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, tmp);
-	msleep(100);
+	msleep(200);
 
 	/* Ethernet PHY Auto Detach*/
 	ax88179_auto_detach(dev, 0);
-- 
2.42.0




