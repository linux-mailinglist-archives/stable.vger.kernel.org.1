Return-Path: <stable+bounces-23120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC60485DF5C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763DC28476E
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D137D7A708;
	Wed, 21 Feb 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mqVxJzb9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9151E7BB11;
	Wed, 21 Feb 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525634; cv=none; b=FKmgTXGN/82++RRtnIm6W3Jhv2MI4nb9IdDuCZbrXnavaAQM0WSQxAXufM2wuWYVSCxLEG2keWmznPwr9+H8XbuQmf5+ghhG3kZOwG4BlvChxyXUxpGxQYQeY33i1YPWGnVjNskK+uroytgW/m2qv+ZunIYgxDpLkZ1v9zbADa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525634; c=relaxed/simple;
	bh=ocVRjMoqs+FiyfKAPluJdPYBVZo2hha39bLY1MP6rYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+f08XdVqXpPmPt76U08w7zmqDZjSNeI+oKVQy6Yi5YEVZxxFoFpksHjf/qUeuRxAUQFN0bm9RG0KIC8SpGmjYk6eHcTELVU/X4r8J/qGiwCTolkUZjgSapxmfqbWXS5DyEiOJ4Y4/0sa0q8IrIBpROujhCVQNLuwbkjvASleYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mqVxJzb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF93C433F1;
	Wed, 21 Feb 2024 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525634;
	bh=ocVRjMoqs+FiyfKAPluJdPYBVZo2hha39bLY1MP6rYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqVxJzb9fhD0bsU2a8da7VHieR4KBOP9VMs93EfbLz2HHsptuI+Vgxb5YYgw2lDc0
	 w5yeMl2Y47+N+Lv5fhVJHOHOk8fziwhz1hxmYK447P5pczTE1MPYybj0vqJ5mTXHXH
	 oZh0Hphcnp741M3jSAb3V7BBkN9GIuqBEgWqJegs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Tatsunosuke Tobita <tatsunosuke.tobita@wacom.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 5.4 215/267] HID: wacom: generic: Avoid reporting a serial of 0 to userspace
Date: Wed, 21 Feb 2024 14:09:16 +0100
Message-ID: <20240221125946.963556675@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tatsunosuke Tobita <tatsunosuke.tobita@wacom.com>

commit ab41a31dd5e2681803642b6d08590b61867840ec upstream.

The xf86-input-wacom driver does not treat '0' as a valid serial
number and will drop any input report which contains an
MSC_SERIAL = 0 event. The kernel driver already takes care to
avoid sending any MSC_SERIAL event if the value of serial[0] == 0
(which is the case for devices that don't actually report a
serial number), but this is not quite sufficient.
Only the lower 32 bits of the serial get reported to userspace,
so if this portion of the serial is zero then there can still
be problems.

This commit allows the driver to report either the lower 32 bits
if they are non-zero or the upper 32 bits otherwise.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Tatsunosuke Tobita <tatsunosuke.tobita@wacom.com>
Fixes: f85c9dc678a5 ("HID: wacom: generic: Support tool ID and additional tool types")
CC: stable@vger.kernel.org # v4.10
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_wac.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2540,7 +2540,14 @@ static void wacom_wac_pen_report(struct
 				wacom_wac->hid_data.tipswitch);
 		input_report_key(input, wacom_wac->tool[0], sense);
 		if (wacom_wac->serial[0]) {
-			input_event(input, EV_MSC, MSC_SERIAL, wacom_wac->serial[0]);
+			/*
+			 * xf86-input-wacom does not accept a serial number
+			 * of '0'. Report the low 32 bits if possible, but
+			 * if they are zero, report the upper ones instead.
+			 */
+			__u32 serial_lo = wacom_wac->serial[0] & 0xFFFFFFFFu;
+			__u32 serial_hi = wacom_wac->serial[0] >> 32;
+			input_event(input, EV_MSC, MSC_SERIAL, (int)(serial_lo ? serial_lo : serial_hi));
 			input_report_abs(input, ABS_MISC, sense ? id : 0);
 		}
 



