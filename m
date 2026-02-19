Return-Path: <stable+bounces-217498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICSxN7Rkl2n/xgIAu9opvQ
	(envelope-from <stable+bounces-217498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 20:29:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E3A16204D
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 20:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B59430252AA
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 19:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735453064BA;
	Thu, 19 Feb 2026 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKULjE3g"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E83064A0
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529392; cv=none; b=FXlqrDlO+DTj6oc0Yp+FO5s7vQACLnfXRDadrUWwPM3ew1cCTUk6seZhQf1lsvmS7SM2I/rcvjHfRDpAN6a9H8bJG8IJBdB3IcPOZYnG4TJs11cYW/dnM3UM/UZz2J+lKIaw5puSqh8OH5akDJILM4WiIXU3hhJdX48zCf+pBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529392; c=relaxed/simple;
	bh=3ieBlftHzrAmEQE0UIaRFemFrvx/oX8TACsV8ScLpTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9SOD3WC72FVwEI+cjKw3OB4+fyXjPumyBWQ9c4dOmUldIxss4YEuRgomYf8dIrYniB4DgJDHUERE/DNLy5annJv6nXEfcH2+RmZkQMpXqmZ1LQPM31ALDrPV27QY2Fkrzwibj9N9Su098bszhDEwhbK8RAAPN/4e5MkAZzzgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKULjE3g; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124afd03fd1so1846172c88.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 11:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771529390; x=1772134190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jNeuVdlDJzTVy0ArtyM66yG3UX1VA/OEWqHiks8coo=;
        b=QKULjE3gD8M7CUDqGURtaKcvnd/+/bw5s//Yx3tO+RK0Y5Asumn8bmiMEtTN4YAUIh
         JKe5HNI0mYAM2/hEmwmZ8Gi0V24zE9dsLEmvvI5ICX34QwO2hKQ6PF07sKYn8RKI2PJ9
         1ZvPbOFfcAT+VP7nhFCfMYkwx8YJyld1uajRSOMH3d2FklyGrD+/f7j7K9GwXCGV8hsJ
         930gpyovp8Pvoxx9c7qcPG+40S5G7pCyIOlOeMSbetTK8afq3PaLGfuXcnFJ3TfhzNlC
         yGx7P3j9b0lQmytNHvMGa9mBuoPDKFICBYQl0ON/Gcnfn+ezAic1N3PXQa91UwFltg8O
         TYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771529390; x=1772134190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7jNeuVdlDJzTVy0ArtyM66yG3UX1VA/OEWqHiks8coo=;
        b=PR9B5LNs8VS7lFqMOMitJBlmv7oqqILbef3G/y+LFu4OXmygSc6f+2i/CsaCm/JgAF
         1RgWG0KnRXsi4lxgALOgGOFqkqZmNCS1H0v4QilBGQKnpdMW1RrRkov6555eqpZKVKGq
         6BV2K3N3liUQUD4wZU5lBBxHjUkZzKZHD9SLU4HKTDhNN3aE9Ei2hjZI3D/bSlPe+x6n
         JL14BY2626crLgTh2rytNz9ER01XekoIDMI7pFojclXM3TQ5kUkETQWNY8TtlQqDHlAC
         1wgUpIaUhROegOUejseSQzncepHFwVwbZzuYjMXjCojgqD/JjxDagKiDQNmcC0ePK/xh
         JMsw==
X-Forwarded-Encrypted: i=1; AJvYcCWlvpnX8XftkWuz6Z/2xyYpM5r0/oc/JXEAPir8GGAk86MjdRFSwa8XPaeZSiyQuJsg+qb50mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtr9cF7WOtMd1HqcfTHli1khGYQ759FcpkKjUnsNGd5oq8FeJZ
	ST5Cg43NeZbxmjLxFrHm6lughGrdQ4yiAFIMiNXRYcby+XnIs32rDfel
X-Gm-Gg: AZuq6aKuiNRtvbkbDS5U/WXgxoaas8lzrfZ4ebA4w3YEcq9HpTr9p6tssKglZJsU14s
	7g80DPAXpgac2FDIvhvA/CzheXvw6YeK0YXpWO4MP30ebAIvNwDE9X7cD2+wK3nwT5XpsORDCdf
	6ncvtrTt4eKsUx3HlT8gYNUOlQHIZrkleR3qms2Ouhwp6lXpQGdbBSRs170lk+BFiAXIArM74yz
	p5Lb7UAzbzlII0oy9Xy2c0NGCRUcMELdfwr67gpQ9KoWd2NMURwv5KSPCmyz22fkv1FINyjfiBJ
	CcfAgPEDqJdQ4nXNKE7IjaNpdXVMSz3uiBEFZsVaZh4Inz+r6KceLPAQjB8yrj4pH0SNxRNj9gi
	CV1/VrGtJK7dowI7ExQFYAWdgtmxOTmllhNp1REnvE3JR0LTvP5aS2oWZ/1ofPCLi2uSGUKdaR1
	eNiuRou2JwVPHPaTzzL+3h83xSs7lXkP8/LMDUZKRaVxigC67UCWENWJ2Gs+9TQnlZ2eKbtjvlu
	YSChSQDncd/bRFC
X-Received: by 2002:a05:7300:fd11:b0:2ba:871f:796d with SMTP id 5a478bee46e88-2bac97cad2fmr7938895eec.30.1771529390130;
        Thu, 19 Feb 2026 11:29:50 -0800 (PST)
Received: from kernel.. ([2804:4ae8:bde0:7200:a049:56ec:8543:a3cb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb67bc16sm22163368eec.32.2026.02.19.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:29:49 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: insidetf2@gmail.com,
	luiz.dentz@gmail.com,
	me@celes.in
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
Date: Thu, 19 Feb 2026 16:29:33 -0300
Message-ID: <20260219192933.805883-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADbaWgF53sPZbR3uahemgZVYv8rENT7-hYBCh5X5prvd3kPo3w@mail.gmail.com>
References: <CADbaWgF53sPZbR3uahemgZVYv8rENT7-hYBCh5X5prvd3kPo3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-217498-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,celes.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[maiquelpaiva@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37E3A16204D
X-Rspamd-Action: no action

Hello Daniel and Luiz,

Daniel, thank you for the detailed analysis of the lock.
Once again, I made the mistake of analyzing the function in isolation.

In fact, I used `hdev->lock` in v4 of this series,
but I changed it to `mgmt_pending_lock` (and `guard(mutex)`)
specifically because it was suggested during a v4 review
to align with other list protections in that file.

But your analysis makes it clear that the primary device lock
already serializes this path.

Luiz, I fully agree with removing/reverting `003ca042a386` as well.
The list operations are already secure, thank you both for noticing this.

I consider this whole discussion a great learning experience on how to
track complete call paths and lock routes before introducing new locks!

Thanks, 
Maiquel Paiva

