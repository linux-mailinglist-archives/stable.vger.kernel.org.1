Return-Path: <stable+bounces-235615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B5rLSa92GlVhggAu9opvQ
	(envelope-from <stable+bounces-235615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 11:04:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4A73D4794
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 11:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E09D53010515
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7283AE1A1;
	Fri, 10 Apr 2026 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gUaOeiaq"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A11E38737F;
	Fri, 10 Apr 2026 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811814; cv=none; b=Flw0x2C8IdH6jQzSCzFHPrbx2g3OJHOL7fmHWdheQDHZIiXth1UTd0MkRLMqWyZiToElf+K55a+VKaOdnpnU76XqojvyGAdKt1Y938vWnuihaAAW5/PFsavegLoSd4QdsHTuy4uVDYBcVXBl2C1btmnio1P5E87Rv93IjEQEK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811814; c=relaxed/simple;
	bh=JQoMRroQGqF2IMGaWv58X8dTA6DCS66M2isFxCvTs8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G9LJH1ca249nZI8uCT4wvG2BjINRMMbVao9b/4unsZ6IY5URn+WU12XpxzuT0yfzQ9aRsW4MqOhYp409A0XkJt/Zsjrk6FZjDMD/KK2SuzFWy2t5i7+ysuZGrmgkoZFKw4VzqKcvPLWtaHJZyrCWhJ14lMHWlINFTfzOtdh3mOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gUaOeiaq; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=YFPayOsjb+5+Gcxzh+8/PY1jTqobcZZS+b7OL2QzsT0=; b=gUaOeiaqFDXf+8LIJE7yyAoW6N
	xXwIVuCcbfNoujKS/rO1JbWmXERoIZ37FxvzSkstW1CES37nqEi7r0wj+GOtHVx0wWyE2Pa6LnKOi
	XIqsTPxpvNQRwzYc7GW6xr33kHhwtqj+0m1z9/sC5aaxs46PET+w1mid796X2/XlCW92gqXKmwD7w
	wf5/hZWaHFnz+LBtD/P6DXAF+nNna8qmLTt5n1SjnYgOJAXI2MQj/9hUnHwIy1Kyds3kl9s112IoS
	e3EZ2js1uw+3fD/BWb+Y2ZLAxfXDhqlKu6yug6K1j3NYH3ydWWeMd9ZjtM8IsH4ZTcAGB7Yu9gO5q
	ZD/DH/wg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wB7lp-009rsi-1U;
	Fri, 10 Apr 2026 09:03:22 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Apr 2026 02:03:03 -0700
Subject: [PATCH v2] kho: fix error handling in kho_add_subtree()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-kho_fix_send-v2-1-1b4debf7ee08@debian.org>
X-B4-Tracking: v=1; b=H4sIAMa82GkC/3XNQQqDMBCF4auEWZuSxNagq96jiBgz0WkhkcQGi
 3j3ol13+eDnexskjIQJGrZBxEyJgoeGqYLBMPV+RE4WGgZKqEpcheavKXSO1i6ht7zHsnSysvo
 mFBQM5oiO1pN7tL+d3uaJw3IYRzFRWkL8nH9ZHt0fOksuuVGy1tqhqStxt2io95cQR2j3ff8CK
 wBLibsAAAA=
X-Change-ID: 20260407-kho_fix_send-ae33f16d7502
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3308; i=leitao@debian.org;
 h=from:subject:message-id; bh=JQoMRroQGqF2IMGaWv58X8dTA6DCS66M2isFxCvTs8s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp2LzWNIW/4bf1GUexjkGfxmnk43wQDHrtZRyl8
 eiiufwcuKGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCadi81gAKCRA1o5Of/Hh3
 bcOnD/9VQ5mEffCzXxXjp3D1jEz1BDnoezdxK4uOGDQ8Wq5ZIMDtwHfIFm7PPIcR5OT4g4XW14j
 9J8SRV4Qf4L+pnIj9NZjeOX1ik2GF+TUNOX5EnIAb5fghKP/BmndASTWVGJ0CeHqljcj8nvVmru
 r+KHfdpbapwtYNCzNiWMeytcziPDEo9Tgg9oL3UjmnCe+pZfGo0JLxyaza3zt75Q/sxbi5PNgae
 qcYpzECpDhROV0Ad364GmXnhWeZ+OBhhI5cSbBEzNpvPANS83/UFJXVB4FakpzBWvmfGN9mvM1q
 QzCNDKtRnnNxqfaEuURQl2gF62pO4vApZoDgfVqIViUUyLe88Db/KjsskUH4MWRaUVuQ8Oytlq9
 47u5/v4ROdHqYSc6TpdsuvJZqieJMlahf6KnepxC1/UOe68REWCoQQ10nkpj1oiYP+eVyNNdyhI
 BpW250VQeRWVQKEB28r0QLxya8Bt3dcroCH8WY8kcE02PgRn25LnyCcWlTUmLuiwjOjDrYpN0Kh
 uWxj+gMypvNea1Ia4a+236iVNb3qQk9W/t9Xa+uE/KwlFBejceHNs4a6UZFaK7GR+2d7JldZoQK
 G6wUaVrZ6wlcZ4gDICVGSkavPDu8eoJClms2x8SAskKdVV7pwXZr8TZJLxEmdW8al6Xs/HjMZhy
 3qZJnSNTZUgUubg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235615-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 1B4A73D4794
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix two error handling issues in kho_add_subtree(), where it doesn't
handle the error path correctly.

1. If fdt_setprop() fails after the subnode has been created, the
   subnode is not removed. This leaves an incomplete node in the FDT
   (missing "preserved-data" or "blob-size" properties).

2. The fdt_setprop() return value (an FDT error code) is stored
   directly in err and returned to the caller, which expects -errno.

Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
out_del_node label that removes the subnode on failure, and only setting
err = 0 on the success path, otherwise returning -ENOMEM (instead of
FDT_ERR_ errors that would come from fdt_setprop).

No user-visible changes. This patch fixes error handling in the KHO
(Kexec HandOver) subsystem, which is used to preserve data across kexec
reboots. The fix only affects a rare failure path during kexec
preparation — specifically when the kernel runs out of space in the
Flattened Device Tree buffer while registering preserved memory regions.

In the unlikely event that this error path was triggered, the old code
would leave a malformed node in the device tree and return an incorrect
error code to the calling subsystem, which could lead to confusing log
messages or incorrect recovery decisions. With this fix, the incomplete
node is properly cleaned up and the appropriate errno value is
propagated, this error code is not returned to the user.

Cc: stable@vger.kernel.org
Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- CC stable (akpm)
- Comment user-visible changes in the commit (akpm)
- Link to v1: https://patch.msgid.link/20260407-kho_fix_send-v1-1-b21977feb960@debian.org
---
 kernel/liveupdate/kexec_handover.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 94762de1fe5f0..18509d8082ea7 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -762,19 +762,24 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
 		goto out_pack;
 	}
 
-	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
-			  &phys, sizeof(phys));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
+			      &phys, sizeof(phys));
+	if (fdt_err < 0)
+		goto out_del_node;
 
-	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
-			  &size_u64, sizeof(size_u64));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
+			      &size_u64, sizeof(size_u64));
+	if (fdt_err < 0)
+		goto out_del_node;
 
 	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
 					  size, false));
 
+	err = 0;
+	goto out_pack;
+
+out_del_node:
+	fdt_del_node(root_fdt, off);
 out_pack:
 	fdt_pack(root_fdt);
 

---
base-commit: 8f8e4b45225ec37b0c69aace920e97148b014956
change-id: 20260407-kho_fix_send-ae33f16d7502

Best regards,
--  
Breno Leitao <leitao@debian.org>


