Return-Path: <stable+bounces-253971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S9KeDcT7EWqutAYAu9opvQ
	(envelope-from <stable+bounces-253971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 21:11:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 677095C069E
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 21:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 783E63014C33
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 19:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1429A33F5AE;
	Sat, 23 May 2026 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6sU/44q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC93195FA
	for <stable@vger.kernel.org>; Sat, 23 May 2026 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779563452; cv=none; b=dC9wn3yeZQs2eHT6KUwcWxULeuIDsmKKZ0DxecXhfnI7Y0jojfeXgjoxPmBWg4tO7tzY5e++vENEhKVdmpBLYoBTz2MQh9OjxxaxihbTI7MTWFQ5CqnautXTSl+W41eB06Zr0P74vkgUmWYMYgBuyCTxabYiUnD5wXpUmaS0nMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779563452; c=relaxed/simple;
	bh=wsG8L4uMeqqXkqDYMklZJ+D049NNE2kAtaY1+cVH4cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdRaLOoeSQZ1RMxCM4gwkdoTOX/pr2dzyLj2lnnHhq3nffxH2iRcxiKOFF7OMaaHIIOqKXYTVKE1xdvibLY9h2rC5VCvfHRdOTjz1Pz9kspb7y7dhTeqbIceUM0O3XKemYrfHRTmU1ugcdSZ+NfRHZ2247T7WlvraC00D4FrOFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6sU/44q; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-367d88b9940so5544790a91.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779563451; x=1780168251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2pdcMudAXsnsf14xcsIygiiXlNDoLkCiV99tMYt+d3Q=;
        b=K6sU/44qC0GT8QZ5TkmAlu6H65p8gw6Wcaa4HVfrqWYJN+oA9sIO279pQppIZKQRn5
         3Q/D/YN89y8bh601WRhtJeYTGe/7NOTvKzX7gAgc3DJ7u6Kvpf8fit1yynvLCWS6HRAS
         tzFzwXr9/0K4ea2+sCtG6Cx0q3oCngfkMxibzfZjD+depziFyh48i1hCIVDWMz7/tNLY
         P/hjRfF7OtPURBlnFxK/xS4cdKVAsIMrqlEHLUHOIDIpJ8B/72fxf8hFzvst5kKgJ1ci
         uCMdajmoFKAAdhWBGLMVDGMgEvbQ7Nks/zf1VSLAdqHNUIXHqlRKVmxquHL1NpXT76fp
         Fp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779563451; x=1780168251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pdcMudAXsnsf14xcsIygiiXlNDoLkCiV99tMYt+d3Q=;
        b=pbh+siNhFJt2Rz5B1na7abNZhBZJ5rtHF+n6TOZ+Ap56um3NryWlvz1fUJrO9ZO+ex
         JAMRDPGqcpdO57tNjC3Deg6mbmt7O75ZiSMuCnU04Pd1AsaRw+2j76PnJbcT0WFlD6DC
         fz4CSrsEGyUEMRs2xmk09N3zKig5rrP2rKi4RvT/VHWhLI55Fyec2L0oJYr/783bMWA9
         SR41T7aiXpQmugfX12gN9gOVn+YmuA8ryYBdArYy/mfdRgAR+kOMOjLPQz74r++eW7KX
         mNv2alrxgT9Zw0PW36+7RDlqnqO0Q8A0kfmt114FSnTJshF7hqCIllbXe2MILDOrfrFa
         b0Yg==
X-Forwarded-Encrypted: i=1; AFNElJ+FvOr6RB4VcKAtM/nBwDpORhB0UAVothgRS0XGPmw4UrKjJNTRqK2YrV2EfFsmhhI/4sbsNQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJM4VbGfTBYf5QZ3XdNSsPmFZX4G3lJAgGz/Sjmo9PisM7LnAb
	XZt72GcFVP/b5SfTV7DNCxNCcoC2hYFw/uKewLFQckDPD1T6pEBLLdD7
X-Gm-Gg: Acq92OGns/2bS+FlbOskARggjfVJukzMMXSr/Q2nyRdfmApioORBiXdbCANsdKopfXf
	+fJ+8eaa5tFD6sLZBviuEG5sj5UGqzGbo70uhVm4aZEYWpp7Ye8s54KrXbVAExa/4N2fOBCqeMk
	WmLGqwvxAV09zOlZG4qdtrauAhlGtcND0IGvwsNmmPlFXs4TEySPxvOAUsGXrtHlEeDVUJxhKrz
	mfmqSvgWHQy+t+9ch3FXfI89xV9G+AmywEXHQZmjXmAM1ih6Vwr4+MT2aHKuqhLpCZHjN3qvGF4
	DssfbpgOHn7PMb6UsxBxd1n0aFuKQzaw2W/htp4oxoquidVmqPTwKpz6k1uT4G+Ip8M2FB3FMNZ
	31qzn8vpHsa7i/eZ22aL7GXp/noVnJf6P/PZ31AUQ5CCbfImI50xWBLUK/mBoYO/vQOAU4RPU/7
	jSGHt3ChUxEjRImMy8jjyGEPgMB90Nw9BqcVacww/RB7HXPhNJd3uLMUIL9njsB6QvkUEoEfVOw
	Njnd32FIOMLqfJtjcwLaXRH9O0ve7qljF0aNVqXP6u1a5qEcvNTOOfpdfnzzTBqiT66CoJDp3Td
	fswQMFBoYkY=
X-Received: by 2002:a17:90b:3dcd:b0:35f:bfdd:f5a1 with SMTP id 98e67ed59e1d1-36a677fd1ebmr7791851a91.13.1779563450705;
        Sat, 23 May 2026 12:10:50 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6f0baca7sm3151877a91.2.2026.05.23.12.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 12:10:50 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	tzimmermann@suse.de,
	Frank.Li@nxp.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/ethosu: fix OOB write in ethosu_gem_cmdstream_copy_and_validate()
Date: Sat, 23 May 2026 19:08:43 +0000
Message-ID: <20260523190843.33977-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,kernel.org,suse.de,nxp.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253971-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 677095C069E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The command stream parsing loop increments the index variable a second
time when a 64-bit command word is encountered (bit 14 set), but does
not re-check the loop bound before writing the second word:

    for (i = 0; i < size / 4; i++) {
        bocmds[i] = cmds[0];
        if (cmd & 0x4000) {
            i++;
            bocmds[i] = cmds[1];   /* unchecked */
        }
    }

The buffer bocmds is backed by a DMA allocation of exactly size bytes
from drm_gem_dma_create(ddev, size), giving valid indices [0, size/4-1].

When i == size/4 - 1 on entry to an iteration and bit 14 of cmds[0] is
set, bocmds[size/4-1] is written in bounds, i is then incremented to
size/4, and bocmds[size/4] writes four bytes past the end of the
allocation.

Userspace controls both the buffer contents and the size argument via
the ioctl, making this a userspace-triggerable heap out-of-bounds write.

Fix by checking the incremented index against the buffer bound before
the second write and returning -EINVAL if the buffer is too small to
contain the extended command.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 7994e7073903..f526f4aedffd 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -387,6 +387,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				return -EFAULT;
 
 			i++;
+			if (i >= size / 4)
+				return -EINVAL;
 			bocmds[i] = cmds[1];
 			addr = cmd_to_addr(cmds);
 		}
-- 
2.53.0


