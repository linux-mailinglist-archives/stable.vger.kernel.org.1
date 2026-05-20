Return-Path: <stable+bounces-251204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AjRLR0WDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:14:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C0359950F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3610E3278F42
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8FB3F39D1;
	Wed, 20 May 2026 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cr0wJLjd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A192A3F20E5;
	Wed, 20 May 2026 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297371; cv=none; b=QTHKZJbiqfANTojrcD+x/O6Z8t8ND1tLSI5mOQFadvbP4yfcHHOW86dAhBclC5gXFJoq2k6WvijKWa24Jh51CXo1+tX2ubqLubu4jjrVObcNgkdXP9Cgpv9PcTCeV8LEUSKYv2ldI5k3HbscthbohsLGGFnHdNoX7Uox/lUpSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297371; c=relaxed/simple;
	bh=VZMxkuJ0lzsWfoc0bUAP2Hd6stIwrI7HZ9Ay/iUpo88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6phCiSSuljYmAH804bcZMZcnNjBdy1ooPtVJBoAopZopgKQ2vmSyv5QPlpYJddkt9aP8w5gcMYUem3jovTQW5sS3DmqeD/nQt0DeMaKIwC4NFfze91ZXPoWmxO33JdGjcc7gC2P/+u2IDDFbvus0JSvkXUrSHYyzgP9ThA6yRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cr0wJLjd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1891F000E9;
	Wed, 20 May 2026 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297370;
	bh=D07j4y4bmzYApxlb+nbmb3GNISkreBaupMezSz9jqfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cr0wJLjdjrD9rj4T6LihlzrVTaqbxN1Ddh2C79oj1sIpeKPkdcw3v5f74Fcy1u3Ri
	 hZY8Jjf2KFSOKVXRmuBIhsDMjfti8eeiNWgAUWHQW4nxAjnmx+VJA/Bifc9f/R5bBZ
	 8uemVkmkbL1hJ/g6m9RYy2gUiVZF1w3hEw4e6Ryw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 7.0 1141/1146] arm_mpam: Check whether the config array is allocated before destroying it
Date: Wed, 20 May 2026 18:23:11 +0200
Message-ID: <20260520162214.075932725@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251204-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,arm.com:email]
X-Rspamd-Queue-Id: 16C0359950F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit 6ccbb613b42a1f1ba7bfd547a148f644a902a25c upstream.

__destroy_component_cfg() is called to free the configuration array.
It uses the embedded 'garbage' structure, which means the array has
to be allocated.

If __destroy_component_cfg() is called from mpam_disable() before the
configuration was ever allocated, then a NULL pointer is dereferenced.

Check for this case and return early if the configuration is not
allocated.

__destroy_component_cfg() also frees the mbwu_state as this is allocated
by __allocate_component_cfg(). As the mbwu_state is allocated after
comp->cfg is set, and is also under mpam_list_lock, only the first
pointer needs checking.

Fixes: 3bd04fe7d807 ("arm_mpam: Extend reset logic to allow devices to be reset any time")
Cc: <stable@vger.kernel.org>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/resctrl/mpam_devices.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2359,6 +2359,9 @@ static void __destroy_component_cfg(stru
 
 	lockdep_assert_held(&mpam_list_lock);
 
+	if (!comp->cfg)
+		return;
+
 	add_to_garbage(comp->cfg);
 	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
 		msc = vmsc->msc;



