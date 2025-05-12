Return-Path: <stable+bounces-143766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F27AB4134
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452E1468009
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8E32550A7;
	Mon, 12 May 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SY2ZmACT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EC175BF;
	Mon, 12 May 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073009; cv=none; b=lncTY8PTc9OOqQU/yPutW0lsH0ZhL/OdaXm5panEQcQPxHicA5Wtp169L4S87YIKEZtsbErEAC3LdrQa2ja3gzIjMHKBTp/Q3MeSFFIDl7bfo62O5YkFDUMBW7Hkz/cgWaVAjTKAHGquFo3oZZQeZ6s05a8JDftXrDDuAjdbL1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073009; c=relaxed/simple;
	bh=QFjSUfJDAnLk/LLvY/Rl6LfXgjQCspz/pDA5ycRYfyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnT3qrfompOypeQ0wEd0JWoFnFMxip/dKCIL0c5Ns3OzyXB3LK14Ma8DGVAj+YwRfmza37umTOpE0raXTe7dgqE3XGf58jWrxBU3iQFHGFzsjBzmBh1Hm2aNw7oCJtC7EflSHPlwHsi/C2HjohqX1ZXp1NDhU/e8Y2+6vHPcyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SY2ZmACT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ECFC4CEE7;
	Mon, 12 May 2025 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073008;
	bh=QFjSUfJDAnLk/LLvY/Rl6LfXgjQCspz/pDA5ycRYfyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SY2ZmACT7/GE/h++2qUxK2XEnu6KaU9OBd2Nfw++PpvEacJzeocVJ0jTa1tCoM9pZ
	 Yahh3Qzgeg9hbNMWljjJ+ILIEsURF8Be6RMMflQws/v6qL1yY/BSjQ5xZ3jTPPWoo9
	 CfsBFHpNdjNC6QBd5BDQbW6C/mFp6dtXGtaRRy3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	RD Babiera <rdbabiera@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.12 124/184] usb: typec: tcpm: delay SNK_TRY_WAIT_DEBOUNCE to SRC_TRYWAIT transition
Date: Mon, 12 May 2025 19:45:25 +0200
Message-ID: <20250512172046.869858228@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: RD Babiera <rdbabiera@google.com>

commit e918d3959b5ae0e793b8f815ce62240e10ba03a4 upstream.

This patch fixes Type-C Compliance Test TD 4.7.6 - Try.SNK DRP Connect
SNKAS.

The compliance tester moves into SNK_UNATTACHED during toggling and
expects the PUT to apply Rp after tPDDebounce of detection. If the port
is in SNK_TRY_WAIT_DEBOUNCE, it will move into SRC_TRYWAIT immediately
and apply Rp. This violates TD 4.7.5.V.3, where the tester confirms that
the PUT attaches Rp after the transitions to Unattached.SNK for
tPDDebounce.

Change the tcpm_set_state delay between SNK_TRY_WAIT_DEBOUNCE and
SRC_TRYWAIT to tPDDebounce.

Fixes: a0a3e04e6b2c ("staging: typec: tcpm: Check for Rp for tPDDebounce")
Cc: stable <stable@kernel.org>
Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250429234703.3748506-2-rdbabiera@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5890,7 +5890,7 @@ static void _tcpm_cc_change(struct tcpm_
 	case SNK_TRY_WAIT_DEBOUNCE:
 		if (!tcpm_port_is_sink(port)) {
 			port->max_wait = 0;
-			tcpm_set_state(port, SRC_TRYWAIT, 0);
+			tcpm_set_state(port, SRC_TRYWAIT, PD_T_PD_DEBOUNCE);
 		}
 		break;
 	case SRC_TRY_WAIT:



