Return-Path: <stable+bounces-213002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB8tMlKGf2mKswIAu9opvQ
	(envelope-from <stable+bounces-213002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 17:58:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3906BC692E
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 17:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DABF30071CC
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F026B756;
	Sun,  1 Feb 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZx5HsPk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F725A659
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769965122; cv=none; b=u7QBhj1xdLaxdI44F+IO0gFDwnrZO5nIfbtZ4Nmfz7qOsXUZ8X3O943VeAT0FbUbPO3IarEM4ZRfy9xdi2POSoMy6xB8v6+6b6LQEx1+HP0zaj48NVnap6iftj1Bcks+Tpy6mbSw8CJT1/5DPq59z7F/FnTcRTsRuLDXV4oRoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769965122; c=relaxed/simple;
	bh=OdAaEFSJaukpevDaQonyqArjBFZiudEKmBCRz2iW6Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6uNpbfl8j+15Q3PZOcIeBJ01y1BMdk9On2BbZOfQsvwnBQbelLOFmhg6FrpW+jg1RO3OLWF/HUrscidmhtOigQvLOAOhQi/MVaD3Kd6w1e+CiARO2CYAyiWbQBiwGJ+CMNbxx+uv2h+wh4hT9Tnxh4NSAL2ysqdMey/YvtVUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZx5HsPk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so38844985ad.2
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769965121; x=1770569921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBfv8eejZu+05bJxMtDkYGwkiaLBdKZ0g8Il/kPgKWI=;
        b=aZx5HsPk9jqJI7pkLm4FIRfkVQsHdY8divUGDNdWSSuf0npIStYpEvuY+6TqjhLl9Y
         WMJcm7pyGG3g6uD/SKA95M8v5F2Plb6LQ0OUGd6Z3knOz5E0L/CNtHMvi20hiwK8QA7X
         Y5uEI/3VVNmOhk5vKcEQQ6gMGC16W6ZrARYO4mnjhL/MMC1UHLFG0hN8+YRlg8lVC9+G
         3EQJXClEWuEwLHBJq0WeJ9Z29sUi7eSA1JS92Q+2WoGSQ5sgPBtHeeEIDJ9irUj1Ap52
         7TmMeupvy6LgPZQ+JoUBG0PGFJuq+KXDuvryOQIe45JZmPthIH9zR8Dd5uY7hdJMXe6W
         xYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769965121; x=1770569921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBfv8eejZu+05bJxMtDkYGwkiaLBdKZ0g8Il/kPgKWI=;
        b=huHe7GtcaTIA+xhNBq+s5pOxK0xJJuq1b9uqLEStCUP3vsiXphPKtLSryMo+DQb8sT
         OWDJ3pylvV0a7ewvU5hQYUZ7lPEmpLHm0giwLlThI9S8o14acxlLSFtSjFvQPLriK9cK
         G6qzX0TeMv80/uuJs2Zp3t0Z4roP3zSc384WXfzvbrWCs042M0Dw2NsWn7ho3y1FOsjL
         xnjO4gptiQ2bzbhb/DKp0qsEfJjzO2FAZdWAG2UlKNWaT3O0RhZYZDtEgTTAmqHwoSgo
         fqG37KETPAvNdix5IvCzK8HoOxgJskgUCPySs48k1Bq4PNEyi4MUpD/rhtqPt/d0eLjp
         Wrbw==
X-Forwarded-Encrypted: i=1; AJvYcCVoeQlyEHBYa4gtyfT+QNL+N9Jd+i6cKEMLKL51DJgZA2DYrRAtAXng+ANWcIdzIJv0KqnLUZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zmUVrEXXvkP+zrAL/kbwoTADLsZUJ6kTxBHGqQtRuMz11O5z
	GAA6Z8+z9EcEwKqOq22rlBVkga0cvBun0ZBXpNaSpNs+iY4xpI79o/4q
X-Gm-Gg: AZuq6aKuC72gfhGVbc9SU84yyTU3AIALBL99OjIAHr1Y+1JSTUYCKT/oLtwlFHXbD4l
	r4oavBcK0OXEyor0XVdAKzaUy6oBHLpXKX1kCWyaWkHKPwwqLQsebk9MCUm6WPdNXLi8C78XSOk
	ZbRVPv2vLgEA/uL5n/XRTRskX0QHtoryRBK6Aj1t0vXqmCbwyLxgCIE9SfNKzJThZnCWT1kDeiW
	IyDgonsChdvUU6SmQgRf7kaJ7Drn+qbS7WqLafYw8vSLKT9Lv3I28L4E5rCvynDMf4bTg+U5lAM
	JUEONay33Sa2sEoMIlumR+niwoPAzJFmyzf2ujMaojUE2/RtFH52M4uAp3lyYnR0AInvb2akS5E
	nrSGXf9tdXmxw9fi15rmz+VAefRSdUZAgX7OUM7cVnRxkUFImsNeBBfQQzb9kwsRfxSw0u/OZRq
	00uKpGxoxfHT9DHkmgSZACo4mv
X-Received: by 2002:a17:903:2389:b0:29e:e925:1abb with SMTP id d9443c01a7336-2a8d96e3de3mr95621095ad.27.1769965120650;
        Sun, 01 Feb 2026 08:58:40 -0800 (PST)
Received: from 4aee0dccb4bc ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3afdsm120222755ad.61.2026.02.01.08.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 08:58:39 -0800 (PST)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
X-Google-Original-From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
To: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	michael.walle@kernel.org
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sanjaikumar V S <sanjaikumar.vs@dicortech.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: spi-nor: sst: Fix write enable before AAI sequence
Date: Sun,  1 Feb 2026 16:58:16 +0000
Message-ID: <20260201165817.53-2-sanjaikumar.vs@dicortech.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201165817.53-1-sanjaikumar.vs@dicortech.com>
References: <20260201165817.53-1-sanjaikumar.vs@dicortech.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213002-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dicortech.com:mid,dicortech.com:email]
X-Rspamd-Queue-Id: 3906BC692E
X-Rspamd-Action: no action

When writing to SST flash starting at an odd address, a single byte is
first programmed using the byte program (BP) command. After this
operation completes, the flash hardware automatically clears the Write
Enable Latch (WEL) bit.

If an AAI (Auto Address Increment) word program sequence follows, it
requires WEL to be set. Without re-enabling writes, the AAI sequence
fails.

Add spi_nor_write_enable() after the odd-address byte program, but only
when an AAI sequence will follow (len > 2 bytes remaining).

Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
---
 drivers/mtd/spi-nor/sst.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 175211fe6a5e..fe714e6d0914 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -210,6 +210,13 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 		to++;
 		actual++;
+
+		/* BP clears WEL, re-enable if AAI sequence follows */
+		if (actual < len - 1) {
+			ret = spi_nor_write_enable(nor);
+			if (ret)
+				goto out;
+		}
 	}
 
 	/* Write out most of the data here. */
-- 
2.43.0


