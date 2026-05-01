Return-Path: <stable+bounces-242259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO9YGhN59GmLBgIAu9opvQ
	(envelope-from <stable+bounces-242259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:57:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E444AB72E
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D399C300E613
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61544384236;
	Fri,  1 May 2026 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="wBDXD0uV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EF37648D
	for <stable@vger.kernel.org>; Fri,  1 May 2026 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629449; cv=none; b=toYt6Vv6eXljwvvOp7t43uCo4hbz7Y6w00+s8IlzPhG1rfyVwehvFCAWjxiNG3cfZWoH7AiyhFir5RxdgyiWuX1LLOwBEI9LYmbVmpsBerGVNMStsKyErphnL2IB+zdLi6pOq4vSdTT8bsDcLttf4hBsaDiCm/jVXqzOcHy2I0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629449; c=relaxed/simple;
	bh=G/XFuwWSYegiGjSYZM0aXjfEM9ASQLOuSIcX/VLpzm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWfBS2PHfBfNrD0t/5Lwq6Nkd0H0lWjFuxzFG6GHYtNIyJTFTDHaj/Z8aAuas/tha5RxqW38rDYsEbliT7fkQs5XJfb5S0MZC+RzWDpHYlUcypRgNnBcw4W4rmAdee6ri1yXw2WaOhTOunT4Vx/Weq5V3ZZ4lXQtGOydWbVz8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=wBDXD0uV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483487335c2so19320295e9.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1777629441; x=1778234241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xTN6OsAVuW3jnezW6FjJSAEG6gFeBXpHPEFbG0OKV4=;
        b=wBDXD0uV35huVdD1wM1fFaUo3/JXJQuZ/MXEeyXa44aStTGI/am5hzYZA+PKmW/WeK
         KxSj6Iym+6hMnvn2tyY7aHwkySlkYtxGDWMdlI0ygH76JqXA1LPbu6NPx4flhBEHsbob
         v6XqInW59UwHPaUgPOIoLLNzKS9jGqoKlXhy75rogcezANwzoK54qunUd/ZyNspCr6HV
         QEoqpUhOxfBEz9MHeay+a5j2R79yCMgRZV+bjChEDxYwLKY5/zEx3NaFOmLOQJHBLjFa
         BUhwkpyx8jqQoUZ9NNRkzSYYtt969Fzf3sCdhmvJrdCkY5g/SKiIrH1lTCjXsj8LtETO
         fDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777629441; x=1778234241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xTN6OsAVuW3jnezW6FjJSAEG6gFeBXpHPEFbG0OKV4=;
        b=GOiDBLhCANGGv8+Y7lkAxEIb30mcXtg6MVaxFkyqp4MHOqDQmxBay+Io+63M5kasND
         W6BsXmJf7j69oDKanZzLJLEmKQqxSrTnPddgKwakNE1kRUC7jQ7137BLYPbDUPtShV3Y
         3stSfHw2bKTU4/kYmiooRQ6uj0wz1eK6oxBub8C6uzwLJt1DGfq6iRu33Vo9+dlFqHxB
         T/hIU91jJE8FWKtr7YrMzB4JdMzYVMsHhpStlcoS6z6CnkuvmQzr4C7seXdFVmucnDtv
         x2WwST6HVS7tHl+DHBUqa9mr+bveCSIFwkBygwkiJez996bQ5cx71N+Fn9rqIqeuUdl6
         OukA==
X-Forwarded-Encrypted: i=1; AFNElJ9Bp5n2iyngssoQpv71fLAgWWN8y5jib0Uzk7B0dRjqE1KmyKQ5tuTfEx2p9SXJC+A69yyONV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0IUWKCzXDcbSghH7H98JFmopO7dbN2G2qkZ+NUV9ZSdRC9yIG
	uJB6oJUrOzVDpwlxqY/9NkPAbvovq/ZyEhc/iSyW11g9yGvRsaOBoCYXHkil5xjBvfoV8WWY/Xx
	N9Q3CZKk=
X-Gm-Gg: AeBDietefXlPJkbBMkRz6kVxNuBh/+2aj5qYj/tBWRuGnQYRA4S06DKWPXILtcjXBiN
	Uln1gPts3KwC1YI0Uq7Se2UUFICfjJdQvsC5PA0kUm0Ipx7eSiuPEjvyCiF6utL6oIMMHA3bZQT
	/i5ly0rVlzm2Y9d/ukKZLq+zV54wxPG9jzeXg2zQ9DfP0iP/Nf8zOrXEoApo5e3bq5s2YGaVGop
	g4EDOm0HXvuJXrlopnHq9R6R5rb6k6MI7sx4ylWltXxyGfDYU3qnCAgEyMT4BtvHON19Zje8enP
	K5+0BWsAT1whb6UTwwRECHtJSChaWXg2X/WapDnu2l5tCCroQMXy1H+fVbMz5QGKIZZBLhcqo7V
	aDRTagqjUfvB1XhGP4TFn65x6rvDHHnKZ9kg2D4IIBqrg+kVy5WMTS5/hCgp/R1RCe23bQSpZdw
	FBYNaf+dqMSMrja1HZIOrTXR3lP066ZugX7Ax3
X-Received: by 2002:a05:600c:154d:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-48a8452db0fmr108898045e9.25.1777629441256;
        Fri, 01 May 2026 02:57:21 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26d2::3de:68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm73837315e9.0.2026.05.01.02.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:57:20 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ice: Fix missing 1's complement negation in GCS raw checksum
Date: Fri,  1 May 2026 10:57:17 +0100
Message-ID: <20260501095717.1032151-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 10E444AB72E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-242259-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[readmodwrite.com:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,readmodwrite-com.20251104.gappssmtp.com:dkim]

From: Matt Fleming <mfleming@cloudflare.com>

Commit 905d1a220e8d ("ice: Add E830 checksum offload support") added
Generic Checksum (GCS) support for E830 NICs but omitted the 1's
complement negation (~) when converting the hardware raw_csum to
skb->csum for CHECKSUM_COMPLETE.

Without the negation, every CHECKSUM_COMPLETE packet fails the
fast-path validation in nf_ip_checksum() and falls through to software
checksumming via __skb_checksum_complete(), which triggers the
rate-limited "hw csum failure" warning. Packets are still accepted
(the software recheck passes) but hardware checksum offload is
effectively disabled and the warning floods dmesg on systems running
nf_conntrack on VLAN sub-interfaces.

Multiple other drivers (idpf, ehea, iwlwifi, cassini, sunhme, enetc)
also apply ~ for CHECKSUM_COMPLETE. The ice driver was the only in-tree
user of csum_unfold() for CHECKSUM_COMPLETE that omitted it.

Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
v2:
  - Add Cc: stable@vger.kernel.org (Aleksandr)
  - Pick up Reviewed-by tags from Aleksandr and Simon
  - No code changes
v1: https://lore.kernel.org/netdev/20260408190214.1287708-1-matt@readmodwrite.com/

 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..c177579e0114 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -92,7 +92,7 @@ static void ice_rx_gcs(struct sk_buff *skb,
 	desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
 	skb->ip_summed = CHECKSUM_COMPLETE;
 	csum = (__force u16)desc->raw_csum;
-	skb->csum = csum_unfold((__force __sum16)swab16(csum));
+	skb->csum = csum_unfold((__force __sum16)~swab16(csum));
 }
 
 /**
-- 
2.43.0


