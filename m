Return-Path: <stable+bounces-213547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIjDGohdg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:54:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DCEE78B5
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F10EC302B50C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86AB40FDAE;
	Wed,  4 Feb 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pPCAaMZG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA527B359;
	Wed,  4 Feb 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216699; cv=none; b=nhQ063qKU07YqaHwhblylqMUZEgqDadofpboRJ9HLDN2xXpuvYOT0zfQp0dSEJaEtgDGEMPHqhTa06dLARJ8YUdiIDpkPb1A+abp5DOYFe1UZRwn4ancRK1FFONfeC61c7nqq5rJIsJVTlurVDDWt+lyMwaqRjir8Fx/3Ra8Zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216699; c=relaxed/simple;
	bh=t/v8m/SIwkljKuUkIzV6npDR3hZAyMMtNIR+wWBkuIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLDxUxb3dWeKCXOTkd6vge64vUDqWZNkLK3pMvrVh+0iWPkKaZ2COANgv1bhOnfBv+0Sl8Qk0CmhmQgUgipKeaJqXrDVVdutEFHmkr31Rpj/YEKzI2lPXq1JgOcrg9VVlQqwfDeLzEKHCiBbN2AMTIeAdf8A6IFA3osHJ2OJ784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pPCAaMZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DF2C4CEF7;
	Wed,  4 Feb 2026 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216699;
	bh=t/v8m/SIwkljKuUkIzV6npDR3hZAyMMtNIR+wWBkuIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPCAaMZGljEksb9aVJcQMzS6qw6L0Tv6/za1+lwFS4GDqAHqK4rT2S734I5tSqbjP
	 HjE2Rq+0D2tfr80YxipZV2HiWOcAD9rK5jdsfIzZNGmITD8ikLtLQNKFKGNv1DARv9
	 detkk5omakwp5gNxPdcpJfFQgbaOXZl8sK+G8Vm4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zeal Robot <zealci@zte.com.cn>,
	David Yang <davidcomponentone@gmail.com>,
	Yang Guang <yang.guang5@zte.com.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 141/161] w1: w1_therm: use swap() to make code cleaner
Date: Wed,  4 Feb 2026 15:40:04 +0100
Message-ID: <20260204143856.820566035@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,zte.com.cn,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-213547-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zte.com.cn:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D3DCEE78B5
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Guang <yang.guang5@zte.com.cn>

[ Upstream commit e233897b1f7a859092bd20b10bfd412013381a10 ]

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Link: https://lore.kernel.org/r/cb14f9e6e86cf8494ed2ddce6eec8ebd988908d9.1640077704.git.yang.guang5@zte.com.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 761fcf46a1bd ("w1: therm: Fix off-by-one buffer overflow in alarms_store")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/w1/slaves/w1_therm.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1783,7 +1783,7 @@ static ssize_t alarms_store(struct devic
 	u8 new_config_register[3];	/* array of data to be written */
 	int temp, ret;
 	char *token = NULL;
-	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
+	s8 tl, th;	/* 1 byte per value + temp ring order */
 	char *p_args, *orig;
 
 	p_args = orig = kmalloc(size, GFP_KERNEL);
@@ -1834,9 +1834,8 @@ static ssize_t alarms_store(struct devic
 	th = int_to_short(temp);
 
 	/* Reorder if required th and tl */
-	if (tl > th) {
-		tt = tl; tl = th; th = tt;
-	}
+	if (tl > th)
+		swap(tl, th);
 
 	/*
 	 * Read the scratchpad to change only the required bits



