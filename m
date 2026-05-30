Return-Path: <stable+bounces-258232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHIXEJkkG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:55:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D4610AA6
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09B6F3018F65
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E9A341AC7;
	Sat, 30 May 2026 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KAuQ/zFn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0025261B9E;
	Sat, 30 May 2026 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163657; cv=none; b=WVH6/+8mCd7eYgwOSvsUQ8ZRmt/3MXrO3n850kCR2sJACJPLJkgu6Gg2T1oe58wwi0PyBsvmKnKZ17ejtPHUDENNY4Rw8Xam899rnQPCAuoVEgU0IJ84rBnusDOgfVVwKhg+nRxlC7mc+dwGiMOmguuDCEeUpE5c2E4ed1ZtUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163657; c=relaxed/simple;
	bh=USFktYoybA5D9ZhqIdBmLY+j6AiOfWW+xHVocyj9XcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHdbpnyFB/XO3N83IDMPV3Mss0QClj1/1gS5WA03UdoccIenxw6SDwSwBYPsj/im0lVgUJM+uZKd2QdEEkyM/Z2VQOVgTWaeyTiHgGhvBs3KzvNImdu7E9ITdJDvh6RkGYJP/z/PwScexPzp+e4Z4BTYdPHf3p4UbmFD/efkP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KAuQ/zFn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0176D1F00893;
	Sat, 30 May 2026 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163656;
	bh=WjrRbAFIhaCKibjZQ2bfX7A/vaIEGwPdSJIY3I8pSY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KAuQ/zFn1y8IxkPwJAmM+DTJNarGXd7Nxs1ToThr4e1pri56dPzjDQ0AdA3J4ZMi4
	 a7pfR/gmszLNB7vBfCO74LwzIeNZnXhs59aDYUuZpLl5V0rd+56uh0o9tsKC8m8Qhp
	 WpvDwkTQtYrbBEd/LoosWCBvxREU21EDSzbdwMQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH 5.15 322/776] thermal/drivers/sprd: Fix raw temperature clamping in sprd_thm_rawdata_to_temp
Date: Sat, 30 May 2026 18:00:36 +0200
Message-ID: <20260530160248.889877344@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258232-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,alibaba.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5A8D4610AA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit b3414148bbc1f9cd56217e58a558c6ac4fd1b4a6 upstream.

The raw temperature data was never clamped to SPRD_THM_RAW_DATA_LOW or
SPRD_THM_RAW_DATA_HIGH because the return value of clamp() was not used.
Fix this by assigning the clamped value to 'rawdata'.

Casting SPRD_THM_RAW_DATA_LOW and SPRD_THM_RAW_DATA_HIGH to u32 is also
redundant and can be removed.

Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260307102422.306055-2-thorsten.blum@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/sprd_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -178,7 +178,7 @@ static int sprd_thm_sensor_calibration(s
 static int sprd_thm_rawdata_to_temp(struct sprd_thermal_sensor *sen,
 				    u32 rawdata)
 {
-	clamp(rawdata, (u32)SPRD_THM_RAW_DATA_LOW, (u32)SPRD_THM_RAW_DATA_HIGH);
+	rawdata = clamp(rawdata, SPRD_THM_RAW_DATA_LOW, SPRD_THM_RAW_DATA_HIGH);
 
 	/*
 	 * According to the thermal datasheet, the formula of converting



