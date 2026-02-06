Return-Path: <stable+bounces-214611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA6RNsmVhWk7DwQAu9opvQ
	(envelope-from <stable+bounces-214611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 08:18:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31797FAE5D
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 08:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5D2E3013A4B
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 07:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC388303A05;
	Fri,  6 Feb 2026 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqsTypsa"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797B2DB7B2
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362291; cv=none; b=Ps2yVBu4KX1E+hf84o1rxWHP5/Xdu9DWd08w0RBqAJR0IA0VfYoTrhRgVeDt7M3BKq2IYCjDjfIt6sK07jidoLp9QkZXQjMp3ri8Iyu9YNdm+kTryqKe39C/G5PhoNCe/zcspORhjtBOOjWIJJDe1DpxMvXg34o6Cbi3HVTgexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362291; c=relaxed/simple;
	bh=D1NGpPueV5ikgZjAQhEwikv1d6XuL86z97qEh4blo9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7huZRpoLna1EJyfcJMCEYCXdlAX8fJW7nZDDmdC9rEiPYywSRlsh18YeNBvrTCw7KlJIXabmyB0QpwEUs95R2qA/psiesfkk3Bd0tjXDQv/mMgH4zXaTawtaB8K2T4X7Bup6HK5ApYvC1xUxFJPpVRUl2YO0Mfn7wGAMmOFKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqsTypsa; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b81ebac5d6so2356552eec.1
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 23:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770362291; x=1770967091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAcAS6itCCUdJZBNZ7FOwqjOX6f/eCKZuoH9k6MbHEI=;
        b=VqsTypsaSw7d9Dh7VjDOiV1Vp2x4rKUIon5aoaf4Ow3FZ+aaXEHe+mjynhxLFUnDMU
         9y+Dr6sMGrcZQ91NNOIDJIDonLQDSDx17UyOkwNawVwLaLUjAQJ9djre0U2297YqaKCu
         ZYcqXPOEH4ZF2WjZgS4ZMR9924qhDB4uofSqHd4Cma5FHxvPkzQ6oK0eScpxfdR5PCd4
         PEeWyOk+NH1xTaf/MjA2QU6bA8HHp8dmfZ2Kwo96EQ+LhGtIEBsV7h3nZzxZYV7w28us
         fYRVnGzRdU7E+9AW1aJZq7fFtKLFESvY+9oerqs+bX0Xns+F+e3aI07eA2TwSQbRvYhM
         rrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770362291; x=1770967091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAcAS6itCCUdJZBNZ7FOwqjOX6f/eCKZuoH9k6MbHEI=;
        b=g5htNY6bPqSN5nbONiuQFZR0NhTDq4l1zvTQ4eBgjGywE49rHtnUMtw/ZajjxmkCsU
         1hDU6jZgqr3MfDcAY+kPcI3psXS1AfdPjSUsqIhCWOHuhNFw+dvMKbNGWtneWeVZZUDe
         /kx9Gl9CAqnGMzxbrK4jP9LfKT6nV1hws/Lh+KUyHmyNRGCXfmWHebbgKpSLipkiMYfA
         6W8HpTBfUKRXNxOPaqF4MaU4vWRiMIvIS8b0QN3Q2PYhyVW4cJhpm+qL7ZTSxIOj6LAZ
         m4EjxJJtY5jrBl/qMct71LxUiv/D5J+5Fu8dDpDIfL316iGbV9zh6eyAfhqZ9CPGcQWq
         y7ng==
X-Forwarded-Encrypted: i=1; AJvYcCUEv4ixFYQRCJT5HqQlUjbmYEcyQDl06eAHGR0Z7x5JsBX1mHePe/8MS95aKeDQqGUajVWe48E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCFvR8/NwukVWWRfYWMmtKiLOLwYcZnQnlJWqTdu//TX/mnOp
	tHXcyIcw7ADVrWPfTipc+KkMU11KfSHQluQbIaxDiURdiSG/oEvMS92M
X-Gm-Gg: AZuq6aJWYl9TB3DwI4SjsgLWw04M5ygsdjgoFzx26dPAbvC+gWX3GAiXHMSADm96zyV
	2kYAimnzNcB1CdNenQy9QYcxpIoLOl3wudeezVHvtICoxC4tVGZCNkFq43+AcNYS9hbKDTfxjY2
	3Orhiur8M4Urx56XVvFBJov2xR5vpIVL3G+Guas0dKfhP//fJJ6taTil4LMB6SyGuuwTkGTwXg4
	vHzPb69HiZBl+/lxS3lEi3mzMPvbAUPh8VKg4lI/vSa2Ig6J/V3U4i0on+aCJmeLA+lpVYKzTSi
	erocG5WFG10VffBPc86y+aE5yw9B8M8U4BXVBFnuMFmhilHkssbeYCb09ESudOpM8BzhTMWOwNz
	QUOYb+w1OyRDCsKjGVImSJrq9dxhj/iyi9olNx71fgUvjUfwrKw1tD0myZkra9Z6y0hikiNBRJ3
	b8JeGKcl3skc0JF29ZHxdimjCRN2442CoJsO3TQ6wNxMeYzfeJ7j5St2C/zZAD7OCgcTrFzQJ0Z
	bIOLO3jCJ7ZDzqXH+XpkuzPOf3dv88XOWEbyou38kLiBOtlD2FgT9OKgS2BEYgprmXhOyyynaYI
	WJal
X-Received: by 2002:a05:7300:d51a:b0:2b8:31e5:91b with SMTP id 5a478bee46e88-2b856830c4bmr889249eec.32.1770362290531;
        Thu, 05 Feb 2026 23:18:10 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c7f5fcsm1107052eec.29.2026.02.05.23.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:18:10 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Mirko Lindner <mlindner@marvell.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] net: ethernet: marvell: skge: remove incorrect conflicting PCI ID
Date: Thu,  5 Feb 2026 23:17:14 -0800
Message-ID: <20260206071724.15268-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,marvell.com,networkplumber.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-214611-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31797FAE5D
X-Rspamd-Action: no action

The ID 1186:4302 is matched by both r8169 and skge. The same device ID
should not be in more than one driver, because in that case, which
driver is used is unpredictable. I downloaded the latest drivers for
all hardware revisions of the D-Link DGE-530T from D-Link's website,
and the only drivers which contain this ID are Realtek drivers.
Therefore, remove this device ID from skge.

In the kernel bug report which requested addition of this device ID,
someone created a patch to add the ID to skge. Then, it was pointed
out that this device is an "r8169 in disguise", and a patch was created
to add it to r8169. Somehow, both of these patches got merged. See the
link below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=38862
Fixes: c074304c2bcf ("add pci-id for DGE-530T")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/marvell/skge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 05349a0b2db1..cf4e26d337bb 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -78,7 +78,6 @@ static const struct pci_device_id skge_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x4320) }, /* SK-98xx V2.0 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b01) },	  /* D-Link DGE-530T (rev.B) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4c00) },	  /* D-Link DGE-530T */
-	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4302) },	  /* D-Link DGE-530T Rev C1 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4320) },	  /* Marvell Yukon 88E8001/8003/8010 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5005) },	  /* Belkin */
 	{ PCI_DEVICE(PCI_VENDOR_ID_CNET, 0x434E) }, 	  /* CNet PowerG-2000 */
-- 
2.43.0


