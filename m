Return-Path: <stable+bounces-237627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGiUBAM13Wl9agkAu9opvQ
	(envelope-from <stable+bounces-237627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:25:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5333F1F4A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D50103012586
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02FE364052;
	Mon, 13 Apr 2026 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oerwcTa9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E435F614
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104690; cv=none; b=k/FxylAA93C6ysej+fPfxIZBYM9jQkqRJmsZxLZvkRF6JOOlGWxuRP46VH+dgLUapwFofkWYDbWLY2fUeW/PGB8dCBggt0JTk5yIkMfh6HQ5DjUAPJgx1vpf2LU+NrsP0H+VW8uLzN4MpYKY7NCeecDba/OoEK1Hk16qLFMrtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104690; c=relaxed/simple;
	bh=WX+GbDCQnemIbX75B+YiYyahJQmX7jQXWaQHRJtE22g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JbW/snanW6Qkw9S9qvdB0UwSnpCtpFyYCBxxXJC34Ow6KCdPXwSaeQa0HkVxzeo74ARcOntCDSediylDKKkEUhOGl3aU/58h/5xoWma2oKysCArDU2wHboF9LFTdFT99zh9/1mwIzilh2Bj+lGqPqSPH1vOnTHj1lJWstDmu+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oerwcTa9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a093c784b0so59911746d6.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776104688; x=1776709488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwuEhADy0804om/OdHEIRZ/J1D9Tqo21sy7eI3dqC5M=;
        b=oerwcTa9ieG1OFUB7FyjG6puCmp+rUhPWSY2P9RJIR80DQy4olguP0QSFpzGjw3yEW
         4s3l9w6/psQwdzXLeIZNv8On2mSK89g03NK5htrp7tqYPfVYEb6ntBGAsHFJyaJOrCXI
         fSxwSqosGzTs+qbDrTb5MFqgYPNmCdIAz4lB1Va6Jzzrju7g/t5Hu5fCcNkNMGwNApa2
         LsvviMh0nUduvQakttLcIviqYmBjkXwuJMnC+s57pr0qE6y1itXEuk7TPs55iFAyOQqT
         ivKjBXK6eD3KO1pK/tUKiddiTgXsplHTX0iEU4OCDRM6011FkiSLw6kzts3d6XmYwKA8
         hXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776104688; x=1776709488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwuEhADy0804om/OdHEIRZ/J1D9Tqo21sy7eI3dqC5M=;
        b=V+Pq0kVUOubwGsUGWJZJbXY8m3oOeuGdJAOsPntr/LJO1mjkdBtsvzG5dbSSLGX7rp
         uEAIop1a4BZYRSYnxfuy9I8iyZzAeYUrulkkwUMycF/KlE9HJKY9CavdpZvWq3hpKiFq
         nejyeRjQQz1d75lnYOVBac+frtUuqToM/KUYRkc8hL1ECdHP8hL6UV/AlL0M4VH4HdQ8
         OcVSRkl992OcRT2hgEwfbQLWO8u7rnr8xNMaT8C9nSADVJu+8yVjYh6nzFuGIhBZuxPV
         SaWFtz0mN/8I7lrc4t9uH0S05r/4QIxRySVkWyJh41uEQt3Rnb5QUajG8FT3leo9QFt5
         rG5g==
X-Forwarded-Encrypted: i=1; AFNElJ/Q3NgQyBFShwD7fsetcng20ujhYH43dLQAPcN8v3ntxkXZ9lCdtENt1PlE6YN10XUgIhhsLo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTRfRbstKSqsiDgLCEmkGrFipV272u0zCfPiC5TDIkz702sRw
	sOri4xHRB7wTOUuSi3kVJNii2X1ToLL3IlTDXMx4E9rTNsN7OITjeuLe
X-Gm-Gg: AeBDievUTdKfwNNcpWmzweb90ydKtO3X547tT+Sh83dlaJ22JmAMa7v2CJcm9EA1Yhx
	4P1kYb28hCPE8/zxpKCLSbK6pi6MOJkGPpsvURT2UhLLee+6nkL6Rx7COIuodNHixYyLCcn49HY
	9ME0MxtgTzBGN9BLbKMmAb3CTr0lnb8KKgt1eWXBxhWFllg1RzyvKoi7JYfKoPmeZfZC7g+UnDS
	uvBX7iyalRVfG7O/aQOO0F/N8grYrXqcQWWoHULB9yK71ST/G6IbkFlb8IAhjIZ9JhfjyQR5MMv
	RdasjXU+jhJlFzyPWZGw8yyhZzJYjsI+FesZT77IEV9LVK+SOjXIyXkxVNi2jj2K5uWuR7ufmnO
	WVCBAnFrSiOMrgr/AnwGGLuzw74VN2fwdLG7DtiqKjS1yts0zuOkshKkKyiwycw+mHUjqjfHCtX
	yTILl9zddiEIqsNndMwW41OaPmQPZGumDZu6NpEBC019vjPvvq8Z/yPsZZ2b3cBNBmdZVKEapXW
	hvJdymQhHqNWhMVadAu
X-Received: by 2002:a05:6214:4c8f:b0:89c:6451:67ac with SMTP id 6a1803df08f44-8ac8617fc04mr206413246d6.12.1776104687285;
        Mon, 13 Apr 2026 11:24:47 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a47a0dsm103210326d6.22.2026.04.13.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:24:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: "Tony Nguyen" <anthony.l.nguyen@intel.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH net] ixgbevf: fix use-after-free in VEPA multicast source pruning
Date: Mon, 13 Apr 2026 14:24:27 -0400
Message-ID: <20260413182427.298513-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-237627-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0B5333F1F4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ixgbevf_clean_rx_irq() prunes frames whose source MAC matches the VF's
own address (VEPA multicast workaround) by freeing the skb and
continuing to the next descriptor:

    dev_kfree_skb_irq(skb);
    continue;

The skb pointer is declared outside the while loop and persists across
iterations.  Because the continue skips the "skb = NULL" reset at the
bottom of the loop, the next iteration enters the "else if (skb)" path
and calls ixgbevf_add_rx_frag() on the freed skb, dereferencing
skb_shinfo(skb)->nr_frags — a use-after-free in NAPI softirq context.

The sibling driver iavf already handles this correctly by nulling the
pointer before continuing.  Apply the same pattern here.

I do not have ixgbevf hardware; the bug was found by static analysis
(scan_drop_continue_loops.py + semgrep drop_continue_in_loop, multi-tool
corroboration with the highest score in the scan).  The UAF was confirmed
under KASAN by loading a test module that reproduces the exact code
pattern (alloc skb, kfree_skb, then read skb_shinfo(skb)->nr_frags):

  BUG: KASAN: slab-use-after-free in ixgbevf_uaf_test_init+0x100/0x1000
  Read of size 8 at addr 000000006163ae78 by task insmod/30
  freed 208-byte region [000000006163adc0, 000000006163ae90)

QEMU emulates igb (82576) but not ixgbe (82599), and the igbvf VF
driver does not include the VEPA source pruning path, so a full
end-to-end reproduction with emulated hardware was not possible.

Fixes: bad17234ba70 ("ixgbevf: Change receive model to use double buffered page based receives")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 42f89a179a3f..4ba3be961ab6 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1221,6 +1221,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		    ether_addr_equal(rx_ring->netdev->dev_addr,
 				     eth_hdr(skb)->h_source)) {
 			dev_kfree_skb_irq(skb);
+			skb = NULL;
 			continue;
 		}
 
-- 
2.53.0


