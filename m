Return-Path: <stable+bounces-214619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNMiGtSshWkRFAQAu9opvQ
	(envelope-from <stable+bounces-214619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 09:56:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB6AFBB4E
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 09:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46323022960
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE41E34E751;
	Fri,  6 Feb 2026 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfxoWx9i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146D34DB79
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368108; cv=none; b=SsmeAgsu1dkV74/whlHP6vSGA2jwykSuI072YmzHOhkV0gGFTqwggyosaOwksotfeKACGliEBLkMp+xc3gyGK9XIbzRXPKlWEi4yhBUwfFFzYBQVplS15P90RgLCJx/cKyTWvxtxVPqNbFZvQSmDXtTXXaaUZK0nwjkIi/mCGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368108; c=relaxed/simple;
	bh=8gJloZSI1GQcrUYIaj8I3nBQOZEH48jxJXr5qkX/U14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzxqB8igtmUx7Wmcey0eZCVGx9scrNEmERPm/Mf0lMkqxxl0F40nqMHDIMU47jSD+nFiVzJLp+Z2+tIrPp0zdTFCqtF19FaWOhyW/2qRoS/pHLALJcrV1WpWTy6YlwpTXg+l7cjZNSHKzDCVV6poSARoYhu54bHRIeNnKmkh6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfxoWx9i; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483103c7126so931445e9.2
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 00:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770368107; x=1770972907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4CfwKcayH4xDR1+iMb7IfsfcQiFBuBvxK6Im43iVvY=;
        b=OfxoWx9iiHt3ibQH7Cjb+JO8C9WfHwZ3XnqZ6lKqTG2L6fSy1c/G/chAKxqmR1bUQX
         qO4+T+GMcw/y2pz6GHJVrgz/+kZLnMoCtxYjB5coSMlTwrQ1D5oIEetoyWWyjjkNZNYA
         sHNFvVgit/wK5BRqSZCXKnW28s1j3OPvzJ4czCITMStB35nyWka/cFfjPpURHxOCgN0J
         EwvxVD/PjDobxyZDqPqJOv+8UX65R4r8i0GW+/r/LiNzINr5hyygYO6SKKwZRtSHDhu8
         u7bd6TOKxyK1cJX0P7Oa0zpO4klJG8ZOS+/oMD0PtXy6nf2V/E797XpdE4of8FD1YXMK
         9LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770368107; x=1770972907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4CfwKcayH4xDR1+iMb7IfsfcQiFBuBvxK6Im43iVvY=;
        b=YOs07xMVmmrFhyKjqguvm3f/UH0aHJ4rqvv5gm5numipNmYMHDBQA2SnMfmfDmE/cT
         5FFFF64BZRXGboG40MICgCHY/7MHnmSOEFKBSpkVqF0pkxV5wYjQVYirV92ug2j/eAm5
         6i+xMZXLdlvNp04k3vcPAXILv79EVraUWXbnljZGcpdExPFbDuho/os2R4QpHaQNp2EP
         VAHOXmv4vkehr6XSWYu2TuVuQjAbSSBPQzTc1KNUfwPJpbvSXzmMRPOHF/zGRfN1oxD1
         ns89xmtcnwU/QUk9W3ukG7U4nj8bxgPhUPz056aXczqz83KdwvlCWlsbAjeTfjtFAE5u
         f/KA==
X-Forwarded-Encrypted: i=1; AJvYcCWwAQsIWViskOfVpqE1A2VkVwRErMgYiUW88WtAss5QlEj/o7CBNMKF3r+ltJt10HrVqAmu7do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysMkSm5YAcmYKFLK5itp5vtI5N4HxrOEFw6zCKEeWScJJVRjb
	gdvNSTrkFlkC5UgCP32vISBUwuY1b4Zg5YywjvdRJSy1o/8kmY5eld4T
X-Gm-Gg: AZuq6aJAbCHDJCgiwDoYPnAxOuLiloo9x9gkPTmqbxp4NUC7TGL69TDtkQNCFPrkIyj
	U0R41DVceUryTkedhzuAfEqa4seYmyly6mvlVikxoNRMR/eOweZ1d2WZDjWbIj2dTM2cyH+Y1Hl
	gpHAMwGKRiBPraqf7fJhK9YtSkgsH9HiAJps6I5q4pvUTjyJqO+AxBWAAvvq1TzII35jWXCOIIQ
	M/JuhXhqdcGaPHtkZpU5o0wUQyAdHLQ+WpoUVAy9ELfUhZ1vBJB9i3Gd/+ROUHyzf1YvW2LFKXb
	DgppfEgIe7RIXgHpQ331kJMjyZWDnwCZEIFtm60C+VVPcxuXCPkddbrBpuINaihw9VOgY4pExKu
	tPSZPN1r+94OfNtglU7L8kpiuxiX/SEXiDRzBcUukc1TW1FkHzQ3IlspDxof/x59LrZizwMuDlc
	5Qem0MtiG/mizO2BGVE8K7Laxl9tC6F5sKQ4Sns1liRyas6CShhOw1+Vdy6XCoQdVDLEq4Rgk8F
	fsEyQSc
X-Received: by 2002:a05:6000:22c4:b0:431:8f8:7f2a with SMTP id ffacd0b85a97d-4362933ec57mr1767057f8f.1.1770368106350;
        Fri, 06 Feb 2026 00:55:06 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-213.paris.inria.fr. [128.93.83.213])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43629744ec6sm4878270f8f.35.2026.02.06.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:55:05 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	stable@vger.kernel.org,
	Zhao Qiang <qiang.zhao@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net,v2] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()
Date: Fri,  6 Feb 2026 09:53:33 +0100
Message-ID: <20260206085334.21195-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214619-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDB6AFBB4E
X-Rspamd-Action: no action

The priv->rx_buffer and priv->tx_buffer are alloc'd together as
contiguous buffers in uhdlc_init() but freed as two buffers in
uhdlc_memclean().

Change the cleanup to only call dma_free_coherent() once on the whole
buffer.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - Cleanup priv->tx_buffer and priv->dma_tx_addr
  - Fix buffer name in commit message

 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index f999798a5612..dff84731343c 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -790,18 +790,14 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 
 	if (priv->rx_buffer) {
 		dma_free_coherent(priv->dev,
-				  RX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
+				  (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
 				  priv->rx_buffer, priv->dma_rx_addr);
 		priv->rx_buffer = NULL;
 		priv->dma_rx_addr = 0;
-	}
 
-	if (priv->tx_buffer) {
-		dma_free_coherent(priv->dev,
-				  TX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
-				  priv->tx_buffer, priv->dma_tx_addr);
 		priv->tx_buffer = NULL;
 		priv->dma_tx_addr = 0;
+
 	}
 }
 
-- 
2.43.0


