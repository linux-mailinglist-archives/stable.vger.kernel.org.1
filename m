Return-Path: <stable+bounces-225810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEyCBLwyuWnsuQEAu9opvQ
	(envelope-from <stable+bounces-225810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:53:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2CD2A84C6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98CE5300D306
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783F367F28;
	Tue, 17 Mar 2026 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="Nq8o1IIk"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC42364925
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744558; cv=none; b=RZhkadXZ9XotdmG+WBDb5NYBMjJQEwivqnFVYRaxty/7f7244DLfWFJTYNf3sQ78bW0eSStt/XXUtVQUMMkUEnR2VPDoASGiCDLEAYBiyHT4D/j3vufJA88JzMhld5hzocpSEy8aRGKtJchnaia/qaqeIv+TyEuqv6VCewN3jtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744558; c=relaxed/simple;
	bh=a10KP7yEtR9NLFyumBm6wDumawSquy7TSD6YbWMChYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dAgGKeUXViFy4pwHLp1Kypo1w07RwetLleG8G5pDTfYRqXrfuEDbXf/zYb7uSClLMho0aZjAF3mJpXOBkk8tvmfhFdh0M69U1SWIuvYuPs7OnagRVO22bk49Ly1YjWNtbdigQvqZeTGMWpjfVLcwNlf/iph4McYDCPs5LaFuBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=Nq8o1IIk; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Nq8o1IIknw9Ep38XQIinIuIATwHuwsMhNp1wXMyyQzcNHBcY0zdJrqAZTA28Zf4Tr+A3jyaTDek4C
	 jHzi7pn5BycU/LRYDTU9Yn00FbPf+CdZmvEA55FRrFB/l/IZXKdMrlz7R6FVIEAkrrmWBal4Lge15t
	 oWtqzWGTqksGIWqo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-Mobile-Kernel-Team (unknown[106.121.140.245])
	by rmsmtp-lg-appmail-35-12049 (RichMail) with SMTP id 2f1169b930d7992-58f0d;
	Tue, 17 Mar 2026 18:45:46 +0800 (CST)
X-RM-TRANSID:2f1169b930d7992-58f0d
From: Leon Chen <leonchen.oss@139.com>
To: kuba@kernel.org,
	igor.bagnucki@intel.com,
	dawid.osuchowski@linux.intel.com,
	himasekharx.reddy.pucha@intel.com,
	mschmidt@redhat.com,
	anthony.l.nguyen@intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15.y] ice: Add netif_device_attach/detach into PF reset flow
Date: Tue, 17 Mar 2026 18:45:43 +0800
Message-Id: <20260317104543.4367-1-leonchen.oss@139.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225810-lists,stable=lfdr.de];
	DMARC_NA(0.00)[139.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[leonchen.oss@139.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.913];
	DKIM_TRACE(0.00)[139.com:-];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F2CD2A84C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

[ Upstream commit d11a67634227f9f9da51938af085fb41a733848f ]

Ethtool callbacks can be executed while reset is in progress and try to
access deleted resources, e.g. getting coalesce settings can result in a
NULL pointer dereference seen below.

Reproduction steps:
Once the driver is fully initialized, trigger reset:
	# echo 1 > /sys/class/net/<interface>/device/reset
when reset is in progress try to get coalesce settings using ethtool:
	# ethtool -c <interface>

BUG: kernel NULL pointer dereference, address: 0000000000000020
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 11 PID: 19713 Comm: ethtool Tainted: G S                 6.10.0-rc7+ #7
RIP: 0010:ice_get_q_coalesce+0x2e/0xa0 [ice]
RSP: 0018:ffffbab1e9bcf6a8 EFLAGS: 00010206
RAX: 000000000000000c RBX: ffff94512305b028 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff9451c3f2e588 RDI: ffff9451c3f2e588
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffff9451c3f2e580 R11: 000000000000001f R12: ffff945121fa9000
R13: ffffbab1e9bcf760 R14: 0000000000000013 R15: ffffffff9e65dd40
FS:  00007faee5fbe740(0000) GS:ffff94546fd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000020 CR3: 0000000106c2e005 CR4: 00000000001706f0
Call Trace:
<TASK>
ice_get_coalesce+0x17/0x30 [ice]
coalesce_prepare_data+0x61/0x80
ethnl_default_doit+0xde/0x340
genl_family_rcv_msg_doit+0xf2/0x150
genl_rcv_msg+0x1b3/0x2c0
netlink_rcv_skb+0x5b/0x110
genl_rcv+0x28/0x40
netlink_unicast+0x19c/0x290
netlink_sendmsg+0x222/0x490
__sys_sendto+0x1df/0x1f0
__x64_sys_sendto+0x24/0x30
do_syscall_64+0x82/0x160
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7faee60d8e27

Calling netif_device_detach() before reset makes the net core not call
the driver when ethtool command is issued, the attempt to execute an
ethtool command during reset will result in the following message:

    netlink error: No such device

instead of NULL pointer dereference. Once reset is done and
ice_rebuild() is executing, the netif_device_attach() is called to allow
for ethtool operations to occur again in a safe manner.

Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
[ Minor changed in ice_prepare_for_reset() to make sure vsi available to
access ]
Signed-off-by: Leon Chen <leonchen.oss@139.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index db5319a8eb24..0403391b3680 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -479,6 +479,7 @@ static void
 ice_prepare_for_reset(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 	unsigned int i;
 
 	/* already prepared for reset */
@@ -495,6 +496,9 @@ ice_prepare_for_reset(struct ice_pf *pf)
 	ice_for_each_vf(pf, i)
 		ice_set_vf_state_qs_dis(&pf->vf[i]);
 
+	if (vsi && vsi->netdev)
+		netif_device_detach(vsi->netdev);
+
 	/* clear SW filtering DB */
 	ice_clear_hw_tbls(hw);
 	/* disable the VSIs and their queues that are not already DOWN */
@@ -6417,6 +6421,7 @@ static void ice_update_pf_netdev_link(struct ice_pf *pf)
  */
 static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 {
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	enum ice_status ret;
@@ -6538,6 +6543,9 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		ice_rebuild_arfs(pf);
 	}
 
+	if (vsi && vsi->netdev)
+		netif_device_attach(vsi->netdev);
+
 	ice_update_pf_netdev_link(pf);
 
 	/* tell the firmware we are up */
-- 
2.35.3



