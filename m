Return-Path: <stable+bounces-228785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOX7AwxpwWmoSwQAu9opvQ
	(envelope-from <stable+bounces-228785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:23:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDED2F8011
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3EE932476E1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F375239E60;
	Mon, 23 Mar 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2yYNWU5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B2235C01;
	Mon, 23 Mar 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277119; cv=none; b=o1SEpY2mr+xpdPdnoSu05TJrhe6FM9PtBOmK42GWY1tCT0p5NweAfpHPU+kHHml245e7JcLf8E6UOL41PL3VIJKw0cnhxaRzMAbp6WDHJ4GAbxUO/IdJdx7FyIzeD/okLdrCFnoDYza88enuvQMSWjVdBeuslYMMBPnluZiMI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277119; c=relaxed/simple;
	bh=kxinHW94fhLfhO3jBDw8TB6E1oMfkGGRkpmurwkMHTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SauHEmCz8AUsXHASKv1920y5Qo8RjGHxlXORWlwQVIagVOPvU3P7Jfzi6JQPp77yWR98ZI+5BzHbgCsUP8HF/zpWSsjAYqNIDxb5dj1WETD9Wl/BV7dKPa9nTbNTjDaAAnf8reieM4vQg80f71qlIt+TRPIL/5oW3MXJ+N3Wnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2yYNWU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ECDC4CEF7;
	Mon, 23 Mar 2026 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277119;
	bh=kxinHW94fhLfhO3jBDw8TB6E1oMfkGGRkpmurwkMHTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2yYNWU5g7jIkXGkECEnFNLY8xWquG7Dvv5FZ+yLxb/tpgyhBjEoDkGsUXC1peiJW
	 4x9BN6/A4ctJyL8D2SUtbNx9+sYkZHej3WiYPW9CWfY7kMupvkez9vM9lnaHhox3SK
	 x8EBKL6b3t9MirtRCOZyKHR9KLD/lrhmfh55HaBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ingo Franzki <ifranzki@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 325/460] s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute
Date: Mon, 23 Mar 2026 14:45:21 +0100
Message-ID: <20260323134534.495781286@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228785-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 8BDED2F8011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 598bbefa8032cc58b564a81d1ad68bd815c8dc0f ]

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
[ preserved zc->online as the fourth argument to cca_get_info() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/zcrypt_ccamisc.c |   12 +++++++-----
 drivers/s390/crypto/zcrypt_cex4.c    |    3 +--
 2 files changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1665,11 +1665,13 @@ static int fetch_cca_info(u16 cardnr, u1
 
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
 
 	/* prep page for rule array and var array use */
 	pg = (u8 *)__get_free_page(GFP_KERNEL);
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -85,8 +85,7 @@ static ssize_t cca_serialnr_show(struct
 
 	memset(&ci, 0, sizeof(ci));
 
-	if (ap_domain_index >= 0)
-		cca_get_info(ac->id, ap_domain_index, &ci, zc->online);
+	cca_get_info(ac->id, AUTOSEL_DOM, &ci, zc->online);
 
 	return sysfs_emit(buf, "%s\n", ci.serial);
 }



