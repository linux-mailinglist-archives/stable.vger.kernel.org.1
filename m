Return-Path: <stable+bounces-9511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35F18232B5
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BAD1F24DEE
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831E81C288;
	Wed,  3 Jan 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cbWimC6U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E61BDEC;
	Wed,  3 Jan 2024 17:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8E9C433C7;
	Wed,  3 Jan 2024 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301832;
	bh=bmRQXjW8W6iy5DHL/ykuavClNfy0mv/gOZLvAg6Tu08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbWimC6UEwrjSvVVXfDmUyBLz00P1U2zLPvFZ9EAllSOCGa85/tDhMjG/rK90GAAT
	 3Rgy01BSqvffDjhZofqpqKATsoV8dy9ko+wmAx9nghA2EYwR+iAauCljskqY6jqHEg
	 bmsCZo2koaigi1vWuYIHwMtNFkG1zteyzcbzyhJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.10 42/75] Input: soc_button_array - add mapping for airplane mode button
Date: Wed,  3 Jan 2024 17:55:23 +0100
Message-ID: <20240103164849.520161811@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>
References: <20240103164842.953224409@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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



