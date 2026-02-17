Return-Path: <stable+bounces-217114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO5mBsvUlGnHIAIAu9opvQ
	(envelope-from <stable+bounces-217114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:51:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD6F150649
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76060301DAFD
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF85284B3B;
	Tue, 17 Feb 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GdeyNZUS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12854266581;
	Tue, 17 Feb 2026 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361470; cv=none; b=tbqBIOIxmBN3l47Vu9vHuFOA0PQiPnWmv5UmjjVjbniZc/o+BO0RUkaGTkbM5Dq1/xNwb+39h505epe/QVjwSTb4WQ/2yTeCztAIPxSde/e6GVyOuH3fmLC1WOiEDKcIMDe8JWN8lwOqZCnz50zJ+PmdGheEYjsACCst32BIHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361470; c=relaxed/simple;
	bh=UQnrLsPEr+z9FUCFVbyxw6AK/3S94EQwMfh9B0VeH5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3KEOvTJEPpej6zyc5RHrtULGQa89dmYdzqC6UCkCEs9uR3bU2GHCsT9Vb0+/RJEyZkx0QOKuCGD+h00r5yL//7DLyWzpw81vlsZA/A1oKg411UfckoFDEKEdbAb/5cjbBPk154U+tLND1Ep4NSzVMVZEvls1M8v3XlZsBSxjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GdeyNZUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A38EC4CEF7;
	Tue, 17 Feb 2026 20:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361469;
	bh=UQnrLsPEr+z9FUCFVbyxw6AK/3S94EQwMfh9B0VeH5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GdeyNZUSt2pSY3CQLz2qXgYYmj0EF6xBegQIGrb+WsGFuQJ1GDvK04Q8bqDW14K8s
	 rsxxXbdeuyVKNvzZdFVNjJ3uG/26QqwrzyS1RK32FxH/Mbp4hcuiJQfNRjdUGR4ZLc
	 R8rj3lYhraCtyrFbhHBjQTYyVwe8hEEDDobE+xeg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alban Bedel <alban.bedel@lht.dlh.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 25/43] gpiolib: acpi: Fix gpio count with string references
Date: Tue, 17 Feb 2026 21:32:05 +0100
Message-ID: <20260217200007.437628788@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200006.470920131@linuxfoundation.org>
References: <20260217200006.470920131@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217114-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dlh.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: 4FD6F150649
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alban Bedel <alban.bedel@lht.dlh.de>

[ Upstream commit c62e0658d458d8f100445445c3ddb106f3824a45 ]

Since commit 9880702d123f2 ("ACPI: property: Support using strings in
reference properties") it is possible to use strings instead of local
references. This work fine with single GPIO but not with arrays as
acpi_gpio_package_count() didn't handle this case. Update it to handle
strings like local references to cover this case as well.

Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://patch.msgid.link/20260129145944.3372777-1-alban.bedel@lht.dlh.de
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-acpi-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index e64e21fd6bbaa..8110690ea69d0 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1359,6 +1359,7 @@ static int acpi_gpio_package_count(const union acpi_object *obj)
 	while (element < end) {
 		switch (element->type) {
 		case ACPI_TYPE_LOCAL_REFERENCE:
+		case ACPI_TYPE_STRING:
 			element += 3;
 			fallthrough;
 		case ACPI_TYPE_INTEGER:
-- 
2.51.0




