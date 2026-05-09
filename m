Return-Path: <stable+bounces-244969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE23KklW/2mo4wAAu9opvQ
	(envelope-from <stable+bounces-244969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 17:44:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C935005BE
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 17:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C575030103BB
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4BA13DDA4;
	Sat,  9 May 2026 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLSF5dbB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FA219067C
	for <stable@vger.kernel.org>; Sat,  9 May 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778341390; cv=none; b=HtR2HYSNwK73r1RvJZVS4mxxMTWy31kT9Ju+a6xOdlyfvaLr8/xWqXSS13Hzi5yMLYAtwIcGSmnKg9/JY5jeTxNdwuvbhz6OdXFc+ATmckTiJMSJ8E0dv0+OpYQ3Ueipi2SWvfE0vrv7xqRRUcPPqyCVJQ8VVHUfL6/1cWQ/hNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778341390; c=relaxed/simple;
	bh=QIxNKk5iv/RLLp+JtmSaZA7qJUTSm3Fnay0kST4Od7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N14wW+90wwpkEyfZCX7dqkqgpLAM+YOdM/rzzo7qch78LjA9sk41cZld0KEuNBYNWmPyK5gMJACCF+lvCDu/ClPSkSAQdgOp6mo4D9D51zRp3zfEdcBdC7pldA7NSOnvy1NiB+13XabB+D6hFK4HRuhsffvml7wjoiLBB1x/9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLSF5dbB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-83659d38e38so1358144b3a.1
        for <stable@vger.kernel.org>; Sat, 09 May 2026 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778341388; x=1778946188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yXJqhcLXVF2p4UTzna8YZIe4V2LsKcR1MgCwvWlSaE=;
        b=GLSF5dbB57Jxeum1bEI9qyI5n1Kx/otq1ONk1yruWSV3edHd0hBL5LfjRRAzbO1ToG
         uasX3V+KcyNsvpIMJ5sspghzPK0tkxBvodznPipNBwAjEbq0YAS7fOktmtIMVtxrTJfC
         e/NqgZawGUMHTvVG2DEfBuxb3suPYmvzQ8CnBvSIPyLpp8LybuFKPH5kvYqQmJsZr0h9
         gUiMupqHJYTyxwmdavq3w7z8SfVGcSrHy8JADQYztOzDTgKOT9NhTbuw+PNxzqiZ8Eph
         DcsUdS1JSe93L6DDze7p4QNVExZl+yMIFM3RDbw0pVKf6zljb+J3RMKJo3XQDOv7yXmm
         aWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778341388; x=1778946188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2yXJqhcLXVF2p4UTzna8YZIe4V2LsKcR1MgCwvWlSaE=;
        b=gTobsQ9+RZgu7HtFEOehFLwtns/OklB1IhnPatRg3RArxmKusbGcMsDBgw/BVKe47T
         /rXVOTvSZajD+jXp7BE0BYHfEofNqJIJ1dBPMuUF/witdXEMnRc2hYs7EF6Rf4DFEy4f
         4eukvKF+CzJwf/Gnz5uYYCil2YgRRKrL04b9R/5wzG2/752IzYmcdOAQbd+4353trFBp
         ciwWJH8skvS3vE99EN6evlsZVE6gbkE9Sx8+yc/lhfSNtA+fm7xvzfAAkkJaCXQC4Mta
         NhdaUE+TTZx00eh4gsq8TtToBNIcUx6HyYFhx9QGSmCE1msppWR9+VHzwGiSl7w08NU5
         gYVw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ouwon/+SgTTEfNIeepaIZuJVRpedQjIaNee6aoiaSd8nX02BirJa6uqL8uz9yOXa2g29M+DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xQqsYyHpWN7dbFR5w2/suRh84a+2gN7WOMN15AfLtvkNGq3V
	+L8t7hr/1YbPQoNvtp2ToXS2o+bmcwohtgUZfh412O7+sE6EOu/fLjQyC3VBvmY=
X-Gm-Gg: Acq92OECXGSQsLWI2rshH8+jY1dMVc4llay6Mpj73E52/+hZIF7bv/TPPl8tSuxplhl
	se/8Xvt6IJ0Pzj68kwiGUpLGXH8y9VLBKCV4SGJbPQPyXCfRf9wcxhQp6iW9+5jujPzCM03lmJo
	rxX345n2BJlLs9k8iTh9vDvsR0XYIpw+31KZ9mJV1ihfBDjmrUGc+nXY7Avh33UdKvxCg3mlpsB
	d+bqNRAI2Mbybxkz73UD0yvlRBq/ofCdH2Q4j5sCJvSe3BNgeWx59/cjf9R96KYm/KP+0vN5TOw
	97UPRlWZiCwa3Vmy3DdL0zHEC3ww0OfUwv8GDITdwentGMGYmVEXsSA0IZ9jJ2rYhHZRucp05gK
	66gWu/fYZLrYpYg5lJlhVg8qfqRy2SeCuoca5Hpb62XC4m4kzm+DEHmJvML/ni9k883N6dGLnFE
	/VYaGe+2DQGudlkTLIn04PgpyGpijQtkmLS3e1G1ShJfMcUf6eZeb/2Nb7bgRWNN+Xg5ZaF0O13
	e4=
X-Received: by 2002:a05:6a00:2442:b0:829:8942:2ca4 with SMTP id d2e1a72fcca58-83a5badbf5fmr16448655b3a.19.1778341387775;
        Sat, 09 May 2026 08:43:07 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm15848028b3a.19.2026.05.09.08.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 08:43:06 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: matthew.brost@intel.com
Cc: thomas.hellstrom@linux.intel.com,
	intel-xe@lists.freedesktop.org,
	rodrigo.vivi@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/xe: Add bounds check for num_binds to prevent memory exhaustion
Date: Sat,  9 May 2026 21:12:37 +0530
Message-ID: <20260509154237.57082-1-adhikari.resume@gmail.com>
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
X-Rspamd-Queue-Id: 43C935005BE
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
	TAGGED_FROM(0.00)[bounces-244969-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Matthew and Thomas,

I apologize if you're receiving this message multiple times - I've tried 
sending replies twice before but they don't appear in the mailing list 
archives or on Patchwork, so I'm not sure if they reached you. I also 
attempted to send a v3 patch which similarly didn't appear. If you did 
receive my previous emails, I sincerely apologize for the duplicate messages.

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

