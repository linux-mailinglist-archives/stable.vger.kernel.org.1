Return-Path: <stable+bounces-228165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCaDBMhMwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:23:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CD62F454D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90B9930709AA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6DD3B3892;
	Mon, 23 Mar 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yoqvyvKs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314773B3890;
	Mon, 23 Mar 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274323; cv=none; b=ELKXmjnynUaDEzmJUnMfaXt8KYXy6AscOE+QIEN/CCP9qjuGV+GJ8pbmJp4L8HU4/LP0BEhwIAqX/CH2EE/4HwqqJndEQGEzcWpJ/fQWvk/CT7R6RZisavfixYaWYhv6UR0NnL7+uH4g0BX5h3Y4IZrIfhCIf3he+q6uXiPe0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274323; c=relaxed/simple;
	bh=vd4ZAOnh06TKWyg+5bUiFTOZzGADuAyF6jReF5AYFgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR203YnZI45HIjnLg5FluoxOAmIE18ueEd075FhkoQ/NaR31c0SUwmhz6NzCq1eXZFliq/Ne39CRqY5hsi7klYKuu5fJjcxxSjPwjlwHLTKlxDYllUopLIz5pEaXgUZvMagehvv8lk5mPcOUYdNmLuawaSmtNyH3NlIBGRI/PPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yoqvyvKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF55DC4AF09;
	Mon, 23 Mar 2026 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274323;
	bh=vd4ZAOnh06TKWyg+5bUiFTOZzGADuAyF6jReF5AYFgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yoqvyvKsdvvfqz6pcX0V4T8E05g0F8S3u0m4cPWIkyTZ1u2wo0srqXNFSN08Snona
	 1BhBk7r55BFWJPgYLtp8C8zb0PPraOsQtu/5lqGX+kXGeMQSbEruTZguxGdV/HidAv
	 JySCyS2Q+dWpJbm9JqZ1SXd6Wt2lAlQlEIlvjrYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.19 182/220] hwmon: (pmbus/ina233) Add error check for pmbus_read_word_data() return value
Date: Mon, 23 Mar 2026 14:45:59 +0100
Message-ID: <20260323134510.324874120@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228165-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:email,juniper.net:email]
X-Rspamd-Queue-Id: 96CD62F454D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit 32f59301b9898c0ab5e72908556d553e2d481945 upstream.

ina233_read_word_data() uses the return value of pmbus_read_word_data()
directly in a DIV_ROUND_CLOSEST() computation without first checking for
errors. If the underlying I2C transaction fails, a negative error code is
used in the arithmetic, producing a garbage sensor value instead of
propagating the error.

Add the missing error check before using the return value.

Fixes: b64b6cb163f16 ("hwmon: Add driver for TI INA233 Current and Power Monitor")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260317174553.385567-1-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/ina233.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hwmon/pmbus/ina233.c
+++ b/drivers/hwmon/pmbus/ina233.c
@@ -67,6 +67,8 @@ static int ina233_read_word_data(struct
 	switch (reg) {
 	case PMBUS_VIRT_READ_VMON:
 		ret = pmbus_read_word_data(client, 0, 0xff, MFR_READ_VSHUNT);
+		if (ret < 0)
+			return ret;
 
 		/* Adjust returned value to match VIN coefficients */
 		/* VIN: 1.25 mV VSHUNT: 2.5 uV LSB */



