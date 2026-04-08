Return-Path: <stable+bounces-234715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJHjJtOk1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:56:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2120E3C2003
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC78D3120665
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A172BEFFF;
	Wed,  8 Apr 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KH6oWplM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E63B19A3;
	Wed,  8 Apr 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673575; cv=none; b=BvWLBLx5pqeAfeapyxx7yrCcOuZvja+CGR0y/XVfWG7vzfb8iIdjKBkQbCghg7oVqKjmvwHCocAJ1U2P/XTTEINlS13yRZEpsoIbKU2GOkPcA7AKbX3LtrJUn7y92MkLIxrA3nL6mhe+kN3c41emaCKFK/KyAPw9tdeCUidOBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673575; c=relaxed/simple;
	bh=/IEQzfnlsusPIeMiH5fTjABEmDP+06yvrXja8W/+uM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8Lr8diuJSs0S1srBjr5UiiKOwB6g7Hw8+95ui6BTxHZA3JbgX+Ec436S72gXl6K1fORHJ/+aSfSpapB7qgpxnHfTg4rFVcHpS4nLIhwwTMAilKLlved4XLZWZTlsywK8kZGcXXuLL1nn189hksJlDhbo1G1wk4QsxsuqA+J+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KH6oWplM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12051C19421;
	Wed,  8 Apr 2026 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673575;
	bh=/IEQzfnlsusPIeMiH5fTjABEmDP+06yvrXja8W/+uM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KH6oWplMnFfDMTz2OiUs+p/QmW5vvkW1mqs0CvVjCz4ayf1ZNhlTguRdUiWVBsYeS
	 sxEYWqTaMDFwQDTXkBPi4baLTJnlq7qQhLB6W/rFRgl/ZVqDeO4qG2j1SclAUCCqKx
	 /VmU16Zd1Aj9lRk4GeGeXeY0jV67sSA5bEOhSDAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH 6.18 249/277] usb: typec: ucsi: validate connector number in ucsi_notify_common()
Date: Wed,  8 Apr 2026 20:03:54 +0200
Message-ID: <20260408175943.156208491@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-234715-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,linux.intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 2120E3C2003
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Rebello <nathan.c.rebello@gmail.com>

commit d2d8c17ac01a1b1f638ea5d340a884ccc5015186 upstream.

The connector number extracted from CCI via UCSI_CCI_CONNECTOR() is a
7-bit field (0-127) that is used to index into the connector array in
ucsi_connector_change(). However, the array is only allocated for the
number of connectors reported by the device (typically 2-4 entries).

A malicious or malfunctioning device could report an out-of-range
connector number in the CCI, causing an out-of-bounds array access in
ucsi_connector_change().

Add a bounds check in ucsi_notify_common(), the central point where CCI
is parsed after arriving from hardware, so that bogus connector numbers
are rejected before they propagate further.

Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
Cc: stable <stable@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
Link: https://patch.msgid.link/20260313222453.123-1-nathan.c.rebello@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -42,8 +42,13 @@ void ucsi_notify_common(struct ucsi *ucs
 	if (cci & UCSI_CCI_BUSY)
 		return;
 
-	if (UCSI_CCI_CONNECTOR(cci))
-		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+	if (UCSI_CCI_CONNECTOR(cci)) {
+		if (UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
+			ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+		else
+			dev_err(ucsi->dev, "bogus connector number in CCI: %lu\n",
+				UCSI_CCI_CONNECTOR(cci));
+	}
 
 	if (cci & UCSI_CCI_ACK_COMPLETE &&
 	    test_and_clear_bit(ACK_PENDING, &ucsi->flags))



