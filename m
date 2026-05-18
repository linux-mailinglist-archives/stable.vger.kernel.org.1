Return-Path: <stable+bounces-249410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGoyCdGnC2oGKwUAu9opvQ
	(envelope-from <stable+bounces-249410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:59:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EFA5754D1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2946730118D1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 23:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736D33B6DC;
	Mon, 18 May 2026 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ciah3Nw2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3862633554F
	for <stable@vger.kernel.org>; Mon, 18 May 2026 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148267; cv=none; b=Ab65qmf7Gx9eOrOZmjiDSXEbZVMgxLopDpTgX8hsL/9yM38zqimeGsDQ/b1jK+Gs+r+pRobZQQggZuJYQKcBpOkV1NRQXCFX+WSRqhFtJVeCfqc7iYrrIoDHzuf7TTKqVL0x7oC3N/6o3g6OLp26z1Zogg4CI3vuK9UNLRIbtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148267; c=relaxed/simple;
	bh=oHzqtxHYGtsFWWs1IIVZkaaC0dsURSMDJdI1EptB08Q=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hqxKn9hiZ5q9WW1LnNy70ifFGPqwJoL4uK/ArJnQ4fYUQ/URH0ES8jYaE4maVEx5kqjvFWKK/lnnyrJFSpIlEehfRXH5kiUWVH9BEZKiM+JVV0oaG6lgU9Zj+bgrE+M9l6bVUH6YugSeyfPlGRzTyqGply8q33AnrBVXP6DIbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ciah3Nw2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67f7caa33easo6146323a12.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 16:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779148264; x=1779753064; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHzqtxHYGtsFWWs1IIVZkaaC0dsURSMDJdI1EptB08Q=;
        b=Ciah3Nw2xdOjcg3w3zBcgShZ+S2a32iIm6TT/7UCDctORSU9A1oFXCLWRiPVu7quwL
         DQnONi/AmCqEf6+i3vfQVAadZsVyW9ulr3FTd3S74EqkIjpUBusmdF7UgMvolLQkW8x3
         FocarObjL7BAof4v287V0tRUiwwKcINFa8q4XgigacbMAoConEBa1vWOkqvtqW7I9lgc
         o1vX/Yi6HtPvE0VmbAl1dgWidsAsmzUSEiyt4Q6Zo1z4fclvpclhGOvK94QOf6C5R4GV
         KFRKKrsfff8gsFRixT5X4B9Fa5+Z5eWztsygea3fKVV2FRFIeThYkwwAqFaJFTWV6fGo
         Ay+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779148264; x=1779753064;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oHzqtxHYGtsFWWs1IIVZkaaC0dsURSMDJdI1EptB08Q=;
        b=M0bB2lOhzxMroS+Q5YmjckLNw1dos6agzoL0C72r3BEiQWpBswVPYzAX1LGQTuB6/x
         vpACNZfw2jl1xzHwDJdm/bRqqGe12EeFUvNLRbn8UCG7FhkMyOu5tq1nuE8owWCt6QaU
         wd6JC7iiHBuVGnF9v0/GpJ32uXcYIAPsINIlvlyRNqWXuRtq3df70EyDGYYa09mW0pYo
         o6laZmXosxRR8oKyT6x5iTCcPlRL2+iA03oGh1q925EN6T5seWaFVRVkFGe0D21JOXKd
         cYmkKBsf0uz01C3yfmTtYm8FNP+kcmDq1ANoVJa0dGi9sZzfdnBMxlvD4G95DnJlHo4B
         px8A==
X-Forwarded-Encrypted: i=1; AFNElJ+C8XsxQu8MqyIkIshMQo4YkbUUnsRedgEr+P1CRYfhaw08KBM8oJBrpT2WgF3GbqbxQi8NenQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1lgQHgHp1WhdRxg2msqKuqvdondEU2uQEBIEZHcU1Lr4/xheQ
	Txk64O5D7G/0odQ2Owd46jjeSp+8WgdAXCK/sUzwq8I+T9jKZ9OzJhHV
X-Gm-Gg: Acq92OFFCv4iqotrDSJO0VwRZ0uBnZ+F2Nm4BydEpf366ZxqogKyaHGyhrGL85vpv5s
	kdzXB7wPFfelj/YWPd+Uy/CAu9e9xl8w/bC1HiKS5+S18X0dKNKTAvIWXMw/O8kvNwQoBPS4buA
	tR5kHNNLbCrTBvGIaofyr2Br/h9NO6eje4Tdjwd0X70a5RFWMxIXRZRBr48Y7vUhpGSZBvI0ytr
	qBIuVY5CHZpFMvRe5uQPU5hP3xLotWVXW4/vMX3undRwkeCB6AEncJMopi8BFELjqjau8HZCR3t
	cp1j9yxHy1WsrG5Px31ZpxTQISqSq4rXDD1Cfx3Fyj+cDIV5VOcYvQPXuo6wKZtcoy+SdIkOs/S
	9+ojyh1Uv/JUtXHwMqIn4+M4/nVyrFKqzn1fUsx2CQA2Y/88oIO7e8wq1exRfDjvpGablInUiL5
	LzVr7M49jYtyB22ZlZ+yNCnNqQHBDXWNg00a6czQOFCx5VZJorYOF3W016wuIg7NNBgEWYlxJHh
	TufZv2AGgFYKdiCX+3DfrmCf3A319bXqHYdftlCvTwk1ORGNWEuGbFAJka/XMr6EruPmLChLjIg
	M1d3da1kg9kTCp6jzBBnkCIKv3Vs
X-Received: by 2002:a05:6402:46d6:b0:678:b2c5:6915 with SMTP id 4fb4d7f45d1cf-683bd38be0dmr8809786a12.22.1779148264415;
        Mon, 18 May 2026 16:51:04 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d58c79sm5829140a12.12.2026.05.18.16.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 16:51:02 -0700 (PDT)
Message-ID: <6a0ba5e6.cd541789.157749.6e89@mx.google.com>
Date: Mon, 18 May 2026 16:51:02 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: ddiss@suse.de
Cc: martin.petersen@oracle.com, bvanassche@acm.org,
 target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stable@vger.kernel.org, hossu.alexandru@gmail.com
Subject:
 Re: [PATCH] scsi: target: iscsi: validate CHAP_R length before base64 decode
In-Reply-To: <20260518121811.385350-1-hossu.alexandru@gmail.com>
References: <20260518121811.385350-1-hossu.alexandru@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,acm.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249410-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mx.google.com:mid,suse.de:email]
X-Rspamd-Queue-Id: 27EFA5754D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 19, 2026, David Disseldorp <ddiss@suse.de> wrote:
> nit: this could be DIV_ROUND_UP(chap->digest_size * 4, 3) to match
> base64.h BASE64_CHARS(), right?

Yes, equivalent and will use it in v2.

> The above check doesn't appear to catch undersize base64 CHAP responses,
> unlike the hex path. How does that affect the handshake?

An undersize response decodes to fewer than digest_size bytes.
chap_base64_decode() returns cp - dst, which is less than digest_size,
so the existing != digest_size check at line 345 fires and the handshake
fails. The result is the same as the hex path.

> Finally, don't we need a similar check for the mutual CHAP code-path?

The mutual path decodes CHAP_C into initiatorchg_binhex, allocated as
kzalloc(CHAP_CHALLENGE_STR_LEN) = kzalloc(4096). extract_param() caps
the input at CHAP_CHALLENGE_STR_LEN characters, so at most 4095 base64
chars reach the decoder, producing at most 3071 decoded bytes. 3071 < 4096,
so the destination cannot overflow. The post-decode > 1024 check is a
semantic limit on challenge size, not a safety net against overflow.

v2 with DIV_ROUND_UP below.

Alexandru

