Return-Path: <stable+bounces-245126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGJNI4+JAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A39509824
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B339F3034A85
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A7B3859E9;
	Mon, 11 May 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEyUg0hZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCF3859DC
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485023; cv=none; b=nI5yhDw9KnjcAS/VanOc+O0Ro5hE7nISdZ20tx9uzH3vX7CLgtbwNSt2gd0GPHniB4KcR++aUlgZ9hepvAvw6Q9bPIYGJTkBUzNkwY6NaI0lvTdWbUxWxrl+7L3NiQGG5hlKJWm62BBb6FZZN3pQbLcn7C54ysOzJLESXqOgcoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485023; c=relaxed/simple;
	bh=JjrSD4bxzfjtcJX5HFOaKuHuOsY9P2PKUr26uPCnP8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+XDYqNKgcp/xlVIne6SeGpI/XilgjDUS4HbDVCSJj+0gyQ2Ky1fCc/2TCQU74GORU2Xp5FsgivmnzBA/OqnMQVhtELbQ51KrZSoarZsAyWLCfdiHZZiSRUkFb0Vbge19XMZUBCSSI3oTA7wAkU/TN4r0AZG0RoioXTDbT7/BPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEyUg0hZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8e0a768331cso519723385a.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485019; x=1779089819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuaVpf5xVLCUUiNqQ2uptyk2DvtJ8VUSGboQ948YiqM=;
        b=SEyUg0hZ9V8d1JY3Am7Cd0SuZyjhNgFXbR1HNmrTUbkd4b8cVH+YFGcjq+eRvX2xh4
         MeBg4OeOkHKBKHzYZP6cTzuInydYOKHp2hz88Hm949wLOX26tnsSYji86PigNfHCz3BQ
         8dGYV4opwXalgessMImxJeCC8jPEki2U6ZyiSk616RXkbqgCp1dBC3tLukvjzNEME4rc
         M7w402xrU7WEjKN4eYxV4DTWcK2YzJVzz32zpxwWRpKhHP9xHM2wtoRWMS1BowJI1qht
         S/pLvv99nDc6ZGSBaS2TQ8pamieAA3HdmaIOvkdkn7UXxfvor/D0yKFGlxzA12Tx4oIE
         xk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485019; x=1779089819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YuaVpf5xVLCUUiNqQ2uptyk2DvtJ8VUSGboQ948YiqM=;
        b=QKRPjI45DyYZeu2p/5Rue8oEcCuqMVBLGNxYt26NSQGpsAr06Esy9+YWXdvmZdblIz
         lVbayhGo5RYQ+3/BJpSTQ7E9MiwSRk9EsJptXlpigjediBn744ODngk16iuio/fOhsBS
         lDE4DwOcjoTyxMjqZKkdW6yzJbjGzPy7Q3o02HEimN7BOGd6dgPbz8xyPGl4P+VqCCk7
         acoR9TNVGx8n15nnYxBWQa0Zq9k7foitkcbBuD2eTYyedYR6Y2mPiq+RIfhbmwsndMQr
         p+EzLD20uaHJdTs7O4F1Qi8oIdO5WKPVOeuBhiX0c7h2viekWYVq8KIYgAHNaP/3ZLbN
         sPuw==
X-Forwarded-Encrypted: i=1; AFNElJ+Mv36nGt9NDkD4DjuHgpTGNVdhpGDECxu0ogOQOVCcr/ABacUAZqFAya+hcCKmAxZ877ZqOpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwEZcVnnwqu5d3Z6rG/4KKXv5wU8OVq+6/TjaU1dP5kFpwyLE
	DK6PWa3Kig478OerK91dZUMiJgSsHuvISEawo8SepEnnxkkVoBuqVZmx
X-Gm-Gg: Acq92OFMG9Y26IhIUSBJGeLTscu6xB7DoIAZ38DUbJzgTRMFxnlIO4IdGTgeqUIOMHu
	6UJl4XRDZH8vMG+p9rKbWVu5preHzcllhL07DaQPQ7a8lk6UJ0338Gu1/Bn4AhBZ2n+PJf8R9Zr
	IDSIRu9ekIn8zWY06JLb9KYXr4UrapmjmImlz/y2as5MSG7lfN61RVYdpF+z6xHFS6qACm5nZbI
	ynCmabDVqiUFXAZIFwE3xwk9c5BlkP8sNHzGD5Nwu94j3SPvnEUyXU1FsnGzQVq/MDskKaazcBv
	lp0qOKKJmFl5hjSTaG27RRHU2tj2/YamvWKqWY/zVDsXy/moUqWsnl1UcEFexxAnficnFA4VrNI
	oUF/UR+xH8/0ozdwIbuFWrba+u20+BQ5DThhgCt/Yr2Hgfj+dE4fQ56m/ikjU+7PJBxkVUByXYB
	vSIIpMUloHgI4eoPuWjTrjRJNBDy6YJwGESH85lDhtSxecvEBBAeGsUqdJpJPowA==
X-Received: by 2002:a05:620a:45a6:b0:8eb:605f:6cd2 with SMTP id af79cd13be357-90653c08f2fmr2439036085a.28.1778485018739;
        Mon, 11 May 2026 00:36:58 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:36:58 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y v2 04/18] perf list: Fix -Wdiscarded-qualifiers under C23
Date: Mon, 11 May 2026 12:40:37 +0530
Message-ID: <20260511071051.537859-5-yesshedi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511071051.537859-1-yesshedi@gmail.com>
References: <20260511071051.537859-1-yesshedi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30A39509824
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245126-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.977];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

builtin-list.c:104:31: warning: assignment discards 'const' qualifier
from pointer target type [-Wdiscarded-qualifiers]
  104 |                 else if ((sep = strchr(argv[i], ':')) != NULL) {

glibc >= 2.42 defaults to -std=gnu23, which promotes
    -Wdiscarded-qualifiers to an error.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/builtin-list.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 58e1ec1654ef..a37f3b8a597c 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -75,7 +75,8 @@ int cmd_list(int argc, const char **argv)
 	}
 
 	for (i = 0; i < argc; ++i) {
-		char *sep, *s;
+		const char *sep;
+		char *s;
 
 		if (strcmp(argv[i], "tracepoint") == 0)
 			print_tracepoint_events(NULL, NULL, raw_dump);
-- 
2.54.0


