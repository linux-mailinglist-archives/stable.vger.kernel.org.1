Return-Path: <stable+bounces-247396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D6YJ3C8BmqMnQIAu9opvQ
	(envelope-from <stable+bounces-247396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:25:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34944549F93
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BC39301A293
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E007937DACE;
	Fri, 15 May 2026 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ49ZISy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2737C11B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826331; cv=none; b=MgwKEcui/aJvxIH/QVl8AThCiOVENEoymigYkavZCrsHjdd0q1DpfLSBmS90Q6UW0OAnQL/lnae//+1u+6O9m4o9PHQg5K/O121/3D1QBSQPN2jOTsWWxjfwkLFVVobyY9xHFD6//1f6oeebNtFS1Sx8QGr95158HlkNB/7YmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826331; c=relaxed/simple;
	bh=zdMaYaIF/WCaUO1A22gCU0P+PgdUjBhJZEz17jz2Bt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOQYCKOVvw8FvztAY+7xoPqYHUrJg8E8wqL7McDKee6JDggsBn7pjPubT2rNczdS2CxyrmNQd+WvwEBErdBcoN+/7GR9EXfd5bMGS6Xsc/pssrVSObwqbgCjY6Y24Uh0BqCVz9V4h50tyV9XPwc3gh21ncNO66I+R3s0dfIAleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ49ZISy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ad135063so72319375e9.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 23:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778826328; x=1779431128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1gkR6dt+RMCWBmuIuEthasGqBXKYWjHEwzJZ2BcFqc=;
        b=gQ49ZISyin+W8yjszGpFSi7ZaUKdSAvM0tNvvdRwICjjvTSEFZTSWMUMuaG50FB22o
         lXpzYamlmkvSZjUSaESGg7LswCiqg5VtdQHB1rcLNZ/SYniUmSVlK0XY4PnzIzcUjZO1
         z0v/KYppWaGYUsTGsmLQBpNQpGfjT/NrKwgHPXzoIVijd/vrEomX1vc9FeQBbjywU/76
         VdgaQHICSOUuDPEwcs+YMp7JWS2fENdnum+FdoVuVVg9KWwMlKPY7rj2EXNNkjoscXUf
         wVtxDViEx1yiP93S1OAPGAoUdU2xdPFkmP42ft8MROjzL7DsXY6rQ4LVJLdprtOc0Bjv
         GQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778826328; x=1779431128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1gkR6dt+RMCWBmuIuEthasGqBXKYWjHEwzJZ2BcFqc=;
        b=iIiFZcTQ8BwoqapIfYI8HblvsdNV23GN6rdZs4zyuqSKR3guJ7h70kR6IwKaFbDRT3
         HxYvrhvs2UUm48BS3HFogvkRlVFLGFbLNujAMnq/vNjfKiyQPDZSfNTFhmwxb2sCN6Rx
         OL9EBGyCJhUpPm2FmUjGYP5vF1U63uAitOxKuwg8YasGn35346qrHyZGunH6r0kJts4O
         V5oqkle+6HmqUwFHYhqG8W3asM4GjHewN7eHEe1NiBDe3X8BYeIVg44iZkYKkKlssN0S
         ASUGtmdWsAPWzL5m5e/NZCifrIVUk1yGk9Q9oL/l81vRskS4GLPYTf9yYmPAdCC5Z9yb
         Hkuw==
X-Forwarded-Encrypted: i=1; AFNElJ/IpqR1/18ztjIhTiIkn5SVT65lXyfZ5droqJWiOYKr6XXeZOJK31cEzeEvNGyIFzpwxy0Rw2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOJDQFOTHu3tfhLkFUHpJ8PZTz8/UfIEoAK94SnDVs6aKnbEo
	553IbrOCTSykY+wwZZMr4RALi+qBdOGJa1/Wy+9/B2EqFRp1JKj3tUSjwzQtBa/c
X-Gm-Gg: Acq92OFTtXZWdQnfGeQPZBDOTUwvTPIzQOzIqJvy5j2wqSex5DNsVsmAb7WbL1IkWHB
	4QjxRaVir2fvu+5eR2vDIiszoRmMVnjyFqYzRdLeMOAlTr1wgRc0iSXMIVKYPCntaiVCyNWp6L4
	ZIV90hWQ4Kc5bBqCnSqacbbvJRo8HehMIwclst2qBFFk35MmJhvtBNCDMuNW4Ya4nNUJE07SNVP
	81RSUihQm1DPAAG/cKOuJLLU3BmSiDLXKVuqDhkTRxFxgEAiqEz6IdY5J8ii6nnUh9Y5pym4LnB
	BdBDVGkCrmuuxUwHeQSr8u7jyyC8UXKPHKiRlJREMY9Zll9Cuv7dwuepKNoxwVGa7MBjM6YLNPE
	UQF15XhSLHqckiCESXSHeb6Jd7t0JAY/viPf3dvgnXDY6iSHFxVLG4MNNvWGLVeEHIXN6KFzkGJ
	dqQyk3QvA4MloFgNTJWJTrmcDke56R16ApVZINRDXtX9GVAEyxj4a3UXAUJsrFDrJ0Ad/7Q0Uhn
	hdgKun7mFPS/o6L/rVZlg==
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id 5b1f17b1804b1-48fe60ecb9cmr29688155e9.10.1778826328398;
        Thu, 14 May 2026 23:25:28 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm11016277f8f.24.2026.05.14.23.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 23:25:27 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
Date: Fri, 15 May 2026 07:25:25 +0100
Message-ID: <20260515062525.57603-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34944549F93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,holtmann.org];
	TAGGED_FROM(0.00)[bounces-247396-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ISO data PDUs carry a packet-boundary flag indicating START, CONT, END
or SINGLE. The ISO_CONT branch of iso_recv() guards against a missing
ISO_START by checking conn->rx_len before touching conn->rx_skb, but
ISO_END does not.

If a peer sends an ISO_END as the first packet on a fresh ISO
connection, conn->rx_skb is still NULL and conn->rx_len is zero, so
skb_put(conn->rx_skb, ...) dereferences NULL and oopses. For BIS,
where receivers sync to a broadcaster without pairing, any broadcaster
on the air can trigger this.

Mirror the ISO_CONT check at the top of ISO_END so a stray end fragment
is logged and dropped instead of crashing the host.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/bluetooth/iso.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7cb2864fe872..b971281f0a2b 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2593,6 +2593,11 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected end frame (len %d)", skb->len);
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.53.0


