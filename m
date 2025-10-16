Return-Path: <stable+bounces-186079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C7BE3815
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32A9584B88
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AED3314D0;
	Thu, 16 Oct 2025 12:52:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265BF2DF6F7;
	Thu, 16 Oct 2025 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619141; cv=none; b=BDrFqrH9f4r2FA6pGvToerVQcPoCoB8ypK4Wrg93l+obAQqRECktZZGv4ABYNDzC78G4zJtQbobuLd/1iWGGVtbbUrI3qh0bBDGFYniq+8G1IZtMj8mRgpIQoi9h4+RAEaq5SAbiyHzu+uNOsOJ7SCefGHq3ZlcKotSDXP8MnGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619141; c=relaxed/simple;
	bh=kQ4x1U8G0JsGuwfwK4p2noaesz1dLIeBRot9BtlLoTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uNC/KX9KdPHTZYn1JeCz48uh9CjqD8Hag/6W6/TCi6bZlrIxPhlophSZHqtBGD9UuiD8xn7Rfi6G/k+Iy9d65U1R9fIJ98kmhkuPUlvQuDD1A/r6dBFfc392hldt8lDE9TOBazRkelPdEpptLbVOxrubU0nwQKbOSGavuC+lMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1760619118t01132058
X-QQ-Originating-IP: kVZ9Lj83PbQOP9p2AFTPJx70wQN3RFwQFKLygcEUn94=
Received: from localhost.localdomain ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Oct 2025 20:51:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15411286175632521263
EX-QQ-RecipientCnt: 14
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: bonding: update the slave array for broadcast mode
Date: Thu, 16 Oct 2025 20:51:36 +0800
Message-Id: <20251016125136.16568-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OBDSLDo3By90iZECQCQ8f/ptmzBKsM7gkxdOTFVq52klque64ddcW4DQ
	V77zcsvlt/y3PESKw+2eK53o/b5omlhkn7HlCy+DrMsQm+j8zi4MdQ+FS04k6HAYxO81N/y
	JjFc2J2wOd2WRHDG3cj7lp5vwhf1VSTsMKPifwHYqjpRUNWUnmsB5NL88eOW06WYB3xbOYV
	7zB82pAOHLOr8YDidEVa1qGcneoBv5qGEHD5ttzRKK83CeZ/IJLUItSPInng89FlN3Iv7oQ
	fiBApK6WRqlCtSGJj7farjmIQQQebB1oQfThxxxIKRM85R1JBNxIarc8b8pgPzATCQ9+B0j
	IOHvdHm8pbScBh9TmZJzwePwFKSW1f00j1uzCSv/EmlkhhE/4zxrLwv4nNaRU771StlW0Ys
	FQHo+u4VMjBhXmKXAFAl2oYXqG11oivD4RKHBAIwoixED9eoLnmIwHQja4NtzWa00PfVv6g
	1zjysqWxZgjPWdM2WuroFqiML3Fa3GMiEMgtIdSv14vpO8PqNsTacaLwwlCROLsa4yzCcVZ
	8KRCAkzSS0+Zf2Yvoug+aIHc/ZLqzFPyDOt4DcsNpP6MYzin7U/baJF5/KTErNAnBMSutZN
	3wT4mOB1dLS5Cgk6syslxxiDFAYFmlPoh/aiZgmdaziFHtnn6m+B5gim3l7/wfZRMfjpluw
	veQYjdCT9a85rQrLQnZAfC3oygRf6HLGY+7wCjFKCIuANgbbO52yAjvPOFb4vjXBqOlAJ8Y
	9sDv+YG9lmbflFPu5mPcG1YsVt2F6wkKbFfcWt1oiacdXasHrYQoHK5S0ZMgt4lP1ZgrfgA
	+6dVLFxw2XmZLMb2iZfcce+wMW6cEvkEaUdetUM3vAgln+m/qTYRkUQZ0eG4FIJ0kh/jqeG
	+Q5TpdjuWBW/NA4/Tx64yUf6IzYGOmlU1nunBSHkHaIfLyduFukcJIWnRRVkBLz4oXdztFp
	h6epbs3v1p5gdbf91YPSRd233yV8+6hYAt/5/POg1G9j5pGQqgMjPxl+p8MEunjypVoFP0O
	pq2gF0MT3a+L1l2dWU
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

This patch fixes ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad").
Before this commit, on the broadcast mode, all devices were traversed using the
bond_for_each_slave_rcu. This patch supports traversing devices by using all_slaves.
Therefore, we need to update the slave array when enslave or release slave.

Fixes: ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad")
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: <stable@vger.kernel.org>
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/all/a97e6e1e-81bc-4a79-8352-9e4794b0d2ca@kernel.org/
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2:
- fix the typo in the comments, salve -> slave
- add the target repo in the subject
---
 drivers/net/bonding/bond_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 17c7542be6a5..2d6883296e32 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2384,7 +2384,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
+	/* broadcast mode uses the all_slaves to loop through slaves. */
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
 		bond_update_slave_arr(bond, NULL);
 
 	if (!slave_dev->netdev_ops->ndo_bpf ||
@@ -2560,7 +2562,8 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	bond_upper_dev_unlink(bond, slave);
 
-	if (bond_mode_can_use_xmit_hash(bond))
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
 		bond_update_slave_arr(bond, slave);
 
 	slave_info(bond_dev, slave_dev, "Releasing %s interface\n",
-- 
2.34.1


