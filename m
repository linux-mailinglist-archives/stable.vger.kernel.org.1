Return-Path: <stable+bounces-270128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X5sNH5PpRGr+2woAu9opvQ
	(envelope-from <stable+bounces-270128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:18:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F26EC068
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:18:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=J3tFyGAg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270128-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270128-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 901ED30344E4
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3440DFD9;
	Wed,  1 Jul 2026 10:18:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91D40B39F
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 10:18:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901117; cv=none; b=Cq2ANde7rbpw8n8za+pOAN+VmTRVXBuHpiu68/3+JEiHTrubNX2Jp1/jTFktBJE6uNGL/BT/7c/nEuhMTH2MHI4FLcMOVGeekj0eYboI6sPIei9rE1P6qtsgICfeBSR6m09lrToSUd0iMRqovCNBHrB0PdRoiHW5vzQiYAF8uIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901117; c=relaxed/simple;
	bh=kvLyuRe9D7WbnGLttVyglhdwKtXJoydg9KcgCYYzFls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWqK3i3uk8EsHFf6ctSZxOFoI9aSOqp9eG+FLXxqoooma2k5nd4UnK1XKfieb+G51ncMqzyyJ53rErcFqYYMSNmIPUm2vUa3qiGi9ckUz1I/SQJjPtTZCTCCCBUiA+c0XpwOL2VOYcEgnqmjAVfKAhuFHRPYDv3e5HyRkXS3UE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3tFyGAg; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782901115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AIb0aVoAuZLgnmmFOQkbVKf1JhNZALcK4GmvrwRR/Ew=;
	b=J3tFyGAgm0NtBnvmFEkvZcvEd0gxHCBq+pQtjOyjNUpv9ZA+J/zX1UdB1gR8K0lZ4sXpEt
	BJyr3XlTS3/dQsjSMTblyZT0loO+yXzdv0FvFTaexcz4t6Yg2CA9r3Q9cvAcMkfEcBUP5S
	U9cj5cChHy/IU+VOwI7N/6NXfLJRTJU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-1zAQ_GYINI6Y8xiFz9n3ng-1; Wed,
 01 Jul 2026 06:18:32 -0400
X-MC-Unique: 1zAQ_GYINI6Y8xiFz9n3ng-1
X-Mimecast-MFC-AGG-ID: 1zAQ_GYINI6Y8xiFz9n3ng_1782901111
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD639184B0A9;
	Wed,  1 Jul 2026 10:18:30 +0000 (UTC)
Received: from nixos.redhat.com (unknown [10.44.49.208])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E152A36936;
	Wed,  1 Jul 2026 10:18:27 +0000 (UTC)
From: Sascha Grunert <sgrunert@redhat.com>
To: linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sascha Grunert <sgrunert@redhat.com>
Subject: [PATCH 0/2] usbip: fix device disconnect loop with isoc endpoints
Date: Wed,  1 Jul 2026 12:18:24 +0200
Message-ID: <20260701101826.894848-1-sgrunert@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,zenithal.me,linuxfoundation.org,vger.kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270128-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[sgrunert@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-usb@vger.kernel.org,m:valentina.manea.m@gmail.com,m:shuah@kernel.org,m:i@zenithal.me,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:sgrunert@redhat.com,m:valentinamaneam@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgrunert@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB9F26EC068

Forwarding a USB device with isochronous endpoints over USB/IP causes a
disconnect/reconnect loop. Hit this with a Turtle Beach Velocity One
Flight yoke (10f5:7001) forwarded to a VM.

The first patch fixes a TCP stream desync: when get_pipe() returns -1,
the remaining PDU payload stays on the socket and corrupts the next
header parse. The second patch prevents activation of alt settings with
isoc endpoints, since USB/IP cannot forward them and the failed
transfers cascade into a device disconnect.

Sascha Grunert (2):
  usbip: drain remaining PDU payload on rejected endpoint
  usbip: block SET_INTERFACE for isoc alt settings

 drivers/usb/usbip/stub_rx.c | 96 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

-- 
2.52.0


