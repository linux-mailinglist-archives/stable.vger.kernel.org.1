Return-Path: <stable+bounces-235857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JJrDoEK3GkTLgkAu9opvQ
	(envelope-from <stable+bounces-235857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:11:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4DE3E608E
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B08E1300D147
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 21:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86B137F8D9;
	Sun, 12 Apr 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZhMmfqY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1B381AF9
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028286; cv=none; b=oPBkB2KF+Brb9MfqixPlO8l1zlSwFtZNYFLgYZv71R2zCgcJH6qKiYYSvR7J56+WSpRrGn7lpJCqUs0p94+/xNmkeNsRK3fAjWTUtTN5Amnpjx5vyCUoiNpm8to4a85YXhXP3laOwaIayZBWlwvKpXciZWK/cmju+7vgmI4HUR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028286; c=relaxed/simple;
	bh=as/Y6rgrCLbxvFJK4woRt4WCiXpZGU5Bmcl75dpz1Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW+WL9rMF5AgRwFWje2nBJ990HC1hZVRqGW3npGwJhVisQcYhdgIdvEkmLcNvTcPkT65BW/8kqzs1m9CIsYhOr7RTVyH5p5WNZBY9PXznsoAnIXVfbvUTNS+d9RiXSF02RGD5o21g5rqCLzpo8CH6ab978wbjAp7HyJd8OhbtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZhMmfqY; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1271257ae53so11097339c88.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028285; x=1776633085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Epvlpqxnk7CA+C9ymJCfGqy8SHrtqDJZ4fsM6TY9RM=;
        b=UZhMmfqY8i6TiedDCEqOwCLh2DM0mNU9tH/OS4oxpi25wxqkZZOQO8OmOsw841YD7/
         N6eQOJIabg8o3PiEQGiUyQaokyoPWZLJ6GYBjDI9XcmUMNgJIK/e35RibHnjpqkbFTUm
         lqxQTLBIcJrhvdAv78FQfewRZ7kMtUs43jh2tnoG948HtEM7T7RCFNUlc1/oU0lm2vgo
         TKCVM5P0owwxe9XpUR1pw81veIZk6I2IwUqY0LGR/c845Mrh3YDQjTAiXU4MUruIjBQ5
         UBVRu8yIEq17KjsFreW9KFpyVwStkudfzUK6+Plz5jzGaPfxOTEEmM1opmjmdJa3bsp5
         dKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028285; x=1776633085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Epvlpqxnk7CA+C9ymJCfGqy8SHrtqDJZ4fsM6TY9RM=;
        b=P1bvZTbGSQ3i64ANsZcNrx2pBG1RjyYACX/pPZPLycyelHuGirWPO5lDPPGXP0jbid
         oeh7CMU0oaaoQCdee7lolg5zWaOwmpcv2Mb8AQfQcgxgmrwvPMoFTBsEyXbhlTYuIcli
         vzGuBZ21bNduJjKICpAbHXSupHLC8rKgccCUe5qTfjLUuSNN5W8TRQJcxrHZCVdCmrJX
         N5HCL9Uy6HWwKthJxf1dC2obYuSiu3dMVuRz9X3aMDqnOtKE3wgp4KZYlqyUXFJN4wT3
         VIM4Bj8y1QICTUgDw27CHjj8mx6J5F0VnxlOj9Go8I3ZbqITVkw49U/Ol5cMN+JTYJQ5
         vL4g==
X-Forwarded-Encrypted: i=1; AJvYcCXU4poXFbF64B/brF8ozZi3ugMDPq0DpyEsyaaF998oKmZAT3ZOOGCPjL2diYSYbk8R8wkyR+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jYBlHA1RSjr8hGW0ylWjB2NAlX95Jsums15ZkwT9AZdhV5yP
	pNS8lvqa02slxVaLN4nveGaA7kJjVjQHvgrMFNdlOxzLLY3hPUBWCzhC
X-Gm-Gg: AeBDietcXXjPPWEfkd3CRK8ocPrm4rZg1dahvb48yuWgo30HN9Q8UCW+DD0f7K77n9N
	JrhJvEvH9kNjstkCojs1/DkybVEIVh4c4ax1rHLhVxfeYu6rOIVz+HDEgW6OctkqdxIK18N7+DH
	Xi6UvMg4XAtheG6IE0c3GnEzJWGdXqAitb5LE652cbQoKLxRPTn5BMVmtzOi1hj3PbINRlsF6Yu
	WQxem8NrqqW0NlYZ3/4JMCGyLUyau9JezdvVhLiHKtEHHF1xeyr5/0q+HIa06OnY4nxZGDQCx+Z
	XZpe/nHEzFW4NyuUROw06GdFJkzL5JpzFiRhsqGt6xdW4n26MrcXcwCLUd69lgyiKdEjN+q6E2P
	2+OevSuhX+ToHz0A55AJWYSA0Ikwqz3oew1hEVg9LpMZwcoibwAljqQpgir3Ni7DhSrWmodtElS
	ZdGFr/l5282wMgMXIwWveyZUK0lxJtiISUCb9afok324ZUES1h2FyKSxEVV3zMXe12HTs+xzYva
	83c
X-Received: by 2002:a05:7022:ec07:b0:119:e55a:9c04 with SMTP id a92af1059eb24-12c34ef9715mr6188284c88.32.1776028284605;
        Sun, 12 Apr 2026 14:11:24 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb141sm11520856c88.12.2026.04.12.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:11:24 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v10 01/16] platform/x86: lenovo-wmi-helpers: Fix memory leak in lwmi_dev_evaluate_int()
Date: Sun, 12 Apr 2026 14:11:06 -0700
Message-ID: <20260412211121.2220556-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235857-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CC4DE3E608E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rong Zhang <i@rong.moe>

lwmi_dev_evaluate_int() leaks output.pointer when retval == NULL (found
by sashiko.dev [1]).

Fix it by moving `ret_obj = output.pointer' outside of the `if (retval)'
block so that it is always freed by the __free cleanup callback.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: e521d16e76cd ("platform/x86: Add lenovo-wmi-helpers")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/wmi-helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform/x86/lenovo/wmi-helpers.c
index 7379defac500..018d7642e2bd 100644
--- a/drivers/platform/x86/lenovo/wmi-helpers.c
+++ b/drivers/platform/x86/lenovo/wmi-helpers.c
@@ -46,7 +46,6 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 			  unsigned char *buf, size_t size, u32 *retval)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *ret_obj __free(kfree) = NULL;
 	struct acpi_buffer input = { size, buf };
 	acpi_status status;
 
@@ -55,8 +54,9 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
+	union acpi_object *ret_obj __free(kfree) = output.pointer;
+
 	if (retval) {
-		ret_obj = output.pointer;
 		if (!ret_obj)
 			return -ENODATA;
 
-- 
2.53.0


