Return-Path: <stable+bounces-227250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEHROSnFu2n1ngIAu9opvQ
	(envelope-from <stable+bounces-227250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:43:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7ED2C8E57
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B449C32195D9
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF093B6BE7;
	Thu, 19 Mar 2026 09:36:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBC3AF67F
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912977; cv=none; b=sB6TDiHxjfs+WkfIWJBm7ftjwTaF2+/aOHjPTx+TOEWY3E1hTtdTTaP3qq+JUpuEJkiQQWRqsZXKPv9X3ax41+l6gbYT5w91Wvsn+V//PyAszaa74tVLUdqJCzHyhlGmHo2Pa9CfrYuBOLqBQzuqimm64SiDL2gql1rArNglpjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912977; c=relaxed/simple;
	bh=gTVzdb8m7QG5g7UkDSopV2bxXllKZ06xKPWgp4i3Yyo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LVBxscGlJO7yAhcFyLbKYBHrhcmLy+AqI9K0KBP6uKnGOxDOt8xJp56aG6vzXPHQamiFDlEppiC5bjyNxeIDf+w1KIyvKgBdBaFNCa2WpLJa9SEFvHULUI4X/qMa5NXeg61khO1GDO5r3Lf/cyzBJvc/W6Uz5zpen83ChwJWUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003OA-P9; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013Da-10;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0W6D;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH 00/11] net/9p/usbg: series of fixes
Date: Thu, 19 Mar 2026 10:35:57 +0100
Message-Id: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH3Du2kC/2WMQQ7CIBBFr9LMWgxMCKmuvIfposLQzgYIVFLTc
 HexW5fv/5d3QKHMVOA+HJCpcuEYOqjLAHadw0KCXWdAiUYqHMUted6pCK3R4ui1NIjQ7ZTpPLr
 8nDqvXLaYP2e4qt/636hKSOGMMsr5l5/JPhKF5b3lGHi/OoKptfYFlTDjwKMAAAA=
X-Change-ID: 20260128-9pfixes-442c28f40622
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hyungjung Joo <jhj140711@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=gTVzdb8m7QG5g7UkDSopV2bxXllKZ06xKPWgp4i3Yyo=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OEKlr52jwzP7/WaPgjjldxaqOsMqc7fToUN
 wl1jwJZp8CJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDhAAKCRC/aVhE+XH0
 q6wOD/0V+1pb82HHuVL/IlBuBIwa83xMfszArPEDRYrkGxmgpO56ksPhsTVAN4jt+GsqmXnym3R
 veQfTDJsf1MqoWtb3pye7hVhQ834TOilgtlw8DstxHGMBrD9MZSoyd0yrIx8FM0rkDgfMQRXQap
 K2CCBf1umV2rCdu/f6rrogjvdXJfWKc3iRFi8zJQp+G3SlCYi0HyNJ6baBm2iJ87Hq4SuBHf3dR
 THvqfAPJYmv7jhcNNN/78ArviUWvbeQjEoFVf+OTl3KGzo86OQSFlIc4FMuFMNDifpI2RzPX6O1
 EZVm+zUvAZnAFQwgPLYuz/kKljrLWi3EsPS25/GAAeFI2gguQeiqgH/FjXW30pz8NrXv7yrOyU/
 eNcELJs4Pyw2tfG6xKzUaf4zwYnY/SXH36a5eCg7di1ne4hZeV7NxA8XcYID6THS26sWcE7BQgl
 5zSbVsmUjWnTRo3NBZ1ZJyjFAQVvI3y+72V64pTFXl2Yjzc3KmmaMzxKomYspovAixHERsiz+g8
 qOt/EXR8gkOOR7UUvsPpKD89fPA5qez9KsVxtLSENHaXwYqNy13xXxgVXMHLTE94n6YePiDFVGg
 gTG++IlAm8mFFgt2bzsMbzqpYzbIRIh1ZaKQKQDQnwAETDJlr+E6ekQhBnBo8n1XNWE3EJHPGfq
 tOhZ1Hc8NNEMsRA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_TO(0.00)[kernel.org,ionkov.net,codewreck.org,crudebyte.com,linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227250-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.grzeschik@pengutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C7ED2C8E57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series contains a bunch of patches to make the trans_usbg
interface more reliable. It adds some extra checks on critical
pathes and also solves the overall synchronisation of the daemon
with the gadget. The forwarder script also gained the daemon mode to
be run and recover any kind of disconnection.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Hyungjung Joo (1):
      net/9p/usbg: clear stale client pointer on close

Michael Grzeschik (10):
      net/9p/usbg: also disable endpoints on p9_usbg_close
      net/9p/usbg: set client to Disconnected on usb9pfs_disable
      net/9p/usbg: always reset completion when disconnecting
      net/9p/usbg: only rely on one completion
      net/9p/usbg: add timeout for usbg_request
      net/9p/usbg: add extra interface for status change
      tools/usb/p9_fwd: catch if claim_interface is not working
      tools/usb/p9_fwd: catch write or read errors on disconnect
      tools/usb/p9_fwd: add daemon loop
      tools/usb/p9_fwd: set new introduced alt mode 1 on interface 1

 net/9p/trans_usbg.c | 211 +++++++++++++++++++++++++++++++++++++++++-----------
 tools/usb/p9_fwd.py |  67 +++++++++++++----
 2 files changed, 218 insertions(+), 60 deletions(-)
---
base-commit: 8a30aeb0d1b4e4aaf7f7bae72f20f2ae75385ccb
change-id: 20260128-9pfixes-442c28f40622

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


