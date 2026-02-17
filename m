Return-Path: <stable+bounces-217058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KLPMALUlGnHIAIAu9opvQ
	(envelope-from <stable+bounces-217058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:48:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F41504D1
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 622B4300A52C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443928851C;
	Tue, 17 Feb 2026 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TofMXs8p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86923261B70;
	Tue, 17 Feb 2026 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361278; cv=none; b=F5U8g0T+Lb9eoSyJ4CTXVlxts/sziWVBQ6nDtyE8nYh4a00tdXKE3VPwuF563w6ETh+IVVvZENXssTA57+Em0/Wf/Yom0sJ3g+2jR0VfpDY3hUt3P1j+pOeCEHEYCe24sgmJw5HtqQhFPtfoeiqXvPxqGAy2GZ1zrfC/52Q2MP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361278; c=relaxed/simple;
	bh=P89CDAfKdMFHfEPvSYjUlA+vJKb9YQw1nEci2gI+8Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTGdufLUmCGXUHJpH7Rrcrox6MNplQ4NhMPubH15u/KSFD00a2+5up8R30qU3GKBexsGA5+S4VcisWzp41cgm/dvRYKtUAEpXlIb59Na9kMxV70IQyn67ZK2yqNgIf3i6HeN9knRvPWUrMOcnxD9Q8+Ci+Z86VgNZ8t6iMOSSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TofMXs8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAC4C4CEF7;
	Tue, 17 Feb 2026 20:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361278;
	bh=P89CDAfKdMFHfEPvSYjUlA+vJKb9YQw1nEci2gI+8Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TofMXs8p4EGr07QaZSKaIdRuLSrn/2p5Lp6BCzuVBZCFAmVX96nkBngXtiNBDzyeP
	 QkIF4n5LROC6rxjtIjJl0GiMMm682LI5Ahr3zwWHBy7aakZkwcxAS69rr1jJcKY0lE
	 9FUmcPSMj4SmXBFLgasK/zU9Y6BCWw9yQSRD+YF4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qingfang Deng <dqfext@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rajani Kantha <681739313@139.com>
Subject: [PATCH 6.1 53/64] net: stmmac: Fix accessing freed irq affinity_hint
Date: Tue, 17 Feb 2026 21:31:49 +0100
Message-ID: <20260217200009.495087811@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217058-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org,139.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,139.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E6F41504D1
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qingfang Deng <dqfext@gmail.com>

[ Upstream commit c60d101a226f18e9a8f01bb4c6ca2b47dfcb15ef ]

The cpumask should not be a local variable, since its pointer is saved
to irq_desc and may be accessed from procfs.
To fix it, use the persistent mask cpumask_of(cpu#).

Cc: stable@vger.kernel.org
Fixes: 8deec94c6040 ("net: stmmac: set IRQ affinity hint for multi MSI vectors")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250318032424.112067-1-dqfext@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3518,7 +3518,6 @@ static int stmmac_request_irq_multi_msi(
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	enum request_irq_err irq_err;
-	cpumask_t cpu_mask;
 	int irq_idx = 0;
 	char *int_name;
 	int ret;
@@ -3630,9 +3629,8 @@ static int stmmac_request_irq_multi_msi(
 			irq_idx = i;
 			goto irq_error;
 		}
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(i % num_online_cpus(), &cpu_mask);
-		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
+		irq_set_affinity_hint(priv->rx_irq[i],
+				      cpumask_of(i % num_online_cpus()));
 	}
 
 	/* Request Tx MSI irq */
@@ -3655,9 +3653,8 @@ static int stmmac_request_irq_multi_msi(
 			irq_idx = i;
 			goto irq_error;
 		}
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(i % num_online_cpus(), &cpu_mask);
-		irq_set_affinity_hint(priv->tx_irq[i], &cpu_mask);
+		irq_set_affinity_hint(priv->tx_irq[i],
+				      cpumask_of(i % num_online_cpus()));
 	}
 
 	return 0;



