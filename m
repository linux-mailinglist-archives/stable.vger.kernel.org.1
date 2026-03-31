Return-Path: <stable+bounces-231353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO6JOlV/y2kKIgYAu9opvQ
	(envelope-from <stable+bounces-231353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:01:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD8365ACF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3682A30AD2F2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F143BE164;
	Tue, 31 Mar 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="DUiRy3Q9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6AF395260
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943656; cv=none; b=NpaC3ldQ/SJ74a/U+lSMIXkDK7qdGZ3TIuRu9DmRhY9QpxQuxMcdRImjprD0YGJSQdRREt5OcFEZd7sFhnXvN97Dp/+ZDeFO2fhHqCiE666KPrOK7L8ta3AWXkyoAD08F4yIAafXrVWAE7DsVaRw17uyirO67Kfo6IPlawcfmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943656; c=relaxed/simple;
	bh=lmze7BYV5hp4Y6sIOaGFbKHwUOMEax7foVnYPnmvQbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIn3hlbIcr/ny1KLV0cKi32zqvGAqwBtj7NvLjCSKORS/u8vJV57uOaD8Wf8sz9h5/pL2D/Cr9SlVzskMcmzMnrkJXuv4mky8SMDcBYJEHvlailoCFG1ugJcN2Z3rY5AVLm+xXvnebj7VVp4IDQrkl7WCIk8HgDjOqoc/BRlLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=DUiRy3Q9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B29013F29A
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1774943651;
	bh=IGd98WxReXhKmS3gVZc2py42NhhB81jPPYvyJnFKCbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=DUiRy3Q9unGA4Zd4oN+0ElhApSSgPCyC45dDzLnYKapfZL40ud72ITVDe9a+RHfJG
	 lhEkafrwhixQb0WdOaDpKJnDClnIiAa5Fzi4NhCvUthGVCIHAcQu/dAAwXAtrfHkhv
	 x/rjQgRfUAsNdEsTFAlIIYe5g+dNlsOOs9GhJLMI/hBJOeYkUjpJ5y7Ext5KgkVf4I
	 RwhuXmX2dV/GGXerYE7K0yPiWzgfHgtkxqIQxoHlV+CnQGVHu4KuJrRZ112tO75tHE
	 fGjD1sKXDvV+ws+YgVPugWdiPqRCuGEvhW2nkrfIjVVqCVXxL9Qicr2d2sOGISL8Fj
	 U5qrZNz66pHLN0OEKX75sOukFPKdXP46VVdMCJyEv6OB+gGsl6mnzteMlQqfBfhWbS
	 kG5ZIID0C0VDOo4Yl5GZ4oDsgZwJu4s3H+2KDzJSHIW38vG2N5IBF6SpSDD4RHaaO0
	 osltoVKJJH+wxdn9y4lm4LAU73XD9cIFtXN11VsIVB13a2D6QYyRNUfSbia8DvC6Ou
	 wCeeWbflg247Xf0T9tvOokFHIXBFXKsH/PLNpy9+f9ppSYIRYJ5QTOsq5Ir4qKTwXZ
	 f+x+SN38PfIQJnk9RIGjZTGa2pa1VFfLaAhHd+TSRVimphH3jUk+uSdQigpTp3hrfX
	 BrHtEiZOBGmDIt+cP3O+SF+M=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so49293975e9.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 00:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943651; x=1775548451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGd98WxReXhKmS3gVZc2py42NhhB81jPPYvyJnFKCbU=;
        b=oMx9FhYTlnCiBM8BKAmyL3R3wRgeNqqsY8zD5ReSOTZs6rk/h9BUC514tnrkZ8aqmc
         WDfFd0X2xuQxTKERWNZ7qLu3Uwgo1pog/u4Janm6Y35ynjiO1jl5YacrcCcQfSPGbDs4
         MaGQIvO7+X/GCQfr61SMZ+gmp6tRn80OsgPbeFnd+gMMlKv22XvWl2sVe6nLaSvpM2of
         XedhsIzfjv5IG0AWWO8HTWMskVwPPsfrRwFM2o1frCfnXnQaeAjbfRuFWfIOjzFzCp7a
         PmiUuxQb63qTJgAYxB5KwP8xKV5OxW4+wZgh/Co2R6KEQxwPsek+BuWcAohQlBU2NDjx
         dIQQ==
X-Gm-Message-State: AOJu0YxUmex8GuFvABml+HcWcHLl7qXYkQsNzYdGvnsEgVE6E4oq9gXH
	H6oIso7ZuVKCLprAqsS2OkG2dgaXRlGB5mB99bybGdnHTYA167ugxGVuqiWeZbVziiRKR7ZRmV5
	QhiihJ8YywMmKD+1F3ZvnNaYf6+ezBmaqqGZ2IYRa1MthgRvUfyBwe8sJiWqKZRDu3+cBup+9kg
	==
X-Gm-Gg: ATEYQzxUO0umzvX1JEM3QTWe/gKKGt0DdoZJAvySsLzsOomCtjsJV/ZmAG0kO3dVvJG
	neozHE7R9JYgW2xZjdwqwBStUaI9nz+NRc5BKA8APengb7qFer36JoraMZr6HOP7gTt6HGw9EbJ
	oC7FI9eeZizbn8ImGzCms91odTKnAgfeURYvdUowdeCvRzG0RhdWMH1Ox81CPnyVqQgvPtpB6Cw
	wR0/qjk9t5Bo+Edqx8P4hS8Rbn+cLHdToU+oPvwePE/HmGeT8X7jnhQrXXmkgrYPi7WDNUtgru7
	0UXLLsVpFHJz3xaPrkgtffEjOlIkn8kKPDtgAEQRqKUjlvu87XfQXxbUF6OkePyKNJAAs9u3Dba
	UrYgh5Y0k1B0e/X8QzwUlP2RI0jZtYCwmiZaS
X-Received: by 2002:a05:600c:3504:b0:485:3e20:4013 with SMTP id 5b1f17b1804b1-48727f0b109mr228374365e9.28.1774943651254;
        Tue, 31 Mar 2026 00:54:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3504:b0:485:3e20:4013 with SMTP id 5b1f17b1804b1-48727f0b109mr228374125e9.28.1774943650831;
        Tue, 31 Mar 2026 00:54:10 -0700 (PDT)
Received: from [192.168.1.126] ([213.204.117.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c883b96sm9903485e9.17.2026.03.31.00.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 00:54:10 -0700 (PDT)
Message-ID: <0dcbb073-4745-479a-8d55-bdb0a3fe55e8@canonical.com>
Date: Tue, 31 Mar 2026 10:54:08 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6.1.y] smb/dfs_cache: Fix NULL pointer dereference on
 session connection failure
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@cjr.nz>, Ronnie Sahlberg <lsahlber@redhat.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Aurelien Aptel <aaptel@suse.com>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org
References: <20260319144929.455978-1-ghadi.rahme@canonical.com>
 <2026032339-irate-monsoon-76ce@gregkh>
 <a7c5ecb2-d46c-4061-a70a-c7b149db56f2@canonical.com>
 <2026033140-endearing-handcraft-b66a@gregkh>
Content-Language: en-US
From: Ghadi Rahme <ghadi.rahme@canonical.com>
In-Reply-To: <2026033140-endearing-handcraft-b66a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231353-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghadi.rahme@canonical.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44CD8365ACF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 > Then why not backport the specific changes that caused newer kernels 
to not be affected?

Based on the documentation [1] for submitting patches to stable, the 
patch cannot be over 100 lines long with context.

The upstream patch exceeds this limit by a lot and cherry picking the 
specific changes from it that remove this function is not feasible 
without causing the driver to break. In other words the removal of 
"find_ipc_from_server_path" is dependent on this refactor.

 > Backport the same changes?

I can go ahead with this solution, given I get the green light to ignore 
the 100 line rule.

[1] https://www.kernel.org/doc/html/v4.11/process/stable-kernel-rules.html#

Regards,

Ghadi


