Return-Path: <stable+bounces-254973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALBYJIw7GGpfhggAu9opvQ
	(envelope-from <stable+bounces-254973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:56:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7562B5F25C4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3619B3032AAC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5DF3F076C;
	Thu, 28 May 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPKJhu5K"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEA3EE1D8
	for <stable@vger.kernel.org>; Thu, 28 May 2026 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972986; cv=none; b=IcA1JNddG5s8+TQvk+s5G11dOkWkVxpIVrrmu+6SZoVlwgivwxUY4ypo7yy6LkeSIu8RtdBqkVjBwNN5ZAt9GvQ3fUcJRWZltouVlPU/5Rf5tns5yBqPXEgsP5xKuWZNUgWai4KLhL5Ww//pJX9pNlc0LCLNnaKrYss5UBPYh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972986; c=relaxed/simple;
	bh=YfZssVGDne01dMYMgGTcgNvcudPc2T+XxFJkjcazgS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSL2+PpNHN3ClSTUgwouYIFsvY8aHlGed9x8ycKl7zyuuY+VeyzbfOGJ799wyaIlx0zbrfYCWr6jpsEWQpEjT6omEFlX8kOGknTkZ3Wmfx/wyZCFPsN2FTQLA7njLkLvGlHbgj0o+imV5EFjJmfSwU4/DfNCxqE/Ut0DmGkjYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPKJhu5K; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-914bfa75911so686900785a.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779972983; x=1780577783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlTiMO+AqzsfMF73zg1sUXIUWFi0uPkexNI2Y+w2IWA=;
        b=IPKJhu5KafV3j2zNhIWpFJG1ODUa3LK7J2/HzlQNckUSG+ivyUPTtrmnv937lxcqp0
         htLaUQbF4tS8pw5eWEawCIz6PIO8iXFdlWXwQDeklfVWuV59Y3TtGPe8hCvjFGVQAqAP
         29BIq//PeRs635L9OBM54AHaaL5ApJWJtLkcyd26Dpk5KYO2bNqpEIBC284KZMmo0A61
         9F169KPZPZ6JKO6YWj4xJ2mJj6lCVMXrD4HpWrsR0kgEuZhoRiPTiWZP+IRDUjUOsVGe
         pZGTCrBJVP6UdS/LmiXyDuKP/ogITIR6G97C1G4OtHf8iK5pRXgr4uxdIZdXhPW3uvf3
         GAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779972983; x=1780577783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BlTiMO+AqzsfMF73zg1sUXIUWFi0uPkexNI2Y+w2IWA=;
        b=RygwKBd0VUhCEH300rTQWAJ96VdqrPnT5Zw9m9Zx9a5tL77eVQZwHzfCwNIja+dz5d
         pzlJB34YiedJwZ05Xjqu/g70aEVrt8Yi3VNf3boQAKFtiBVKtv8xOxq4/hupIIwcaIKP
         vEerN8gjn1tUPZFiUTS9c7qC/cJTWoVrpkTBzhGvezmvos1XuBgrwkQ4p54wccfvc3WD
         fG888cXBKj6GJnrcNDga7dfZ6xj9kNkXzhH4Z+1BXzmxDVbPglmqyHDo8Fd1dwXWOReA
         f/CRlkx259vriqcCaGZwqcJ02qLxQ3OIg4yvRFEaYijoybSRnIcTqrXDMXTz3cqioyyz
         6GHg==
X-Forwarded-Encrypted: i=1; AFNElJ+Xzij86h+l2uujRJH+XO4Z4xy1oCtAeW+XOgs5GL2KTM6ttFNJkMpUosBcjB/SgyLYfKgiQyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkq8GlNEX20IE8PO5S/SF0Oucio3yT6W/XNA15jExnN+1Ij8eO
	OtV8Om7/x0Eg1BAb8J4w8g/EJZJqYATyGLMgIqjBRxbj001JscyCTeHz
X-Gm-Gg: Acq92OHpe84sawXicX3DYvp1ruq/4iprOOzRLvlKONurLnJg0TkOqPn2HBZpzQreUgY
	1l4Wo2LNwJ+nqHUZvPsRO279+yz9ZoZfTaSMgxpKAfDEnn/NW8SzOWypEjhI2z8MtDyJIKAAgld
	kr3mdYyhKeN8XWUKC2SZ0wT7VKRTe4n16XuVoYHtMoZbq8woruBtBjZWn07v4WVF3PoSncCbQU7
	DtCxOueUdQjjHj8LswwkpvIB34+31AryvjohMRvRe5Bab16LKbXblfYBamO0PS2VSuWBjnXnsS7
	1KloALg+wJzMUYyUwFfjOzAAT5zVyaR50pHwNUf6zENE5qAXSBXD1pyAcXRrJ+SOr4kVp63mzLV
	FSOaSlkwsIDMWo+mGXduafpL1F9Y2XJEjNAuxW6PKDngN7qlXn/efdrh0G9bgLKugyp5u7/E5GN
	gb/U8ja9874KXuyhx9B0zyMoZNjffIzIIwEGfLQb7wz0o00deN+IxNwuFukiYCN5dijrU1HFrPC
	zQyaG2YAKJMHO+yK9dWgcgIou1r3w==
X-Received: by 2002:a05:620a:1b8a:b0:8cd:d688:7aef with SMTP id af79cd13be357-91521722eaamr138903585a.19.1779972982782;
        Thu, 28 May 2026 05:56:22 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86e9b34sm813683585a.5.2026.05.28.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:56:22 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: kwilczynski@kernel.org
Cc: leonardo.costa@toradex.com,
	achill@achill.org,
	akpm@linux-foundation.org,
	bhelgaas@google.com,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	francesco@dolcini.it,
	gregkh@linuxfoundation.org,
	hargar@microsoft.com,
	hongxing.zhu@nxp.com,
	jonathanh@nvidia.com,
	leoreis.costa@gmail.com,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	ryanmatthews@fastmail.com,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.6 000/508] 6.6.141-rc1 review
Date: Thu, 28 May 2026 09:56:05 -0300
Message-ID: <20260528125605.255471-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526183025.GA1285841@rocinante>
References: <20260526183025.GA1285841@rocinante>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254973-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[toradex.com,achill.org,linux-foundation.org,google.com,kernel.org,gmail.com,dolcini.it,linuxfoundation.org,microsoft.com,nxp.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,fastmail.com,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_NEQ_ENVFROM(0.00)[leoreiscosta@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7562B5F25C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Krzysztof,

> > When you have a moment, consider changes from the following series:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=sysfs
> > 
> > Test, and let us know if this fixes the problem for you.
> > 
> > I would appreciate if you could test this for us.
> 
> I realise that 6.6 is a bit of a far cry from changes against the upcoming
> 7.2 release, so you might have to massage the series/patches into sensible
> state, so to speak.
> 
> Let me know if testing is too involved, given the need to potentially
> backport a lot.  I will think of something.

I tried backporting the patches to do a test, but it turned out giving too many
errors due to the different context. Since it's not really breaking anything,
we'll leave it as it currently is.

Either way thanks a lot for clarifying this! It's good knowing the patches
where this issue was addressed.

Leonardo

