Return-Path: <stable+bounces-218621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJjPKhBUnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2F18FB77
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C8033193020
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F12262FE7;
	Wed, 25 Feb 2026 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zjs9riNE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E7A2550D7;
	Wed, 25 Feb 2026 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983469; cv=none; b=ALVNtulQpU/lLvB6HVutN5FZIJIPu69LlYu33YmdwOA3EdMqoSw8ieTDmKlZbTjOZCrTFaBf2f8lXH3VpIxMIeYwfVOpCOtjQqoEILXCEjOgH3EsC8ILyg9AxgjYby/MllGtF5rQntATfvp0G56mpBDgma3vvfBWgC1xDI/0NzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983469; c=relaxed/simple;
	bh=i5Mgv4d62U8FjC61UqFJXkmYcM9hvABaqzTnQ9LjA/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDy899aFy8hgFr1DBjcuGT791ZrnCBYhdeHhSB4pskpzEWcLNu1KZ9bQ689h28KCiTgBXr+yqMoZXPhpmgY2vMwoNMhHZtS9ZZY5GZVLY/o1/O+B/8dQa0at8gTieEwjOMxHDFgIXJ8VyB8ngCWDofySus70pB7a6++OpOwU/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zjs9riNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AF2C116D0;
	Wed, 25 Feb 2026 01:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983468;
	bh=i5Mgv4d62U8FjC61UqFJXkmYcM9hvABaqzTnQ9LjA/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zjs9riNEudQxf6qw/lfYMET9jLQdl+ohL+dCgnqBQCDDLaYWQBgEVqRzRe1CHWsFR
	 rAJLTPIUp9i1UmRZgP2zrxsV2gyMfy6mkrf84AfU0l/4cAgIOJBn9hni94dSSMH2PE
	 wZQSIaFYz15NExFejtXEHfXlHzyoX95PH8eSO8LA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Junjie Cao <junjie.cao@intel.com>,
	"Daniel Thompson (RISCstar)" <danielt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 584/781] backlight: aw99706: Fix build errors caused by wrong gpio header
Date: Tue, 24 Feb 2026 17:21:33 -0800
Message-ID: <20260225012414.123635540@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218621-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FD2F18FB77
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junjie Cao <junjie.cao@intel.com>

[ Upstream commit b7db7d9c4ffc04210fe631f73a81746d6e2ef24b ]

The driver uses GPIO descriptor API (devm_gpiod_get,
gpiod_set_value_cansleep, GPIOD_OUT_LOW) but includes the legacy
<linux/gpio.h> header instead of <linux/gpio/consumer.h>.

When CONFIG_GPIOLIB is not set, <linux/gpio.h> does not include
<linux/gpio/consumer.h>, causing build errors:

  error: implicit declaration of function 'gpiod_set_value_cansleep'
  error: implicit declaration of function 'devm_gpiod_get'
  error: 'GPIOD_OUT_LOW' undeclared

Fix by including the correct header <linux/gpio/consumer.h>.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512171631.uKXlYwqu-lkp@intel.com/
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Link: https://patch.msgid.link/20260111130117.5041-1-junjie.cao@intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/aw99706.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index df5b23b2f7534..938f352aaab7f 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -12,7 +12,7 @@
 #include <linux/backlight.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.51.0




