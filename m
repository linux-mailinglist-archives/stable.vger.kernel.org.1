Return-Path: <stable+bounces-175818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5A3B36A6A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AE09844CA
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D476B35206F;
	Tue, 26 Aug 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="grPA3PzL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA034DCF2;
	Tue, 26 Aug 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218049; cv=none; b=dOgKGPd6AY8VtnzZbIGKIxPuI0TeRFxbJxbPDldKaIPeatYnaXH1faFaOy8okUYHpCyVprFnDwgc7FomrWZpib2vYpEvpWjUhq5e7QMgpnfyYgG3cmZ1QGH/z/jwsDGQg/smZGAbm/rChn9xXkAAG8PqG80xn/3WFreAkpAuPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218049; c=relaxed/simple;
	bh=+9bD4+t/QnvfZsrfeBYzbDF6sDjpie8a6im4Kw+EYwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnndAWPkLTiWg4g/rOLc7pzMVcBI9rcuQ4AQCCN+j0Kn0LepfzFj5eU3lsiziYxFgRxLrsovvNyO1o4zdIucTKzl6uqdHc+wmis/I5lfTmkyewukDLDgzd1RygcubaGW2F+9F1pFMQ2ynay3ImFCGCCHs3t9TUkMforhyFbZMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=grPA3PzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BC6C4CEF1;
	Tue, 26 Aug 2025 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218049;
	bh=+9bD4+t/QnvfZsrfeBYzbDF6sDjpie8a6im4Kw+EYwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grPA3PzLEVxc346wuiT4b9wA0HtB3O4XKk36RGCdgpIToScEsc8VATqBrgL6wdjOF
	 NG2HeXg9wbIRMD3Ry8vmqwDLBHDg/W/Q5wJHIGQt1emikC+InSqkPvDDxqxiPtOVGM
	 szJhi/XWetfMtbA85vHkjV6YstyoCecQNibAuBOc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.10 343/523] usb: typec: ucsi: Update power_supply on power role change
Date: Tue, 26 Aug 2025 13:09:13 +0200
Message-ID: <20250826110932.928775149@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

commit 7616f006db07017ef5d4ae410fca99279aaca7aa upstream.

The current power direction of an USB-C port also influences the
power_supply's online status, so a power role change should also update
the power_supply.

Fixes an issue on some systems where plugging in a normal USB device in
for the first time after a reboot will cause upower to erroneously
consider the system to be connected to AC power.

Cc: stable <stable@kernel.org>
Fixes: 0e6371fbfba3 ("usb: typec: ucsi: Report power supply changes")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250721-fix-ucsi-pwr-dir-notify-v1-1-e53d5340cb38@qtmlabs.xyz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -779,6 +779,7 @@ static void ucsi_handle_connector_change
 
 	if (con->status.change & UCSI_CONSTAT_CONNECT_CHANGE) {
 		typec_set_pwr_role(con->port, role);
+		ucsi_port_psy_changed(con);
 
 		switch (UCSI_CONSTAT_PARTNER_TYPE(con->status.flags)) {
 		case UCSI_CONSTAT_PARTNER_TYPE_UFP:



