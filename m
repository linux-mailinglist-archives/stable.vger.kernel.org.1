Return-Path: <stable+bounces-41128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65FF8AFA6D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E201F29687
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7741149DE1;
	Tue, 23 Apr 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xvWGootP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489F1420BE;
	Tue, 23 Apr 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908696; cv=none; b=ILryCsM92JE070bmkPHE11TI0a0pgwGD/FCKPHO32Y/lHXBW44Pr/lPWpB33r1rGfWozjbuglfUF5+4sPHA0XmQ4EHYnIb6qmd/fHoNIbsj3b+1DxzeF5Gky6HThfvsKU7S2r9EMooQXpdFR0t0+6JJWJaiqV674wg6dB1Glpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908696; c=relaxed/simple;
	bh=I9Svx+8p/Ks6+/TfsePBYYzO5rnX0N5cHAgJCeHvyPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZttGLAbMHq+g6vdXyGwVRl0+i4AFjRJGciIkw+z0hZCjUYOA4R5aVmN/yaDcPv7izbQpOjxyz/hbbhXOn6mM8svxmcHqMLY7xqgbPCRyqCRZ008+5W0gxxAUTuH0io7kFTOc7FpXKo8tUh0YnF9DLD40LxUi/txOeJfKoL4IYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xvWGootP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6962DC3277B;
	Tue, 23 Apr 2024 21:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908696;
	bh=I9Svx+8p/Ks6+/TfsePBYYzO5rnX0N5cHAgJCeHvyPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xvWGootPzf+pRzSRFk5FRZp+SSu9VYmOdMZbLhTKtXX3ZJEC/sslD0pxxBGbRZEQr
	 ombhQFwJ4N5IVITPCsZBI4pkEOnteMqob+cof79qSDA1NIcisNADrcaLE/5oIHTC0v
	 L9M/3qmGM7Do7H2Mq0EL5r867PBZKUtMLOH1+h3U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/141] net: dsa: mt7530: fix mirroring frames received on local port
Date: Tue, 23 Apr 2024 14:38:34 -0700
Message-ID: <20240423213854.752710228@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit d59cf049c8378677053703e724808836f180888e ]

This switch intellectual property provides a bit on the ARL global control
register which controls allowing mirroring frames which are received on the
local port (monitor port). This bit is unset after reset.

This ability must be enabled to fully support the port mirroring feature on
this switch intellectual property.

Therefore, this patch fixes the traffic not being reflected on a port,
which would be configured like below:

  tc qdisc add dev swp0 clsact

  tc filter add dev swp0 ingress matchall skip_sw \
  action mirred egress mirror dev swp0

As a side note, this configuration provides the hairpinning feature for a
single port.

Fixes: 37feab6076aa ("net: dsa: mt7530: add support for port mirroring")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 6 ++++++
 drivers/net/dsa/mt7530.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d4515c19a5f34..b5f61a9a378eb 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2461,6 +2461,9 @@ mt7530_setup(struct dsa_switch *ds)
 			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
 	}
 
+	/* Allow mirroring frames received on the local port (monitor port). */
+	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
+
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
 	ret = mt7530_setup_vlan0(priv);
 	if (ret)
@@ -2577,6 +2580,9 @@ mt7531_setup_common(struct dsa_switch *ds)
 			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
 	}
 
+	/* Allow mirroring frames received on the local port (monitor port). */
+	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
+
 	/* Flush the FDB table */
 	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
 	if (ret < 0)
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 2d1ea390f05ab..af18f47f22141 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -31,6 +31,10 @@ enum mt753x_id {
 #define SYSC_REG_RSTCTRL		0x34
 #define  RESET_MCM			BIT(2)
 
+/* Register for ARL global control */
+#define MT753X_AGC			0xc
+#define  LOCAL_EN			BIT(7)
+
 /* Registers to mac forward control for unknown frames */
 #define MT7530_MFC			0x10
 #define  BC_FFP(x)			(((x) & 0xff) << 24)
-- 
2.43.0




