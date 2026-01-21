Return-Path: <stable+bounces-210811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMhcIt43cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-210811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:32:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E15D49E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B72387CA2DB
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669A4378D6C;
	Wed, 21 Jan 2026 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HpToMITf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C825F78F;
	Wed, 21 Jan 2026 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019460; cv=none; b=J69oXmfkq4tW3KCK2HQeZc5q7fTRww5ayu8tw0e1ygPtRf/kRxK2PPwNDCbn5MSG6d9CCZA3eC6ATxTFy1Y4rMShZF+s355/2GAnICua137D9qYYSQ14Nc0FicAB/DS8+/pbvPiU5XaYgmtPHJvznF5wKGuJlp0G77mZrUA6Yro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019460; c=relaxed/simple;
	bh=s2hxXL8ik58DdCGCxmJJiOFoehN8t35oG1Jx4oR/ZZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blZ8gv378qjLNPmXHZKebD2FdyvJ8UompLzg1FFxDBQVmqrrCArmarI6l0TOXVLXeRHAjQwmIVNrGhRvwkMWAAkCQx215bX2qo+8vzaXwheKvIBRx3AswFdzZwMF+TaqFJcXzHusYNZcHbHhGlUhxJhXrzTfsYG82P1yPD732+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HpToMITf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD91C4CEF1;
	Wed, 21 Jan 2026 18:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019459;
	bh=s2hxXL8ik58DdCGCxmJJiOFoehN8t35oG1Jx4oR/ZZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HpToMITfeL6sl0NBLvC/DW3cEE/+L5AbRr6Kk/1fCKj9fS+VRi7WsPuymk/MUOZO2
	 2VhNyvddzRZL4WJAeoEiZjSxJ8WtYOlYwcMexS8zmNxEE89yzV8mFspSoInSy+Hxad
	 mPGIQfh8U5enuYs4TI//NRsEDJX+HCmx8gm3oqpI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 013/139] PM: EM: Fix incorrect description of the cost field in struct em_perf_state
Date: Wed, 21 Jan 2026 19:14:21 +0100
Message-ID: <20260121181411.936448044@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210811-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,arm.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,kylinos.cn:email]
X-Rspamd-Queue-Id: 285E15D49E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

[ Upstream commit 54b603f2db6b95495bc33a8f2bde80f044baff9a ]

Due to commit 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove
division"), the logic for energy consumption calculation has been modified.
The actual calculation of cost is 10 * power * max_frequency / frequency
instead of power * max_frequency / frequency.

Therefore, the comment for cost has been updated to reflect the correct
content.

Fixes: 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove division")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
[ rjw: Added Fixes: tag ]
Link: https://patch.msgid.link/20251230061534.816894-1-tianyaxiong@kylinos.cn
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/energy_model.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 34498652f7802..09ce3dc4eab5c 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -18,7 +18,7 @@
  * @power:	The power consumed at this level (by 1 CPU or by a registered
  *		device). It can be a total power: static and dynamic.
  * @cost:	The cost coefficient associated with this level, used during
- *		energy calculation. Equal to: power * max_frequency / frequency
+ *		energy calculation. Equal to: 10 * power * max_frequency / frequency
  * @flags:	see "em_perf_state flags" description below.
  */
 struct em_perf_state {
-- 
2.51.0




