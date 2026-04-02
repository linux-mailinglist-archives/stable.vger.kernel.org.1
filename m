Return-Path: <stable+bounces-233107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKCYC17QzmmRqQYAu9opvQ
	(envelope-from <stable+bounces-233107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:23:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B39E238DEC6
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A86C1303762E
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 20:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77B38AC97;
	Thu,  2 Apr 2026 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7dBeMYt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3036C0DC
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161329; cv=none; b=SB/bJtmSJjyigo12rRIeCn1kNb+JNkg8fQa2HCyVLO9v9lngkQEQYill3IxccrEi4/ZbkoWmd9CksIIwVENlwi86VzqjjqbySk+nTtoht8YlqI2XbXKyTHt7i8ZgZXjSBB3VcJCDhdqjFp6fsq52rHhBVdoXv//2m274DO6oF3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161329; c=relaxed/simple;
	bh=2ALUTexkUDGQ0uM2WUOwABu2ysGRyfOZIT1Vy0Kc4D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAmU5NEAnc9egOhjhuuMi/O+3ZKLx2fLVt7VKABboYcBKBtDF1KUBqoRCbwjVuGgJor2cPEDeOBeo5dW6wJp1skVbqZtW3nM0vFtpmM2FvKo6Sa9eIOPgPIg9SBM5CzamfBxnLbmmBrY6/ncc3C/72WrwgOl05kTFcIj8QbXBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7dBeMYt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso1232692f8f.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775161326; x=1775766126; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nPCeq4iQWlTeSpgeZgdE1HiF7Waw+BvqGsLGLfov9Sw=;
        b=N7dBeMYtjsXoTLKLedcm/K6TjBhxjsi8bUYKtY0+cuRQ+kGlQF7AegFsglERMoy3KY
         i+T2gkBhy9vp/x1J5sfBg0JGNCnFnfj3CIQwxNO2M7uNbBH1u/pbgDTqK8tG7v1u+RWP
         pNZSg1N8VTrismqVyfCnDygv4Str6BRW8wgx8tXKhWOkv1lWjfBItwytOKLb1CJs/1z1
         JfMU2gGUXQ/+ebUxz3+AQqhKz5xRiSXZIK0qz8XY20SDPWtOqL0DnbCKjpQPT8Y9Wf22
         Ws3fspq0vVqsOSGTBxGUM8Y3qbg/hsWupZUYKpGfyOjXLd94muAz/Nhcnm9bOY/evcIy
         Z98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161326; x=1775766126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPCeq4iQWlTeSpgeZgdE1HiF7Waw+BvqGsLGLfov9Sw=;
        b=Pkn7mIt6Ho/3HkwC1ya/hCDPSnzdwtbB/2PAPP3y0Z5194KFSnmKiRyK/G1PGTMqWv
         yVzfPKkO1XctHBU7t2SKWEf7WeiTFeNx5d2EGlXFrDc48cGX7LfSXYR3oW4sUc166v2s
         YG7KRLRcHr0XqjPMXn6IcMY/c4UOV8WIYN5o4VtpsirBFPlY9i4kWg2HPWOuQWGAvydy
         26KdVw0O1Bt4aSAA0RUrMOlLcVWTGExK7RUPOOEA3YgLXknOKQnTBLFR1hn5tPuhL2fX
         R53U0CYRERbpfuwlYdIAcwvSsCfpiTsVEdIY+ZYmt18yRk1NKJfHe8+bYRkzBaqGCblk
         LVag==
X-Forwarded-Encrypted: i=1; AJvYcCVq9kWM2VyDOP8Rkbq3vQxolU5pZ7EfzDdCL06V3mnZPKlbmJLtkr5KPKWlc3yUOMnKpBcU+Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztdZmWLZAUZnhN9iAY/Mq/oJQmCT+by+meCGHxlvNlGrd/G45s
	YBY/7asImWg/Y3F+MPNCQQ0yy8XB87Ys6MA0M110dl1kkhBpYEFeigG0
X-Gm-Gg: AeBDievSSdoYNo/xrIvbwikAJthlSGAMYQK3Uhl4SPtA8QTt95WD/36/yIhifWDx/PS
	Wyxi/tImFtnOxuBHJGlbxwf5yBIPSbyt6lOcr+l42mlfjeLZsy59ZFsbTcjBlnnc69498+1tTRd
	oKjAog4aJgtUKWQPIh3+ppnds8SS4JwgCfmOBTd0GmFnu2M+nqU7z0CmAcW9CR8dtPv6pYsL23z
	xV23WifMqayrVmn+O9bz7G3OcsGWazT71oR41PhSz1VkOzG14oHkYlKsbW6IKbzDwEhDVMPv5vn
	hFe+q884xi468JaToXfRAQzJGSsVvEI/est2LqVAIDTjtCByCtOcRhKz61tlsvekx9qKV38wtoo
	hziNdoaX1N5I4b8uYX3WYTwYueBktnwZDb+7/LCzgHX9nKgQSn0dmvPtHSmFXXqokC+lNLAWNp2
	osTuV3fcPZ0GGEZzMzi44Z+U/xxm64Le8O3bW/TczIKAErJc+tEHAIowlmeEc=
X-Received: by 2002:a05:6000:208a:b0:43d:184:8a9c with SMTP id ffacd0b85a97d-43d2927b833mr695855f8f.12.1775161325919;
        Thu, 02 Apr 2026 13:22:05 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm9808420f8f.31.2026.04.02.13.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:22:05 -0700 (PDT)
Date: Thu, 2 Apr 2026 22:21:41 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 5/5] selftests/landlock: Fix format warning for __u64
 in net_test
Message-ID: <20260402.bdeb96fdcc2b@gnoack.org>
References: <20260402192608.1458252-1-mic@digikod.net>
 <20260402192608.1458252-6-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402192608.1458252-6-mic@digikod.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,maowtm.org,intel.com];
	TAGGED_FROM(0.00)[bounces-233107-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gnoack.org:mid,digikod.net:email]
X-Rspamd-Queue-Id: B39E238DEC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:26:06PM +0200, Mickaël Salaün wrote:
> On architectures where __u64 is unsigned long (e.g. powerpc64), using
> %llx to format a __u64 triggers a -Wformat warning because %llx expects
> unsigned long long.  Cast the argument to unsigned long long.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: a549d055a22e ("selftests/landlock: Add network tests")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202604020206.62zgOTeP-lkp@intel.com/
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v2:
> - New patch.
> ---
>  tools/testing/selftests/landlock/net_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index b34b139b3f89..4c528154ea92 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -1356,7 +1356,7 @@ TEST_F(mini, network_access_rights)
>  					    &net_port, 0))
>  		{
>  			TH_LOG("Failed to add rule with access 0x%llx: %s",
> -			       access, strerror(errno));
> +			       (unsigned long long)access, strerror(errno));
>  		}
>  	}
>  	EXPECT_EQ(0, close(ruleset_fd));
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

