Return-Path: <stable+bounces-244507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNsnN6kb/GmELgAAu9opvQ
	(envelope-from <stable+bounces-244507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 06:57:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A44E2F4A
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 06:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C010302631E
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 04:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226C5326D51;
	Thu,  7 May 2026 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuXEC4n2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7EA30E85B
	for <stable@vger.kernel.org>; Thu,  7 May 2026 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778129816; cv=none; b=IZlFKl4E3WpjloZc6rJHvC/E0C48V4UXYrpyQ4wqGFqmdN1NPOTwafGJ6NUX4MGaAeYi+9y0TKHFkrM9nNTurdk69aLg1/vUK+mGP0cXTB6Cfl7wL2sGc/SGMh3sJUa8T09RWuX/b9hmPsiWJdxyELD0ggm2Gfm9UkUrJZew3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778129816; c=relaxed/simple;
	bh=3eE5haRfGcjDTqRR6Xt3Y7qwbYtLOCiNxAyT3odM/Lo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O1BAljkHh4rTN8zSVOjgb2nOSg7tulBE3NYsu45wOirapM7r0RXD21wPxL8xBneYBnklM49dCkcZ1kNgrQzAJb+ZYn85RHwz4MnS5n/lZLknR4dUgSTYBewCq5erkKLYpDGvJHjLaBE6gGQ7zIPrVgMczh/8GsvW9HKQ+SdyyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YuXEC4n2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4530a90fdso11608595ad.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 21:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778129814; x=1778734614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ywGKeEnvYSXg9nFtEwvQO+tPBvZeysG1x+jeuWr74M=;
        b=YuXEC4n2j/YC/FDWb1MnCm5jw5m8SWEph75T98+uJ78doNVh/NvUMfkFam3iASR7ln
         nAStUfAE8g3crn+GEh729SXoR205s9m0+736w/clEbcwyi9YtYH+Zz2Nz2ke5aUZOq8i
         2agp3iad1RSngpOuFc9VIWiWq7VERLj/AjxK1cRkLtehUXKHfElvp869UFzXRGSFr6tp
         F5DqtxMDcyDx6poe6ApzePMc1tBHkNvX7QoVPzWeWQY51oPeyZcYRPpCuOvIX6mdTmus
         RNGteCE7C8Wfh87/3QrWLmcDpYwOe52/UFGUO8vTjyhrQnrQTz0NJ2YXsL0ksB8PclKH
         4hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778129814; x=1778734614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ywGKeEnvYSXg9nFtEwvQO+tPBvZeysG1x+jeuWr74M=;
        b=GoT1A7CMqGen/TOAjeOelfLMz1U9R7475CDawUhUKq8IkkV4QlWcxVl0XxcadtkwRj
         9vZQ18DMx4y5H2V5RPJdP4E0QwITON5w3UNox6LtEsT/9J3dSf+LtA/TAP/ppTcMPxRf
         amydZIZrZasYrsj7I1K++aLsNSmCrYKSd4E7wTaQPpCMZ5VM5uAHr4+py2i4U4r5L1OM
         Ftt6fcVcfkyXAdO4YwvfDP2H+u+OZA/lixOatETp1INVIwoFYxa67HAIN2idd3yaZ3qe
         JrKVLxYIR+eym3deaiXA/pKDOxT3j4bUNBlfPdUEDTn1XveRBBmx4uw05GuhDX0EA/VT
         4jeQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dx5pGxjNqJWgYvnz5y1/RcQTgniFU2ud50VCMaMipPkrP0YBbi0si0tr/BHPc0oAN/cwHo+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhy+C2m35Mb0o5kUl/aC48KpE3R2CD9lBdnCMuBL3IMiikZGy+
	l/xi1xL47/3UathfJsvv+2vTM09NgMiL9m3BcWO5RXieJSi4KvjkiQzeHKNPBpNJ7U+hbQNMoRI
	0PgKvZLfFfoUJ189eiJAmpm90zQ==
X-Received: from plot2.prod.google.com ([2002:a17:902:8c82:b0:2b2:50b1:327c])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1ad0:b0:2b0:a980:3687 with SMTP id d9443c01a7336-2ba79291460mr70680015ad.3.1778129813774;
 Wed, 06 May 2026 21:56:53 -0700 (PDT)
Date: Thu,  7 May 2026 04:56:52 +0000
In-Reply-To: <20260421104652.211276-2-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421104652.211276-2-joonwonkang@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260507045652.2296187-1-joonwonkang@google.com>
Subject: Re: [PATCH v4] mailbox: Make mbox_send_message() return error code
 when tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com, sudeep.holla@kernel.org
Cc: dianders@chromium.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, joonwonkang@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 473A44E2F4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244507-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> When the mailbox controller failed transmitting message, the error code
> was only passed to the client's tx done handler and not to
> mbox_send_message() in blocking mode. For this reason, the function could
> return a false success. This commit resolves the issue by introducing the
> tx status and checking it before mbox_send_message() returns.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Joonwon Kang <joonwonkang@google.com>

Hi reviewers,

Could you help to review this patch? Since this attempt has been open since
June-2025, it will be appreciated if you provide any other reviewers who can
help review if you are not available.

Thanks,
Joonwon Kang

