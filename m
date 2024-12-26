Return-Path: <stable+bounces-106149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84809FCBED
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 17:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234661619D8
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 16:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618A54D599;
	Thu, 26 Dec 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8kZbEOF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057228EC
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231469; cv=none; b=NSY7oyCFSP87Mxu8za/ooEWRLnZxEX1OvPmzCejqdqu2H2AzzGVCit0Zs54UWT0IYKdH1YVPk6APy8SEctg2tF+lHPGIQ6GtCqxrqdvMKYT0i+L3l02BXJJ7XMrthvPVpcCSKsbuBPDkr50kx6713WM47NLnL22thPbuEuWxKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231469; c=relaxed/simple;
	bh=XzZxFsJxcpvXAVrC2KBTeHViWTSq8zd9kdwi+eC/LsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZhgRRnPiUdvP9AIVumchWFesAG1PNXAwWZnnGVHNFGh6R4J4wt6F4FVE/vNVatoQ/y1RtdcrmFQ5AVk1MsNyqgEU9c5ABxRDHihM7EfAtJUPTxGLXSiE+vdShlcvrXaGTlZfwkX56ZkkU1riFi9MrngnPXX6DLI2qC4dDySCwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8kZbEOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83117C4CED4;
	Thu, 26 Dec 2024 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735231469;
	bh=XzZxFsJxcpvXAVrC2KBTeHViWTSq8zd9kdwi+eC/LsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8kZbEOFBSwgHY+0owiyS395kJhzHK9iIMA6eCfJGkgh3HopXyR/r3XgsCBRPZcSd
	 g+Rrd+icDFyX5hs/mpxbj8MLBJVc0FsmG9Ii3HEwf0lPIgxSKeD7ugDxG3G1EJlS6d
	 ym1RyjT6BsdcmoT9l6A60GkqO1V8QgbZk8rMUCKSDCUehhGS/BVeWs5IHg+O78fQdg
	 s0MdUgQcN1EzT+ykw0+7I1cZLUNB7qwW2Pp7E9GjCfQXbZ4S5DNmK265hKc/m6PAwl
	 T7lnADmNPH2ZzzwO/w7XtyW4KphLhpHLxyfkIVrITUXQT5jj8NslG3UEXl0jAml0Q4
	 mN2I+j1TQ2rLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "d . privalov" <d.privalov@omp.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 1/1] Bluetooth: L2CAP: Fix uaf in l2cap_connect
Date: Thu, 26 Dec 2024 11:44:27 -0500
Message-Id: <20241226093034-1312603e9b4e73e7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241226093539.44806-1-d.privalov@omp.ru>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 333b4fd11e89b29c84c269123f871883a30be586

WARNING: Author mismatch between patch and upstream commit:
Backport author: d.privalov <d.privalov@omp.ru>
Commit author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: b90907696c30)
6.1.y | Present (different SHA1: b22346eec479)
5.15.y | Present (different SHA1: 686e05c9dbd6)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  333b4fd11e89 ! 1:  b709013bb07e Bluetooth: L2CAP: Fix uaf in l2cap_connect
    @@ Metadata
      ## Commit message ##
         Bluetooth: L2CAP: Fix uaf in l2cap_connect
     
    +    commit 333b4fd11e89b29c84c269123f871883a30be586 upstream.
    +
         [Syzbot reported]
         BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
         Read of size 8 at addr ffff8880241e9800 by task kworker/u9:0/54
    @@ Commit message
         Closes: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
         Fixes: 7b064edae38d ("Bluetooth: Fix authentication if acl data comes before remote feature evt")
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +    Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
     
      ## net/bluetooth/hci_core.c ##
     @@ net/bluetooth/hci_core.c: static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
    @@ net/bluetooth/hci_core.c: static void hci_acldata_packet(struct hci_dev *hdev, s
      	hci_dev_lock(hdev);
      	conn = hci_conn_hash_lookup_handle(hdev, handle);
     +	if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
    -+		mgmt_device_connected(hdev, conn, NULL, 0);
    ++		mgmt_device_connected(hdev, conn, 0, NULL, 0);
      	hci_dev_unlock(hdev);
      
      	if (conn) {
     
      ## net/bluetooth/hci_event.c ##
    -@@ net/bluetooth/hci_event.c: static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
    +@@ net/bluetooth/hci_event.c: static void hci_remote_features_evt(struct hci_dev *hdev,
      		goto unlock;
      	}
      
    @@ net/bluetooth/hci_event.c: static void hci_remote_features_evt(struct hci_dev *h
      		bacpy(&cp.bdaddr, &conn->dst);
     
      ## net/bluetooth/l2cap_core.c ##
    -@@ net/bluetooth/l2cap_core.c: static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
    +@@ net/bluetooth/l2cap_core.c: static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
      static int l2cap_connect_req(struct l2cap_conn *conn,
      			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
      {
    @@ net/bluetooth/l2cap_core.c: static void l2cap_connect(struct l2cap_conn *conn, s
      		return -EPROTO;
      
     -	hci_dev_lock(hdev);
    --	if (hci_dev_test_flag(hdev, HCI_MGMT))
    --		mgmt_device_connected(hdev, hcon, NULL, 0);
    +-	if (hci_dev_test_flag(hdev, HCI_MGMT) &&
    +-	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &hcon->flags))
    +-		mgmt_device_connected(hdev, hcon, 0, NULL, 0);
     -	hci_dev_unlock(hdev);
     -
    - 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
    + 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
      	return 0;
      }
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

