Return-Path: <stable+bounces-211846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKXyLsPdeGnytgEAu9opvQ
	(envelope-from <stable+bounces-211846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:46:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A46E97028
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98809309D0B3
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C757F360740;
	Tue, 27 Jan 2026 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="VZw7wMzF"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C7360724;
	Tue, 27 Jan 2026 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527311; cv=none; b=VvZVZptERU50AeS6LT/21s8v65+Ke92MlZHznn/OXWEwqpNSFB+AkFxn9M90oaB9lW9pv611VZk8bIxooK2eSmwQd2mygCWrRZLY7MQCbTXRREgxFA/XvXyONBO7P+OnWKS1K/RQODA+d/TQ68P4jMihB9vpMFeHNJTmzipdP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527311; c=relaxed/simple;
	bh=PZoMFREOKYb5A2RBb3T/kOEVl2HYfvqsepMW8enuzrU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K9+lVhc6uB4wBXcyc+y4ixYCfA9ZpAGIjiqKwsnT+hY0PlYelh91ji0+spbonbpqv5tc2SbZMj58PYmNrIgPa96oj5/RZm/DWrtCPT1E5zs7gAZ/8stca3u/ONslsG0IaxEVUX6+AKhsqFbNeAwjB552fyvUAtaC9nqWKToiRCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=VZw7wMzF; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id B6EBB60020E1;
	Tue, 27 Jan 2026 15:12:11 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id 5itpaajWBzqb; Tue, 27 Jan 2026 15:12:09 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 0CD1560022F6;
	Tue, 27 Jan 2026 15:12:08 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1769526728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JNRbm588iHwZF1GxdMteQr8E3PEwbL6XNXp5vje3+7g=;
	b=VZw7wMzFh65Q/cPZxUF7cvpWg9/0YWNg+8wazANDXB+D2BggUp6u0GrRSzvXl0/8IBQ5hl
	e7SNMl/bxWF0qH4vadx6JIk9XsLnKeWo8eu22cVFBLYjJspDBpKWxGnN61ub/lbGkSrZVF
	/RKHItx0dXfifjDeTj6Scd+r6ixa+iJsKYSJ5W2nnvNNLFkX5paL8SyYtCw9A8GUkeWtAF
	HCEXyYb3H0HJE8XXMMfyMbSKKmAeUtY31hhrASttbZZFwTpDRB9/5BoPxuWSx0iEldinkL
	1FJY+3bBCfxrxeSMuvA+3GfjBo81jkfmJasWb7NBYR7p2ykdvwrE8rJwIKQEjg==
Received: from [192.168.2.110] (unknown [148.63.39.39])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 1DB273600A6;
	Tue, 27 Jan 2026 15:12:06 +0000 (WET)
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Subject: [PATCH v2 0/6] Fixes to Tegra USB role switching and phy handling
Date: Tue, 27 Jan 2026 15:11:46 +0000
Message-Id: <20260127-diogo-tegra_phy-v2-0-787b9eed3ed5@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNwQrCMBAFf6Xs2ZQk2qZ68j+kSJquyYI0JYnFU
 vLvxoInj/PgzWwQMRBGuFQbBFwokp8KyEMFxunJIqOxMEguGyG5YCN561lCG/R9divrWtOdjR7
 UUSkorzngg9678dYXdhSTD+seWMR3/blOf65FMM4aoUunHfmA3TWhmcj4+vWkOHhdzwn6nPMH+
 CEtercAAAA=
X-Change-ID: 20251201-diogo-tegra_phy-86c89cab7377
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769526725; l=2265;
 i=diogo.ivo@tecnico.ulisboa.pt; s=20240529; h=from:subject:message-id;
 bh=PZoMFREOKYb5A2RBb3T/kOEVl2HYfvqsepMW8enuzrU=;
 b=D8MsCp26CqE8ASu3nLdiC1jufNdbt6L1Lp4OgiaNsEVhs6wqPOft+KGYsKf+Yjp1lYoVYNDgS
 9jzgwMt7t3TDJ+ZE4kXwu+C47Ue/5WIzm5kIWgv16o6n0OskPIs6R2L
X-Developer-Key: i=diogo.ivo@tecnico.ulisboa.pt; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tecnico.ulisboa.pt,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tecnico.ulisboa.pt:s=mail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211846-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,linuxfoundation.org,gmail.com,nvidia.com,kernel.org,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ulisboa.pt:email,tecnico.ulisboa.pt:mid,tecnico.ulisboa.pt:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[diogo.ivo@tecnico.ulisboa.pt,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tecnico.ulisboa.pt:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7A46E97028
X-Rspamd-Action: no action

Hello,

This patch series contains fixes/improvements for USB role switching on the
Tegra210 and Tegra186 SoCs.

The first patch addresses a wrong check on the logic that disables the
VBUS regulator.

The second patch removes a redundant mutex lock when setting the PHY
mode.

The third patch guarantees proper ordering of events when switching PHY
roles.

The remaining patches are included to standardize the PHY .set_mode()
callback between Tegra186 and Tegra210.

With this patch series this feature can only be controlled from userspace,
by writing the desired role to sysfs as

echo "role" > /sys/class/usb_role/usb2-0-role-switch/role

with role being one of {device, host, none}.

Further patches will enable automatic role switching via the 'cros_ec_typec'
driver which is currently broken on Smaug.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
Changes in v2:
- Remove DT patches already taken to be upstreamed
- Add standardization between Tegra210 and Tegra186
- Address review comments from v1, detailed descriptions in each patch
- Link to v1: https://lore.kernel.org/r/20251204-diogo-tegra_phy-v1-0-51a2016d0be8@tecnico.ulisboa.pt

---
Diogo Ivo (6):
      phy: tegra: xusb: Fix USB2 port regulator disable logic
      usb: xhci: tegra: Remove redundant mutex when setting phy mode
      phy: tegra: xusb: Fix ordering issue when switching roles on USB2 ports
      phy: tegra: xusb: Add ID override support to padctl
      phy: tegra: xusb: Move .set_mode() to a shared location
      phy: tegra: xusb: Move T186 .set_mode() to common implementation

 drivers/phy/tegra/xusb-tegra186.c   | 73 +++++----------------------------
 drivers/phy/tegra/xusb-tegra210.c   | 42 +------------------
 drivers/phy/tegra/xusb.c            | 80 +++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.h            |  4 ++
 drivers/usb/gadget/udc/tegra-xudc.c |  4 ++
 drivers/usb/host/xhci-tegra.c       | 14 ++++---
 include/linux/phy/tegra/xusb.h      |  3 ++
 7 files changed, 111 insertions(+), 109 deletions(-)
---
base-commit: b02a5530af8abe0d3cd4852ba48990716e962934
change-id: 20251201-diogo-tegra_phy-86c89cab7377

Best regards,
-- 
Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>


