Return-Path: <stable+bounces-226807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCIAOBqPuWnQKQIAu9opvQ
	(envelope-from <stable+bounces-226807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:27:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D322AF9A0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4777B30A49FA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA623346A0;
	Tue, 17 Mar 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGstgmjb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0932AAC5;
	Tue, 17 Mar 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768269; cv=none; b=hhli/VjH90IcGpr1lgPKAhfY5G/V/OYwGNmb5iudTWXKJC6Jj96g6+8qGozRsvvHFVMmzXbMnGrXnTpaOgs3gPeu/HDd1ECv8iGx1zUdaJmTpA3syp7hf1EO4pJXiDJ8yYFk+OSRAb5Scb1syZV1EWbw4IYBdJ5DVyJiv561NRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768269; c=relaxed/simple;
	bh=zYBw4uOKHKNWisJoKAQLGqo8ohP0aZntGR7u20j0U2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMUk7bYR4IOwfdDu3ngdJCy6cUVZjgW+YLJq+i0gaO5L6O69WsaeSqKCWBPyTni2jTvOcTV7IpZUxCjt1ehofHWfZKDcER3rE+PrSbsccRZ4g9HL3q7YSMdEQrJN6MBSyHxbNI+/tqeby581ioerpssBsKsYGN6NiP/fKOu63LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TGstgmjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBCFC19424;
	Tue, 17 Mar 2026 17:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768269;
	bh=zYBw4uOKHKNWisJoKAQLGqo8ohP0aZntGR7u20j0U2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGstgmjbHItDc+oJIktgVeICsIhsvr0qvrKpU5HABxr5Rpf+6JCQoxvwqfjgF3kV/
	 I+mZrnHV5Q2DB7+qDIn/2+MJbzQsxbN3n3M0qRulqvUei7cxGs/7ZXxTA8UAzVKqMs
	 w3ZXEDCYJLb6uXuik1h6cVBECJlsirZheC8ByBAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ingo Franzki <ifranzki@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.18 272/333] s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute
Date: Tue, 17 Mar 2026 17:35:01 +0100
Message-ID: <20260317163009.477783815@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226807-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5D322AF9A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harald Freudenberger <freude@linux.ibm.com>

commit 598bbefa8032cc58b564a81d1ad68bd815c8dc0f upstream.

The serialnr sysfs attribute for CCA cards when queried always
used the default domain for sending the request down to the card.
If for any reason exactly this default domain is disabled then
the attribute code fails to retrieve the CCA info and the sysfs
entry shows an empty string. Works as designed but the serial
number is a card attribute and thus it does not matter which
domain is used for the query. So if there are other domains on
this card available, these could be used.

So extend the code to use AUTOSEL_DOM for the domain value to
address any online domain within the card for querying the cca
info and thus show the serialnr as long as there is one domain
usable regardless of the default domain setting.

Fixes: 8f291ebf3270 ("s390/zcrypt: enable card/domain autoselect on ep11 cprbs")
Suggested-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/zcrypt_ccamisc.c |   12 +++++++-----
 drivers/s390/crypto/zcrypt_cex4.c    |    3 +--
 2 files changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1640,11 +1640,13 @@ int cca_get_info(u16 cardnr, u16 domain,
 
 	memset(ci, 0, sizeof(*ci));
 
-	/* get first info from zcrypt device driver about this apqn */
-	rc = zcrypt_device_status_ext(cardnr, domain, &devstat);
-	if (rc)
-		return rc;
-	ci->hwtype = devstat.hwtype;
+	/* if specific domain given, fetch status and hw info for this apqn */
+	if (domain != AUTOSEL_DOM) {
+		rc = zcrypt_device_status_ext(cardnr, domain, &devstat);
+		if (rc)
+			return rc;
+		ci->hwtype = devstat.hwtype;
+	}
 
 	/*
 	 * Prep memory for rule array and var array use.
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -84,8 +84,7 @@ static ssize_t cca_serialnr_show(struct
 
 	memset(&ci, 0, sizeof(ci));
 
-	if (ap_domain_index >= 0)
-		cca_get_info(ac->id, ap_domain_index, &ci, 0);
+	cca_get_info(ac->id, AUTOSEL_DOM, &ci, 0);
 
 	return sysfs_emit(buf, "%s\n", ci.serial);
 }



