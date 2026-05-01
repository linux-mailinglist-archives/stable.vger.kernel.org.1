Return-Path: <stable+bounces-242518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CoEN/gP9WnIHwIAu9opvQ
	(envelope-from <stable+bounces-242518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 22:41:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C00D4AF8DF
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 22:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F58301CFA9
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872B242316F;
	Fri,  1 May 2026 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEi8ltVY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DB413225
	for <stable@vger.kernel.org>; Fri,  1 May 2026 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777668070; cv=none; b=GmcuscS+nC+5UQ6hSwYXWjIYMWaN3cMp+QOC5tp6aEEELd1i1fARw2+JaJ9+9o8EcwILB8+Yi27IaGMW/ecEYNNaMs0J/j9WobpzTivtWagsIMRxYm7mBz+4V11RKcTQ3QiOvfjrFzkd5j4mx/vKUm2aL7wGDfkyfPxjfJLmVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777668070; c=relaxed/simple;
	bh=VAGwlkfOhO8vq5+QQLvGj7XDBS7ATS4VX2eI2mgwUus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sfAGsgMSGnyS+Ag2BL84B2MX2c6y80Sz1StDi+4ns9potvBkIPXEsoqJ1BOgDcErckcw4ezXClmPYP/ugaTgUI69uYoQeM0EJvB3qFNaUp5ktUUzlRkLM9+qWZmEltErtgoIO4quWsbjA23/DpOf62R6+CTlLHBGzi6yUue8ZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEi8ltVY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so23393315e9.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777668067; x=1778272867; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAGwlkfOhO8vq5+QQLvGj7XDBS7ATS4VX2eI2mgwUus=;
        b=qEi8ltVY5FPEkzaV0Cs9mYwRsvjaa8SVo60MZY0QFhFnG6FzppCD07Ig8oFLUFCBbH
         puGD2nsRT7C5GnHb//5Az6G1obFAXi/gAlcuPX8h9ntj0DNsW1CZeuKAALjO/Hhvac9t
         FmBk6RXdOlM0X+r/1iwngpC8pEKFe3FcIgyaoOwCO1ZGBj1EEZ9zl+Hz4AKfVdVllvM5
         qpXddun6F14obLU40djU92xYXpovRtbDpeaj2SYRk/FcztH1pkcPdosmgEDdi+YQ5mWx
         hHx/qpD1IQIGBBInApPHgk5mPsFY6kuiyqmAWxbbfBETeq3dCSihVsbftqa28pXx+Y1/
         a6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777668067; x=1778272867;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAGwlkfOhO8vq5+QQLvGj7XDBS7ATS4VX2eI2mgwUus=;
        b=pSip6QhDJlcPbvZ/qmTGdy43+wXaUXkzu7sS+IrIoqkct7Ufg04FdaBjlefmC0TdkS
         95N+2z09aRT9Sq4kh70mttvEDfbewdCaG9d4eFEqHZibf19DdFYhZjV7F4H0XKLdtpCr
         IRaicM20XsNdDXTrrUmkkz80XAjEzDT1kd0gCGEbrej2jDV7Svzd1rKDYAvEdgdGpl/Z
         EVhw1+d7VHv+baQazLMs/ofWaPBjVlparDsOd0At99PtodpuOudzPE9PZspsfp+XXDUR
         Zf03mongzEFjlPOHvcqtVxmVGIKPeSbE3KyLCjwrImMB2Ocfzie9dwYrOa8tXx3uy7rJ
         e1nw==
X-Forwarded-Encrypted: i=1; AFNElJ+iF/yK8GqERXKYdBIRnJD8PUMiE0pA2rl27uLIA2YBULMuAcI8BWajkNlxMfNphp/Fpg0jV/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkPfO/rEPt/WyLUcqXY0h1jFxOpy1A/E3XOSIZBcOv0GbzSc8
	VqYQl4Gk5Pfa9vfbymvgKz2ji737aRRZCNVQd1zaTR/PdcUPSUv9bro=
X-Gm-Gg: AeBDiesLdmB7gD84V0aN4b/3KKl/rcXWD6zifaeicLGfG7gnkCzK4WPiBn8liI4nc8y
	M+ZdWmyXHJgvVRXOdYhXEABYFb148XWo1bI9TK7le+eny7No5xoI++iIR5ai2jWDYYkUu4V5ahb
	zCTtxOPXd6cxBxGVr/BH7djVKA5KwF6AiuXT6l6GmY91e18vTECZO0r9IAXIjjWhoQz5A+mXbOq
	pBRedK3DBxnMInivOxPMZBE95JfxaTUKsfFBq9zyzoBtGIQBlYSN3CgmycF9XEa/o4UR85LU7bt
	schjtD11YdXITbProWiVecddEubNqC4WJkTQ09h0fXMCGJ+qSJ1T4pSfYi+ITR2+PKAVGDrqDb0
	/ds6J9S4mmPdqd5dxYTyEHFc4R6xRqDMxpWg23kg3gcdOjdR5SJJQ7TrSWVzFgQlZ7MSPkAID4R
	ccEAbTgTukaNw=
X-Received: by 2002:a05:6000:2383:b0:43d:c95c:4259 with SMTP id ffacd0b85a97d-44bb5b4e054mr1421092f8f.30.1777668067195;
        Fri, 01 May 2026 13:41:07 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aa3a5sm7882383f8f.26.2026.05.01.13.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:41:06 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] netfilter: ip_tables: guard
 ipt_unregister_table_pre_exit against NULL ops
Date: Fri, 01 May 2026 20:41:05 -0000
Message-ID: <177766806589.1898033.5646188235412407059@gmail.com>
In-Reply-To: <afPUr2oksLlaMcOj@strlen.de>
References: <20260429175613.1459342-1-tristmd@gmail.com>
 <177750472539.3004201.15967003942391945312@talencesecurity.com>
 <177750474339.3016150.13196470704394042910@talencesecurity.com>
 <afNYqx41pBCyDnjR@strlen.de>
 <177758578919.118018.11758358602621428742@gmail.com>
 <afPUr2oksLlaMcOj@strlen.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8C00D4AF8DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242518-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 1 May 2026 Florian Westphal wrote:
> If we have races between a thread calling ipt_register_table
> and the netns cleanup path there is nothing we could ever do to
> fix it: we are tearing down a live network namespace.
> Something else must be going on.

I agree, this one is unusual. I tried multiple PoC approaches
without success -- all I have is the syzkaller crash I shared,
no reliable reproducer. Syzkaller itself could not minimize it
either.

That said, the crash is real -- KASAN shows ops=NULL in
pre_exit during cleanup_net -- so something is reaching that
path. The V2 guard handles it regardless of the root cause:
if ops is NULL in pre_exit, we should not pass it to
nf_unregister_net_hooks.

I will share any PoC/repro if I get one.

Thanks,
Tristan

