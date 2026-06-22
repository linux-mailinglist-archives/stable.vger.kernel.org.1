Return-Path: <stable+bounces-267607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dyl0IJneOGqqjQcAu9opvQ
	(envelope-from <stable+bounces-267607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:04:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F256AD1EE
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:04:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=d32aRLLb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267607-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267607-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A44313006021
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 07:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25DD351C14;
	Mon, 22 Jun 2026 07:04:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D1233943;
	Mon, 22 Jun 2026 07:04:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111890; cv=none; b=CyUiUFzpZtuqWbbCmXOHIeaNwKFHOPhpFzrk8KN6TGIHLSPWdemnDDQ6a4CyVmMaieLJ86RGQMHCE9BRFvIR7C8rwLik5oATD+WGk5nMtmY6pkDIXNHw9AxwO880RSt+3qlCLweQuDrS2VAlytCVKDYLFUh4RLOevWBMpg0XGgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111890; c=relaxed/simple;
	bh=94ffQZN5smXw4dtist2N6Ff1+673ITZAbyoknLT5Ab0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiSmab7i1pW2KEaApMnjm1RIMZT5zrs4auwfK+oDvEFXZeosiK5fwPQcdDF4SFe4s0JEoeabMphtVSBoKMOQhMPiUDLkiuaygoWeIKQAGcS2o1hq1EZ4wB52LLyNezr+dVMsvsrkFjG7ZPizca8m9f9IRIN4/vmjqjvZxkfxsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d32aRLLb; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=LC
	l1kE52dxJs4SrnZw4dUUD9eSLe2/W5walU+U+dJtc=; b=d32aRLLbJF+QRdZWKO
	rRwSLOhr3AQjf7Qp5mgqmRJBAYFGgO5KRQzuvOWyJoTR/TCjTAs7CzkquZy9VJ2H
	aWtdrP65U92WVHHvNdiQPe4jrryBx7/Yhcd4+LmwIjDpwLiHnUrnR8Xqa3IitBc/
	LH3wSP+rcRHVp4BPRraerMxe8=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDHAhdZ3jhqsX6EEg--.791S4;
	Mon, 22 Jun 2026 15:04:01 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: srinivas.pandruvada@linux.intel.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	sumesh.k.naduvalath@intel.com,
	mgross@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH] platform/x86: ishtp_eclite: fix ACPI device reference leak in probe error path
Date: Mon, 22 Jun 2026 15:03:52 +0800
Message-ID: <20260622070352.689982-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHAhdZ3jhqsX6EEg--.791S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryxZrWUuFW8WrW7Jr1rXrb_yoW8XFyDpF
	W7KFWrKrW5GrWfK348Xa18Z3Wruw1jv3y8GrWkCw4Uur45uF9aqayIka4YkF1kurWkJa45
	ZFn7trW8AF1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJGYdUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC1AF4g2o43mHegwAA3e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267607-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sin.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:srinivas.pandruvada@linux.intel.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:sumesh.k.naduvalath@intel.com,m:mgross@linux.intel.com,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:make_ruc2021@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[make_ruc2021@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[make_ruc2021@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78F256AD1EE

ecl_ishtp_cl_probe() acquires a reference to an ACPI device via
acpi_find_eclite_device() but fails to release it in the error path
when acpi_opregion_init() fails. This results in a reference count
leak, preventing proper cleanup of the ACPI device.

Calling path: acpi_find_eclite_device() ->
acpi_dev_get_first_match_dev() -> acpi_dev_get_next_match_dev() ->
bus_find_device() -> get_device().

Found by code review.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Cc: stable@vger.kernel.org
Fixes: 7b6bf51de974 ("platform/x86: Add Intel ishtp eclite driver")
---
 drivers/platform/x86/intel/ishtp_eclite.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ishtp_eclite.c b/drivers/platform/x86/intel/ishtp_eclite.c
index 93ac8b2dbf38..bca7e217878b 100644
--- a/drivers/platform/x86/intel/ishtp_eclite.c
+++ b/drivers/platform/x86/intel/ishtp_eclite.c
@@ -600,13 +600,16 @@ static int ecl_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
 	rv = acpi_opregion_init(opr_dev);
 	if (rv) {
 		dev_err(cl_data_to_dev(opr_dev), "ACPI opregion init failed\n");
-		goto err_exit;
+		goto err_put;
 	}
 
 	/* Reprobe devices depending on ECLite - battery, fan, etc. */
 	acpi_dev_clear_dependencies(opr_dev->adev);
 
 	return 0;
+
+err_put:
+	acpi_dev_put(opr_dev->adev);
 err_exit:
 	ishtp_set_connection_state(ecl_ishtp_cl, ISHTP_CL_DISCONNECTING);
 	ishtp_cl_disconnect(ecl_ishtp_cl);
-- 
2.43.0


