Return-Path: <stable+bounces-249463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAIrHWn7C2r2SwUAu9opvQ
	(envelope-from <stable+bounces-249463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:55:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCF5577A4F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABDB8305A72E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 05:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718FA34E754;
	Tue, 19 May 2026 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="kb8/oiYn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC6434D910
	for <stable@vger.kernel.org>; Tue, 19 May 2026 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169835; cv=none; b=uavCdA72UsgGYZUoyO2R9uySCAMNNY1CAB3sExWwEyShHfH0Fw/ie1y9l+iqx7zR9+wkZNZaG6fXiQ2zDKKCsNlsDioFF4ON3rNUD5YAByJOY1ADmA5Oq35iI2VjigbLZ+hrHQq7nxs7qbaQWq/kM9292n8v0aYfsel+NrsaeeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169835; c=relaxed/simple;
	bh=R/tnHUko7D+r3pgXbo43DR9BDen0uTM6J+JkfW2aJ2g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cSPSmpgjMajE/DvG2pUGNjeCAaKSu9gQ2KnymgOOXL5gx/MQ7et1bnW0NE5If3l1iYo16fAg+0GLVgzQZIlnjnRQqwiGbtafeBIPFeNAPj6PMhLH8sMvbv71+jCVeiIpHd7UCyImsmNB/WbGpDNnIYp9/XozEbk9HfuxM8Mi4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=kb8/oiYn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83659d38e38so1237401b3a.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779169830; x=1779774630; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tR5Snb8/Kee/sNXevElfs1t3MackxeJDCbbiIWdetnk=;
        b=kb8/oiYnGS8XX3+gPMccw9NDrF/GG+3oGDuB9MWk/LcyeuIlhINo8pUtPEc9uUj34I
         KKAo67iP0PQXqOS8ro9s00RJUbR1ZCELHUQs+2T4yN/AAdd4LxbMeJ/Fr7Jti/DxKHNF
         QLTMbfh8dhX0InT9YPKwfqeNMoXA8pk1lScR1DDnuO0kaVWZccjdp+fnB2V1fLkZ8X1A
         FPpL9c+QalNpt+v7T8H9wT5/m387ejApPyvhYGDkFRTanLJZfdzTNxz02z3TDjCL6QpI
         p+bkPL/Z4XC2+lBomQT/r04afDnkkpnvlcXL+/JL3L9l/zaX9DSghUxgMHAoyzj8b6+6
         7lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779169830; x=1779774630;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR5Snb8/Kee/sNXevElfs1t3MackxeJDCbbiIWdetnk=;
        b=Z65K4y7fOrUYvi8Xk67OzrLIgtfgte9xu1dMhHXjrlVkWfB0ILwHDWcVE9cbpzdUZf
         838CBRPMhD36pXsBBVXhZ8UANcgoVs66Qn4VnSEwmHzAAAsONr0gFMIHTGBoeFCs2OPj
         goysCISToItmzh0zszUp4nvQw60Byjhsre/FZeH0YSEt+cQFKaacljt+WtSRfHux4TXE
         wecuJkfk/EjI9ui2xU/tC+9T3eGQ+EtcEPDHeuzftmQsqAHdMcGKJnqctYDu8/cW5eoa
         PpSjZklhm3lMXJfSr3HI81QOa5mV8r2yCz+ejfhbAuMf063f7HyUpymlV++uxKZTy+IU
         +jNw==
X-Forwarded-Encrypted: i=1; AFNElJ8AqM+YuuW+hFXDakBL6hn19IVlxWEgmFIOBbMJmFgvsN3DgGZcDnap6r3jrV3QOvJLMpXCRwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjiLu//yBPiRcRvwSn9+8pMeSi023SnzD6Tg09FVvDinYNxxlh
	IJ/CIoUyYPCbfgPtOdxAI47wHRWRunknL6GsNfSNOJZCMxJWbRsOqA9kKh0kOVWk+W4=
X-Gm-Gg: Acq92OHR/wl8AglICFzrrvME0+FZxBu872aLdc1PkM9d9CZaHOV0LEfbGD2mS3QKssZ
	KpVDzR51G79HA93+vB/44dCzZTe9ndVedqcLFNYTPwyLEXHNUMD38WY1aUS1dub9TjPoFvvs40S
	vaCUeIJfYBby9P2gq+PV3Dg8zWpg+BTqDXwBRg1626flpGeiieIs3zK9z3nR66b6qKjYhSsbRj5
	KWTDwMMosJbkxniE9LVJefILk/JqODaSleWRvIMcOtSm3XP+vqGZVOor32+o2Zvyk41/R9ZCgHQ
	/WqRiqAyjkbv1y4QmJdFi+soy7Klml7SBCEqip/ytypmJeHF936p8WUtCln7PleGGW8PEifWq1O
	ROlk4G4qXtwo5cwIjCPPsFc9NC/b6Rf2xSlySuJvB0PWPSb9PUyBwrRY/Y7/olSlxoVOO9+ahDZ
	de3hHlIaQ2qo6iTBcO3ngQGy5KtCMKXaKNTjmYyZIhxReDD2dojp14EQoFhbDiqkNjeF0SwiHZ+
	BMQBevJyQ6HRDCTJTKIuXFkSQxKbyaYGmrRA5TrYNiWBdXT+e26Upo=
X-Received: by 2002:a05:6a00:90aa:b0:829:8c08:d1f4 with SMTP id d2e1a72fcca58-83f33ccd856mr18535467b3a.39.1779169830165;
        Mon, 18 May 2026 22:50:30 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83f19664a59sm16818807b3a.1.2026.05.18.22.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 22:50:29 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Subject: [PATCH 0/2] nvdimm/btt: fix a few memory leaks
Date: Tue, 19 May 2026 11:20:11 +0530
Message-Id: <20260519-nvdimmleaks-v1-0-592300fb7a43@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABP6C2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NL3byylMzc3JzUxOxiXUPDNBODRJPENGOjRCWgjoKi1LTMCrBp0bG
 1tQDWZ/BoXQAAAA==
To: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-249463-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iitm.ac.in:email,cse.iitm.ac.in:mid]
X-Rspamd-Queue-Id: 0DCF5577A4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following two patches fix memory leak issues in error paths in the
btt_init() and discover_arenas() functions.

- nvdimm/btt: fix potential memory leak in btt_init()
- nvdimm/btt: fix potential memory leak in discover_arenas()

Compile tested only. Issue found using static analysis.

Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Abdun Nihaal (2):
      nvdimm/btt: fix potential memory leak in discover_arenas()
      nvdimm/btt: fix potential memory leak in btt_init()

 drivers/nvdimm/btt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260519-nvdimmleaks-11f40a4af32a

Best regards,
-- 
Abdun Nihaal <nihaal@cse.iitm.ac.in>


