Return-Path: <stable+bounces-225935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DgyGr9OuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:53:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AE12AA2CE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEF2B3055568
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E043C6612;
	Tue, 17 Mar 2026 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qH69Bn6D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA613C3BF8
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751996; cv=none; b=MoSkb3+qzf1AT2+Z7n8wgPax0E+a/4o9YqKUBU/P45mpX5FqWYCo1nwry1olnmdgti25CJng2PM2cabIwGSZHcVeBGuhFdP3DVMTX9cAu4cIrKldiJ4r2vpKfJpmQ4SBWBbnXC4tEYN3P/TNwnfYl9NybxL1f8H3V7AHOAjRZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751996; c=relaxed/simple;
	bh=wB3/QGYFfMc/ELqAUcjx8L3UJCBt3ivBorGpB7tnkFk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aUJvG1x6OcFSNpF3pCGk0gW8i81FLTsdzGTMtgiBa3Anzi9bBgIcF1K5xHxUzkP8YF7x6THYM9VaknoZY0o4WVkJnxWgqqJyWndsfOB3yvfTNCjHy8wluYu/Qixx2C9Tmj143itfRzXeH7+fsgM20A48OAa1MMuz+w/oFNcGF+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qH69Bn6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF09C4CEF7;
	Tue, 17 Mar 2026 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773751996;
	bh=wB3/QGYFfMc/ELqAUcjx8L3UJCBt3ivBorGpB7tnkFk=;
	h=Subject:To:Cc:From:Date:From;
	b=qH69Bn6DhuVleDVz/DD/eD+lCGTHr4vTzjYfcxgKVhx/vhWgovuWGRHFylxw7lXvu
	 1eW10O+Hil+Zq1z+mgWVy90yvntWbp7SX4euEmyEH7qCqJpuVp7FeMXHWqhD5yk8OQ
	 u5PXnWozETzqajs8E1LlhJNgRYp6f+I7CpEDrPZ8=
Subject: FAILED: patch "[PATCH] crypto: atmel-sha204a - Fix OOM ->tfm_count leak" failed to apply to 6.18-stable tree
To: thorsten.blum@linux.dev,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:53:00 +0100
Message-ID: <2026031700-bootie-guts-d510@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225935-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linuxfoundation.org:dkim,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1AE12AA2CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d240b079a37e90af03fd7dfec94930eb6c83936e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031700-bootie-guts-d510@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d240b079a37e90af03fd7dfec94930eb6c83936e Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Thu, 19 Feb 2026 00:54:00 +0100
Subject: [PATCH] crypto: atmel-sha204a - Fix OOM ->tfm_count leak

If memory allocation fails, decrement ->tfm_count to avoid blocking
future reads.

Cc: stable@vger.kernel.org
Fixes: da001fb651b0 ("crypto: atmel-i2c - add support for SHA204A random number generator")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 8adc7fe71c04..98d1023007e3 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -52,9 +52,10 @@ static int atmel_sha204a_rng_read_nonblocking(struct hwrng *rng, void *data,
 		rng->priv = 0;
 	} else {
 		work_data = kmalloc_obj(*work_data, GFP_ATOMIC);
-		if (!work_data)
+		if (!work_data) {
+			atomic_dec(&i2c_priv->tfm_count);
 			return -ENOMEM;
-
+		}
 		work_data->ctx = i2c_priv;
 		work_data->client = i2c_priv->client;
 


