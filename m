Return-Path: <stable+bounces-270989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X34JOxCZRmq4ZgsAu9opvQ
	(envelope-from <stable+bounces-270989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:00:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CDF6FAD6E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:00:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=V13Hrxc6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270989-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270989-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF1B630B49F0
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B66435E1DA;
	Thu,  2 Jul 2026 16:39:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2135F602;
	Thu,  2 Jul 2026 16:39:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010378; cv=none; b=FG0fhhP3MKTTq/tU2jKI0A8m9+GTO6au6hFy1YmfxkzhSDsiaT0WInYtUk9AKqy32pwWT7eWOznvY/TOerQ232BoS5cloj2KFoWLY2fRQLXI7utM4vQm1kevgu9/c6tsy/xUjVN56HZmP9C4arjEOUwCkypsZwvtVAcUyoSXF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010378; c=relaxed/simple;
	bh=T+px+FU+ynCZ37HevFZrA4swf8zU8tkcRxdRNnIZcQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vA9S5a4GiE0sFykPchglrbs2tprrfNLk+x8PWMtUX6gWVQayEuElR5HSbwFRrRm3/dR7zmuUwh+ONJvUvpIDydjUk3MQ42Zotq4MvYL77ciIW10Rfu+bNS8Qs0Lr8pXuLdvLEdRHdD4o6iPLutieHLLI5ZSVZqa9wtPMzxyyw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V13Hrxc6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3271F000E9;
	Thu,  2 Jul 2026 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010376;
	bh=M3MVU3TnEhJ7O5YMAq817MxgNt0eu/G7szvLi2dqxMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V13Hrxc6eGR8pH0x1UTo7YvWUtAJMrbfOO3SzZOrwYwu9aaCUeMnAu82BTFAqhGBE
	 ic3050zBms9HF3agpjZ5Je2KoOo4C0qDUtjCeWjtQ/i3Sa7yeJCW8igRrVzZu6sF0H
	 G4ZE/lDMYgtyX8ruWzBR1qWnbFN1kSOpY5i9xK8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Sam Daly <sam@samdaly.ie>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6.12 086/204] iio: light: veml6075: add bounds check to veml6075_it_ms index
Date: Thu,  2 Jul 2026 18:19:03 +0200
Message-ID: <20260702155120.468920490@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,samdaly.ie,gmail.com];
	TAGGED_FROM(0.00)[bounces-270989-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sam@samdaly.ie,m:javier.carrasco.cruz@gmail.com,m:jic23@kernel.org,m:javiercarrascocruz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,samdaly.ie:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39CDF6FAD6E

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sam Daly <sam@samdaly.ie>

commit 307dc4240bd41852d9e0912921e298160db1c109 upstream.

veml6075_it_ms has 5 elements but VEML6075_CONF_IT can yield values 0-7.
If it returns a value >= 5, this causes an out-of-bounds array access.
Add a bounds check and return -EINVAL if the index is out of range.

The problem values are reserved so should never be read from the
register. Hence this is hardening against fault device, missprogramming
or bus corruption.

Assisted-by: gkh_clanker_2000
Cc: stable <stable@kernel.org>
Signed-off-by: Sam Daly <sam@samdaly.ie>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/veml6075.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/iio/light/veml6075.c
+++ b/drivers/iio/light/veml6075.c
@@ -100,7 +100,7 @@ static const struct iio_chan_spec veml60
 
 static int veml6075_request_measurement(struct veml6075_data *data)
 {
-	int ret, conf, int_time;
+	int ret, conf, int_time, int_index;
 
 	ret = regmap_read(data->regmap, VEML6075_CMD_CONF, &conf);
 	if (ret < 0)
@@ -117,7 +117,11 @@ static int veml6075_request_measurement(
 	 * time for all possible configurations. Using a 1.50 factor simplifies
 	 * operations and ensures reliability under all circumstances.
 	 */
-	int_time = veml6075_it_ms[FIELD_GET(VEML6075_CONF_IT, conf)];
+	int_index = FIELD_GET(VEML6075_CONF_IT, conf);
+	if (int_index >= ARRAY_SIZE(veml6075_it_ms))
+		return -EINVAL;
+
+	int_time = veml6075_it_ms[int_index];
 	msleep(int_time + (int_time / 2));
 
 	/* shutdown again, data registers are still accessible */



