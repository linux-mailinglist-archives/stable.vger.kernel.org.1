Return-Path: <stable+bounces-216980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIsZNxjTlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-216980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:44:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491BA1502B6
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC933018AE1
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC13783D0;
	Tue, 17 Feb 2026 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bMBYjq9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83436F431;
	Tue, 17 Feb 2026 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361014; cv=none; b=XwM1GjN3ZrNAYGkB5uEB/qGzjTHuVWzB/Wdi+nzHscTAQWhvJz6bx5eJQHazcMV2vv32YwSXtQS2uIizXlVw348IMLRLFE9LdfueqHYT8AAG8AfAQTOEHViyaZvHADadxCffXXXgHtHhYzYgEVXl+hesKSXkFLGtky21W85Pv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361014; c=relaxed/simple;
	bh=3fRjGDn2huDDSRyqJtQEjgYvALlGoLkeXNo7UscDNHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWS2I4lm7RPQvigmv9yzlgLHMNqMdOtDL6+z/uWDhrO72P+5xT+r5pbCV+lYsB1Qv/NkFfzsMJsLAZCUOFx1JOBlCEQ+hhs8kc0/y3aIab1Nt20mjVgYvl1N2sMa6SxHY5fEnwRAA/vc0f9G7KuBnEiZbrir6J3mzr4ZrVsd3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bMBYjq9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD65C19421;
	Tue, 17 Feb 2026 20:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361014;
	bh=3fRjGDn2huDDSRyqJtQEjgYvALlGoLkeXNo7UscDNHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMBYjq9HIGm36fKamjb6kf+7jqF6KiCwyCHM9aGd/qgjtaKeU6MlKAZ7EHpIRLk5y
	 loQCvN8ccHCAJ9B/z891PDYQyVB6M+VaFjTltrwNjDlmfOP7r5uiirlFV3cSfOsi/Z
	 014p10eUP3gbK62WIlLrVQaXHo7rGoEU/VrML7Pw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alban Bedel <alban.bedel@lht.dlh.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 16/39] gpiolib: acpi: Fix gpio count with string references
Date: Tue, 17 Feb 2026 21:31:25 +0100
Message-ID: <20260217200003.554952275@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200002.929083107@linuxfoundation.org>
References: <20260217200002.929083107@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-216980-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dlh.de:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: 491BA1502B6
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/gpio/gpiolib-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 3e4fd028a82da..0e6a2200a5feb 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1369,6 +1369,7 @@ static int acpi_gpio_package_count(const union acpi_object *obj)
 	while (element < end) {
 		switch (element->type) {
 		case ACPI_TYPE_LOCAL_REFERENCE:
+		case ACPI_TYPE_STRING:
 			element += 3;
 			fallthrough;
 		case ACPI_TYPE_INTEGER:
-- 
2.51.0




