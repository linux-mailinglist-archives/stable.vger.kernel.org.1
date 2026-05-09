Return-Path: <stable+bounces-244966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGsvImNT/2lZ4wAAu9opvQ
	(envelope-from <stable+bounces-244966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 17:31:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A6500490
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 704083011106
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722DA2D6E64;
	Sat,  9 May 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHG0gmvv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FE25EF87
	for <stable@vger.kernel.org>; Sat,  9 May 2026 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778340700; cv=none; b=BoK6JFlemLn5vxZLs+/3o5TbA5gcLWHI+7W1R7hftk9yiU+awtj/YwnhH1SNtDXwqDHcM0g8viX++CVY7CWl9rrZZRzpQ3J8z9yiBQgAr8AH0sItNPjF7vsV5QK3yWnzuIV1Y2DjwmRSx7oF13A8UEmVUUkfH2EXkxzdAPt6nxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778340700; c=relaxed/simple;
	bh=HCySDTlk/5AUy2ZQY8Bwy+NCIU64YMqRRrySRnB4Csg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SLZXfnAMW0YW93TMrdgqQ/cc/mzCHDfqAyGiqM6yLMp757tBMWEq10Iy6HoPFLRoaYoSqg3LW5Fh+ecLJzYYlHwkfMi19HhZI4SlYkNou+6d6GpIZ8C+bHsHDxQP4SrcfHgbHzPwdcFxLDeCt9IhM0WWPKXmlZoKnvMBZCDdta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHG0gmvv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9358bc9c50so479496766b.1
        for <stable@vger.kernel.org>; Sat, 09 May 2026 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778340697; x=1778945497; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCySDTlk/5AUy2ZQY8Bwy+NCIU64YMqRRrySRnB4Csg=;
        b=dHG0gmvv4aAOBLBusKjNeX0tYarzWTh74xwqusaTRoQHPG0CJ6kTRfILUpaDZ0oyxq
         lpRhZH1mCZVi6dlYixU+oUvXnGWFgBlDoxeY8wxnZ3xkqXn61uQgP3VcL+3OC7oqooj+
         UDSK37ep2hc3zXYBMhDzWe3dL3580PvnDz46wBTPiP9hOYe/YJo33rXgNk0vEK+68s5Z
         1G/PFTQmlgKwuEKs1reRdy0uVDsd+ly7rAxC0yDK+x1Y/d4vfpbcpjD43roIXoGOu7MD
         zR9Xn8oo+szcHJSfqXF/1uE1CtxxwnCoIzRmLblX9ZP8pezyWdgEBVdUPwKZ3xcCxips
         7nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778340697; x=1778945497;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCySDTlk/5AUy2ZQY8Bwy+NCIU64YMqRRrySRnB4Csg=;
        b=ir1OCLaW+dwSozSibIe8AL1GHOoL8SUFUAbXXzlAjsFps5MPuoKeqlKr4M4NP5yymC
         RQruGR8URKAotyHAflgj7U1A24kViySOh6JbeSr3EwKsrmIgVcZ5OPIJNK70Cp/3fHHx
         zxYmJWwHGHHoPpH1Fru6/k/bReC+IhIvU1KHbUg+x8FWK2cuv0dCNH0po1bgS/A0aTgK
         FEROIwdmL1reJj6B03dMoG5gtSp7hjW8fO5KpVIrNpNFxxJsYrJzvjmsoEVi985uNZ8a
         VrGvsJZeTzWC45t/yr9joBtXCx7luEtd4LLJi51TdLwKLxrnBuc1k4mzq7tPq7NJbsL4
         AFZw==
X-Forwarded-Encrypted: i=1; AFNElJ+qdE4hEcOVkeIrGAK0GQAXhimYjfTM9emZMeMPxhWcVhOb9qMCHMuBkrgMq9UlYobamETIw30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgU0+GrKVZFlb2ZhPeEOAa2mMpDaEwedgZiAIKYG364FfwfMi
	GvmIL3HoPIZUQT+3UsCgo1VCnzYkhU4dITGIj0DuAdZIFzv+TphM+c4=
X-Gm-Gg: Acq92OHYKxPfx/v7VGIaIcdII1guL+0TllITx0m6FWu5ZWS6XNkW/mO+1CmRHy+Kmhz
	KEdb+Sq8PNC4Ba6pd4Heu4io9gzbLEueAyKstodgXGTwDlcW4He2qg9mI9LM28wDByrXYpxgjNB
	n2WxEvpMrGXK7StR0czTqev92EC7VKrszqS7iVVo9Bcc3FKGsaAebcWnksdaNUZvZJIlKLQvBAv
	uXi4Tt243yfLD4Lb/S347tdpy8CPz+CnKe7NI0C9Z5XiZ8sRuRN2w2sMr1doJtAEb50eKZCOn6C
	yIFQnZK2+kLgkbFhttvUw75t227yUslF1ienjQfJ9P6FPMPhpHxTu5NCZd9Hc9Zrg5df77NPbgD
	mysWdpwA6KQxsRz6Tb8MSY5DamKAAdX8s/1SAYIgbyi8p8AeYU4IzT7G2BK5mFkZHmUze1X3P+e
	Mt
X-Received: by 2002:a17:907:e148:10b0:bc6:14b3:e838 with SMTP id a640c23a62f3a-bc614b3f201mr807691366b.6.1778340696400;
        Sat, 09 May 2026 08:31:36 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eab7sm12303834f8f.23.2026.05.09.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 08:31:35 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] Bluetooth: btmtk: handle FUNC_CTRL events without status field
Date: Sat, 09 May 2026 15:31:34 -0000
Message-ID: <177834069495.1159760.2273651965423157568@gmail.com>
In-Reply-To: <20260508173121.27526-1-mikhail.v.gavrilov@gmail.com>
References: <20260508173121.27526-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 043A6500490
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244966-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Action: no action

On Fri, 2026-05-08 at 22:31 +0500, Mikhail Gavrilov wrote:
> Preserve that effective behaviour explicitly: when the status field
> is absent, set status to BTMTK_WMT_ON_UNDONE instead of failing.
> The OOB read remains closed, since skb_pull_data() still validates
> the length before any further access.

Makes sense. The hard -EINVAL was too strict for controllers that
legitimately omit the status field -- falling back to UNDONE preserves
the pre-fix behavior without reopening the OOB read.

Reviewed-by: Tristan Madani <tristan@talencesecurity.com>

