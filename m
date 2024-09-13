Return-Path: <stable+bounces-76031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A1497789D
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 08:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4BA1F25CFF
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 06:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B6187356;
	Fri, 13 Sep 2024 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="gMP7rxpX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5915666D
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207595; cv=none; b=fWAIxqatZTgte0cmIRXgWBk1iPrmEPR4bX1KJUqCI9AzeT2mAieJ9amM5Op+d1rYKOQAqsL48VBTGjVEmQDc6gaX3GKJpf7O/4oGOvq9FgwW/nU4dbOUhyoHLzApHNAemNjpqYqdi+8LrlRxpJZwI4+wbot07V2VSu+AAju/EgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207595; c=relaxed/simple;
	bh=c6Hu5CnM4BdwvovbL1B+FTv8bvzkAJlZ365AHjO9B58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=reVcxH2yD55iABBUgq5ja350x2VXckQacCe6UTC5EUcYELv3RHmUL49+1A3OkA8QYmwkfikhXjD7J+XIMDls7w6hHVDLeuQ7PiNG7rJ6HnenKI0i4o4xpYeicLFNjoG+oRuQu16Dhbaimd5Cfa8BQYm7k47vFPJ3MUX0E3lx7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=gMP7rxpX; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1726207592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c6Hu5CnM4BdwvovbL1B+FTv8bvzkAJlZ365AHjO9B58=;
	b=gMP7rxpXEXTt10gACyvMldvmjGunKKU7c6Z/spqA7qFs+8TIuw8N6TgN45dAA17gcpMWOL
	+g+4as4y1jHjmVSVLadoL4yI+OO6psLCjzqkWmjCp0bX5ppBOQ/8n72AfYaMYbGH5FtMtr
	bzf5aMG+GSxcr7Wf+Z55G032KQA5aVY=
Received: from g7t16451g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.73.128.137]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-ZHRi_eTnNJmDdQywcIsKjw-1; Fri, 13 Sep 2024 02:06:30 -0400
X-MC-Unique: ZHRi_eTnNJmDdQywcIsKjw-1
Received: from g8t01565g.inc.hpicorp.net (g8t01565g.inc.hpicorp.net [15.60.11.226])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g7t16451g.inc.hp.com (Postfix) with ESMTPS id 7B19C6000C98;
	Fri, 13 Sep 2024 06:06:29 +0000 (UTC)
Received: from mail.hp.com (unknown [15.32.134.51])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g8t01565g.inc.hpicorp.net (Postfix) with ESMTPS id 90180212D3;
	Fri, 13 Sep 2024 06:06:28 +0000 (UTC)
Received: from cdc-linux-buildsrv17.. (localhost [127.0.0.1])
	by mail.hp.com (Postfix) with ESMTP id 6A80DA40465;
	Fri, 13 Sep 2024 13:58:53 +0800 (CST)
From: Wade Wang <wade.wang@hp.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wade.wang@hp.com
Cc: stable@vger.kernel.org
Subject: [PATCH] HID: plantronics: Update to map micmute controls
Date: Fri, 13 Sep 2024 13:58:51 +0800
Message-Id: <20240913055851.1322592-1-wade.wang@hp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

telephony page of Plantronics headset is ignored currently, it caused
micmute button no function, Now follow native HID key mapping for
telephony page map, telephony micmute key is enabled by default

Signed-off-by: Wade Wang <wade.wang@hp.com>
---
 drivers/hid/hid-plantronics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
index 2a19f3646ecb..2d17534fce61 100644
--- a/drivers/hid/hid-plantronics.c
+++ b/drivers/hid/hid-plantronics.c
@@ -77,10 +77,10 @@ static int plantronics_input_mapping(struct hid_device =
*hdev,
 =09=09}
 =09}
 =09/* handle standard types - plt_type is 0xffa0uuuu or 0xffa2uuuu */
-=09/* 'basic telephony compliant' - allow default consumer page map */
+=09/* 'basic telephony compliant' - allow default consumer & telephony pag=
e map */
 =09else if ((plt_type & HID_USAGE) >=3D PLT_BASIC_TELEPHONY &&
 =09=09 (plt_type & HID_USAGE) !=3D PLT_BASIC_EXCEPTION) {
-=09=09if (PLT_ALLOW_CONSUMER)
+=09=09if (PLT_ALLOW_CONSUMER || (usage->hid & HID_USAGE_PAGE) =3D=3D HID_U=
P_TELEPHONY)
 =09=09=09goto defaulted;
 =09}
 =09/* not 'basic telephony' - apply legacy mapping */
--=20
2.34.1


