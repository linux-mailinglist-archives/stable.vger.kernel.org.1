Return-Path: <stable+bounces-274443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bK6iCCVoVmrn4wAAu9opvQ
	(envelope-from <stable+bounces-274443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:47:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E72F7570E2
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:47:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=encKXvoW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274443-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274443-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3300D307467C
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3133F4DA52B;
	Tue, 14 Jul 2026 16:46:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B94D98F8
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:46:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047599; cv=none; b=VF9pXMMzUKeb7l5i6Ch0jO4fTxizN0hd419zGAz8BwWJFVvL9UW9vbYe2C/b3OFGV4eIdkTnJbi54O8NU20hEmnLNZ235TGTj7/7Y1RGAWg3fSIJjTkSVT6LnlnyXXuFeULm6dc7dUb/J5AkaoKTT9mHT6y/MIaWDKPlleK40kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047599; c=relaxed/simple;
	bh=9iodVMrU+2GAF2BdS6r4I7mPchCfTnRiHaGN1DpNBHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0PRd3VT20zYRPVGCaIkxwOocQbWkajEHJ1boqxWuK4ltAR9SwLWRWbbdMl8DpXYKyYziLbMXBmq4iir6FjhJ9s6Su5Jezs2YMAxkGAlkwSS8aFIghtUoRnewSvudwNuA4dlY2zeZqnE1IZZ4uF0VMQwe2U8vHPYJlBbaiqqE5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=encKXvoW; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so3432417f8f.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784047596; x=1784652396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xA34URPmvLevJFaYVe08J7EpsJU8i+fALDat5zmBi3g=;
        b=encKXvoW02r8DklJ2kIbfxCvf+XSZ4XX93lJ+91p9CLzAhZc0nf2oNxfRoNmrk1lYe
         AzcDgQ6kOEU2YgRvZf2dz+pCJd6UDqlfx+4uwFzPPXoulFLYcDzob7EpTUc1QTPgN3h1
         fXluyw05AuWLt7/v3ym37dkQiVoDREZyCfCl1S/4G2IPAXel9I75g9J+pb6oTFjsVB2T
         frhKYBMXlg1VVviLk/1HLWBR3TbLhmfEuP2l8oTbYoDKEkKaKoJGcU8gkW6/sWtB3T6c
         jBbmpFdCHaRbo84Jdc0xw0thhfSG1KWCPki0gaHhXv7W2bW14/VnU6Gl9U3kcx8S/vMy
         7Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047596; x=1784652396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xA34URPmvLevJFaYVe08J7EpsJU8i+fALDat5zmBi3g=;
        b=gLJ+2I5coKZ079tj1jBX/x0fhHqajY/revcG9NGrYuHuELp+5HVaBDXr35uYyO3tkC
         seGhK5iYjn+eX9/fBuRSArys8kiLKiIk1xjEEKTvt1ZHnweg0r3YSr64J0WT7R75+kpi
         rb9jjc/mAgI5vm9z9WTRjYL3f/IKNgHq1h8wIWPUMjypTmjZa8gKOcaHo57bBKFcaRpQ
         PutaLbWSGHq3MchH8fUpETCxdVzSqEjKLascUfXi1OjcX6RVYWJ1dsP/m7uXrOQ6aLhK
         yn/o0sEAilePjc8GYJMeJtuzSQMxOgE6DEpjYFP5BsGNXohJHu1fIZZf1sU5Frli1GQu
         4asQ==
X-Gm-Message-State: AOJu0Yz3oCxHcz0CuNxIo17D/ebnso/a+6XE1kyARVv/WqhzWx/cv8MZ
	v9xfGiRATz2umMcFrPl4MKP3EIH38a+MvR2OhgaoCFCrF8m7U1g6PWRPKoayXa2m4K3m8QQB19M
	SbdThFwLZ
X-Gm-Gg: AfdE7cmulMUvILgggJj1B7hmN8NJVlVZCC7gwiCdzm8JLAvk+5ryed6N6+nUtO+mg0/
	4WoZmNNiJX37sLHf1U1YY7Dlfom4XqVFhrUx5H1nHa//U8fGidjiRvrbxDYzacJX25QjvBpdCdp
	u9ZxaxDWi06LPYPEw+AXjb5ZPHW6yz+yWXWcxw4tGTRaSJKvf58DyW7ZSqs075heur46cUO3LLN
	J3p1fq3sKo4anGe0FrlWfNal5YBtCOUJXNDmhi4tmCicVTrYDc1D3kjRj+a+6k0S1d4tVYvKzoO
	Msq+zCk4N0Sede/cJolaDvgnGHnQbbzTUqVMUnAFp5uQrDbOE+uaXJS3Sk3180QLXvTa7S/DNSf
	QTw+A8zL5XW1Q5aMz4IHea2hzhTlPZf0Eqno5iH8+zrh+gs7HcwOqFlHaUUkw4l/IgGOuqqdfqO
	NNcpC8hSB2OS20G3PWv9attk0qSdC5ZaMqb2gZSzKUdo3kR+ZxPwCiMTPbXrGZ/mjP/mYQELwVT
	NQ63AoS884jgU0BaEgScpC/R2OGvWm4gZk=
X-Received: by 2002:a05:6000:4615:b0:46d:d6e0:9cc6 with SMTP id ffacd0b85a97d-47f2dcf556emr15992661f8f.44.1784047595602;
        Tue, 14 Jul 2026 09:46:35 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0d9sm9739781f8f.2.2026.07.14.09.46.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 09:46:35 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: stable@vger.kernel.org
Cc: olteanv@gmail.com,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Please backport: DSA taggers OOB read on PACKET_QDISC_BYPASS TX
Date: Tue, 14 Jul 2026 18:46:33 +0200
Message-ID: <20260714164633.75135-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274443-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:olteanv@gmail.com,m:andrew@lunn.ch,m:f.fainelli@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[0sec.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0sec.ai:from_mime,0sec.ai:dkim,0sec.ai:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E72F7570E2

Please backport the following mainline commits to the stable trees.

Reason: the ocelot, ksz and sja1105 DSA taggers dereference
eth_hdr(skb)/skb_mac_header(skb) on their TX paths. skb->mac_header is
not set on the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path
(packet_direct_xmit() -> netdev_start_xmit(), which bypasses the
dev_hard_start_xmit() reset from 6d1ccff62780), so eth_hdr(skb) resolves
~64 KB out of bounds -> out-of-bounds read. The fixes below make these
taggers read the header from skb->data instead. Reproducible with an
unmodified CONFIG_NET_DSA_LOOP=y kernel by sending on a raw packet
socket with PACKET_QDISC_BYPASS set.

These commits went into v6.4 without a Cc: stable tag because they were
made as preparation for reverting 6d1ccff62780 and the bug was assumed
to be future-only; it is not -- the bypass path was always unaffected by
that reset. 6.6.y and 6.12.y already carry them.

Prerequisite (helper, not a fix on its own; needed or the ocelot and
sja1105 fixes will not build on pre-v6.4 trees):

  1f5020acb33f ("net: vlan: introduce skb_vlan_eth_hdr()")

Fixes, in mainline order:

  eabb1494c9f2 ("net: dsa: tag_ocelot: do not rely on skb_mac_header() for VLAN xmit")
  499b2491d550 ("net: dsa: tag_ksz: do not rely on skb_mac_header() in TX paths")
  f9346f00b5af ("net: dsa: tag_sja1105: don't rely on skb_mac_header() in TX paths")
  0bcf2e4aca6c ("net: dsa: tag_ocelot: call only the relevant portion of __skb_vlan_pop() on TX")

Not all fixes apply to all trees (the vulnerable code was introduced at
different times). Per tree:

  6.1.y:  1f5020acb33f, eabb1494c9f2, 499b2491d550, f9346f00b5af, 0bcf2e4aca6c
  5.15.y: 1f5020acb33f, 499b2491d550, f9346f00b5af
          (tag_ocelot has no ocelot_xmit_get_vlan_info() before v5.16)
  5.10.y: 499b2491d550
          (sja1105_pvid_tag_control_pkt() is v5.15+; ocelot is v5.16+;
           skb_eth_hdr() already present, so no prerequisite needed)

Ordering: apply 1f5020acb33f before eabb1494c9f2/f9346f00b5af, and
eabb1494c9f2 before 0bcf2e4aca6c.

5.4.y is EOL and also lacks skb_eth_hdr(); not requested.

Thanks,
Doruk Ozturk

