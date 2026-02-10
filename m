Return-Path: <stable+bounces-215635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHDwERcDi2kMPQAAu9opvQ
	(envelope-from <stable+bounces-215635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:06:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 332F411962A
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D178E3020E9B
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4757346AC5;
	Tue, 10 Feb 2026 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cV0juBfw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB603451CA
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717890; cv=none; b=RPYUfz9M+2p7/zs3VvpTBLoXFihLkpoxwn9z0SbVQizKUlJR+KCxAABtU5GRf1485axUeGEA7LPwLLVHD4fKcmjgKTSVzvCg8PyzBSPOP9xr9MAaVx2ewcHu6e7Vgdg+X1fpVf8m3RV9oTxn7lD4Lru5Kcv308AhF7U70Os1H6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717890; c=relaxed/simple;
	bh=5iJeETj5dQOns2mVh71JREb7761Ypc61NmlTN6qjefs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhkblKi1p2bGm4iIMar3qAG47RyiL4KOZj2Q75WUOC6inkGnJ4xvk9Jkkj3zIcC6BWmOSbTg8IFuePvYgS+RFL+GZxVeCTNOsQ0MZKXJXdcIsmmCSl3SW18uha+M0Dv9OZy1+ln8osFRbWEJPRM8y93lQKp4geNRMMbsELZiJ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cV0juBfw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-354a2a7d90fso398176a91.2
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 02:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770717889; x=1771322689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsMx9lTnGL8tafbfR90F7hlJqCSmQiAaP//ctV+yPsU=;
        b=cV0juBfwdX8PDYtuUbqXUZ76ogIrmP40NkB4brsZoztQ6RJ0k0O/cMilCpIqAZO+UB
         jwhrT9eZHqPf137gQcgMIXgS+vWF2l1qPUAOeolOPwyKn7dMuq6YvfDgB3nkwrJpzQjo
         wrO850NraRTzyiU/Eg/XOEerr2R39lRcu/9b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770717889; x=1771322689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsMx9lTnGL8tafbfR90F7hlJqCSmQiAaP//ctV+yPsU=;
        b=X0JKxLjHah5sgyqJ5tyxcdDjx3CHrWUIq89ozo4uhBaT0EReiba/0GXsxY95xdCsI2
         LDuVHLJY460jvE3dpTCiudqZdyBhEbb73K6cq2PKcS2YgqbmC+xZPoCdSMTCyecb84FQ
         wlMhLlgVXHRGBJY2ygPSY+YmqKqhU+GuN0RqQApZLCQxK7WHwmmq99ltQJnii4KvokT9
         hvJVwliArGu8S62AxT0kbDrH/OjyH4MUs93Qxo8oaB7x5xqTI6GRMWlqq3N5bUHeaUoi
         ckhfTVe/HYM8iNEprmwxmE9xowSh6K2XaB6sfM8wdxfKkocAf/hs2P9Xmx6kqkBgKymT
         3KTw==
X-Forwarded-Encrypted: i=1; AJvYcCVyRhGNwOUjNQ0hSZdOvptR6KrMmKZxghdcS+JxFZ4gY7joOcV5FUvfsjuX9WUbwVKLdqDJOOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFvDpJX1qK34aR7VO51/BmX3upjCbGVmAOBubxABY6HIShZ2x
	Pl8CTmL+l9wpeWZrIChxA+f9h63BG9854lcAVqf9FkGFk56i2z0zEX2IgbUhAFvyZg==
X-Gm-Gg: AZuq6aLG2opBSRPyZRMGikCSlCJZPecSVko0olOA8NXtcF9I5V2JFODKkqRDj4+tSdR
	fcI+cVVTuG9nDVom7GzDzpMlWugKHt6HwngEoQwO/erdhRoDxIw8gPb4JfzmoWvOrsBTwuUV4Mz
	EdtlriNH14Ue6XyQ67MJOhvotu3V+flCw+1Vt15O0gjjz8tVaateNEy4IMHG5dCV/efUjCzxrSK
	KYdoidV6l+LVYpm4L9M+YiTQPgk6Ydhyp8RH43lMgo3ixTBYGBmTYJ00WvU/EUYgv8QlRoHiTGz
	RHP/ajE7Re2lI9A3ArLAkYAaoYOCL9eFR4odn/KByk/xp6xkG/ESgg4u5nd35YuDpibC6YkJtrq
	a2zRjRfnUzfmdAwBtx9/pql2JilPOS0zAqtdW/R5DAwCbbni92QQ2fhjUVQ9kIVai3CIvLUCjvp
	rTJGwT+7DDkqkmXuY7x+hWnPULVCA68HXv5nGOACOmGLvTbWlnoqjMz6qOwXUOwg==
X-Received: by 2002:a17:90b:3809:b0:34a:b8fc:f1d8 with SMTP id 98e67ed59e1d1-354b3e7644bmr13497513a91.37.1770717888985;
        Tue, 10 Feb 2026 02:04:48 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:ec5:3497:e96b:e7be])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b45c41dfsm7541804a91.5.2026.02.10.02.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:04:48 -0800 (PST)
Date: Tue, 10 Feb 2026 19:04:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: dsmythies@telus.net, christian.loehle@arm.com, 
	daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, harshvardhan.j.jha@oracle.com, 
	linux-pm@vger.kernel.org, rafael@kernel.org, sashal@kernel.org, senozhatsky@chromium.org, 
	stable@vger.kernel.org
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
Message-ID: <67clm4sqv5cbqxjhjoyn4eodwocc2jm6piwky6cyv4zncfrp7p@izdkjc5db37j>
References: <006601dc965c$afe30280$0fa90780$@telus.net>
 <20260210093321.71876-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210093321.71876-1-luoxueqin@kylinos.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215635-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 332F411962A
X-Rspamd-Action: no action

On (26/02/10 17:33), Xueqin Luo wrote:
> 
> In addition to the cpuidle statistics, measured system idle power is
> about 2W higher when this commit is applied.
> 

We also noticed shorted battery life on some of the affected laptops.

