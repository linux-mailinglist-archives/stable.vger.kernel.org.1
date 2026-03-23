Return-Path: <stable+bounces-229747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KjMJ7FswWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E25172F888F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D70631AACB7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62643AE6E6;
	Mon, 23 Mar 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WNx27qlk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4A282F35;
	Mon, 23 Mar 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282759; cv=none; b=NpKBWv+jgeDOAZGXJ4mel1gQ9eRJeaLD90+n8GSaNG4qnSscq3sKBlT8kaiQq/jcK37AMMNODB6k1FoaEeWpPWTYhyFFIVBhryCY9mjAPp3xF6f3/PxMMbD4gFK45CHP941+mT6kVO9gonttxil5DDRc6soIiXIlW1aMvoyChjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282759; c=relaxed/simple;
	bh=ftV4tm+4OEq+hOOW5YZq/0aBh7SyFpW5YzzalepsHbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9zOUzmRdA0uw1JhjyjHYah5/Ch8XyxeoI3qeUQzBoBuHWMEitQcaksqQDs7zRpReBt3Z7+H92KFs5EKWw9tCnAX4MutfL9mEdg1SPyiq52zfS8MAw0hSyptj286QABOhNwpobH3WJY0fBqpZaPoY9TclAQofsPv432MHHrMMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WNx27qlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16061C4CEF7;
	Mon, 23 Mar 2026 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282759;
	bh=ftV4tm+4OEq+hOOW5YZq/0aBh7SyFpW5YzzalepsHbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNx27qlkGu7Djt9luc8PtgtokmbHr2WS68krfQecso+zfBD5kRN7jiVJcs2BaVq3M
	 +yzO4f2irVJTjUTLTsovtNEWtDT+31xGZ415mGzDr15Ns/4IV4ZL88GzNNgtaE6SKy
	 4anGqZ31MS8Q0z43zACDJHQN5rhSdtsWUuifpkxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.1 273/481] i3c: mipi-i3c-hci: Use ETIMEDOUT instead of ETIME for timeout errors
Date: Mon, 23 Mar 2026 14:44:15 +0100
Message-ID: <20260323134531.782439165@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229747-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E25172F888F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 4167b8914463132654e01e16259847d097f8a7f7 upstream.

The MIPI I3C HCI driver currently returns -ETIME for various timeout
conditions, while other I3C master drivers consistently use -ETIMEDOUT
for the same class of errors.  Align the HCI driver with the rest of the
subsystem by replacing all uses of -ETIME with -ETIMEDOUT.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-2-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c |    2 +-
 drivers/i3c/master/mipi-i3c-hci/cmd_v2.c |    2 +-
 drivers/i3c/master/mipi-i3c-hci/core.c   |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
@@ -335,7 +335,7 @@ static int hci_cmd_v1_daa(struct i3c_hci
 		hci->io->queue_xfer(hci, xfer, 1);
 		if (!wait_for_completion_timeout(&done, HZ) &&
 		    hci->io->dequeue_xfer(hci, xfer, 1)) {
-			ret = -ETIME;
+			ret = -ETIMEDOUT;
 			break;
 		}
 		if (RESP_STATUS(xfer[0].response) == RESP_ERR_NACK &&
--- a/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c
@@ -277,7 +277,7 @@ static int hci_cmd_v2_daa(struct i3c_hci
 		hci->io->queue_xfer(hci, xfer, 2);
 		if (!wait_for_completion_timeout(&done, HZ) &&
 		    hci->io->dequeue_xfer(hci, xfer, 2)) {
-			ret = -ETIME;
+			ret = -ETIMEDOUT;
 			break;
 		}
 		if (RESP_STATUS(xfer[0].response) != RESP_SUCCESS) {
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -237,7 +237,7 @@ static int i3c_hci_send_ccc_cmd(struct i
 		goto out;
 	if (!wait_for_completion_timeout(&done, HZ) &&
 	    hci->io->dequeue_xfer(hci, xfer, nxfers)) {
-		ret = -ETIME;
+		ret = -ETIMEDOUT;
 		goto out;
 	}
 	for (i = prefixed; i < nxfers; i++) {
@@ -311,7 +311,7 @@ static int i3c_hci_priv_xfers(struct i3c
 		goto out;
 	if (!wait_for_completion_timeout(&done, HZ) &&
 	    hci->io->dequeue_xfer(hci, xfer, nxfers)) {
-		ret = -ETIME;
+		ret = -ETIMEDOUT;
 		goto out;
 	}
 	for (i = 0; i < nxfers; i++) {
@@ -359,7 +359,7 @@ static int i3c_hci_i2c_xfers(struct i2c_
 		goto out;
 	if (!wait_for_completion_timeout(&done, HZ) &&
 	    hci->io->dequeue_xfer(hci, xfer, nxfers)) {
-		ret = -ETIME;
+		ret = -ETIMEDOUT;
 		goto out;
 	}
 	for (i = 0; i < nxfers; i++) {



