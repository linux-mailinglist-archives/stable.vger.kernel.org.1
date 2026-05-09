Return-Path: <stable+bounces-244980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDLvAMFr/2kR6QAAu9opvQ
	(envelope-from <stable+bounces-244980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 19:15:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58833500B2D
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70041300A8ED
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D93AE189;
	Sat,  9 May 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mze20OuS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51892175D53
	for <stable@vger.kernel.org>; Sat,  9 May 2026 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346899; cv=none; b=WMYpAVdOBcHrwtAiiW8OY8CX30U35+8uUi6tq5L0cIgBYjrE2T3Mu0hBRAVGndgTHxvnYSvx/0NXNAgIdRsO7+fUEET4VbsllyZG8EtJkdQQ8zY6N2OAmOVj47tJgNCzZZb0t5/8DNxdX3qKsGHnZ6lDPp/FhJpwZPl83x7Q6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346899; c=relaxed/simple;
	bh=V7kCa7g50bjI089QsgYbShaoV1q8ppYh7Ghmai38EeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnmMO+M5RakiPqEXAt/FKvuJ/qZZuYmEEcZEQ92/C2oFS6d1pCW7BCv+xZAePFjENkpWv7uuxk0uktQP65ZeNXfgJdbmRJQoFU/ixCiJ6c9X0canOWfJvQudBjagHvadruYhCNJE2J7mD1bhWgwtdJQh85skrixENcabNBCl/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mze20OuS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bab2548e8bso14001425ad.0
        for <stable@vger.kernel.org>; Sat, 09 May 2026 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778346898; x=1778951698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsm6iRbgrzXYFIwlQx5X50SIqM7IIVrJi5fl7hMYCB8=;
        b=Mze20OuSPsUkVj5aMo9dJtQPl1lhUA2oieLa14C2lCtcfD5WvI1VcKBaTD5DQzAewn
         FZ01pa8TqTB8z6emMhtbJhS+ieZ3J4WaJEii4fF9upapzADM2k4HFM98FPIMEU+zUG/J
         1M6SFSi511iOozqzC4BMoV2SetWwE0V15KEHVYJD1mRkytYY+9wYUqCEG++pwgGnw81l
         Nx91AqM1iBgYzbv4q+iqXKycMvRu0/KUsagnRo6+7WnInXbBw9B46lLMkqT+R61Qx1z5
         WUUZzD4Yk0/4dZa9Dmfe0lQJW+ReUsyo9RluF5ykiZaun0wLdZcDrh2akRZNCDwuLokc
         Im8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346898; x=1778951698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsm6iRbgrzXYFIwlQx5X50SIqM7IIVrJi5fl7hMYCB8=;
        b=Z8GSY4R7ZC34+B2j1kAu7Xs9zDKbKq1CR+ClbGdofNxg35yuhFEOp5n2/hWwEfy72k
         riqZVrI1UEEcJxAVqdwDIXZRShXAX5mZ7usJ1HqLaMdxJBicPvywJB/zzHFvMAdUvemG
         /a0j/kVlP3frT9N7CiOplNEztJB73fMooSiwRZBT5zJWTZKrNIm/xJw1sm++BZEOjLyC
         DbHSjFnbBpYND4mR5OzilRoT2MOGlASpO3nazDSmvGZN2Bq8kF8epkzIlrs1racjxC3Z
         i66/LSq0FoFgd5Anh506T7GzBpIGAGK6LFtzQ2syiJzOP1gX8VbLSbztiUo8eZCE7Z9p
         kclQ==
X-Forwarded-Encrypted: i=1; AFNElJ9a0OTr3cGAocBoO6V6OK2qNGfy6WwUDYfUarVey/57H8XrG8d4qOaScAB2lSrFnfqZyEMKZRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8TbLhJUs+rTbpJnctvQRXaT945z9jbCF5AQ6UzsPppYRTq2hJ
	zmaKfpE+wPdYOtQOD2jiR5RcW8rJlxTvt8Ji6eUhrCjQy3/Xqv32n2s=
X-Gm-Gg: Acq92OGty1N0tN3Fp9eWYrDnVlkELACezVS1T33AtHLciMmDbnjb+DTe/RNPHhjp9ui
	y+pTHBIH6Ty/WgKMCrK7GTft/VidJCBtIXTHhVx4tFrpL6Y7FNK1soNGSK5i977FnXVSK/R6ZqO
	MGyyBkZEErHD7c3SZ1YQ8k0v723vbJWTZ4onxnemAuYHg1jEQR38eUzPVjXRbO14jrjKsRXYrjx
	PfwOu/jRWczR6LmH7fShJWdd14l2SW7fY3lNefRRW1iFuZBnvT9OYF5Bp1M6+n5NXTUu10rB2h5
	OZbrTdVpMWjOSZzD/bE6INsrHPzT4HfeM2WWXQqKx6CAx3WXvY4mOBUEj3LWoHdROIWCas1KwQN
	ioOV/ALdnCCUyNdhiJ289WQ09Z1X9Urky7notsnre6sF8/I9ljegPivmi8SyP7UTE1P+JDNcYNA
	y3uBcTUVPQjOu+ImAMpWh2b1UmMKmMfnjdQd5XBbXveDYnDFzjGK4dyTtGn/iYAtUMAIhwF6pP/
	I4EyUY5lf9FCNc=
X-Received: by 2002:a17:903:1249:b0:2b2:4611:5dca with SMTP id d9443c01a7336-2ba793aee10mr175847495ad.24.1778346897463;
        Sat, 09 May 2026 10:14:57 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([202.177.225.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebd0ddsm55098795ad.75.2026.05.09.10.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:14:57 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: matthew.brost@intel.com
Cc: thomas.hellstrom@linux.intel.com,
	intel-xe@lists.freedesktop.org,
	rodrigo.vivi@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/xe: Add bounds check for num_binds to prevent memory exhaustion
Date: Sat,  9 May 2026 22:44:43 +0530
Message-ID: <20260509171443.58152-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507055352.61017-1-adhikari.resume@gmail.com>
References: <20260507055352.61017-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58833500B2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-244980-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adhikariresume@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Matthew and Thomas,

I apologize if you receive this message multiple times - I had mailing list 
subscription issues that prevented my earlier replies from reaching the 
archives. I'm now properly subscribed and following up on the discussion.

When I was tracing through the code, I found that vm_bind_ioctl_ops_create
allocates about 160 bytes per bind (drm_gpuva_ops + xe_vma_op) in the loop,
and those allocations use GFP_KERNEL without __GFP_ACCOUNT. That's separate
from the main arrays you already have protected with __GFP_ACCOUNT.

At 2048 binds that's only 320KB unaccounted, which is why I thought it was
safe to start conservative. But you're right - at 64k binds it would still
only be about 10MB unaccounted, which is probably fine and won't force
unnecessary fallbacks.

Should I send a v4 with 64k? Or do you think the loop allocations I found
need a different approach?

Thanks,
Ramesh

