Return-Path: <stable+bounces-267820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EL7UAM6+OWq6wwcAu9opvQ
	(envelope-from <stable+bounces-267820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 01:01:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 537146B2BCE
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 01:01:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dhXwrePV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267820-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267820-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C00301053D
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 23:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DB825A2C6;
	Mon, 22 Jun 2026 23:01:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52499231830
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:01:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169287; cv=none; b=l3Sx1FzqAlJasGlVTYwnCupMmHWxABii5SzE18+N4iT23fjg87Ylyi06Ij34iMueAaW3kiaMZcmHD/D2zx9KDtICYlC+HTgs03pg72ncZDLh9i4HaxUMdo+0NlH6PvonF8JqrB3grdA+U6LOwFEcirQDoLxecDoaNUodhqOBsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169287; c=relaxed/simple;
	bh=3JBxGBnmq2p2FDhnDtI4+aT0V6p9eLbBXeAWbVZXxEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVqTehNEBZM78eUzZ1ypxzmDleCK9QQHVsednvx3SOCfC0SK52cUOw0dMR+4WeUNz9YEwxoK8XDvpc7DcdcV5H0w9NUPZZMJVaxdLg3QQQQICfqAnBp2H81QQPWNbTsu/SZUYMR+ICKURPq2x+WWnxrS7Q/OHHIHTKJWW2TMuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhXwrePV; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso3296465e9.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782169285; x=1782774085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8raFnbe3ZmeHv8tNWRCnm2r9ziZZ3BplUai93sgg1aI=;
        b=dhXwrePVrgWJMf7swRp3i6C6yO+u2zGdcKDz78TNmC/kQkjWoshMQMIAVdXBzalLdx
         AIdI9p4tHT+ixmNpPg6EmcRKqU+P1FOWDSc0HcQ0KiyemwMqXmww67JbtUirTA+iTlR9
         795HT62uRbQmUxt5TxIpagalXgJQ3AccDwsJyaiH71Mef2yrNKY4goAULFLGCe/DnfjO
         5rOLccpftkTdBWbbzEQrGF49lrJI0CQWnFyPPml4oUFzl64u/b0ZJuuKaKxs0cOfANu8
         bR7CsokQWPRdIIaC+p8lv8dBG/n2sYmH08YZRxzW7zVwA2BJ6clfqxJIKSLEBeVBtWdU
         4oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169285; x=1782774085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8raFnbe3ZmeHv8tNWRCnm2r9ziZZ3BplUai93sgg1aI=;
        b=jGdOYvv5gPZXhBKM4eZnk3p7Qe4bdOluXiU90YCCCHWvrHRPQyW2dc1Iz9AdbASjwN
         dvbqdWmxhCQR9ujgzsZ/qsTzXcFyr7oOKOkufAA0UnFCY2Fz/LQGUdSmKoJXhSg4SfsX
         W925G1D97rbAFgkgIu/KbrokLhzpj1QhXegfffiDy4OtazEG8zmzwHSEt+QC+I5/+Eu+
         WOFUVBS4fjZ4bBuY/3a/prJEj1/r693NWf75zLcCI06WCuDZXCyWke5Lq4JfHNJM0fED
         HBvnnxfdsdhDZlw9Ia8EWzJCyH2yTF8POVSa+mYo1jN657OC+y3oVrvtM4AjqcOJROM7
         C0Lw==
X-Forwarded-Encrypted: i=1; AFNElJ+1uZ3X+Tec7Gv5xdJH2ZgKf+TapzfDKeZtrOCnGMORXGkdmymqbtcI4AwGJ3Hz4q4qFqgWKhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+xXysKnUkolBDg7uKQJxIzXV1zTGWusH1EXiXFLwv1l/YaS1
	dJjEK7LHuKRuCGC04d5C6UPRR9FtS77T+NdFe1xEjqM/mqHfV/IHroo=
X-Gm-Gg: AfdE7cmb9F3TXMOZ6l6wqcJTOA8tMhAxQswWMzlHu/cFz0MYc8Jw2J7YZcS2a2Mp+6n
	xSN8a1WU87QX1s8syd00fFQjstCBzyO5jk3J9M46XRvpkF1QOHnXko++k7wEqgXcMou20wcbJfw
	kwdbfxkd1+zEKL2gmiS8yBJe4sIvQL9cUIIE94WN64IE5d+FA+LFdPozJQx5gmyXD4XJE7cr47b
	m3BfJWyv8Kpr7gZ1Mwpi/qm/QpSho4KTG06DAUkR2+hHztzAyib/Ide8mq1qAu7kzRRqZyw5xnP
	BGfA+gy5rUVW0gmknnmER1vnw7hHa8IiNjncnZN0Pl7bFJSh8wUSeN82hgOwZU3/L+gSj5gRUEj
	s/VXoQL3cc1smuYX0n7BeGzCbSXXMyq4UwB9JedME1VtK0Kt81ANBcVn7WEnMdfshK8x2
X-Received: by 2002:a05:600c:3e0a:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-4925a0a9ad9mr16515335e9.6.1782169284668;
        Mon, 22 Jun 2026 16:01:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm371339255e9.5.2026.06.22.16.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:01:24 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH bpf v3 0/2] Fix stale register bounds on LSM retval context load
Date: Mon, 22 Jun 2026 23:01:21 +0000
Message-ID: <20260622230123.3695446-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,kernel.org,linux.dev,vger.kernel.org,talencesecurity.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267820-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:xukuohai@huawei.com,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,talencesecurity.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 537146B2BCE

From: Tristan Madani <tristan@talencesecurity.com>

check_mem_access() calls __mark_reg_s32_range() to narrow a register to
the LSM hook retval range, but the intersection preserves stale bounds
from prior instructions. Add mark_reg_unknown() before narrowing (same
pattern as the else branch) and a selftest that catches the mismatch.

Changes in v3:
- Add selftest demonstrating the issue (Eduard Zingerman)
- No code change in patch 1 from v2

Tristan Madani (2):
  bpf: Reset register bounds before narrowing retval range in
    check_mem_access()
  selftests/bpf: Add test for stale bounds on LSM retval context load

 kernel/bpf/verifier.c                            |  1 +
 tools/testing/selftests/bpf/progs/verifier_lsm.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.47.3


