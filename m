Return-Path: <stable+bounces-128441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA11A7D290
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 05:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1131188BA2D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 03:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B7217F35;
	Mon,  7 Apr 2025 03:42:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5219C56C;
	Mon,  7 Apr 2025 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997358; cv=none; b=IkFsX4aVv0Dbitg8x3W5fp54Kk25xcuOzxBfoWewk5R+eVopSQy7myO4afQCMep9XwBDfSouVBbDZXhLR54EU4xhHrAJiLsIpT0A9V3f8WwluSvYnhTJ2NcZsmtqhgSPHccKuL2innJfKVVdsbfFYyff5BITT/VrYSed1pc5LCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997358; c=relaxed/simple;
	bh=1E4N30ToQrS4oTEuXMPktjG45U+GwxhykLqwMXbp9JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fg9WoG52uAor/lzC2/k94R6T4BEezL3YRFTRfSmmZfQzxC0A2xzW4oD/+NNuBTNQjQhxcbfLfx/ON9pZmvURlIZh7G9dJekQQ7NALgYQiOiupVzUqcTpfSkhbDbKoFjzVd0ytjQdisEzRqEZ86LHS0BoSBEYK6BxrSI1ae9KtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADXff6XSfNni_PKBg--.48924S2;
	Mon, 07 Apr 2025 11:42:21 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] e1000e: Add error handling for e1e_rphy_locked()
Date: Mon,  7 Apr 2025 11:41:54 +0800
Message-ID: <20250407034155.1396-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXff6XSfNni_PKBg--.48924S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw18ZF1fKry5Jw48CFyDZFb_yoW8Xr1Dpa
	1q9ayqkw4rJw4avayxGa18A3s0v3yYyrnxCFyxu3sa9w4xAw18Jr18K343XryqyrZ8JFW2
	yF1UAFnxCFs8Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe4SrUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUFA2fzOrdCVwAAsD

The e1000_suspend_workarounds_ich8lan() calls e1e_rphy_locked to disable
the SMB release, but does not check its return value. A proper
implementation can be found in e1000_resume_workarounds_pchlan() from
/source/drivers/net/ethernet/intel/e1000e/ich8lan.c.

Add an error check for e1e_rphy_locked(). Log the error message and jump
to 'release' label if the e1e_rphy_locked() fails.

Fixes: 2fbe4526e5aa ("e1000e: initial support for i217")
Cc: stable@vger.kernel.org # v3.5+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 2f9655cf5dd9..d16e3aa50809 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -5497,7 +5497,11 @@ void e1000_suspend_workarounds_ich8lan(struct e1000_hw *hw)
 			e1e_wphy_locked(hw, I217_SxCTRL, phy_reg);
 
 			/* Disable the SMB release on LCD reset. */
-			e1e_rphy_locked(hw, I217_MEMPWR, &phy_reg);
+			ret_val = e1e_rphy_locked(hw, I217_MEMPWR, &phy_reg);
+			if (ret_val) {
+				e_dbg("Fail to Disable the SMB release on LCD reset.");
+				goto release;
+			}
 			phy_reg &= ~I217_MEMPWR_DISABLE_SMB_RELEASE;
 			e1e_wphy_locked(hw, I217_MEMPWR, phy_reg);
 		}
-- 
2.42.0.windows.2


