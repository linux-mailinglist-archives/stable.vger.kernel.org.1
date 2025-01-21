Return-Path: <stable+bounces-109656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D26A18343
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57402188273A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D11F5439;
	Tue, 21 Jan 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B7En0bGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E481E9B38;
	Tue, 21 Jan 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482055; cv=none; b=sQubsVlKsSf+oIWTvPvbtLuyakB649aVpsfw8AxJ42+B0UeLVi80qPvQE1+Y5aVinUkVxKulT/HpfvPQUcAl++IPZVN2fhVYgV5bRrdqhuzrOkNSfSIbLveJ0YIpCa3T5qrL6l098IyHCbJZObNwv1S5Cbv9fEiotMscjEJ/i34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482055; c=relaxed/simple;
	bh=sdcBJZv764CMjFeLvAgZbmstGdY0mraVSzaUEkpJBPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFptfoZqRgTdhjjXDnnCnPh15UkeTpd1/+IpHqASx6ebfdXmjxyfPez14sludYAHRzRoneW3hq7UGJ8YorHzjbcidHQu6aZbMgvbf77pLwDS0iqXQ441/0WxIKWfwy3ge29mkOUA+7rv0OX7FeX0FrBOnYttr7vXimAQY1gnmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B7En0bGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7136C4CEDF;
	Tue, 21 Jan 2025 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482055;
	bh=sdcBJZv764CMjFeLvAgZbmstGdY0mraVSzaUEkpJBPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7En0bGN9/SbyLTpFJVRHR1erif+mP1qL0DKn4FLasqiVH0lIkMUv8990jwMjpxZT
	 vAVyXVSoZuYJEtamgTcLL3vv/INTxhYeZV97XY0cnrPKZlH7A6LgZc8xufLXhk+dW6
	 HrXFhC9/bCjmH/BTjFz8ylfnWJd7xIk9PRP7fyQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Friedrich Weber <f.weber@proxmox.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 03/72] openvswitch: fix lockup on tx to unregistering netdev with carrier
Date: Tue, 21 Jan 2025 18:51:29 +0100
Message-ID: <20250121174523.564640881@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174523.429119852@linuxfoundation.org>
References: <20250121174523.429119852@linuxfoundation.org>
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

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 47e55e4b410f7d552e43011baa5be1aab4093990 ]

Commit in a fixes tag attempted to fix the issue in the following
sequence of calls:

    do_output
    -> ovs_vport_send
       -> dev_queue_xmit
          -> __dev_queue_xmit
             -> netdev_core_pick_tx
                -> skb_tx_hash

When device is unregistering, the 'dev->real_num_tx_queues' goes to
zero and the 'while (unlikely(hash >= qcount))' loop inside the
'skb_tx_hash' becomes infinite, locking up the core forever.

But unfortunately, checking just the carrier status is not enough to
fix the issue, because some devices may still be in unregistering
state while reporting carrier status OK.

One example of such device is a net/dummy.  It sets carrier ON
on start, but it doesn't implement .ndo_stop to set the carrier off.
And it makes sense, because dummy doesn't really have a carrier.
Therefore, while this device is unregistering, it's still easy to hit
the infinite loop in the skb_tx_hash() from the OVS datapath.  There
might be other drivers that do the same, but dummy by itself is
important for the OVS ecosystem, because it is frequently used as a
packet sink for tcpdump while debugging OVS deployments.  And when the
issue is hit, the only way to recover is to reboot.

Fix that by also checking if the device is running.  The running
state is handled by the net core during unregistering, so it covers
unregistering case better, and we don't really need to send packets
to devices that are not running anyway.

While only checking the running state might be enough, the carrier
check is preserved.  The running and the carrier states seem disjoined
throughout the code and different drivers.  And other core functions
like __dev_direct_xmit() check both before attempting to transmit
a packet.  So, it seems safer to check both flags in OVS as well.

Fixes: 066b86787fa3 ("net: openvswitch: fix race on port output")
Reported-by: Friedrich Weber <f.weber@proxmox.com>
Closes: https://mail.openvswitch.org/pipermail/ovs-discuss/2025-January/053423.html
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Tested-by: Friedrich Weber <f.weber@proxmox.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20250109122225.4034688-1-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/actions.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 4f5cbcaa38386..9445ca97163b4 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -918,7 +918,9 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 {
 	struct vport *vport = ovs_vport_rcu(dp, out_port);
 
-	if (likely(vport && netif_carrier_ok(vport->dev))) {
+	if (likely(vport &&
+		   netif_running(vport->dev) &&
+		   netif_carrier_ok(vport->dev))) {
 		u16 mru = OVS_CB(skb)->mru;
 		u32 cutlen = OVS_CB(skb)->cutlen;
 
-- 
2.39.5




