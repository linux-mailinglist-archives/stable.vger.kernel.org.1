Return-Path: <stable+bounces-272567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uu6mAEkATmoBBgIAu9opvQ
	(envelope-from <stable+bounces-272567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 09:46:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C07C1722CE0
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 09:46:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZlPWhh6r;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272567-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272567-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 759433001CE6
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB5B3AC0C7;
	Wed,  8 Jul 2026 07:45:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454E3A9014
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 07:45:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496733; cv=none; b=dNKGsaVJv2E59gVHseWBCVf7vzpywdVuev/JeFW2D6C+Wgim+rFexdty1tfAaV7BjpnggysMTBo6s+36QK9MSSxQ7gOLUoD16yXp3Y6OT9k/8C35KYuHzI89+1I5vkSA1n1Lozw2KC06+dwKRWpYJtZn4+5niN7BG+bVu4yIdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496733; c=relaxed/simple;
	bh=fxP/FvmfgqrjVfBibyivbUPMOXYxiIR61JLIZjBwzbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8JUCw7Hm0mHG0XHu8Y6ZZXhsueIQ4i7uV0+LrAByrKnWt3cUWogzKcGCjljHsJtzGajrB8zzE64LJuvGA5AIU8o6t5NPYGNuUDCCyXSQqsWsggfEYQLv7fKc3fYU0UUy9ukbkN1MZFDoDnP3yeMlwFq0ekaIwCXj27lm1JXGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlPWhh6r; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845c92bc464so208464b3a.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496719; x=1784101519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9H4EFrSPp90tbiuGg/f2tSbBBfDqyoNWlRJb4BwfhZk=;
        b=ZlPWhh6r9YWNFskwchkWJRY1+3aku8kcPJeRLBUCEzR0/fP1ai4nHyNnkAhiPwTnZB
         4eoQ2F5zlX9OTbzlKoVgKq4SM+HiDOFa2R5Jez/hz/kCB+tI44ZwAfi2P/VSgyo6LgnQ
         sfIef3HkRLsGfbGO9+kriIrax2sJpFqXY9BNxizKcRTyACnVglZ7Tb072N7Geb2zsxlw
         95dgkzbz66t2wcN6ClbMGlmtKAMEJX8BrBORrAZCJD4INvNCEypwSDiKPaXRPp58jYy+
         vbOdLb19VCF3Nmus8VQwtguD93Kr1Fa+mIg3kYB8sj1Yoib+VnE/Ohqh7AWwZooDgIYH
         0k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496719; x=1784101519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9H4EFrSPp90tbiuGg/f2tSbBBfDqyoNWlRJb4BwfhZk=;
        b=Ycjoy6j4PECvM4O0HkY7H6RW+6paRHmB1mf1K7Fqrkpf/FHF46WCvetqc/ZvRJ1S19
         t4OTsBg3jf/HRotKORb6q8f3jqEcJ4gsmqx9JQomKQgm3a2HJc6KpWi4B6jBjEcxK94C
         6toKRSoOMij5CQIJhB8kjOCggS5arDGx/z/lt0IghRvgV2lezpHvNLIWANFdLzr/HQA+
         xkwQSWT7oyH8xukE/lN+jlSxD+pf8Z7SV7JoWOf0DHzwjDWtgTmH/ihW4vaI1Ay2OucL
         vnqdPObGgIZhaHJ99/KAmX2kv0Q15mMWsfUbG/2TjdYQTff05/lCqOY9v0t3Zusovps4
         fNyw==
X-Forwarded-Encrypted: i=1; AHgh+Rq5wnyQYVhas/jKn+86n0YsqYV8FR/GR8IAYNIV/4m0NG7zcjM/voTg3DTcrX1t2JHv7M46nCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYW6TVZIVXqHf7F6qGHPoseLSltPLSoAYqfXzPXmi3C0KFCyx
	b+NXttZPnH1N/sb8RJwUIDFCahw889LH3clhoqCtHtAh5cbaVTIUrhkCtj91MLWiGP0=
X-Gm-Gg: AfdE7cnYc9lxyGpQ6cmLfbtDfQk5TwCp3o78o65JB04KK/uEwF5/nLPphku5Hl6WZqE
	6kzL6xCs3ULSqHZJngopGXaL1jrKbyteTOQQxWplOnnVTH7BePx/PgV6qCDQjp6gBKnVTpyQY3A
	nRmaGcw989X0dBTPwtKdqctUG86+XGI+z+onDLdHIhJVsFnf7sAKmxHfONHvKNvKOWbFV5yka6T
	zspXr1yI6ISkP7Gc/JwaC8QdYgC6bP3S7I4PHigVZum+t5+VFVhMLXZYtFqFS+CpjKr7maNHPzO
	7N1DVyxCfg082jrfJ4SMTdHBAvoP4HoVur2QhlwH/ZA/orQKr7lxYMUE1z7VyfHKHUtLeCvm0sX
	xY8xXC9dZ96guyPlOeb8OHoRWudqimsg+moeTM8Wws+09FDrSyJ+d2/qfdWq4yB+rpQKBb3zXZu
	vNXkMDrWE=
X-Received: by 2002:a05:6a00:2190:b0:845:e1a3:107e with SMTP id d2e1a72fcca58-84843662b02mr1318793b3a.52.1783496718602;
        Wed, 08 Jul 2026 00:45:18 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848490f7bd8sm265990b3a.13.2026.07.08.00.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:45:18 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: wangzhaolong@fnnas.com
Cc: jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v3] serial: 8250: fix shared IRQ startup race causing IRQ warning
Date: Wed,  8 Jul 2026 15:45:12 +0800
Message-ID: <20260708074512.4028251-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708072306.3921604-1-wangzhaolong@fnnas.com>
References: <20260527092052.2086342-1-wangzhaolong@fnnas.com> <20260708031115.3757150-1-wangzhaolong@fnnas.com> <20260708072306.3921604-1-wangzhaolong@fnnas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	BROKEN_CONTENT_TYPE(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272567-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[realwujing@gmail.com,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:wangzhaolong@fnnas.com,m:jirislaby@kernel.org,m:gregkh@linuxfoundation.org,m:linux-serial@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C07C1722CE0

On Wed, Jul 08, 2026 at 03:23:06PM +0800, Wang Zhaolong wrote:
> Changes in v3:
>   - Rename hash_mutex to irq_chain_mutex now that it also serializes IRQ chain
>     publication and first request_irq() completion.
>   - Add __must_hold() and lockdep_assert_held() to document the locking
>     requirement for serial_get_or_create_irq_info().

Wang, these changes listed in your v3 changelog were all made in our
series first — by Jiri's review feedback to *our* patches, not yours:

  - irq_chain_mutex rename: our v7, sent before your v3
  - __must_hold() + lockdep_assert_held(): our v5, sent on Jun 24

Your v3 copies these verbatim and presents them as your own work in the
changelog.  No Co-developed-by, no mention of our series at all.

The full timeline:

  May 27  Wang v1 — only the THRE test race, no use-after-free fix
  May 28  Our v1 — both races, full fix
  May 29  Wang on our v3 thread: "v3 fixes the Bugzilla reproducer"
  Jun 24  Our v5 — added __must_hold() and lockdep_assert_held()
  Jul  7  Our v6 — back to guard style
  Jul  8  Our v7 — renamed hash_mutex to irq_chain_mutex
  Jul  8  Wang v3 — copies irq_chain_mutex rename, __must_hold(),
                  lockdep_assert_held() from our v5/v7

We added Co-developed-by: Wang Zhaolong to our v7.  You've applied
several of our changes across your v2 and v3 without offering the same
credit.  Please add the appropriate Co-developed-by tags.

Jiri has asked us to coordinate.  We've been cooperative — we credited
you, we're running the same fix.  Let's work together on this.

Thanks,
Jing

