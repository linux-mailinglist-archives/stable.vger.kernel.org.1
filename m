Return-Path: <stable+bounces-254845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O66LxcjGGrkeAgAu9opvQ
	(envelope-from <stable+bounces-254845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:12:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0655F1186
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA1DC3015896
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB443E00BE;
	Thu, 28 May 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZqdbQHA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FC3D16F7
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966739; cv=none; b=sTRItEgSwlK9ytIcSJV66PXfFkuJJwdxGLnWbDiM/V6MUpEkbRkRQW1Y03W7j4eDxYfvArbA9Mm/KNCBTR6oah8O3ZR25WqYJPD1ts3DxFWBCnvuNnC/Gl9aBazDa+liV4Tb84YtHkWAtavR+GTS+V/KEc+UCjKa3KOoEQFrH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966739; c=relaxed/simple;
	bh=b4yzUYDgsNnna6cksjHB3xOq3uPizKotCCHRLJR2qVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzGo9gG7yUlM7FwEUOzIa84cVuI8TQy2mzU/Pdt4HgmpNNMb1LIA+rrvgN98+E2qeiTN2sxh1R8/LliZJ1E7CYIPWF6KlWmk5nUblU9yO0c7LsBoS6VwAfg1qIZ2TsbYX2JfCRWfSit5qHgXsNaXxU+6qENZ01zPDzBaA2QLxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZqdbQHA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b9ec9443c2so70558715ad.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779966737; x=1780571537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqc9nveU7NUU23u0mW5oSotuBU5xhBDBx8BbOpvmxL4=;
        b=aZqdbQHA78YL6Yapz/v4sSCIHsooUknz4CwhbqAjxVc2UZpYUGy8BSxy003crU7Ia/
         JkkAbrtngt2ZH2bQxcZ7DImFrESJtO8U0ow4IKkWGzFsa5TRsbWbJikLuMSqqIS3xsrN
         H0+GiN9RBm4+tTdvuAYNYtU+MaV57Gsq2APK7Anu1wJFLMdCVFftGE8rnqeaisfTCyC2
         abFy/uuMw8CH0uzgJfNMbyw+FWAoapHRKrVQiNAjkiSI63pQBgmRKZ7MnN5fhj5vTJhI
         pa6KZnPsk+vdvSX++yxnSufyifMOhTHeYc5ucX29P7rGGu2VKPEJw2EWWPP30zX7ywBB
         8oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779966737; x=1780571537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqc9nveU7NUU23u0mW5oSotuBU5xhBDBx8BbOpvmxL4=;
        b=ow0TZBd5535vFrMdY5xiIim4SA+N69HUn1VF1n8Z/nGz85E4n1j+ZU/I61CP78Xkvu
         0AzRFUOyrbsbHuEoAoE+iWQY9PTICuhA+Dj7Im2caadGAQI06jNG5ExB+/ev+45m22If
         4YOuWpMk8FVVCvu1KHwjlTro2HaRTG+dDixWHOCkUXc+1KlXP6ENV08M9pBb7xEVqmNc
         pDpuLBrnNuecPzcjfcQhNTI/8vV1t6ba/0GMiS+ok1whvQo/fDM2L43AtJ1gadxGfOPi
         GNbOlYA8MQGiazpqdP982ejbCrci1JOww9kdVXV6xDXbKC/7UlGCMM1XWt5l8UsECUEQ
         1SDw==
X-Forwarded-Encrypted: i=1; AFNElJ9D/82dKqSb7bbvIZIS5iao/f7lE9pIbTZLw+dA46ifBFk47uZZHuIQ98FZ4cy0fBhq1Sv0kiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgMl+96bdGoNAQAAuQRj0zb4Q9YyfJwAP4hB8TC5WeY8ZNhfU
	YBwECi2Y5Fsk3FbAiAT0cWtuTwiIA7ejmguX2jD8dtrvdbFnzWGTEYv9
X-Gm-Gg: Acq92OE+FvoUI472I8Hzcn79Q3bbvpcP5gjf8iDgHvq0OK/V4bWWzrnMCJklVPmMpmJ
	U5qmCPzIcL6vwucMhDHXx8zl41tHqp+eCxiS8NrH0dsWTrQg2bMKU+akVCwO4vhnjEfrxHwsWmD
	BAFWSsf9cI+/V6s7DAIep0INv89kLwgbXOxwnQibI/nAJUHzsedIFKuT5+wjUAY7KGAqXjNxon8
	hTGPUOtkinQdfJ9B+PiJ7gAwsKPcmAC55mlgA/D890wPbUKpUQSXuiWJUwYmHzfBv93tm2/MPIf
	DB3uIQgUGqixq4lQ2NIPQDBmw8E11HD7AP34LU+3drv+mwHti8HDCIWmbtxZFSXVQx3oZlBBZKl
	LOtscrLKHRW7d2XBYX2bVeWBeeQGkPeTDG5yb7yHQbDwIj/WDxU1KVcK+paWuUwuoh/pOIDu08r
	fkdZ4E6Nvq2AzOJ2laPCuJKtrwTZWNMgB4QTBb8+R4zT1UeOOtdJWBKAY=
X-Received: by 2002:a17:903:2acd:b0:2bd:6327:b507 with SMTP id d9443c01a7336-2bf10cc81a1mr10828205ad.18.1779966737321;
        Thu, 28 May 2026 04:12:17 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([192.129.190.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5924211sm162946435ad.84.2026.05.28.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:12:16 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	horms@kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH net] ipv4: validate ip_forward_options() option fields against skb tail
Date: Thu, 28 May 2026 19:12:04 +0800
Message-ID: <20260528111204.482401-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nvidia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254845-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5A0655F1186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip_forward_options() re-reads the RR/SRR/TS option length byte
optptr[1] and pointer byte optptr[2] from the skb on the forwarding
path and uses them as indexes for 4-byte writes via
ip_rt_get_source() (and a memcmp walk in the SRR branch).

__ip_options_compile() validates those bytes at parse time but stores
only the option's offset into IPCB(skb)->opt.{rr,srr,ts}.  An nftables
FORWARD-chain payload mutation between parse and consume can rewrite
the bytes, driving the indexed writes out of bounds and overlapping
skb_shared_info.  With optptr[2] mutated the write can land in
skb_shared_info.frag_list; the next time the skb is dropped
kfree_skb_list_reason() walks the forged list and frees an
attacker-controlled pointer, an arbitrary-free primitive (R15 below
is the corrupted frag_list):

  BUG: unable to handle page fault for address: ffffed10195fd757
  Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:kfree_skb_list_reason+0x167/0x5f0
  RAX: 1ffff110195fd757 RBX: dffffc0000000000
  R15: ffff8880cafebabe
  CR2: ffffed10195fd757
  Call Trace:
   skb_release_data+0x565/0x820
   sk_skb_reason_drop+0xc1/0x350
   ip_rcv_core+0x7a8/0xcd0
   ip_rcv+0x97/0x270
   __netif_receive_skb_one_core+0x161/0x1b0
   process_backlog+0x1c4/0x5b0
   net_rx_action+0x934/0xfa0

Bound optptr[2] within optptr[1] before the RR and TS writes, and
clamp the SRR walk to the bytes actually present in the skb.  Match
the existing error handling in this function: skip the malformed
option in place rather than returning, so the single ip_send_check()
at the end still recomputes the checksum for any option that was
updated earlier.

Cc: stable@vger.kernel.org
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/ipv4/ip_options.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index be8815ce3ac24..36a4e3cc39dd1 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -544,18 +544,26 @@ void ip_forward_options(struct sk_buff *skb)
 
 	if (opt->rr_needaddr) {
 		optptr = (unsigned char *)raw + opt->rr;
-		ip_rt_get_source(&optptr[optptr[2]-5], skb, rt);
-		opt->is_changed = 1;
+		if (optptr + optptr[1] <= skb_tail_pointer(skb) &&
+		    optptr[2] >= 5 && optptr[2] <= optptr[1] + 1) {
+			ip_rt_get_source(&optptr[optptr[2] - 5], skb, rt);
+			opt->is_changed = 1;
+		}
 	}
 	if (opt->srr_is_hit) {
 		int srrptr, srrspace;
 
 		optptr = raw + opt->srr;
 
-		for ( srrptr = optptr[2], srrspace = optptr[1];
-		     srrptr <= srrspace;
-		     srrptr += 4
-		     ) {
+		/* optptr[1] (option length) may have been rewritten after the
+		 * parse-time check; if it now runs past the skb the option is
+		 * malformed, so skip the source-route rewrite below.
+		 */
+		srrspace = optptr[1];
+		if (optptr + srrspace > skb_tail_pointer(skb))
+			srrspace = 0;
+
+		for (srrptr = optptr[2]; srrptr <= srrspace; srrptr += 4) {
 			if (srrptr + 3 > srrspace)
 				break;
 			if (memcmp(&opt->nexthop, &optptr[srrptr-1], 4) == 0)
@@ -572,8 +580,11 @@ void ip_forward_options(struct sk_buff *skb)
 		}
 		if (opt->ts_needaddr) {
 			optptr = raw + opt->ts;
-			ip_rt_get_source(&optptr[optptr[2]-9], skb, rt);
-			opt->is_changed = 1;
+			if (optptr + optptr[1] <= skb_tail_pointer(skb) &&
+			    optptr[2] >= 9 && optptr[2] <= optptr[1] + 5) {
+				ip_rt_get_source(&optptr[optptr[2] - 9], skb, rt);
+				opt->is_changed = 1;
+			}
 		}
 	}
 	if (opt->is_changed) {
-- 
2.47.3


