Return-Path: <stable+bounces-268541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PmODBEEtPWoByggAu9opvQ
	(envelope-from <stable+bounces-268541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:29:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1216C6224
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:29:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=oLokY56C;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268541-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268541-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686DD302D0A1
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0332A3EC;
	Thu, 25 Jun 2026 13:29:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3342FFDCC;
	Thu, 25 Jun 2026 13:29:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394169; cv=none; b=WWkh7yzk4JC3ozhIVibYcVtODhHf17ODHobOubiVErEXcXiOkW32qZ7BL1UvCuxnx+ujXqKjAm97yMYMj1e0TJn1qw4iDBzvPxDdhDuIfow2Qj0dU0nI4SuQ0zMALrfvDWqzYTj1wDJV1uxFLY5zlbI2SH79q0i68p43/1S2orM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394169; c=relaxed/simple;
	bh=lR8ReByppS9j0Zz4J5mwLiH/Kk6k6t8oiAGWQgVuRII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRbeEl9O21k/3I4sqnTGI8YYpQhTZk2S9FlQ/oix9WSXB/1DWxX1TEWij2g+WZ75hwCYAOCDkuoWFx558BpXxeBrOjWOOb371nJZa6YYY4KZNqnc4Nfa1zDaojCf1BB7alBexRgRJOfVjYJRcqtKaVaXreY6TpHtXkPWKxLeMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oLokY56C; arc=none smtp.client-ip=54.204.34.129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782394152;
	bh=F/c9kHQD6QLg3SohqohRdqazcvSfghTJd0SGSsKc4/w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oLokY56CGY4x8zO+t5Dh+WxZpFwJ2EuxVC5b8Jj8//juyWP87u2d0Ya4oRduZQs/d
	 ++kVKZLn6jeviIPBRN80ZcxIrr2HXTUgqI8Qz9Ma8ZeA8fAaNCY9UV/d/ayh5Kpvge
	 RPwfnaiDGuxh6iFK/yIWtt6zH89A4ef/SdJfj8xA=
X-QQ-mid: zesmtpgz1t1782394147tb3c9e761
X-QQ-Originating-IP: PZeMdAOHBtXkAHxpAsB6podZ48I51po+U9kHMja91gU=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 25 Jun 2026 21:29:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3255596446001045278
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: TAD: Check AC wake capability before enabling wakeup
Date: Thu, 25 Jun 2026 21:29:03 +0800
Message-ID: <961A84FF37B50665+20260625132903.2840457-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MAL61fhe2h5SZjwhnlJBOSASzuE5jENPOQOlGmIjjPJ4QPurwrtFvTBY
	bUkJwkZyv8Lc8p0nE7G1Fvji7xZyef7exb78G4ZWrJd2gANBioGoUc5uyjebVcJb0zBNZJA
	/PmVGFgbCX2eHjqm7pXmYDqYnwC+CbCZCY83/62UFVfRVA61b322g5/ysL54cmH8tyUNtO6
	9eZ9hF40lPRg2wzSvEv7AQ0YJ5kqS3FH3BmlpRYB6jMsqqidIcL5dww8WzWYUkerEgStfTi
	cVfeGUYXQyzCHhXdBiRpgkw23VrbNiAqKG2R//v7Q41var812gaOuZhG8bGRaGuwcO9E0nB
	eG5lsXWYI153jsSV4tKB7fVRU88NxGkSIsA/Zwe4m5MG/ge5vayTrgPSD3dU9Aub6zM+6w0
	C248oDB5sSvc4owXqNWvF/+qCvc01zgBeR03zudtTxEhC0ksom2O1BxJd9YITxTo2W8ic0C
	hLbZ81XFSfe6x747hp1HhQfV6eWgI0yvTeRAjWHNwo5gBIgsSFytYTN2/kRto9JBBt/QRRe
	aEOqwjHqLPxo9vI8wbMvspL1hEkxaaBulMpNMxRwy/akXDyQ/+PgFhN9ME9n2YL3RcbTIFL
	quToswRU4hI2i3VxrHo6YeiBdWPwuxrQuED0x7eGOjlQBLADxxuLTsiZXobNk17v2R8to4d
	qEUtYqSqqheeMKQPwaLL11CJHKmrXd/07W9IJZYqR3UBHuaeKboJygxvxcoM8yeY/UU1TBM
	RaqB/h+av9nhrIuIQCMGdo7clJs6jhAio1w0ab5a5DKxIBAfl8zsZmQiGIojDTq4Z1wXdru
	Gyb9iEKmgFtbz0UE8FXkEgujmP0nG0EZ/knkSTlj1sBPNERztMVw+53gNPjyeDQJ5Zs7Xi5
	sMTcRIb/8s9r7x3oDnhAZzHiCYOhIrkMij8abIZELpQ+AEljiuFd4W0fQCwx0ZKx5heI5yf
	n0SFTyFZeKO8dRoVldHqMvw62ahVg88gQhU/soYE3Zt4yUC7Af/PI8kGODFx40ABsIy7wPM
	5KE8oj1sVR4XN5HLhPk984rUW9iVW4L321zwHRHG9sHsNa3MLO
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268541-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:rafael@kernel.org,m:lenb@kernel.org,m:linux-acpi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:raoxu@uniontech.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F1216C6224

From: Xu Rao <raoxu@uniontech.com>

ACPI_TAD_AC_WAKE is a non-zero bit definition, so testing the macro
itself is always true. As a result, every TAD device is initialized as
a system wakeup device, including RTC-only devices and devices whose
wake capability bits were cleared because _PRW is absent.

Test the capability value returned by _GCP instead. This keeps
RTC-only TAD devices usable without advertising a wakeup capability
that the firmware does not provide.

Fixes: 6c711fde3a1c ("ACPI: TAD: Support RTC without wakeup")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/acpi/acpi_tad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 386fc1abcbdc..fc43df083738 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -856,7 +856,7 @@ static int acpi_tad_probe(struct platform_device *pdev)
 	 * runtime suspend.  Everything else should be taken care of by the ACPI
 	 * PM domain callbacks.
 	 */
-	if (ACPI_TAD_AC_WAKE) {
+	if (caps & ACPI_TAD_AC_WAKE) {
 		device_init_wakeup(dev, true);
 		dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
 					     DPM_FLAG_MAY_SKIP_RESUME);
--
2.50.1


