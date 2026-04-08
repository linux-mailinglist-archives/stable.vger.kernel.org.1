Return-Path: <stable+bounces-235179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBfpKtir1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:26:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B373C2F97
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B80E320E96E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E1537F8AC;
	Wed,  8 Apr 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PF2J9Hsg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5F13176E4;
	Wed,  8 Apr 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674772; cv=none; b=Xv2yjphW48PuLpN8PS3iIWXmEnHDM9q1fuGLeP+BkDZwFRshK3afJUJ74kre74BBfdTgmOr72Mnig49uNjjZoaoJ7UK1F6mnmGhPExjFEtwZpFquUVa6ZGfjcJbCCXoFmhVWbxvvsZzUsI49Smc3xfSKOFNPinzcrjS+9PWfnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674772; c=relaxed/simple;
	bh=m/7lgEP5tmd1uWx34yS1Lr6ZL+r0v9k6big2A12Xyno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfLwQGD9GA1YjrsYcgizXfPjrrP7rL0j6PzY9fps908DjYYafQ3eUn4V47PQeEsp8rJhA2PD06xNqwvO2SBJVT8YHeJ9gsJp1KmARu9sHcKenIz3L988+ra2KdSgj0xzY0mqx8HO2LBGraz4tE3PzlmGztTelrr5V26ew3pozec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PF2J9Hsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704E7C19421;
	Wed,  8 Apr 2026 18:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674772;
	bh=m/7lgEP5tmd1uWx34yS1Lr6ZL+r0v9k6big2A12Xyno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PF2J9HsgzbDJbIZIsM7rDWB+2SXdRSD20+HeoTfNAbwlYPz8fovztO9/kErzF6QIf
	 Jo8qSWoy1+Gwshr92ZVEXG68DRCKXcAwzBA2Mcw37ESrmTXvi1IGNuLJ5YIZI9Z4g7
	 2NhKrGp62EKmKqMEAYTrYngZsFwUxHR0btXl2Jmc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aldo Conte <aldocontelk@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.19 227/311] iio: light: veml6070: fix veml6070_read() return value
Date: Wed,  8 Apr 2026 20:03:47 +0200
Message-ID: <20260408175947.876180658@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,analog.com,vger.kernel.org,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235179-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 20B373C2F97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aldo Conte <aldocontelk@gmail.com>

commit d0b224cf9ab12e86a4d1ca55c760dfaa5c19cbe7 upstream.

veml6070_read() computes the sensor value in ret but
returns 0 instead of the actual result. This causes
veml6070_read_raw() to always report 0.

Return the computed value instead of 0.

Running make W=1 returns no errors. I was unable
to test the patch because I do not have the hardware.
Found by code inspection.

Fixes: fc38525135dd ("iio: light: veml6070: use guard to handle mutex")
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/veml6070.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070
 	if (ret < 0)
 		return ret;
 
-	ret = (msb << 8) | lsb;
-
-	return 0;
+	return (msb << 8) | lsb;
 }
 
 static const struct iio_chan_spec veml6070_channels[] = {



