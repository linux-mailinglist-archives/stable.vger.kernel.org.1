Return-Path: <stable+bounces-262871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lnpBMd+1K2rtCQQAu9opvQ
	(envelope-from <stable+bounces-262871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:31:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B96773CF
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:31:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dF8nUp1S;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262871-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262871-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01A2C3009F2B
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 07:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE54346AE3;
	Fri, 12 Jun 2026 07:31:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACDD314A73
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:31:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249498; cv=none; b=Gfi+I/xR7DrmpujKCyKNXoZVZjGn6iOa0+0ZjDCbfgyDKrmf1Zznsz/70evhyhG63Sf+sAlvB4IHAraWkGUFSNj2nfr9FEFemABgbnxdfZ/Ab0cwKbgKDYUOPEIVD/mr3KWkK/XnvIjPATTLjmwiGu1dYR71fOE+F13Cd7OKzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249498; c=relaxed/simple;
	bh=eHmMfifAH+b/pWnLwnIAEeQbfu0AqydXxKUsBJd0qp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZFUJNgWPlEcmH1Va7GBgtGDXWKmbGwhF6OoM/0OfUbIlSmP9Ly7/Y0Sux1uyUCy06K616NZj1Zj8w2RXfZd4BtuglXdKHFnkMiAqkxtg+GHNGJQqO3qoKCIkyAVixADS2bFJDHjhbDkixrjgtCe95HUlxOiqwIQPQyiaCKH+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF8nUp1S; arc=none smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8588f8fef3so226147a12.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 00:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249497; x=1781854297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMrdpBLwtgNudIzjWDD987f63Qm2qC8/+0JNe44FmBw=;
        b=dF8nUp1SX6TQ9dB/UNyphtkfB2amuX9N3Tr0eRoungcXSMSJ4BCdFuwzDHRw8GdZK3
         RdLMjmqCkURNyXzbdrLzestaBrEFNyt+MzqSqPbtt1oRPv8krlBmPxRa/iuCaTvBTbB8
         SFR04Y3gu65Q6usIlhwZK37Dz1K3ZZMYJvzmHZUyiOZN4tukgZqOm1Aq3fCqZZaLJiok
         dEmIfC6JYA1Nsnd9WU3r60vDMpA2xqSpn9KpBw7A8N32h5vM+ZjWiCZd5dZjjhIdNsXS
         2SngPF+HP0juWqrS572JECQZGxpi9qNgcqpI0aIwt50sSdz4+3ua8Gweyo7gyjIJPHNf
         Nb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249497; x=1781854297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMrdpBLwtgNudIzjWDD987f63Qm2qC8/+0JNe44FmBw=;
        b=D1qk+sf0L2EXwf810vzW+9wgKWuKyDjJJHAVgD2okhRKrqmkKniht9JTb2sxMxFhce
         aHCRcC5P2aqmbtgNvEbSFSlB5zSOGuVhtCwLhR4XM0Ut/MFWCRfh+R69EZRVl2iYrV0B
         dkIzp8WFtaOi+1mCHTluYaQfBmb3a154nSX4H9Q4+lk59bgrNFYrElfChVSZlu3++zpn
         Evbn+bqLY4JHFtzffw2ARVBQVtYcm1hAzTBPB4FxQZi2aRuw7F0m82cIMpRWqHFIpNIl
         LtZACYH81yR1tYD19Lp/DhTzNNsfN0wbKb+JqSB0ziGUZomZ8e4S17GbMFadl8TLsEnG
         GYGA==
X-Gm-Message-State: AOJu0Yxmduf3ZL3sfw5BeYl25JpQVSuLSeunVYl9wyVU4sxf21LQMn8B
	wyEXF45C3s0OH0NNRAlWoZhZ9ZbDVEvYrRvapvXTwRv/ZjxMuRP6qHcMPqTC7Q==
X-Gm-Gg: Acq92OGwZOoNw+Zh4uiKkwIvoYx8orMnLQZFdhlUJAcnFrPvkU8dbwFgHRmdqudcyN0
	v0oPsWPFZGWJU0ZmkyxXJFXVxApSAZrAdvjT6O1HY+Pog+PVgdfP90ojhPvxGI4h2KgiwSaHeI9
	nz6rlANT0geCaN1WHzZb5en6f3V9BQd3SQJrCPP9bmhG0OGAOhnCdJ5uQyL36soUWIPuwToHuCf
	YFh9gHcRCaeZ0Yj4r/gQ1aYvZoowuqIIE4LHXn1KuXhKfsSfl8jLzxuhEGunbzv7ThX40aAKY8r
	GzyJzIx39QtBO1b3Em03WkZqrZPyKcIuMf4V1DLVgaa9/EPHw3TM6Ie/pGn7tns+Ahm//uvlMDj
	OI4p5DDBUeC85ny4e+tpUkTU2Hx0bjMYaY3XVYaesJ3Tllxyi9dpq9umwQ8MYvtcphw0ShTjPrR
	THUvH/2v7qo4tk9l6YKo34uLzfbMj2Pvl4VAmw5TBWKiwL2A/XxtzxwZY=
X-Received: by 2002:a05:6a20:7f86:b0:39b:dea7:5626 with SMTP id adf61e73a8af0-3b783fb321dmr2475342637.35.1781249496917;
        Fri, 12 Jun 2026 00:31:36 -0700 (PDT)
Received: from localhost.localdomain ([116.72.140.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866519f0a6sm1221208a12.22.2026.06.12.00.31.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 00:31:36 -0700 (PDT)
From: Piyush Paliwal <piyushthepal@gmail.com>
To: piyushthepal@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] net: cdp: reject CDP TLVs with a length below the 4-byte header
Date: Fri, 12 Jun 2026 13:01:17 +0530
Message-ID: <20260612073117.81940-1-piyushthepal@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262871-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:piyushthepal@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[piyushthepal@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piyushthepal@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C89B96773CF

cdp_receive() reads a 16-bit TLV length (tlen) from the packet and only
checks that it does not exceed the remaining buffer (tlen > len). It then
unconditionally does "tlen -= 4" to skip the TLV header. As tlen is a
u16, a crafted TLV with a length of 0..3 underflows tlen to ~65532-65535.

For a CDP_APPLIANCE_VLAN_TLV the underflowed length then drives the inner
"while (tlen > 0)" loop, which walks ~64KB past the receive buffer reading
*ss each step -> out-of-bounds read (crash / info-influence). A length of
0 additionally fails to advance pkt/len, hanging the parse loop.

Reject any TLV whose declared length is smaller than its own 4-byte
header. This is the same class of bug as the recent bootp/dhcpv6/sntp/nfs
fixes (unchecked length field), in a sibling LAN parser that was missed.

Verified with a standalone AddressSanitizer harness using the verbatim
cdp_receive()/cdp_compute_csum() routines: a 16-byte CDP frame with an
appliance-VLAN TLV of length 3 triggers a heap-buffer-overflow READ that
the check eliminates.

Fixes: f575ae1f7d39 ("net: Move CDP out of net.c")
Cc: stable@vger.kernel.org
Signed-off-by: Piyush Paliwal <piyushthepal@gmail.com>
---
 net/cdp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/cdp.c b/net/cdp.c
index 6e404981d4a..300b3d5c409 100644
--- a/net/cdp.c
+++ b/net/cdp.c
@@ -276,7 +276,13 @@ void cdp_receive(const uchar *pkt, unsigned len)
 		ss = (const ushort *)pkt;
 		type = ntohs(ss[0]);
 		tlen = ntohs(ss[1]);
-		if (tlen > len)
+		/*
+		 * tlen includes the 4-byte TLV header, so it must be at
+		 * least 4.  Without this check a crafted tlen < 4 makes the
+		 * "tlen -= 4" below underflow (tlen is a ushort), and a tlen
+		 * of 0 also fails to advance pkt/len, hanging the loop.
+		 */
+		if (tlen < 4 || tlen > len)
 			goto pkt_short;
 
 		pkt += tlen;
-- 
2.41.0


