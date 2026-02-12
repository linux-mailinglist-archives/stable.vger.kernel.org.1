Return-Path: <stable+bounces-215962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLkHLaXZjWkw8AAAu9opvQ
	(envelope-from <stable+bounces-215962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:46:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 258D512DEE3
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E81CA3037488
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15392EEAB;
	Thu, 12 Feb 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b="ifj6X24i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EAD2AD20
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903970; cv=none; b=oTQSNF+AP/L5H73U5B+RYjIgiMbqfbdKYniKpVYJ1qLFf0RntY3lLVQYMcbD37phTHw7rq5m5Ew0Mjo/SWPbHXbbVQhX30769T80/sTewRnOgo5lbUmNJsvEkxQv2N3np6hN6+926HxUCL+qyPVfzejlEbpP+neDuHkWsbNFu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903970; c=relaxed/simple;
	bh=dUv4Z4RKWbg1YOudiByIx6u5p/gQcLg3pFtWHqvTLv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZiepMGmIHnAJOrQnB+FUc/UWHOrgCkEyWYjJ2hW7Ndr83xM3G45x6j5vD9YAIWpuFepLDSb3je1YiVb8VZund52/7BREDMURJ9HMSWWnG1p0aD25DkwUrMNUGy72CQrDjpYfyby8ORJ0T7dBwvINmTpnFkJmFHbTpmlM9TR+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup.pl header.i=@codecoup.pl header.b=ifj6X24i; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43626796202so2741452f8f.3
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 05:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup.pl; s=google; t=1770903967; x=1771508767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5IJc+vMufOcZ7BrhUT8ALQP9dDE3pvyqu+vStpetco=;
        b=ifj6X24ig2SlPvsqvRu52Iyz6IWawTOht77brOe27JkqvQ2TIVyhPGswgh8hHPB3Ao
         19/FDzRQ0r8uw/no1PCBG82yPTObb2tVepb1d6RTcblpUOWiRkN1d+uc8iVHxh58MNJs
         TwS7wSXSKDHB3zCTkzKKSbKBYjQs8dCBzdRphHpY5Yed/XxXGFwTWZDvUWkaAKbUDbmm
         J0IlrHTQZPHOc58s9isYnoKdEtz1ibYSEnhI74y4Z+WC1nfchpZelewAaDAxdjH6lCnZ
         DvhoyX6gZYtTFMuL8H8a3sFeZ6tuNwUjIqTFGSgZMNi41LjGDqRwyxeCdYwrc4NnRZ/n
         sJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770903967; x=1771508767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5IJc+vMufOcZ7BrhUT8ALQP9dDE3pvyqu+vStpetco=;
        b=Colpf7Ra4lGGSq+TcpUJqTmWB9zz6iPfa+eQ4flfLmz+FXJvy106cFK7p4szt901sY
         ztpCLxIopXN5GZ4Q4ASjqYtQvxuIv0sObGMMDGHkMvL2UWpBzQM52Zn+BbjwszhdILky
         mqqQvglggFBKe97oy1D3qni3RYellbf4KBbx0pzRPTQ15FokiC/V3DB14GfOc0o4UtsF
         S056ViEYoBx6fTxDwygLpqz1RuQRDk4Flev2ex6CGAkuz2c+itqDFw91Sf9FYS4uBSm1
         9Dm+xYm7hEW6CFvBtmFmrC7poABSHvvDRA+JEHEA/pVVJTHOuL9i9GkG+z+Qne5xmJ3h
         7PlA==
X-Gm-Message-State: AOJu0Ywk18xbyFav4kbq3E4qRRKd5tHNj/DS1s2pprniktjlimL+bDul
	7NjgXgQRVO3ThElDPfGyZOwjW6SvMhGwwPAbSbVM9wTX4RDU4ggJrV2DR2KfmOPySBoPjUwQusp
	eiPJu0no=
X-Gm-Gg: AZuq6aJyDfa8c5w6Z+59P7gQpgu1f+j0cG3uTQAJ1aE0OhrR2uLoOTOFAdBhreSBUm8
	WSW6bUSM0KkV0/MqK3iU51lBx3NjkF8rCbRCAA6wQ9nWZMnT5Cxz4tpvc4WXHgO4CiLmG68geK2
	ccm6hBG9duAIVmFEMhnpxYV+qL6FFuKJzwU42ShXE9lOFCxud83zTO/1BuRXbxEzO4XFuxvL2N8
	wIqfVt7Bb5ucu86ZNnk9kyx4cTxioCriXJNKEQCGbMFUdj7Vqj06tq+aFBuyCziDHLdBQDRhiWk
	KkkKCXcbz9Q3J9LfL0UWNka69E30smS+CPoLfhlZocoCXNxhyGqXJKr9oKi4AIAyMp64UlUCsUD
	02oRR7tgwhV7C6NdKQgT2qNgdtVdcgCimbB40Qs7nXODzGT2EOgpAVEFV5t3rGd4mkgoGn+97Ta
	77H8TNn82kxHdamfM/YUzxNkbIZsNg
X-Received: by 2002:a05:6000:188e:b0:435:9ea8:8b83 with SMTP id ffacd0b85a97d-4378f14870emr3625053f8f.19.1770903966891;
        Thu, 12 Feb 2026 05:46:06 -0800 (PST)
Received: from localhost ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d36f86sm11357396f8f.7.2026.02.12.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 05:46:06 -0800 (PST)
From: Mariusz Skamra <mariusz.skamra@codecoup.pl>
To: mariusz.skamra@codecoup.pl
Cc: stable@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2] Bluetooth: Fix CIS host feature condition
Date: Thu, 12 Feb 2026 14:45:50 +0100
Message-ID: <20260212134550.430152-1-mariusz.skamra@codecoup.pl>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[codecoup.pl:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215962-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[codecoup.pl: no valid DMARC record];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mariusz.skamra@codecoup.pl,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[codecoup.pl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mpg.de:email]
X-Rspamd-Queue-Id: 258D512DEE3
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


