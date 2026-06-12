Return-Path: <stable+bounces-262876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PhT/FqC5K2riDAQAu9opvQ
	(envelope-from <stable+bounces-262876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:47:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D2E677694
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:47:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RMuSIQPJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262876-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262876-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDDAB305B211
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB443DD51C;
	Fri, 12 Jun 2026 07:47:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035E370D4F
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:47:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250460; cv=none; b=d7B/LMrVRuaxhVXstoMS87o21MUk/akT4MmMRN264S82wIiTVqulZDvncqWyI4RBXxEw3kWQh2merTZLiSvPdw+DF3kLUt7q1KT0nYUzDs1lD0D4P17VVFHTj9gmcbc0W+bjIXGEXl/sgyFUD/5VkpZU1Q5Ilg5TDMku017vgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250460; c=relaxed/simple;
	bh=eHmMfifAH+b/pWnLwnIAEeQbfu0AqydXxKUsBJd0qp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EO8f9cFV1hkpvtK8dvsprfrLcomlLrsz0f39/izQdd/tE9HmPC1N+Q70ai7UqpFqRcKMm9biQl37rKb2TvjJLVEIt2D9/ctpuByZCO4DYNvgj9Wvu4b8QMe/TyQJS9xlN+2WPV5MmyP9Of2qpBJeZ2bKq0EJentx8VCVRaIrGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMuSIQPJ; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423610ec93so640025b3a.2
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781250458; x=1781855258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMrdpBLwtgNudIzjWDD987f63Qm2qC8/+0JNe44FmBw=;
        b=RMuSIQPJAfK1o3ep1fZHK6FXPoVi9kJL26sCNz32rS3chkAWxU2Pm5r/TGsIcqhiIY
         CVYkAL9QNVvZGqo/WbJQcsqV16AztBncgV2L/BPFkBkXbi8Rjg+5CL2vXqNFTy38O9gq
         RAYYxfopApSbGY5Ljjn6bKkfLHjQQCvDf/fIKtvrQR79szWInJiJzERVOWYRwTkhTdfZ
         grAlV1F4BUqyDqxwZxaX52mnR918Hu5Ji/VhFGOoAfSCMzDb50e6Dn40HTM3478ZiW+T
         a6rjbUDncnckNhSoLkYm2XQZwn/4K6twUsakmciT8dTFnFp/vXYfc1S6QoooNVVozupB
         yjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250458; x=1781855258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMrdpBLwtgNudIzjWDD987f63Qm2qC8/+0JNe44FmBw=;
        b=Z9D8Ka+gQlm4fXtfVr7JQFsGv3R1/FLRRt5kGiWPJDcS50sNVqZ7fC6l4se9StYfrF
         hmtTJzjts4hYtIKu1hy9YN+gcMWhVjWbzlIUlqzqitwBZPFc8jAwQ/YIiNsxRcyww+xf
         xUEtKu91F1Lgnkbd7ovxLonRixqB/q9H/TW+LJXFqb2BUYPmFCgpSw2T3jwxvzJg0E+n
         Ek8fTtvUWq4pIyBa2I6UvfgJe6vaIOUOE8UIpn5puR2OcOQyIdlou+ipe/GBI41+yZN+
         LV52C0NgK6hzyxC17RFSGoV1l3nLOWWoYddDPpxx2477eyQx1wz6VHSkEKv1Y5Zj8krY
         2Grw==
X-Forwarded-Encrypted: i=1; AFNElJ/VjvNs3/VXiRRiroZH2DsYlNgCH7+nDA7DVXC/VJgoJMZm5SL82IqNSJYW9ubM2003hUVXuZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbdtv/6TZ88xlOtdfQFDOmG6Mp8gwgShrRiWLTDIa0IHZrQsiI
	lcHBeOvc6GXOVWrv6xgq+GZTCVcUcjuIby/yVocA5HG7JO38+YqQ4dAf
X-Gm-Gg: Acq92OENZfVPwuGel4PpXpt+HMcBj8AzY5g6l4GQYRjDMw8B4ACFGAo4FkvNUrGUtGA
	MROEm4rKUEEQVYE9Qchfg5I2iaMuPnw30h8IV2eowRNLOZirVMpa8/ljsEzR3NH3HZDfbG2lXYl
	DbyMtPDGdDgBNDgd8NXvS7/vbk8JoggHCcgWCjHU6GHn7WcdHXSV2GBHXXTthiP+qBpbqi7xek1
	Y7UstnycnOmMsOvG0/3gTuUwA2iD9ayb2f0e7f1hKt8HsbdOd75pc/8CUcU7cLosCGyIUv3Mbje
	8ogEHsYUjt6y7resWGFF4QHBaezpYCJFYDAkAgcdEgdg+IQFiC/PkjwxSlhw0jumCw3ikuxNvtU
	N1ZPS2qpRErsIIpQbmsBakFmnwzbfV3CO0FttO5m33dloaMn4sbPDxAG8M6AkfIMJ1kuAA3YXS0
	7AB5nOiYGObsMMX08MIs8qEWInBg4VN4Jrtt4ebwcy4ZV3Dc5fayDlKQA=
X-Received: by 2002:a05:6a00:84e:b0:841:d7f6:7297 with SMTP id d2e1a72fcca58-8434ce6b927mr1957626b3a.40.1781250458164;
        Fri, 12 Jun 2026 00:47:38 -0700 (PDT)
Received: from localhost.localdomain ([116.72.140.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd50e6sm1337683b3a.30.2026.06.12.00.47.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 00:47:37 -0700 (PDT)
From: Piyush Paliwal <piyushthepal@gmail.com>
To: u-boot@lists.denx.de
Cc: jerome.forissier@arm.com,
	trini@konsulko.com,
	fberder@outlook.fr,
	Piyush Paliwal <piyushthepal@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: cdp: reject CDP TLVs with a length below the 4-byte header
Date: Fri, 12 Jun 2026 13:17:30 +0530
Message-ID: <20260612074730.82719-1-piyushthepal@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,konsulko.com,outlook.fr,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-262876-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u-boot@lists.denx.de,m:jerome.forissier@arm.com,m:trini@konsulko.com,m:fberder@outlook.fr,m:piyushthepal@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[piyushthepal@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piyushthepal@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5D2E677694

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


