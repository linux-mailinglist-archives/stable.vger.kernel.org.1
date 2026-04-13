Return-Path: <stable+bounces-235867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEJJDfQy3GlMOAkAu9opvQ
	(envelope-from <stable+bounces-235867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 02:04:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB203E6702
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 02:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A467E300B460
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 00:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E41FD4;
	Mon, 13 Apr 2026 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHpaElGz"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F075139D
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776038638; cv=none; b=gS+zdusPmk8XFUQI/MOlmmw4Qtpe6n+btnbTa4QufCNROt9v87P/pT/2ao9qG5XrgLOsKad9bSe4nr7F+tk5XUpniKcm6ILDJ5j1zkMUVhIJQ5P/9M60vfVSEpmgwKQdqUMXjBlnj7pjbZPuoU9mdX2r+qq7AEWSFaHeeHt4Z60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776038638; c=relaxed/simple;
	bh=VHSahNSTeWuAKCv5baXyFJs1A6nLUSD2mX6ATQzuEL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvZczrWzptUKh6Dc8hUvlmF8VucV9kmsacRqgxwk8DeG1ba+7CEtlfbl1cTQMlA9sk0JdTx/buiTrtxGKaGzTHfGvz4X4NhIQ3xmlJj0Hrxb+xkBuRQz4JKP8syLysWz7rMl9zJkLnwl1O6cxRJd5UJxeJlYLwEw5t2YxEjmk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHpaElGz; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d868d014a5so536209eec.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 17:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776038637; x=1776643437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bLZ2hGvxy/AXXUxBlYW4a7XQvCB2LmyGHSGavvwLlRA=;
        b=VHpaElGzCEzPT5HF6/pO/Agl41Kuw2oAsYK60lYv4BIaAJJwizwJlYhTqxgXWXRdjP
         uvau+HfH7/eHlp5L/F6ocaegZGNPXclFLm/WNOvHG+lTAKrxfHjtxsGlaX4SEWSeJyUU
         MqGRsBkWE/1mkXm4w34hrm8Z6QyWwbFndRRCqF6nRrel/eBpcC38sQFc/BqZCKdTFYlF
         lzK6Jc2++FEv7/2mF3iJL982b6gFh4svDEmyzWYC55JfcVKIvDXpxfV1CdOYGS88an+v
         czJpuqz8lZ/r5UjQqQ73Yw13FdAdJqJQCWE8BzcMUYbMS/Sbn8c4AYdYj+cUC2DwI0eH
         9JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776038637; x=1776643437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLZ2hGvxy/AXXUxBlYW4a7XQvCB2LmyGHSGavvwLlRA=;
        b=UVAgIVs/trexRdEV8x2eMNi4FVawq5bFbOrxO20wiaxqK23dulRav0/bQD7Wso0zb5
         yroqAPXc02/patTKlFJNXoJoltoACc13e81UyG19qP8Wf5eF07ecS4GWFDBvq+ul2HBt
         vCNYntdG6WbcxZI4FoTngVob0p/iL5JBfb5wNerh1ixrnxa7fm2lU+cK+w15isavf85q
         ketB1jgQfsycD9s8MEn09dawnZh0XJPH7uVte1GO4ViYziBib2SyMhOgZ+Vz58F2msYq
         7gsdXeFbOtaCqAQKRDJSuZu4Ubekev2I70WmXUOl0633Yywm9pdV1Z6RVUvAPUX3GSaF
         gTHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BAHK0nq5h5qzlSkqySkSB5tC2OFCmP+WFIo6tBI6IQeNwqhzcntv02BVC97zV2I70VM5/sww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6lKf9J0AGnbg4zvLdDdO/E/34TBXyone17twKWxeppKajRzi
	+E+rvjDY5DFOLvGHBB/foLoHMmCZB4L0Qh4g/n+si5iZuEn3jESZv9pbRfbV97RKU0s=
X-Gm-Gg: AeBDiesjrW04xDIolDu3rokp7i0gWRAJJQ7T7gG2zfGoBbb03WbTQWS5FCozLupydKi
	mw+fWHK+AojcimOU5Gbn2SFJS2oL47ssKKH6AnIDoUhmfscKiCzvwD7zaHq7c+3EonWl3h+fdFs
	I9QNNqiWPnwMhE1CpHW8e7iCy2Xg47tXKg+hBGgNOIIMnlrutyq9FseHLTe45yKhwYwlUlS0haJ
	El/I8Gnpfzv35TwbJIcRVX4joYN9ryos1yPEYVBOpYbldUAceaWcVnz5ydzcRFdJtR31lQCREmU
	erGI668Mh/pDMmhMsaOPaMqDcCvzhp13POcR59texpx2bkmzPsDMmOlUab1lLfgCSeHUZzvg6Nx
	H87X0bVPAe2QSOKvuvSr24/L/+e/AWvGtPz4E0kROsLKzgbA/cTiOY9tpJQ05yip52fO5xpchdx
	1qCXA=
X-Received: by 2002:a05:7300:dc8b:b0:2d9:f0b3:1d98 with SMTP id 5a478bee46e88-2d9f0b33952mr27219eec.7.1776038636511;
        Sun, 12 Apr 2026 17:03:56 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:ba4::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2a4esm18067085eec.16.2026.04.12.17.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 17:03:56 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@osuosl.org
Cc: Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH iwl-net v2] e1000e: Unroll PTP in probe error handling
Date: Sun, 12 Apr 2026 20:03:25 -0400
Message-ID: <20260413000325.33379-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235867-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tactii@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DB203E6702
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If probe fails after registering the PTP clock and its delayed work,
these resources must be released.

This was not an issue until a 2016 fix moved the e1000e_ptp_init() call
before the jump to err_register.

Fixes: aa524b66c5ef ("e1000e: don't modify SYSTIM registers during SIOCSHWTSTAMP ioctl")
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9befdacd6730..7ce0cc8ab8f4 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7706,6 +7706,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_register:
 	if (!(adapter->flags & FLAG_HAS_AMT))
 		e1000e_release_hw_control(adapter);
+	e1000e_ptp_remove(adapter);
 err_eeprom:
 	if (hw->phy.ops.check_reset_block && !hw->phy.ops.check_reset_block(hw))
 		e1000_phy_hw_reset(&adapter->hw);
-- 
2.43.0

Changes:
v2:
* Apply the correct Fixes tag
* Target iwl-net
* Cc stable


