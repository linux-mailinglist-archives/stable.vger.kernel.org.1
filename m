Return-Path: <stable+bounces-215964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIDjMOXZjWkw8AAAu9opvQ
	(envelope-from <stable+bounces-215964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:47:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4312DF19
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78226300D0D3
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F46284672;
	Thu, 12 Feb 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b="mGlNQfT6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A0EEAB
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904029; cv=none; b=d9scWm3+f3h4r1MTYqV91xK1rB4IDMTh7yIPHRO7SW28Q3gbVL++8NXJ7VmZlPCdvR25DmhPV0pJb5QOEyrJ63NUhNRAJ9GJPtIPcYGsE0Uc4xdEwKi942/Tx1399ujK9vaYjaF9YvMfq/SQk9IQfruRWNIALCCv9O01F4AtoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904029; c=relaxed/simple;
	bh=dUv4Z4RKWbg1YOudiByIx6u5p/gQcLg3pFtWHqvTLv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/ULr42683Tw+gh/D34uV4NIadlvJExo8uljIsZpLPT3BkLSVZr0ntWqwTIzZ3Q1+9caYovlUk8Ax1qVNuUUUu3UNQCH8gUbIw89r2QBiaz9n9voNcF2BmXZXZxGq5whQChPRIoBnMffFK/mmrz/bsGjtM7hq4s1bOAxa3K4Wdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b=mGlNQfT6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436e87589e8so4296399f8f.3
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 05:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup.pl; s=google; t=1770904026; x=1771508826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5IJc+vMufOcZ7BrhUT8ALQP9dDE3pvyqu+vStpetco=;
        b=mGlNQfT6ZddHbRCzNGSebbliRtFm9QPlKkmdXmz+AAzZrLPJ4na09KvxawP3NjBetc
         JQciPk5NHei4O6Ce2Md1VgEVa/UabqLUDhhCDTehVbkyulKTQBKQve8h/+zhm//v5vQ6
         CdWrJUsIIpLNk6ibLi01IwxvJy2GNNvVOTRfvVZE9hqQbCLNSUIfjCxmXoKwY/1ep+ld
         jfRsBLFaZsrDRZUZY69HRauTCZ2yOkQjFImSLgxVP1rQh6wiLT4kcPbbdebjhbaP5YXE
         WWgw/du2e46ACdGLYTmOU9Fx94tG0aBCF5ragfz2TORG4kCb9RVYo8D1G1cwjLO1rsok
         BHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770904026; x=1771508826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5IJc+vMufOcZ7BrhUT8ALQP9dDE3pvyqu+vStpetco=;
        b=jofB6t2cD5i5TuBSRaQ8JxlDA1dJgb0jMRfnpg6jxrQIggYKmV2hNiMuFmPKDcILwt
         lBmB9zk2lo34UButrceb2UrlWT9RysbWdIos+0NStQabxIKnl/A8b5pki+FF91tNFVBd
         kZJwZh/YRsPhNWBjJUD3otghahDdZMlVBzZ9ecrszxCgDi5cnqVtqljAs7Ow66wMEmJn
         IA4gw3fPRDT190HpLK2NYJZOAXEH4kKUydsn6A+6enBZ50Mr+co5nDC+0jHDXrkWXsyS
         yP/QvwqVF5k8Owzyq1kmaWObMtjWhvQ6cGzJLuEsEgq2RO54fO4zDp+Zqp4e+lLEkeD/
         5i2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd9xahlPOfVEszAS59+myjsK4QuVSZRPnjtpDCuS9F//JO7+3fgXGnzvIL2gCUs8CeQMTDEY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsIuQNTahyDYBQgI1hqg9ZGkh2cbzEqpsFq6WQc7WePFIAoP9B
	5ft1GDVFzA5lYTnVoxqZTesn5YXfIee1lKy7DOgHCHjlGKzQcFpBSqtClre4EozQF9g=
X-Gm-Gg: AZuq6aI6WnfF0hFvuxbFCAe5so5Os5VS/phHfH/4RHhCgtKmCqoX+Q7/fqTlJay7FhX
	WbBNLlYD+Mf3n2SrfjXs76tTA6bUt594qaaN/1vHHMoE9RtH1BzD4Xd16X1LSKjMupm1F4VdWGx
	yvPctuZSM3/i2OY2Lsk8R+7+hx7ug9FvMrRE9qEjmQ4cCQS23HEYeygxJy83WOCB7cTBA4eb7jK
	mI35m4ARBqXnaOjpHMT/IJ1ZEjfIvqIplT+N3RZZ7LVCkBal57oHImlH9fZHuRAXbHWl8/zDXVD
	dcX65B/uMSrd0+KQmNeldOn9UQQxNypPILX7iVaOfOq/NlsHmzPt4wEh5SbI586hGdzqT/Gh2EN
	bVk0p9LhjirMBh0dmInR85n+tjdNczMPYTHN6Y4sGDd5xMzDhFxKN72W65ucYFBjGkJ9kaaofqo
	zjzy6uEIQShOLExc4GQgRg98rgLfIh
X-Received: by 2002:a05:600c:3e83:b0:480:6999:27ec with SMTP id 5b1f17b1804b1-483656c0a9cmr39466285e9.13.1770904026135;
        Thu, 12 Feb 2026 05:47:06 -0800 (PST)
Received: from localhost ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e3cacesm12598158f8f.31.2026.02.12.05.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 05:47:05 -0800 (PST)
From: Mariusz Skamra <mariusz.skamra@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@codecoup.pl>,
	stable@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2] Bluetooth: Fix CIS host feature condition
Date: Thu, 12 Feb 2026 14:46:46 +0100
Message-ID: <20260212134646.430396-1-mariusz.skamra@codecoup.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[codecoup.pl:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215964-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[codecoup.pl: no valid DMARC record];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mariusz.skamra@codecoup.pl,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[codecoup.pl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAD4312DF19
X-Rspamd-Action: no action

This fixes the condition for sending the LE Set Host Feature command.
The command is sent to indicate host support for Connected Isochronous
Streams in this case. It has been observed that the system could not
initialize BIS-only capable controllers because the controllers do not
support the command.

As per Core v6.2 | Vol 4, Part E, Table 3.1 the command shall be
supported if CIS Central or CIS Peripheral is supported; otherwise,
the command is optional.

Fixes: 709788b154ca ("Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings")
Cc: stable@vger.kernel.org
Signed-off-by: Mariusz Skamra <mariusz.skamra@codecoup.pl>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f04a90bce4a9..0b0dc0965f5a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4592,7 +4592,7 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
 {
 	int err;
 
-	if (iso_capable(hdev)) {
+	if (cis_capable(hdev)) {
 		/* Connected Isochronous Channels (Host Support) */
 		err = hci_le_set_host_feature_sync(hdev, 32,
 						   (iso_enabled(hdev) ? 0x01 :
-- 
2.53.0


