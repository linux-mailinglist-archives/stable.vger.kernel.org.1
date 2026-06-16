Return-Path: <stable+bounces-263992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lwGKHRNtMWoejAUAu9opvQ
	(envelope-from <stable+bounces-263992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:34:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D033E6912A6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:34:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=cPcUh65k;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263992-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263992-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C02A7320CE65
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF71F3A8746;
	Tue, 16 Jun 2026 15:26:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827C43E4BA;
	Tue, 16 Jun 2026 15:26:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623564; cv=none; b=iZtAx9Y4Ioe/r7AWhxQwSCmPH+P7oagDyHMRdhfzEN/CGJqXckskVibmgSbgnwdv4W/tH1vqqDAQ3ITS6gLBnWKey2Qh3+kxvf1NiujY0Vs7WLoESwLJ+TTED6df9jS6Z23K2yuxzsjCZJHjoiJA+5wvQKBGUN17kCzGzfOo3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623564; c=relaxed/simple;
	bh=+TfS64cb1rl112/KTO+hFz2KY8pTOCB9C/m154WDdek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n69/8xiixaGVvhgUwfaHJjEtRm72brzDeLj83EiTpy8NvyELcM1jwYccP4O9qD7ZtsMcOx5mH5/hgM0IsVImWtBwHI+Sm/p6igJSxlQoTfr33sNXBwZndgTl9UWB6cqw2M8zSGP6QAB1fARtHLa5RYHQ2xCDB6TkaJ78EYFLNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cPcUh65k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8C61F000E9;
	Tue, 16 Jun 2026 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623562;
	bh=BM7SG0YRUKpWIV/dGuoUcDCCwEROSB5lmxYUhY74Gs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cPcUh65kBnP5mdSDvYyh5M4aBwrZZRLfv+K9BmuyPsZ2geRXgb7hB2u5XvRyjVhM0
	 zk/IKiJF6wc1cgKo6mFV+8dKDucR3SOzVFptozlHk4f6ErPkQxVlFHE7xo2CmT7UqB
	 cFrtI53pbUK/rjB6PLavEBRxwkPMe5RiSq36YAXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	lvc-project@linuxtesting.org,
	Georgiy Osokin <g.osokin@auroraos.dev>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 7.0 171/378] tee: shm: fix shm leak in register_shm_helper()
Date: Tue, 16 Jun 2026 20:26:42 +0530
Message-ID: <20260616145119.332321551@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263992-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lvc-project@linuxtesting.org,m:g.osokin@auroraos.dev,m:sumit.garg@oss.qualcomm.com,m:jens.wiklander@linaro.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,linuxtesting.org:email,linaro.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,auroraos.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D033E6912A6

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Georgiy Osokin <g.osokin@auroraos.dev>

commit 26682f5efc276e3ad96d102019472bfbf03833b2 upstream.

register_shm_helper() allocates shm before calling
iov_iter_npages(). If iov_iter_npages() returns 0, the function
jumps to err_ctx_put and leaks shm.

This can be triggered by TEE_IOC_SHM_REGISTER with
struct tee_ioctl_shm_register_data where length is 0.

Jump to err_free_shm instead.

Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
Cc: stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tee/tee_shm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -435,7 +435,7 @@ register_shm_helper(struct tee_context *
 	num_pages = iov_iter_npages(iter, INT_MAX);
 	if (!num_pages) {
 		ret = ERR_PTR(-ENOMEM);
-		goto err_ctx_put;
+		goto err_free_shm;
 	}
 
 	shm->pages = kzalloc_objs(*shm->pages, num_pages);



