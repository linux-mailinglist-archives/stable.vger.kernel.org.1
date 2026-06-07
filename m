Return-Path: <stable+bounces-260939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wHfCDwxCJWq6FAIAu9opvQ
	(envelope-from <stable+bounces-260939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:03:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E150B64F4F4
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:03:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ei1+UNeG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260939-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260939-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DDB030028BC
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C72E1EFC;
	Sun,  7 Jun 2026 10:03:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D46296BA9;
	Sun,  7 Jun 2026 10:03:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826632; cv=none; b=auz+NduXFiP8EysAMln5LhFxVXO37qixiko52DVPH8lmB0G0XX54SDtIXh1Wici81fyFQYhDJ10l3pf2UbmYeqLrBecgPKEUxylzgDw8AA11H3d907HO9PB54/BTIsU2xzXI7VdbeyuEi1wTvS+bXCR7Nu1mizLekDf2evH2viM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826632; c=relaxed/simple;
	bh=Olen5gYC+EqVr1KblwOGAj5INNmrnentHBP9NFSsT5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJ7bdPtJ5vZ3MFcarvuw8KXD7kuAhjEy6u96dPDRdDUdRY8aR8M59C98OwS2gHNZ8+B2QHWtcHJpy5CG2Gx8QDYmu5JlY8ULCIrpF/z1IcByCpK5Z2CGPAA6FCeLy2kLcfdbvILz7infRCKKK/N/HSMFXUVAj/ZyPdFQ1qTESnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ei1+UNeG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD511F00893;
	Sun,  7 Jun 2026 10:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826630;
	bh=tgrNDxuT8hoKzbaGJ/nLxGPeaw+Y4+oUVYt///eYau0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ei1+UNeGGmnOpDEFo7gnS7iCqGpB8h7oK3CDpeKzmK27tdowMKEN6/R8+PB7MbnkU
	 lEylhyFS4sjnSTLHuxvHF5MQYMuVtIAwO0Yhyo5p0BnSdXoCCCxrTMni+rnz6I9/Rz
	 9mL1jDRyIPqQXUdXOTS1mTFzaFTHHKE1KATK0CM0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 002/332] ACPI: button: Fix ACPI GPE handler leak during removal
Date: Sun,  7 Jun 2026 11:56:11 +0200
Message-ID: <20260607095728.120450683@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260939-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rafael.j.wysocki@intel.com,m:superm1@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E150B64F4F4

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit fe80251152fed5b185f795ef2cd9f7fe9c3162e0 ]

Commit a7e23ec17fee ("ACPI: button: Install notifier for system events
as well") changed the ACPI notify handler type for ACPI buttons to
ACPI_ALL_NOTIFY, but it forgot to update acpi_button_remove() to reflect
that change.  This leads to leaking the notify handler past driver
removal, which may cause a kernel crash to occur if ACPI notify on
the given device is triggered after removing the driver, and causes a
subsequent probe of the given device with the same driver to fail.

Address this by updating the acpi_remove_notify_handler() call in
acpi_button_remove() as appropriate.

Fixes: a7e23ec17fee ("ACPI: button: Install notifier for system events as well")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Cc: 6.15+ <stable@vger.kernel.org> # 6.15+
Link: https://patch.msgid.link/7954431.EvYhyI6sBW@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/button.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index ff30f993b15062..22f26d8fdb1f6e 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -690,7 +690,7 @@ static void acpi_button_remove(struct platform_device *pdev)
 						acpi_button_event);
 		break;
 	default:
-		acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   button->type == ACPI_BUTTON_TYPE_LID ?
 						acpi_lid_notify :
 						acpi_button_notify);
-- 
2.53.0




