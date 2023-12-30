Return-Path: <stable+bounces-8851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C73820529
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701F3281B7A
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07BE79E0;
	Sat, 30 Dec 2023 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YfPXtuYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D5179DE;
	Sat, 30 Dec 2023 12:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2F4C433C8;
	Sat, 30 Dec 2023 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937927;
	bh=f97rsNMSLzgP4LwxHep3LQhYDcdqK8K3pDMMfDgSKM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YfPXtuYkEVYS8I2YBbMB2j46id6cS/P7wCRD/ksRJaw6bpVdzbFvQVvPCvd31Ctpr
	 IjUoQPDC9ukRMltVQtlkW5Y7wejhprCMWUPKu7UV1NLYbEN5u6aDmc45bq4do5RZbh
	 WInRmXjiuO+ddavYRkodwiyaBiwTR/DZbGOeM924=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.6 117/156] Input: soc_button_array - add mapping for airplane mode button
Date: Sat, 30 Dec 2023 11:59:31 +0000
Message-ID: <20231230115816.184476042@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Christoffer Sandberg <cs@tuxedo.de>

commit ea3715941a9b7d816a1e9096ac0577900af2a69e upstream.

This add a mapping for the airplane mode button on the TUXEDO Pulse Gen3.

While it is physically a key it behaves more like a switch, sending a key
down on first press and a key up on 2nd press. Therefor the switch event
is used here. Besides this behaviour it uses the HID usage-id 0xc6
(Wireless Radio Button) and not 0xc8 (Wireless Radio Slider Switch), but
since neither 0xc6 nor 0xc8 are currently implemented at all in
soc_button_array this not to standard behaviour is not put behind a quirk
for the moment.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Link: https://lore.kernel.org/r/20231215171718.80229-1-wse@tuxedocomputers.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/soc_button_array.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -299,6 +299,11 @@ static int soc_button_parse_btn_desc(str
 		info->name = "power";
 		info->event_code = KEY_POWER;
 		info->wakeup = true;
+	} else if (upage == 0x01 && usage == 0xc6) {
+		info->name = "airplane mode switch";
+		info->event_type = EV_SW;
+		info->event_code = SW_RFKILL_ALL;
+		info->active_low = false;
 	} else if (upage == 0x01 && usage == 0xca) {
 		info->name = "rotation lock switch";
 		info->event_type = EV_SW;



