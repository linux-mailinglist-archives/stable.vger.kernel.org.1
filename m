Return-Path: <stable+bounces-232879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIumFGa0zWnJfwYAu9opvQ
	(envelope-from <stable+bounces-232879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 02:12:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F9E381E98
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 02:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ED2A3071694
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 00:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6262F851;
	Thu,  2 Apr 2026 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iSMagunR"
X-Original-To: stable@vger.kernel.org
Received: from outbound.mr.icloud.com (p-west2-cluster2-host2-snip4-10.eps.apple.com [57.103.68.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B21A294
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088599; cv=none; b=cE89qSruE+Bx78UZulgtumxr+6wb/zeoPZHW3zCk8UL9kLjA0ayv2ZrWqaBTK5nxwbT5NmJbyLrpcWKHTaRKcgz3fdV3Rc70i8UYqFAnnZGclyBwgQ7RyHuxzDl+zGTkSrvIA2wZEkUaxdR2MPwimnWqi0vY9lJzaXInbJbSkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088599; c=relaxed/simple;
	bh=v53V7g1V8tTzWSmrHGzZibB9+U0z5hWEJC9YW6+BcBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBO4yac6w5L8w8L/A2KxAVJ1eMuVKzm0KcuDbakghGDtbi8vw3jqmqgYcqHgX4W35q6eIX2FZ0RZg3t0VlJJZQ8MdMknBzNSxLGzUlYH2B/egL5GwQgzY9Z3SzN1D2JxXE5r9Htx3rTEcVPuRdUmLIOGVm5ZfpWC7n16P93S6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=iSMagunR; arc=none smtp.client-ip=57.103.68.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPS id 4CA5518001BE;
	Thu, 02 Apr 2026 00:09:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775088597; x=1777680597; bh=iEhD6I1AfA0RRQQAAbP4CVRxjAFzpgK6h+poLfMFR4c=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=iSMagunRQIvmIUDYf1c3UpVUcDlfhOho3FsJ3/Zov8HnBu7Ktjt+5QaEQevrOdi/UfTamXF8deh6A1I1Yw48UlEI541LhGmfNEycWXgiOc7Q149w2286QG3tsOlhvU3gT265JiFJKbfhTp3J5XADT7KmQvIK9HMjK+vzp19daUGZAvdOHThCxQTQxdSPdTgGXLhHLz0xOUGfZ5S1Hn4wTEs17wE99bMSe4O+Pi885ACLcSBVWEHZyVxJDNFr381wGsD59iO1b63z5ve4B9EVcIfs7Z6tI/caZ2/JlFGGp394x0HI5pBFvkm1bcEVHFHeCpWRqPw6aUFJnhBWDUpgTA==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPSA id DD35618000AA;
	Thu, 02 Apr 2026 00:09:54 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sven@kernel.org,
	Vincent Cloutier <vincent@cloutier.co>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] usb: typec: tipd: Restore generic TPS6598x contract interrupts
Date: Wed,  1 Apr 2026 20:09:50 -0400
Message-ID: <20260402000950.715470-1-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDIyNyBTYWx0ZWRfXzyqhj3gqqaxY
 wLMXImoYMclOSMrTV9ceW4kETSnz+XIAstrHhxvhNvuTO++B92LtRxsmqUW17BmzEv88ZJIJ5eJ
 hF8XAldmgqxc1LMAFBbk0a5IvEQngGMRj1eFKikB+CHJ6/48oV/B/6Bx9c09THRtT21K+0FQvAC
 JDc7QKWiFovb1BOHgfkHtajodagjkecShr+eUGTQ3pwsdX/cJtMGHooUiJTNBCurWqWaH2806VG
 Fozbd5gQtIVfAl4OszISVQQCxb3UWmZqyaGONy7Ws5yVMsyPjyBnf6bcAQkSPqgHNVtXmFpGeKg
 uPiN7YXi8josrU8YxHveVM/zqAfiQo2yMWsIQstaKgE5HhGgwJ9nhCyVOfq1ck=
X-Proofpoint-GUID: PkPConQ7h62PGs4UGwYcz8kF2uTlpDVS
X-Authority-Info-Out: v=2.4 cv=TK9Iilla c=1 sm=1 tr=0 ts=69cdb3d5
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=F8PtdawhZOR1Lvo1uHQA:9
X-Proofpoint-ORIG-GUID: PkPConQ7h62PGs4UGwYcz8kF2uTlpDVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_05,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxlogscore=754 malwarescore=0 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604010227
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232879-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.cloutier@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[icloud.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:mid,cloutier.co:email]
X-Rspamd-Queue-Id: C8F9E381E98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vincent Cloutier <vincent@cloutier.co>

The generic TPS6598x interrupt handler still relies on
PP_SWITCH_CHANGED, NEW_CONTRACT_AS_CONSUMER, HARD_RESET, and
STATUS_UPDATE, but the irq_mask1 refactor only kept
POWER_STATUS_UPDATE, DATA_STATUS_UPDATE, and PLUG_EVENT in
tps6598x_data.

On the librem5 that leaves PD partners stuck at the 500 mA fallback
because the active contract is never refreshed after attach.

Restore the missing interrupt bits so the existing handler paths are
reachable again. This fixes USB-C charging negotiation on the librem5:
after a replug the TPS6598x source power supply reports 3 A instead of
500 mA and the BQ25890 input limit follows suit.

Fixes: b3dddff502c5 ("usb: typec: tipd: Move initial irq mask to tipd_data")
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/usb/typec/tipd/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 84ee5687bb27..83f2fec6e34e 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -2395,7 +2395,11 @@ static const struct tipd_data tps6598x_data = {
 	.irq_handler = tps6598x_interrupt,
 	.irq_mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
 		     TPS_REG_INT_DATA_STATUS_UPDATE |
-		     TPS_REG_INT_PLUG_EVENT,
+		     TPS_REG_INT_PLUG_EVENT |
+		     TPS_REG_INT_PP_SWITCH_CHANGED |
+		     TPS_REG_INT_NEW_CONTRACT_AS_CONSUMER |
+		     TPS_REG_INT_HARD_RESET |
+		     TPS_REG_INT_STATUS_UPDATE,
 	.tps_struct_size = sizeof(struct tps6598x),
 	.register_port = tps6598x_register_port,
 	.unregister_port = tps6598x_unregister_port,
-- 
2.53.0


