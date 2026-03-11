Return-Path: <stable+bounces-224739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IhCDAWvsWmzEQAAu9opvQ
	(envelope-from <stable+bounces-224739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:05:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F37226866A
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 949963069D38
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8343E63A7;
	Wed, 11 Mar 2026 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eBtR87qP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B031717B
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252333; cv=none; b=V/uwAOXumJT0D+/0/ZEoVAblFgAyz0TVYwL4JXQ1gj9lCHiLfPK8zUSup5YbOs/S3dqh1L/PqrsZGKGFiMoJRINW0AVwv7WqW3NMB/rvr2zhe55REZoqIOXXEWhqm1AGUNW4QjvACT2Kpa8/zkiZPOl0dX9i/BFlx/DuCZ34Dg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252333; c=relaxed/simple;
	bh=AL4IXq6iPYsWryMg2utdwYspGX4JCOQveTu5QegF1jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTX+gB7KnwdxsYPLz5RaJMx5lvwz2hMaKZG3p2RBabEsaeTVw3mDRal4nsoadKfQPLWfXG1sur88g/x+uHvviaVQuRK98HPeh4sek3D4lznZEVscB/Bh3ceUtnYI1y9Edn71LcxuFyb2YX1xXPV2kP3V6dZ8YcEnvaTwyaqdcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eBtR87qP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso1146045e9.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773252331; x=1773857131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xO0XJEJMI0VhT27CaLqa2S0ptnjebbKGDNoewgUI+WA=;
        b=eBtR87qPMTASFWRN2WwbxgNu5qCAvf9N72MF1jxlDq9zXIShT0KyGhuRsYDwGErxID
         0zhDuWZAsBa+6UtdxGy4qXFnnIhcD5w/fe5M4/E4CoTwYVX+iJioV1e4XD3RXJKLYZmH
         rF8/Wcjt+65HgGauQIG7aMBc7fIod/HB8p3QyZ3g/m7GLz144rUiWEEZQ7EqzdjlRDah
         qvhI6mlTMxT+ebOq+NsAXTInO23QKE+MdgNmWjwnGyvUlp/n3spAz3q/TeYAffoN2N1t
         mZjMOdbOe3EkUwirh9MvX3ey6Nq6CCRMRqHjON7Y478h64ByQs/DdGtBNMAyQwTxdKl9
         7P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773252331; x=1773857131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO0XJEJMI0VhT27CaLqa2S0ptnjebbKGDNoewgUI+WA=;
        b=XJQi1pk8rRIRSRPlLMgNdzeJ2ni+eKahz3hB7SP/yrQJPsNSocoRuN9MZaEzxxrpo3
         O0YeO+TgDu5GZ7/FSYHuFjkL1Yuyq3SkpA9SrohkiV82Eyq9FViS6ZQK6JI5hinrDQDC
         JPfPn8kW0TRe8nVZeus/BQ88u3DvOF76w7MWoSoEkaFRXDFszEEufUFLJ40vua1zUjdx
         S45y7U0yLelGOy/dSx/4JkEXjg0mjUBH5v8XUI7jzgK8Sz3SSp2hVcuxDNsmThaNSTiE
         CgveO+gR7J6r2wo24fj8Y5V8YdqGz+6OJLrOvdFPmZ83QinsgF/MxwiDTL942DxH3G8Q
         IK0A==
X-Forwarded-Encrypted: i=1; AJvYcCV+bpa/dABmyP1TOcQM2YJRyyO0yN6AkdDAElHMkprWe4+sDR83icXqN0jQkMNm7+hanah/R/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0A+/GRznBJKWs8G8V/oV02v+CKaehBw8fQ/ixUIH3BtQQZhPY
	BCCqZICLmeSPhMUppQzgCX/kdLDrjAcTSeqCUbaxHqNP+RaEN/aQO3/+vcvOdSA/lX8=
X-Gm-Gg: ATEYQzzmKeWJMkFaYwQGpudHi9ryvTqNzEGiNWQ6OT9gqLTc46mqw+nEtyMbM8Brw8F
	Umv4OwCfWe/4gs4KPbNwOJxfu37MSqSHXqpu+YIuEmgEidVkoDERHxe04mi1Q1oJHMdVtsukKBS
	+M+kqrqTswQ1T95bDBX3cIuybsNiZmz3xUvc6BxB9g0uBrkLL8+Lm63ugVND1WpeSZIlto9DG5A
	LHUblbsCEv81NsSxMXSBhhyqHssGWjgEf3dbKNRoLV0M5KYHow6252QGYN9bSc8qMLCYkMiwaBl
	n3XovGibFlnFQ/QiMQQXGBUcQYfWwYGIHyH2QwcwjW6fKOwgMoqjPXW06MnTWYQowU0XzQbQ5x5
	XF3xhNlJdOzGthQn4r5+P40Bczv+quq6jWC5ZKMu1OzFDywMjasffbWJTlZrMZxKNnwk3eWWgXT
	+8MDzsjWNM/YqaZCsrzHMoghJDkjMTug7iCzhbYKkg4yOiWmP6FwIsxZY=
X-Received: by 2002:a05:600c:64cc:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-4854b0b950bmr56222225e9.11.1773252330755;
        Wed, 11 Mar 2026 11:05:30 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7cb5208sm5510617c88.9.2026.03.11.11.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:05:29 -0700 (PDT)
Date: Wed, 11 Mar 2026 15:05:25 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: Paulo Alcantara <pc@manguebit.org>
Cc: smfrench@gmail.com, Thiago Becker <tbecker@redhat.com>, 
	David Howells <dhowells@redhat.com>, linux-cifs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] smb: client: fix oops due to uninitialised var in
 smb2_unlink()
Message-ID: <37stwkoyvb3xjcstdzyhh34nwd7nu6mdnjbkq6e3xayjncaycz@t2fhg4rpiau6>
References: <20260306005706.830672-1-pc@manguebit.org>
 <r7ojhnxu3jkr42oczp2o5w3hp5bs24ft5yav6nnlcohsybqeuv@zjvwndvvxayc>
 <353be345dcf906816d61e127583032d2@manguebit.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <353be345dcf906816d61e127583032d2@manguebit.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224739-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 9F37226866A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 06, 2026 at 07:51:44PM -0300, Paulo Alcantara wrote:
> Henrique Carvalho <henrique.carvalho@suse.com> writes:
> 
> > Reviewed-by: Henrique Carvalho <henrique.carvalho@suse.com>
> >
> > We got a lot of those replay uninitialised bugs. Maybe we should prevent
> > them by having a replay(func, cond) so we can take advantage of a clean
> > stack. Opinions?
> 
> Agreed.  No strong opinions.  I'm wondering if that should be
> implemented in the transport layer, therefore we could get rid of all
> that duplicate code.  Alternatively, having the thing implemented in
> netfslib instead.

Since not everything goes through netfslib, it makes sense to be
implemented in cifs with different approaches to netfslib.

I thought that implementing in transport layer is a good idea. However,
we have two problems here. First, netfslib callbacks also go through
this layer, leaving us with the issue David mentioned about performance
and handing in cifs before returning to netfslib. Second, we would need
to change the cifs_pick_channel architecture as well, because the replay
happens in potentially two different channels.

So I thought about doing something like the following, please give me
your thoughts. This would require a lot of changes in existing replay
functinos, but mostly intialization at the top, removal of internal
replay logic and definition of a static *_once function.

[PATCH] smb: client: introduce smb2_should_replay_wait() helper

Introduce smb2_should_replay_wait() to centralize replay decision and
backoff.

This wraps the existing replay logic so call sites can use:

        int smb2_operation(..., tcon) {
                int rc = 0;
                int retries = 0;
                int cur_sleep = 0;
                do {
                        rc = smb2_operation_once(..., retries > 0);
                } while (smb2_should_replay_wait(tcon, rc, &retries, &cur_sleep));
                return rc;
        }

This helps avoid replay-path uninitialized variable errors by encouraging
single-attempt helpers with fresh locals per retry.

Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2ops.c   | 24 ++++++++++++++++++++++++
 fs/smb/client/smb2proto.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 592c1609443b..43223389e2b6 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2806,6 +2806,30 @@ bool smb2_should_replay(struct cifs_tcon *tcon,
 	return false;
 }
 
+/*
+ * smb2_should_replay_wait - decide whether to replay an operation and
+ * back off (may sleep)
+ *
+ * @tcon
+ * @rc: return code from the previous attempt
+ * @retries: retry counter modifiable by smb2_should_replay()
+ * @cur_sleep: backoff delay (ms) modifiable by smb2_should_replay()
+ *
+ * Returns true if the operation should be retried
+ */
+bool smb2_should_replay_wait(struct cifs_tcon *tcon,
+		              int rc,
+		              int *retries,
+		              int *cur_sleep)
+{
+	if (!is_replayable_error(rc))
+		return false;
+	if (!smb2_should_replay(tcon, retries, cur_sleep))
+		return false;
+	if (*cur_sleep)
+		msleep(*cur_sleep);
+	return true;
+}
+

