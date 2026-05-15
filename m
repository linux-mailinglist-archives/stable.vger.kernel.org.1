Return-Path: <stable+bounces-247757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGBcIAciB2rasAIAu9opvQ
	(envelope-from <stable+bounces-247757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:39:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA7555097A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F89F302CFE5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13B646AF12;
	Fri, 15 May 2026 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqj6IY1M"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826E38643B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849086; cv=none; b=ZWPKiwrxuQUjWOtft9aMACnnksidb+PTdm/B9Trtr8yQkvZOB57rgceaF9z3v5/+hy97M2OxFX5wHEojNzaNfHy4qFtGlGYUPKmHC1tnD4kkroaNQd5mOIZJKmeOc9bbpnbQOhKdXBtLKjfOTr4dqCWnA7PcfebJZItn0EfB3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849086; c=relaxed/simple;
	bh=JHRcVpZIKP2G4PFYLwnPmzPUOAUHO5E5dllxU0Kp2pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDLGZg5rcjoTNztx3pO2srY3VIubibqjyGwEVtrVd/TzF4Phyed3V8FwtxzegReQzjmW80e9VQpLX6OkZluKQxK/I3AEFpZ7AZHzX+VofIL93VDj0RJsFLSB/1jP2IHDi35Pjs82ESNnii6LOyI4cCRFF1+tru6TUr/OzCP9w7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqj6IY1M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a8f97f6bso12097125e9.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778849084; x=1779453884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOA5VhKwxGV3Lsu6xJEpHRMCj9rQogyWN6nM6iFqcG4=;
        b=mqj6IY1MS3rX7iz0GCb95o3ZMNkfujVz3ErxXZGXTpRZVWklIS2cxO3NJ1NpI2LndN
         Up5Vdkeq/wVhNlhNKzXYzcBXAmNAHSBf/Ol2HWK3mZQg/YMmrWuwvwYiEUCZMqUx1y+L
         cwBLLX93TcLbHZphA/qgMD3pOnLhhAmJlTuSVnZJ8MsyIp43kIgqiPyUrP9RtnnH0/bZ
         Sghyr2bb005RMg+zwcXL3jbjp+TWCZcXtzAJfbzjhEfTFAFpJjJA3j98RdHJQbbthzkK
         0NLOKKusVBbdD3QVMAwVWhG0UxfsVDkmEQrpEziYsWEewm42EmyAawLDMzVMJBgL0Y1F
         jZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849084; x=1779453884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOA5VhKwxGV3Lsu6xJEpHRMCj9rQogyWN6nM6iFqcG4=;
        b=bRgSOd1ekTGBUWciC08L/+u5Mh6N41g7541wMvHsApnEfM3q+Rg5AjVNeDRq19vquw
         z7XHfYm/r8t12xEJJvLoCs0K/ip7/HAGi+EGAmMjQ8x703TgrGNzOGP9QEBlxvY0ndFs
         iKtCdih1auJAp8D6cm2M7hp4EAb0jg/qA3nNRo9FYy9sVBUl/iH3KPQ+LBcSNx+C8qLq
         qDvkBXZsUf739VUjdEoU0dTzOYrtgyjdxfBFTfmFv2fnvHgpfPRvOPL0cueLb+FL4QNB
         64vKcIHNwmmCnfXc6wiNtR70L5E8rQl9reW2GQqMq2IQTwfgkaCCiBbpYBqD4uOGWfOv
         ICTA==
X-Forwarded-Encrypted: i=1; AFNElJ/pVkcWy1LVMa+BCmdaBavfZR2GiOy54EXYPZNUH4tx4t2ECxuAsPR9viyjQG7mvi6e/ExmKb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXB+C8xmuNO6UgOz3l7cAw8vkJP2IT0kQyb1pz7vlQrKZkx64G
	oA7FalGtNFk6KqKZZm2DyXt7zOf7pX3ZuZDc92g9cV7MVIIYu4NB88qd7BVwLx4NKBg=
X-Gm-Gg: Acq92OFqTogRIVXUIvwzmhhrTtxWSiXTtqpby4NM7CT97C/uR+Nmg9X9R9/0gHsFcAe
	l8mPpdkkJtTpWqqIYkUcRChDrUfhq/A/rodbDvU7YoxRaxFiPTwGbszCsNRQsiPNlemBEaivWwm
	EBcpGCI+K5wUyQ+/+eiFV6gQdu2egNbA+oFYTGUIEJaUihY+xhOxNKPNnwVrEjcxW5qVVQgZF7r
	j+4APbXyKSshIvxmMvcPlHp2vG0i6deFoNdaqvWSqAaEvnIoVAR/r5xqfvYpxdeUDLSVNEILzds
	NbeUZjnAeQajEANHGKpbfsW6Llzoafo9YTZD3s0HhlcGI9mH624Mqitsm5V5I1Yz+n701s+BVQo
	TJo76xqT9fVuRXdKOIfcUrOH1vxrWBmOLrU1hF/5aDZB0qua2PeVORp8bhK4ZyjxWXBWaNcAvk/
	vEuah+ujtqLVWHyraCpibDCw2nyoX18usSbgYuRObzaZLo
X-Received: by 2002:a05:600c:4692:b0:48f:d410:6072 with SMTP id 5b1f17b1804b1-48fe6302a9fmr28617125e9.6.1778849083283;
        Fri, 15 May 2026 05:44:43 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm13596705f8f.26.2026.05.15.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:44:42 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andy.shevchenko@gmail.com
Cc: andy@kernel.org,
	geert@linux-m68k.org,
	hcazarim@yahoo.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH] auxdisplay: line-display: fix OOB read on zero-length message_store()
Date: Fri, 15 May 2026 17:44:21 +0500
Message-Id: <20260515124421.30945-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <CAHp75VfsA_LsbEKjxoeMdbhPbWj7OHZ7=0SYNA3c=ZLj_M94Bw@mail.gmail.com>
References: <CAHp75VfsA_LsbEKjxoeMdbhPbWj7OHZ7=0SYNA3c=ZLj_M94Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6EA7555097A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux-m68k.org,yahoo.com,linuxfoundation.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247757-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 10:12:26AM +0300, Andy Shevchenko wrote:
> Isn't it also triggerable when  PANEL_BOOT_MESSAGE is left default
> with PANEL_CHANGE_MESSAGE="y"? (However these double quotes makes me
> wonder if this even works, as usually we compare symbols against plain
> 'n'. 'm', or 'y' (without any quotes).

Yes -- the same count guard also covers the init path: when
PANEL_BOOT_MESSAGE="" and PANEL_CHANGE_MESSAGE=y, linedisp_attach()
calls linedisp_display(linedisp, "", -1), so count = strlen("") = 0
and msg[-1] reads .rodata before the empty string literal. KASAN
catches it at boot. The patch covers both paths in one guard.

Re: depends on PANEL_CHANGE_MESSAGE="y" -- agreed, that looks odd.
Normally we'd just write "depends on PANEL_CHANGE_MESSAGE". I can
send a separate Kconfig patch if you'd like.

> In any case this seems a legit report, I will take the change.

Thanks for taking it.

Stepan

