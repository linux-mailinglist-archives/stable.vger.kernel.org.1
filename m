Return-Path: <stable+bounces-243010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDKoBYKN+GkVwgIAu9opvQ
	(envelope-from <stable+bounces-243010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:13:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF894BCC7D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08DDB300826E
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9A13CF675;
	Mon,  4 May 2026 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3WLX3l0"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06E3CF054
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896823; cv=none; b=sE0V/yxBU2hnZnGqEE8e3vYbLI87OIMeM/9WEVqyqm8h923rGYj4smK2Pq+/4kwIJDHWOgpmV04Kuu8OXp1YfRgMCnjfn/Y41klTmqfbE8u3rmVYNqHC4Jdr8zXhb5A7adEyB+npj93T5AP0yFR4csuGgNJvBWLUjzAabADMnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896823; c=relaxed/simple;
	bh=XNNpH1F5wvOWEqcIvtiZ7uYlDMRnhSh/liAy8ctj5SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN3TelmDf5GWAEnsgrdFQ7MZggv05JEkHvbUVyl0urCNJphPq43v8GZTn2Z+Zm5YU1gmvydJGBHiIsdZeO/Qny2QGv0Zg92fKVeP7KCYX+YTC6oFifL3S74RFliA705yqwHI1gcwhFet9t9NGcK3ASXXIJYoWIiKuGg1bXd29Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3WLX3l0; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a535e7c00so45102437b3.3
        for <stable@vger.kernel.org>; Mon, 04 May 2026 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896821; x=1778501621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM5dGgpkjSsxJQtB3BR2yd0n4llyOuuMJ1LAIAlQ75o=;
        b=D3WLX3l0AXcCNKZlUurWw4ZDO6UmsrO3V+pAw+JcDjPiDgH1mfO1eKnP278z4z9Utm
         GTfenXEI86lMRF0ZNNcZ+Fzo1v8jRqpnYsYUSOykZYfGjCSEDtk0SeYUvLHFdQJEfkRB
         joK04IpR055SgY+vgSeiauf9YgunWmaN0BCXOJo7fh26tApJK04oiE2j0JubBaSnhGmr
         VFI7D6QFr60XDJ2prFxPTQfr2Ap1Q4NG9xpwK4pCUIZp5Mug6WIdhTvKeRUJaJZu28G8
         EpjiJZx/xnf72aml5K1h8e4c54Hb/Zi+nY6DMM//Er0u+Q46Y0DuIuPqCjuAwhNo/qqk
         /sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896821; x=1778501621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XM5dGgpkjSsxJQtB3BR2yd0n4llyOuuMJ1LAIAlQ75o=;
        b=ZbQS7QhQUIP4s0nl4ylk4gvNy+Uf2ai0dy2YckLnrNxpOaCtKBp0tOLev9gbQmNoro
         a9tnQVugYdsvQ8OH0vtzcBhXY8pJu/4hp1RPxU4c5HmhME7zUBV80zPaPjlh604+GfC0
         xUW0jSgK2QLztVof+Z5QiByZWawqFbrv/0EInvNgatXMnB/ynRsPDoUb+NZsu9otkaPb
         /OSMFrJK4cXfUDaazqFWxUiUZnSJRTd3xv1Q2Vk9lvmM6YOOOcCnW85cPvaUvl0+KgmH
         38vTNEk3AY149zDpsocaqcfXzURECwIAylJF9ip3vFtAi3YzpuwNRyHvFnvm1qL+MO52
         ASrw==
X-Forwarded-Encrypted: i=1; AFNElJ+xqrcQ4VZvGceXkGJBDpnrNWSBcqgixnMN2JIGd5rDpxreqpP9eLf1zMYaoaHpB/iJaoy9ru4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNWRqFSmFbmXPfPiULsO+SHab7e668Jt0Y7hmgpRMy0Q/irCAb
	T1nDydutr8sa8aGU2Y/yHo9YTTt+85hmoBOjnTOK/RrUVoLRf31YiG5A
X-Gm-Gg: AeBDiet3HD5BXsvuYY69Dz0zZwCMi5hausE+8EfcJA3JfH6gjDBSsCTIBTRcnaW1xC8
	cqluCwqVF8WL1qEOMqEvgDGOT1HRF5LScWU3urCSUnU/D+c3HdxfS06ttEGZnMCQkXTzx4rUwSc
	PaLRG+pKxrOb50ywJLgJqJGXqCDU6Yz3U3y+O9/v6jfhF/XjJgDYES6W6IbW7030+pgQis69ekq
	HLsUQ6u6GuGYicuvikUvEtdAjO6p6XE4xyLON04eDS1uO3dunsB1lb8nr1W2DFgTBvz96gtuLWx
	O4Hq48p+kBTiFUJqZxvDmDg/J9hjGwbLJjA93PVXCIMUQVbgk1z2sJ1EO1pth3qj6/Oj4E6SBls
	wOoDv6zxwR3kHy3JCGcwrMwF5r8EXc84pDP/LvcqxYCGvNE9N7l6Aqw93QPksf79A771J9Kxjsj
	ihr+NzkOu1aOugJmLa/XID2uWcl2wNsl5w0/4G54GWW+xgHB5zhRyYYUE=
X-Received: by 2002:a05:690c:a01c:b0:7b8:bc4e:ac3 with SMTP id 00721157ae682-7bd77104b4emr88139017b3.26.1777896821391;
        Mon, 04 May 2026 05:13:41 -0700 (PDT)
Received: from ubuntu-linux-2404.ts.net ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm48417937b3.11.2026.05.04.05.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:13:40 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v5 3/3] fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()
Date: Mon,  4 May 2026 06:13:32 -0600
Message-ID: <20260504121332.1053563-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504121332.1053563-1-sebasjosue84@gmail.com>
References: <20260504121332.1053563-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EBF894BCC7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-243010-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

mpf_ops_parse_header() reads header_size from the bitstream at
MPF_HEADER_SIZE_OFFSET (24). When header_size is zero, the expression
*(buf + header_size - 1) reads one byte before the buffer start.

Since initial_header_size is set to 71 in mpf_ops, the fpga-mgr core
guarantees the buffer is always large enough to reach MPF_HEADER_SIZE_OFFSET.
The only real gap is the zero header_size case, which cannot be resolved
by providing a larger buffer, so return -EINVAL.

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v5:
  - Drop the count < MPF_HEADER_SIZE_OFFSET + 1 check. Since
    initial_header_size = 71 is set in mpf_ops, the fpga-mgr core
    already guarantees the buffer covers MPF_HEADER_SIZE_OFFSET.
    Only the zero header_size case remains as a genuine bug.
    Suggested by Xu Yilun.
Changes in v4:
  - Reduce to two minimal fixes: minimum count check and -EINVAL for
    zero header_size (superseded by v5).
Changes in v3:
  - Add overflow check for 32-bit in component size loop.
Changes in v2:
  - Return -EINVAL for header_size == 0, -EAGAIN in block loop,
    add count check before MPF_HEADER_SIZE_OFFSET read.
---
 drivers/fpga/microchip-spi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index dca1a5d..cc8f6d7 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -115,9 +115,6 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 		return -EINVAL;
 	}
 
-	if (count < MPF_HEADER_SIZE_OFFSET + 1)
-		return -EINVAL;
-
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
 	if (!header_size)
 		return -EINVAL;
-- 
2.43.0


