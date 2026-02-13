Return-Path: <stable+bounces-216026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCI8M3HRjmnJFAEAu9opvQ
	(envelope-from <stable+bounces-216026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:23:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E91337D2
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD5B63032059
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B252D541B;
	Fri, 13 Feb 2026 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaoYk5xq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674812D0610
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967359; cv=none; b=NSe7lMQRNl5z8Irpwy8zGmVpTmXFoN6VBqlFdFCmDTIc/2LHPJ1qZNSgy9dr7W9X6t9BsCGTnpKihu+QksPgmoY2NdH/OlHJIF52wQXXqGXOS0lv0lbp4djvqYJaI3g2VUr30x7ntjhzu6oTd6qEwewsp3B3H4nt7/Jjli5AY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967359; c=relaxed/simple;
	bh=LSYFkz0UrOYAmwgkQWvg5id8QdlFKf3BK68u5Xx8e2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLdRMSXTssNgnomUtRNP3o+bP8Wwd0lbgYAm7ncvmdZa9AOvkAhCEVFlnKKFqgEIFvexlJGf7cILcj05iET3qEi57oTUoKQRYCzPa3xn72uRDqp68NfQU0wn972JFPVlD4eWvYv+C1bePULZWaWHFuHLrL00+c1KIfyzdANjcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaoYk5xq; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ba94dbf739so740266eec.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 23:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770967357; x=1771572157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiCbh2V+lOmkwVu8CiLzDS6uSCAV7WhBVlxztbyz1pI=;
        b=DaoYk5xqkP7/w4vfPaR8ZCHq3058kThbaT0Y2Vto0NCLEXQzaNQo3cIX2NUKSTBs4L
         GMU3f2nmLsahoY8PV/5ZLSE0wvDrIx4QSu8Wmt9FsmPQa0dufRfExfjVSRxuqg//ejjk
         JDHZLo9FGo9MsSh0arO6ILS+NHgfMufWxQgRHKKL1gI++3BUiWv5osyE5jvMu8wTW5Oj
         EJpJXEHtqCTRoeVZ9HZ2jTknzOXTP5o9crEQzAfeT/yynZt0eiOyJoZ4/GN18CQ9Jd60
         an3Mhfe7M+Shvt6VMd4BIodD5pNZAzve6oszdOk9E+WGsOTySbJ1rESfXteyjF3HR3AN
         3RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770967357; x=1771572157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiCbh2V+lOmkwVu8CiLzDS6uSCAV7WhBVlxztbyz1pI=;
        b=tTMfEoHj/TQDZRSUybLfdPZufi0jWFa4ApECYwhdcTRZjHSMW70olyZMs7PC4qvPDk
         Dlcw/J+eyZVMkTZy/LjHmtQkDHTKdTelRTl8wSc0o3fBmZls5C54LUc5Nij9wXhH3JeU
         3+pZ6lRt/dppYtGN6F7duRSuUbquBMvl544mFNTHTSK5Y0OFlsVa7+tRSD1B5nAi9XPd
         1nHPocFdWBh2sOw+6ykiMZmXQqcABcSTOxAxXX6NmIQUk/VblTCElBL1S7hVERHGjTbn
         ahTa2sk439wR9a/nxgSQlq8ejg8rUMbrPW/rkqM5elJTa6OQamOeMaKI6vkVYADve8GA
         5yAw==
X-Forwarded-Encrypted: i=1; AJvYcCVvFza+SnnqsdpY2NH4pLMZ2aSlrV0Pg0mCkTzCpgX3BcsiWMehXms8k4au1DQPrYZNRkkrEQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2SIOR38JX+LiaGGGzJ2Eang9xQJcMpztNIPzulRN+caq2Xmp
	C0tRimEMuTvy3D2Xj2fmFVkbZaSDRF9YIuvfDy/WdYxFde/ebTKw+/ncRRxaNg==
X-Gm-Gg: AZuq6aIbI6guEe7ZfINM2MyREYwmOnb0mqRSYK4d0mCf2K91DG6JOzqr6lKSiKaYQCz
	ylowoVVCIVWyOJKYhAqBd/luTQku2F9rdhC1knX3Zl3VYPV31NgP+1vCn0MvrDa6MinEBm4pB3J
	d63lEHktAa4X2dASHNFEnpTBUZDndJSAvPg6k1WzARfbhgnoT+YZp+N/zoNALsOmTBhCu+vedeI
	POQgTDVTJNILS4agUxHK6k/eiPvayPOefaQ2stAf0c6p7uPXnJLx1oWmZm+kvFy5agRGJOOmUfJ
	UfNfI1eXbh2OPq7Z0a+pJzKeNoT526fFO97fW/WgvarV42DtP2+ky1XvQbSTs2s74/gJA7JL7vr
	idZP/8uFs87t2BhJsjuwdYuzJ/oWDJBcUPHZgW0wL/6Gul5lBKrKUxbV5BYUyyWQUbB0cxBfm3o
	QwPXj9NaCK/X8ahj5qConqQhiXxznhc0MBIGlyH5RSIClglagMH4gUAabLAOKvtdFEE5guSQJu8
	ZLAsRL62sO2Q5dj5VAxdSb3h4OpCCpV/NPj
X-Received: by 2002:a05:7301:5792:b0:2ba:858b:3751 with SMTP id 5a478bee46e88-2babc3a977amr344411eec.3.1770967357418;
        Thu, 12 Feb 2026 23:22:37 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcfe6b7sm5898148eec.29.2026.02.12.23.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:22:36 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>
Subject: [PATCH v8 0/1] Bluetooth: mgmt: Fix heap overflow and race condition
Date: Fri, 13 Feb 2026 07:22:04 +0000
Message-ID: <20260213072205.18404-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,holtmann.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216026-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maiquelpaiva@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test.bot:url]
X-Rspamd-Queue-Id: 3B9E91337D2
X-Rspamd-Action: no action

This patch addresses two vulnerabilities in mesh handling within mgmt_util.c:
a heap buffer overflow and race conditions during list traversal.

The fixes have been consolidated into a single patch to ensure atomic
application and to follow maintainer feedback regarding the use of 
existing mutexes.

Changes in v8:
- Rebased against the latest bluetooth-fixes/master to resolve the 
  merge conflict at line 413 reported by bluez.test.bot.
- No functional changes since v7.

Changes in v5-v7:
- Combined heap overflow and race condition fixes into one patch.
- Switched to guard(mutex) using 'mgmt_pending_lock' instead of a 
  spinlock, as requested by maintainers.
- Resolved minor style and alignment issues.

Maiquel Paiva (1):
  Bluetooth: mgmt: Fix heap overflow and race condition in mesh handling

 net/bluetooth/mgmt_util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0


