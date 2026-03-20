Return-Path: <stable+bounces-227474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAY7JFwLvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:54:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F87A2D78DF
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E102A3103262
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21A8366558;
	Fri, 20 Mar 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eQ4G8mJ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511134EF0C
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996673; cv=none; b=J19w916ndwrwgemH8xo/sF9SsOu9+UcMSjo+PeHxO9DsLgT7jho5o7kIIlNKUVfOTLehN/K5qlloFWTwgTP8sfj3PZaQ9dIi4hjW4oC/EBWsJdhJnQa4VeltJ3bp3NTjqX+Z441Bp72TMBd4y/gTJqbzglB8E/Lzl0EQu11s2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996673; c=relaxed/simple;
	bh=g+mQukaa3mBWXnG2Ryc/nV7u0DWlguwSem1Jmsq21u0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TBgDNEnaDOgJBFJpX8uAYYYh6/AWfPPQtrT1sHXSU2Nwx0TOQQCevJvwJUB4ufpxrEKs1VGaGEeFpBQz7vK7gvhLkycUiwyfbVrYIcOqXSU17pQ9S8Jnb4J0v1P8sIzH/7vTrcAwbgQeTO7mC8jb1a5+zGrfQSiJfA3zfUyiSuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eQ4G8mJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0DAC4CEF7;
	Fri, 20 Mar 2026 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773996673;
	bh=g+mQukaa3mBWXnG2Ryc/nV7u0DWlguwSem1Jmsq21u0=;
	h=Subject:To:Cc:From:Date:From;
	b=eQ4G8mJ9V0Ppg1x+byFcU7N2uvXoQ/3bcqfjap9JHZbO4Eedu1t4qeMbGpLlO9Nme
	 YXjcJybdmhKzL2EEmjeBApNImWJJGkpCIfKSx+07IKgyWD2ZZ+Z2W05Ki29BPaQn3u
	 HMvdYQhRNHsFkPvutGzIjRDenlmx1qTiGw6nHW6Y=
Subject: FAILED: patch "[PATCH] LoongArch: Check return values for set_memory_{rw,rox}" failed to apply to 6.12-stable tree
To: yangtiezhu@loongson.cn,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Mar 2026 09:51:04 +0100
Message-ID: <2026032004-june-value-0884@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227474-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.888];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 1F87A2D78DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 431ce839dad66d0d56fb604785452c6a57409f35
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032004-june-value-0884@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 431ce839dad66d0d56fb604785452c6a57409f35 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Mon, 16 Mar 2026 10:36:01 +0800
Subject: [PATCH] LoongArch: Check return values for set_memory_{rw,rox}

set_memory_rw() and set_memory_rox() may fail, so we should check the
return values and return immediately in larch_insn_text_copy().

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 25fdb933119d..6c4ce6892276 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -258,6 +258,7 @@ static int text_copy_cb(void *data)
 int larch_insn_text_copy(void *dst, void *src, size_t len)
 {
 	int ret = 0;
+	int err = 0;
 	size_t start, end;
 	struct insn_copy copy = {
 		.dst = dst,
@@ -275,9 +276,19 @@ int larch_insn_text_copy(void *dst, void *src, size_t len)
 	start = round_down((size_t)dst, PAGE_SIZE);
 	end   = round_up((size_t)dst + len, PAGE_SIZE);
 
-	set_memory_rw(start, (end - start) / PAGE_SIZE);
+	err = set_memory_rw(start, (end - start) / PAGE_SIZE);
+	if (err) {
+		pr_info("%s: set_memory_rw() failed\n", __func__);
+		return err;
+	}
+
 	ret = stop_machine_cpuslocked(text_copy_cb, &copy, cpu_online_mask);
-	set_memory_rox(start, (end - start) / PAGE_SIZE);
+
+	err = set_memory_rox(start, (end - start) / PAGE_SIZE);
+	if (err) {
+		pr_info("%s: set_memory_rox() failed\n", __func__);
+		return err;
+	}
 
 	return ret;
 }


