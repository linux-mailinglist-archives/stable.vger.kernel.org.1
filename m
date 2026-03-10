Return-Path: <stable+bounces-224320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULkvMIQBsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:33:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9593E24AF87
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D84831171B8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD85389462;
	Tue, 10 Mar 2026 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWSKO/lu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F75387590;
	Tue, 10 Mar 2026 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142015; cv=none; b=n2J6MZR2vaUy4DnBmzyxUPnqhcKqtenzyLl7var3Ve/Ax4xWLGTQDgawKhrf/YjsaqVzZq3EcfmhmMdapHwx78qV/Qbx2yCAeySuK4t203u9WtDCJhCtP7VbFKI0veXYcOi7DbCL0lwHobJYVEYBzbe9LzDdsV/BPhRZtf+3+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142015; c=relaxed/simple;
	bh=8o6Lv28lOS+5vGTn8/bgXDYNKRaJzqu/+CVMSml+ZXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOpGFWdK5nxe3ZZXpQt07SFM9/qMH2P6ARcTLd+N7QIJyOpj7ENhoW+xiieSMnv/GIRcGad/tnWrabtS3+hS9M9Iis6bMmLQmKHNZeQxX/7VAmUsxQ6YdLZMWMozUYCFBMdt0WGpyKjJBqzhCrc6/So6JLtuo4GAwpZGbQ5Qm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWSKO/lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B21FC2BC86;
	Tue, 10 Mar 2026 11:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142014;
	bh=8o6Lv28lOS+5vGTn8/bgXDYNKRaJzqu/+CVMSml+ZXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pWSKO/luBgVrU5RT957F0PGIhfNQ13+4b+UYfYJ+ZVR4B/ChxTXiya5yLl+g0FTBy
	 UqEx7e5BW6qrtqImqBhXqSOpUymEIY+yUNUAPXrZ7NgEl1zE2VRYj0eMe96yxL2XNu
	 rYJhwFKySgGhzz09AkGrc9MyysZ+fWnKUg8naJFWzeCip4AKPNHsFraRXkocwtqWwg
	 gieP0+YcWq/45EsdEsu6pn+EmY0C8vpmdhXPEep1qZm01Yh+QUH7rjnS2ws4sqqmNV
	 foU0sot4dhJUJf29QVUlDNwWTOyIxTtsElXUQ4N/i6smW8BnbczIPx8iU89rpu7dRI
	 no6WMtzswNhKQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org
Subject: [PATCH 6.18 141/314] can: usb: f81604: handle short interrupt urb messages properly
Date: Tue, 10 Mar 2026 07:16:40 -0400
Message-ID: <d24917bd35bed67ab2eaeac1c0605c99bd3aa750.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9593E24AF87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224320-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 7299b1b39a255f6092ce4ec0b65f66e9d6a357af upstream.

If an interrupt urb is received that is not the correct length, properly
detect it and don't attempt to treat the data as valid.

Cc: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: stable@kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026022331-opal-evaluator-a928@gregkh
Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/f81604.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index 9e416cb642dcf..e87e2674ac585 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -626,6 +626,12 @@ static void f81604_read_int_callback(struct urb *urb)
 		netdev_info(netdev, "%s: Int URB aborted: %pe\n", __func__,
 			    ERR_PTR(urb->status));
 
+	if (urb->actual_length < sizeof(*data)) {
+		netdev_warn(netdev, "%s: short int URB: %u < %zu\n",
+			    __func__, urb->actual_length, sizeof(*data));
+		goto resubmit_urb;
+	}
+
 	switch (urb->status) {
 	case 0: /* success */
 		break;
-- 
2.51.0


