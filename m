Return-Path: <stable+bounces-244922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CsKJyrn/mlLzAAAu9opvQ
	(envelope-from <stable+bounces-244922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:50:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0457D4FE939
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E447D3034DEB
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583B1363C6A;
	Sat,  9 May 2026 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cERFP7e4"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343ED23ED5B;
	Sat,  9 May 2026 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312945; cv=none; b=jAS8VqujC97fSQY0GGsKF6UgQRdhbHuOuca9WXLl3eQijWPkoO1UD1vtRYZT0WXIVU1KLC9+9JAe2iuRLg/h13aXHpZhTWB4T08MOIEZU0bRFf7UwRMvMtahJiMNq7643g40pUrAdkKc5wuBBMkFggjqQksv1qaWc/M4/NkTOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312945; c=relaxed/simple;
	bh=MZkOOzOb+bKBFHgkg1vENsysaTJjJbKi4UD3inQXTv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jydE3cUzW6GNjtU+79BM9fZThE72Q56rXUJHP/9rHHNM+wvN9W1byJiPH2He6UoMuSodGkF0+ya4NOOkP+fYz6/8ReRnfALe07gM3Frv5r3DP4ITMKTWSinkV3/AmHrua5RFebxi/rrZZ41fuT+Ba3Cc2PyViEjnfg1sQZ5k6LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cERFP7e4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tU
	+OAfrpH6jHC1D7PyGHl4B3uAlL4JFvis5+z3yEDFU=; b=cERFP7e4x583wvfP1G
	kCSpoW595amnE5En1NKHNpksI508l8e3JYXbDLs7pewMh+s6xSO6DYlHO4cBd0ci
	9MLiY6ikZ0tGQ2eDmToHE8/jawOdYET5Bi5BF7/IMt3VPk4Vk5MRw/9W8Yf93xMo
	xVzXbJsHbG6EdMlsnJrJbVF6c=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3vx7H5v5pPBpuAQ--.62799S2;
	Sat, 09 May 2026 15:48:26 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org,
	jetlan9@163.com
Subject: [PATCH 6.6.y v2 0/2] dmaengine: idxd: fix event log crash and memory leak on FLR
Date: Sat,  9 May 2026 15:48:20 +0800
Message-ID: <20260509074822.2587-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vx7H5v5pPBpuAQ--.62799S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4rAF18AF43Jr47uFWruFg_yoWfJrg_Aa
	48tr9xWanYvws7Jry5AF43Zr9rWw47WFZ8Aw1qva4fXFyrZrWrCaykJrn0qryxXayIvryY
	k34DWw1fCwnIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRu2NtUUUUUU==
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC6woGzmn+5sp-tAAA3Z
X-Rspamd-Queue-Id: 0457D4FE939
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244922-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

v1->v2: add commit 52d2edea0d63c ("dmaengine: idxd: Fix crash when the event log is disabled")

Backport of two upstream fixes for the dmaengine idxd event log handling
in drivers/dma/idxd/device.c. These fix a crash and a memory leak when
the event log is disabled or a Function Level Reset (FLR) occurs.

Backport notes:
  - Commit 8a5084ab3af8: The upstream fix also touches idxd_device_config_restore(),
    which does not exist in v6.6 (introduced in 6.14 via commit 6078a315aec1). Only
    the idxd_device_evl_free() NULL check portion was backported.
  - Commit 2ea19af4a590: Clean cherry-pick, no conflicts.

Vinicius Costa Gomes (2):
  dmaengine: idxd: Fix crash when the event log is disabled
  dmaengine: idxd: Fix leaking event log memory

 drivers/dma/idxd/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.43.0


