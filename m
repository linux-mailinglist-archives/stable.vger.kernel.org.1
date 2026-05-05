Return-Path: <stable+bounces-243961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PMCLKl5+Wnz8wIAu9opvQ
	(envelope-from <stable+bounces-243961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:01:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7266A4C6A0A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DB6C3020857
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C693C2770;
	Tue,  5 May 2026 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzrEkew3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41C1C8604
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957204; cv=none; b=hxDBfqVQRM+aAN0Au5fk5I4Gq61hSU7mWlLrPwIv5uzdju7quoE1j/4AW9Umvz4yqyQQvuHWx54cHejC0vrMRyt5DiTgJE6Ay7yYJmJ0O5voMV/50BpUuEFuGQJS9EsO43W0rKqffaJXqlAHipneUMIy2EKGUNg50CioFSVY7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957204; c=relaxed/simple;
	bh=AXplrR7s7AGLwW1IX4e8KEzh0R3eAKBb1/o6rOguHPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlBIOwf0QBDOh2nkTwfpjLPtwJFouqo02iKykdAsQfmz9SCCAU6TixL1ZO3trLDCfNW4umSU4rlO6NLPvRiJCSLkfZMZfnrDMpIKbVD82lLiYesReILSVSG6+/Ke+2BU+isoCht16fBA7sCwRU33hN80im5/6W6RI+TrZL4vdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzrEkew3; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1309f4ee973so1152799c88.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 22:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957203; x=1778562003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJnK2nHTHKap6LV5wTwh1mU7zzvWh/QmG1m02AjJOGM=;
        b=YzrEkew3aDI1ObhRt2lip6cU/xkoykmP+vtMJDpqumXhPp9MMEAF3qOWHEqmuNiy5z
         qD0U2Y/xxPIp2p0t71Ch06s0IQ3b3X1+UEGkOxBz8LbiBbqjzsUsjk5rj5L7W1JgH79y
         B6W1fcQxTJe3OXtBW8XSL4vNNlgciQY3QOQMIk8uHrCV8p6DHUJ2P3xBfJY9bNpzZus5
         5vB7nBfWEBMBMdYayNyyrqQKmtPF8Xmgkrh2Wz6cpsT06Top7AXY0BOT7WKDmqJLwlkm
         bPbXCBbgfVIgz1RzHZS0YKrt94m+2inBqnZ8n6Qsps2PueybdIgVyBumUhwbk/h9X7Cf
         LgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957203; x=1778562003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJnK2nHTHKap6LV5wTwh1mU7zzvWh/QmG1m02AjJOGM=;
        b=ecaHtmXznQMZUkA6I+i1NHoLSKBFG+JpCX0H2zm7acy/22UAU6mRcmRuxTGDTIa8hG
         PouatCJP08GtOaDs1xY9psjPu6d6rJpkf9wwIpftmMSbUWeQvilobERr/WVx2AmQroKg
         Ov31rDh5KtV5Y57m/TTL6kBlZR8D0VA8MYhHNR03UYDPvNNCYGItKN90K2p+k+55HmmX
         WijEchMpB8lissmepb7u9z//cP4iGLgTZVBNYGzerS9wRHiyzduycTZiA5JvSACOTtjz
         eRYY31q0F0O3NyHMrV4mdZJvQhayuI0XxBTaPebTEM30v1Aro5NHqcKwWVp+AOigHYqG
         V9bw==
X-Forwarded-Encrypted: i=1; AFNElJ847r62Wz/vHdF+6Mwjj0ur8eKoKi+iGRtaVeYXV9tYie7kPO6C+aZYIkTd/2uBJtLcfull6VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZGsJ27bclaxsBH5/IvVC4G3VZ4NayHbK0IAh61wUyGXsal44
	PG2R5MJxQ05rgYay1rH3RyLJ9A6SU0tOajlzxECynotYdHXCm9BuKixiz6MA5w==
X-Gm-Gg: AeBDieueu2ZBnsPHA2xz3VVk+FJL70U3mQy8GKR8WQVb4oo7M0+yDSpQu4RSE9auzdI
	Wx31fellP5QExi5gglzu/1tGaB+P7JjYLkk0JGeupbwPj+9j0MHRzaKXgDPiJIywaMu8WXOLRqB
	J1/3KRdbrN0iGTVcvee1rTRUiziRa/vVGNghBF4NVqSU1NNKHnA1yKQ8ENQ1NKyy+nQ/spq/DOb
	fuRWMv773ql+qmeN88pwtQLjMmdHvaRUcIS5GbU04gOVKct0vOPlwQgaEsyVWcvssC2zrew6ZP1
	5S7f2a6DiWwmfb90BujI06RgZG+QGEDNhhtBLndbkKftC3kcYrGjm265yMydmwfLG6O/5C9vRih
	YKDMxg6zot27y8TvATEZifQUdFY7ucz0rQLNJL4HcfNAJcGuehh50MwtoQZKaADhuP0g3zZFNtf
	0q1+7jkgD9UgvyibhoEchTmZVwTYysGHyAgF9wZp7Npj+X5SO5i5u3LqJq7qL/ZAYWt2xm4Dg2v
	Ts2Mw8n9Q7lBeMciYD3svQiug==
X-Received: by 2002:a05:7022:3897:b0:12c:44a5:fb4f with SMTP id a92af1059eb24-12dfd7bda5emr5489512c88.10.1777957202612;
        Mon, 04 May 2026 22:00:02 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:01 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 04/20] Input: rmi4 - fix num_subpackets overflow in register descriptor
Date: Mon,  4 May 2026 21:59:34 -0700
Message-ID: <20260505045952.1570713-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7266A4C6A0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243961-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

RMI_REG_DESC_SUBPACKET_BITS is defined as 296 (37 * BITS_PER_BYTE). This
may overflow num_subpackets in struct rmi_register_desc_item which is
defined as a u8.

Fix this by changing the type of num_subpackets to u16.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.h | 2 +-
 drivers/input/rmi4/rmi_f12.c    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 5f769fcc758d..6952059bf4f5 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -53,7 +53,7 @@ struct pdt_entry {
 struct rmi_register_desc_item {
 	u16 reg;
 	unsigned long reg_size;
-	u8 num_subpackets;
+	u16 num_subpackets;
 	unsigned long subpacket_map[BITS_TO_LONGS(
 				RMI_REG_DESC_SUBPACKET_BITS)];
 };
diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 8246fe77114b..c2b07c6905d7 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -467,6 +467,13 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		f12->data1 = item;
 		f12->data1_offset = data_offset;
 		data_offset += item->reg_size;
+
+		if (item->num_subpackets > 255) {
+			dev_err(&fn->dev, "Too many fingers declared: %d\n",
+				item->num_subpackets);
+			return -EINVAL;
+		}
+
 		sensor->nbr_fingers = item->num_subpackets;
 		sensor->report_abs = 1;
 		sensor->attn_size += item->reg_size;
-- 
2.54.0.545.g6539524ca2-goog


