Return-Path: <stable+bounces-237928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNnpGeJz3mkqEgAAu9opvQ
	(envelope-from <stable+bounces-237928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:05:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B39973FCD28
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7895C305E379
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDB52D8376;
	Tue, 14 Apr 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="CSX1pQ7n"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (dresden.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66D26E173;
	Tue, 14 Apr 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186255; cv=none; b=fL/SnPPqRQundhCLrMjc2I8N81ll5r7vAUF/avaPKbEbYLwHF3mCnVMb2oVIyaeVCt0CahzywhAR9cKmrM6jNUY5XAQEdm6QhWwUiPsu70jocpyOW6PYZNEsfqiouL3F9SC5JXYcMWbqiwu3LMyVJQ+8SlsPmq/NMvLkv0IGYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186255; c=relaxed/simple;
	bh=d5b8T4zCEgbcN+ZpI7QwuxjPdlB0aJM6gPa06xSaFDM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rYkY6gW9od/qrfFLqXIgNtCTjuYDqZryWdSSEYQSr3bvrpP1hKSc5AuZQiPEN4H0lTwLdtz0CkVgGrZeazSyZhYD2iMyBhiRp1Un5hsIsoQ+lamgxfFrTasbthTG9bZyXxV+P4w5BrF4baWOsr6cLFTHWJVKFVkr90JU+DJObuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=CSX1pQ7n; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4fw9bw0DHVzRhRN;
	Tue, 14 Apr 2026 19:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1776186252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SqZ1vwQDrlv3zYSBUn624CG+uCzCVZFAlKcABS1o0s=;
	b=CSX1pQ7nDwUrgbj+lR9xeFN07E2qh+naI7NFFoKyanBkDQl8CRdHA+cVSbcwiC79LzAGWD
	BG69jGwAi2BzL4Ji2ZbWtzJE9iRYIR1A42QydK/7+4iOsSXiT1TzO3SWxJzv4rOjfwOD/L
	Aje7rDZRyxYKk1eKpcGbqbCrtPBEWFLp2iQs/GGfUiMqyOqQ56GFyerhxRqqSbzuWEO7US
	5DX1CpZHmBn1hI08roBXJtIL6OloheAl2bXeSZPQRvR47wS4NsJFQLtpfB2Y3YO4AZSwVr
	A191h1QS3mgNmsFxy0oIQrncW3u5zwsIND/6lh9KuJvL7MClJxromLgbLLLd7A==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 19:04:11 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Sasha Levin
 <sashal@kernel.org>
Subject: 6.18.22: a question to commit "crypto: algif_aead - Revert to
 operating out-of-place"
In-Reply-To: <b397c5b34ed7484aad6e0acf7e1319c6@stwm.de>
References: <2026041152-boaster-patrol-1918@gregkh>
 <b397c5b34ed7484aad6e0acf7e1319c6@stwm.de>
Message-ID: <fe119b5dc5716d1cf4ed53e6420cdf2c@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[stwm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[stwm.de:s=stwm-20170627];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237928-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@stwm.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[stwm.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,theori.io:email,stwm.de:dkim,stwm.de:mid]
X-Rspamd-Queue-Id: B39973FCD28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello

another maybe stupid question to

commit fafe0fa2995a0f7073c1c358d7d3145bcc9aedd8
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu Mar 26 15:30:20 2026 +0900

     crypto: algif_aead - Revert to operating out-of-place

     [ Upstream commit a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5 ]

     This mostly reverts commit 72548b093ee3 except for the copying of
     the associated data.

     There is no benefit in operating in-place in algif_aead since the
     source and destination come from different mappings.  Get rid of
     all the complexity added for in-place operation and just copy the
     AD directly.

     Fixes: 72548b093ee3 ("crypto: algif_aead - copy AAD from src to 
dst")
     Reported-by: Taeyang Lee <0wn@theori.io>
     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
     Signed-off-by: Sasha Levin <sashal@kernel.org>


This commit makes

crypto/algif_aead.c

almost like the version in v7.0, but there is a difference:

$ git diff v6.18.22..v7.0 crypto/algif_aead.c
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index dda15bb05e89..f8bd45f7dc83 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -144,7 +144,7 @@ static int _aead_recvmsg(struct socket *sock, struct 
msghdr *msg,
         if (usedpages < outlen) {
                 size_t less = outlen - usedpages;

-               if (used < less) {
+               if (used < less + (ctx->enc ? 0 : as)) {
                         err = -EINVAL;
                         goto free;
                 }


Is this intentional? Or is der missing a fix from v7.0 in 6.18.22

Regards
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

