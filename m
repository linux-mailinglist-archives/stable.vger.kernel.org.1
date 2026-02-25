Return-Path: <stable+bounces-218944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEKKCc9WnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:56:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DA11903DB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01F26321C40C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE827FD75;
	Wed, 25 Feb 2026 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fc1vo3rC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546725A642;
	Wed, 25 Feb 2026 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983843; cv=none; b=ZorA6bkRjtb2X3lLqjjDleIubJd5I+exTVmDqeTD+LUUm6lHXhnXdwTykaxvCBzjwuVeesotXHsBcdQgnQw+JniLI2YEaXrPosrUT1SV6IRrncg4wcC6LA7t/9ZXfq1IUSDr8tHyPC45DYmHed55CMERHgLG8SkjAyG7wgASy1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983843; c=relaxed/simple;
	bh=PMO7C00k1MkQZ//mUkDriTarzSqjUiOHaJecc6eN54s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHsv+FddnGAey4qhtWuddKCJyPMuDtkGclUnlsWT5LlQ8HB06kvoCLsvHF95LUvIPGPhqHQ8Qc8OzNMDEglLijTZmUFqG9Vikt0z+DICUDiYzgD7jrjfM6gTd4HwMQPQSoNhj9YwwoptuDvHzgFuncixtbtylup2KShSUqs8CWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fc1vo3rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1C5C116D0;
	Wed, 25 Feb 2026 01:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983843;
	bh=PMO7C00k1MkQZ//mUkDriTarzSqjUiOHaJecc6eN54s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fc1vo3rCZE67ly7oVD3ODCcawI3wj0iSP0iQi230Vr1pKtM3W2UvN7MJM0wKU+jmy
	 hRYgu4lLcc13h/iMKUIOx0oIA1gSBN0k4oEoJjmaHhbij3faFJ1qSK07nMp+VEBVt2
	 fkuWwLP69Fu5YYA3QnRkACUwcP2bbcQMl6RvL73M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan McDowell <noodles@meta.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 121/641] hwrng: core - Allow runtime disabling of the HW RNG
Date: Tue, 24 Feb 2026 17:17:27 -0800
Message-ID: <20260225012352.068008800@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218944-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,meta.com:email,debian-qemu-efi:email]
X-Rspamd-Queue-Id: A5DA11903DB
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan McDowell <noodles@meta.com>

[ Upstream commit e74b96d77da9eb5ee1b603c937c2adab5134a04b ]

The HW RNG core allows for manual selection of which RNG device to use,
but does not allow for no device to be enabled. It may be desirable to
do this on systems with only a single suitable hardware RNG, where we
need exclusive access to other functionality on this device. In
particular when performing TPM firmware upgrades this lets us ensure the
kernel does not try to access the device.

Before:

root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
/sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0
/sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
/sys/devices/virtual/misc/hw_random/rng_quality:1024
/sys/devices/virtual/misc/hw_random/rng_selected:0

After:

root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
/sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
/sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
/sys/devices/virtual/misc/hw_random/rng_quality:1024
/sys/devices/virtual/misc/hw_random/rng_selected:0

root@debian-qemu-efi:~# echo none > /sys/devices/virtual/misc/hw_random/rng_current
root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
/sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
/sys/devices/virtual/misc/hw_random/rng_current:none
grep: /sys/devices/virtual/misc/hw_random/rng_quality: No such device
/sys/devices/virtual/misc/hw_random/rng_selected:1

(Observe using bpftrace no calls to TPM being made)

root@debian-qemu-efi:~# echo "" > /sys/devices/virtual/misc/hw_random/rng_current
root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
/sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
/sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
/sys/devices/virtual/misc/hw_random/rng_quality:1024
/sys/devices/virtual/misc/hw_random/rng_selected:0

(Observe using bpftrace that calls to the TPM resume)

Signed-off-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: cc2f39d6ac48 ("hwrng: core - use RCU and work_struct to fix race condition")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 018316f546215..56d888bebe0c0 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -341,6 +341,9 @@ static ssize_t rng_current_store(struct device *dev,
 
 	if (sysfs_streq(buf, "")) {
 		err = enable_best_rng();
+	} else if (sysfs_streq(buf, "none")) {
+		cur_rng_set_by_user = 1;
+		drop_current_rng();
 	} else {
 		list_for_each_entry(rng, &rng_list, list) {
 			if (sysfs_streq(rng->name, buf)) {
@@ -392,7 +395,7 @@ static ssize_t rng_available_show(struct device *dev,
 		strlcat(buf, rng->name, PAGE_SIZE);
 		strlcat(buf, " ", PAGE_SIZE);
 	}
-	strlcat(buf, "\n", PAGE_SIZE);
+	strlcat(buf, "none\n", PAGE_SIZE);
 	mutex_unlock(&rng_mutex);
 
 	return strlen(buf);
@@ -544,8 +547,8 @@ int hwrng_register(struct hwrng *rng)
 	/* Adjust quality field to always have a proper value */
 	rng->quality = min_t(u16, min_t(u16, default_quality, 1024), rng->quality ?: 1024);
 
-	if (!current_rng ||
-	    (!cur_rng_set_by_user && rng->quality > current_rng->quality)) {
+	if (!cur_rng_set_by_user &&
+	    (!current_rng || rng->quality > current_rng->quality)) {
 		/*
 		 * Set new rng as current as the new rng source
 		 * provides better entropy quality and was not
-- 
2.51.0




