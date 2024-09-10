Return-Path: <stable+bounces-74208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EFC972E0A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BD71F26387
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACE618A6B9;
	Tue, 10 Sep 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0EcdTWsS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F4188CC1;
	Tue, 10 Sep 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961130; cv=none; b=Uta7BPOZthAm5EvI4mjC6ruUTaYhb+VJ7+3aTh287zvzHRNsGfovRKZ11uAx9PtFLLlKD4aUVt1xd59l39oG2PqxlnW2H9/SZ/zAtN63s12Jhr4Dr/iZleX6yTM9ToosW6yd16JV9OLgzlb26TYW2zFho1hloc8XpiZq+tAO75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961130; c=relaxed/simple;
	bh=BReXOfmhUGRGvIUJj8b+Gi01TvqoETkcBDK3Tkf7HOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms2U+uXQLoVXTG7ibLV9M26hDG0oftvzdcWwQqS4JVWU8jJfrAxnDIHDYAs6LGD61zYtoQr8wM7tFUUG03ZemOltzV6bY+W0JR8WVkwuYvlJjp7sfemJ2BCSWGZTXrx3/JaVP/tgLX6rp/uRTICob8DbS7snBPQHOmzyBQVqykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0EcdTWsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478A7C4CEC3;
	Tue, 10 Sep 2024 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961130;
	bh=BReXOfmhUGRGvIUJj8b+Gi01TvqoETkcBDK3Tkf7HOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0EcdTWsSV7QIN0P9fG6DCqR+Ebk19twEgeUxkDZaolb+QVBXlaOkgoEy8/fAFFt5W
	 VDaHiYlz8xWKiivs3Z2zDR++UsKsbv9wnhLdQYDZ5e4/dntRsML/J1H79rcyiZsTDN
	 V89gd98kx2aW31FhfRIXNu/D26npBQ9bP3mmMMVM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daiwei Li <daiweili@google.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 4.19 36/96] igb: Fix not clearing TimeSync interrupts for 82580
Date: Tue, 10 Sep 2024 11:31:38 +0200
Message-ID: <20240910092543.103751926@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daiwei Li <daiweili@google.com>

[ Upstream commit ba8cf80724dbc09825b52498e4efacb563935408 ]

82580 NICs have a hardware bug that makes it
necessary to write into the TSICR (TimeSync Interrupt Cause) register
to clear it:
https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/

Add a conditional so only for 82580 we write into the TSICR register,
so we don't risk losing events for other models.

Without this change, when running ptp4l with an Intel 82580 card,
I get the following output:

> timed out while polling for tx timestamp increasing tx_timestamp_timeout or
> increasing kworker priority may correct this issue, but a driver bug likely
> causes it

This goes away with this change.

This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").

Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
Tested-by: Daiwei Li <daiweili@google.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Daiwei Li <daiweili@google.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5d8d5915bc27..01138fc93ea1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6554,10 +6554,20 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
+	const u32 mask = (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
+			  TSINTR_TT0 | TSINTR_TT1 |
+			  TSINTR_AUTT0 | TSINTR_AUTT1);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
 
+	if (hw->mac.type == e1000_82580) {
+		/* 82580 has a hardware bug that requires an explicit
+		 * write to clear the TimeSync interrupt cause.
+		 */
+		wr32(E1000_TSICR, tsicr & mask);
+	}
+
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
-- 
2.43.0




