Return-Path: <stable+bounces-223968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHJCMGz9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C72F24A423
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA95A318B923
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129B2D24B7;
	Tue, 10 Mar 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1m3NjQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9F2BF3E2;
	Tue, 10 Mar 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141102; cv=none; b=lyJ7PGelida63obK6QMkW9zyXrior595VuuqGfLLXfdIINv+09xZwoYTozQKrWiUpOvF8AIJySNaQU4pttCsrryL+AxJvMzKu7gOsBRRSCXf/4NF1AagHkBNe22EkVjhA4pbHHv462kcIkkmPt0NqnSBQvMRlU5w6/48RhqgQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141102; c=relaxed/simple;
	bh=Hh591+xD1Nclp492E0PdaKSIxwUvAMs8sCX2/GhP1C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1bpFwbZlNf7TuMHjx4+Ib6IJuTc+2ER/HMuCzcoX0SMv2/6rk/WnXMHEis7FWqvmp4Fr5y6Q10KHO+Y0XscgbALi/ZDu5jeqkppTV5wLIaYobFDl13CT75542Hu2XPkqvL/2uhPa0+nLohJIKpLzrW/HEVVoCw5CbEdUf1XZSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1m3NjQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D2FC2BC86;
	Tue, 10 Mar 2026 11:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141102;
	bh=Hh591+xD1Nclp492E0PdaKSIxwUvAMs8sCX2/GhP1C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1m3NjQLjitCcpwuyZVQsZ8VpSpqpT3+v2JwCw34QKOP3ahxZAUAAyjT52cTTJIzo
	 R1nFhqEzYUbxjq0nf7JVhGUAmJ/qT5taL9Yu0hHHCTlO1jOW6BmRv9/lBQ09rVRI8K
	 axQ7PqQXEz6Fz5jRBb+eHtmG8EXvavOCxCxnAdd5gZx5dLTpLp/TBbROeNPmTOflNU
	 TbbcWVWd74vJ/jCJVdaMKc9IqiylUf0MPhn60+v04wpU4m9EZIzdzNmO0QLrEBvZSr
	 xpRUhLRr1WHJgp4XTkiNrwGOzVQC2c3+Ox3jTJ+Rx1PWTF2BBuKEYslQCQo5z4yukN
	 f3nKOVS2tbgGw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.19 103/311] nfc: pn533: properly drop the usb interface reference on disconnect
Date: Tue, 10 Mar 2026 07:02:30 -0400
Message-ID: <bc3b8681b4e273297afe144982d7d419a3ecd92e.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C72F24A423
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223968-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Action: no action

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 12133a483dfa832241fbbf09321109a0ea8a520e upstream.

When the device is disconnected from the driver, there is a "dangling"
reference count on the usb interface that was grabbed in the probe
callback.  Fix this up by properly dropping the reference after we are
done with it.

Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: c46ee38620a2 ("NFC: pn533: add NXP pn533 nfc device driver")
Link: https://patch.msgid.link/2026022329-flashing-ought-7573@gregkh
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/pn533/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index 018a80674f06e..0f12f86ebb023 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -628,6 +628,7 @@ static void pn533_usb_disconnect(struct usb_interface *interface)
 	usb_free_urb(phy->out_urb);
 	usb_free_urb(phy->ack_urb);
 	kfree(phy->ack_buffer);
+	usb_put_dev(phy->udev);
 
 	nfc_info(&interface->dev, "NXP PN533 NFC device disconnected\n");
 }
-- 
2.51.0


