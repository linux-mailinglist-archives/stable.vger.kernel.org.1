Return-Path: <stable+bounces-259495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AT4MolcHWoBZwkAu9opvQ
	(envelope-from <stable+bounces-259495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 12:18:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F55661D359
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 12:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67C6530E4B8C
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9EE3A875F;
	Mon,  1 Jun 2026 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSiUw/7F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5639EF14
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307812; cv=none; b=J/vVs5/tb4hNxfaWgmJq2Nb6ObLBvJA2p8WwAL2Zhh1t3PyvbfGnW5IdDoto0xbfSs4qJD/EVsgeh+7DpBMLI1T3KMT0A39oCNYZgxABINW4ZI/pxsXwJU+sWxzoY8Mua5ISB+AEY70MAM/Dnu/o4M5PKmE1Own6lXv5+BU4J0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307812; c=relaxed/simple;
	bh=oTyuv/4q8lfTEk2MTKANVi4deoOAEf8o5emx4pw77kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alrsQBTFWjKAK19qbTkmYBGJy0uQze+hFiOSUb38IHcf8k+4Xo8IF+2eevmLtzaUtvA74Yk/H7IBLdvgjpzjagW6alkn1BijFax0Qv4nuk2UaKkeYKkOzcbVlBKhB7Gyuhc5nirWxjSjXD4IGeYyRcTOl+FcU7Aqxk6/jjUOz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSiUw/7F; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c379e8ffso7776905ad.3
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780307803; x=1780912603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTyuv/4q8lfTEk2MTKANVi4deoOAEf8o5emx4pw77kM=;
        b=BSiUw/7Fk3WHa0LGaHe9B8pASuTyDGRPQt51lsLMgL9A3IyNQc+L1Y2U25nhQ+fNMf
         gAWJMCkxK63AElqZ8EUZYqC9arhMMGTGNPu1RkYgYj0RxWw+SjtfWoXKDlgCOC33a8JF
         pUCBHTaEUOE/5j+laAI+myPJ4EDfzMDvoj5RnPVA47Z9S8dqROsOthSrGnJQQqYlsG/y
         IlIH/MKPXOZ9SXg34arUEIdqgTHTBtIgRQn9fmm/8YUB5hB6RWXh8Xf6z6jjBWmCVbKT
         kBu8m7WD/CPec+UM9Z2Fui4W90zqXqlLo9PhjUWRwVAHEl4lUUZrVIcVVY4fnxffp/oz
         pY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307803; x=1780912603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTyuv/4q8lfTEk2MTKANVi4deoOAEf8o5emx4pw77kM=;
        b=SbU7ew1EzgsuG2fDIGyzL9NaZnRdi/qDbZDLXIAu11sCToVPDbKGYzGXyKjPH3NUCe
         x3xxz1MB7C76OBZj5ohLbU4S4S3a8l5d1rhTE1thBEYLFvn1pgIQERDijZnLZuxhvqLh
         Qml1/l17gh/+D749BvO1B+YOu9ZSstsIHZrw3aEmp4Xw95fLvc45zy06TWlq04WB09Tg
         HJV/EGXuAMbN60pkWeQCTjkwCLJv397FhMOcJtjOTVcUl/jiiU1twdDs7Yd3ViKSn78w
         kNbe1VKYaSNDpGkrZK6DNEb5W6yELo3FH1BtLLjVyhOq7nuTOZ8uJHu1hM61pablXotO
         DxHg==
X-Forwarded-Encrypted: i=1; AFNElJ9vrXme2xeA7i9DBPZood/X7liVegn04x0knEbqFNFGvZGEtcq2J7OwfI94IsbTbafqsS0y7Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrb19yEpXcxZ8fUKQvARok47G9VtYzQv9iv5rpPdmrTjx3gdx
	CaPfsIZ9i4NJMHBukdN8M9uQ5DUQAekX4W9aOlbr7yrXZiD98LBaQGg=
X-Gm-Gg: Acq92OFAKVuzPhXS0SlIRRxqTJnAPDq2AGwdKpEpf5pW8D9nwfD5iX4RkLXYRQ9AvCF
	6fAMyy7WdzuKgfxU2sIyrBrJ7MIbCTZKQJ2kdVJrTtBqq9mxAXLLHTtJIVZmvqAqHmZEDwGIDYD
	1MTPtjHgwWT/ciEyvq6Hx0iEG7QmQUXJG0O1zDddT38DjDIkMbWPBZioVXgF2Ea+DJDX/x5XZzB
	v4aE0IMjBEQlePQu0qwOR2SO3L6uALe5vfwPNFmE8IYeqxSQNNe2q8y4OPePv6oHyBrHBKVfnPo
	OduEAG882NdsuK6YUSAA0IhCCb4RDUWO2lIUMOlB3SQvf+a9nOCGKej1byO2Fj2viH9mi2LF31V
	GojEsXpuWTMbW1WdF2dMg7H+c8Jm6t4JWymIo/RbR6mF1koJfTIsAWrjt0g5nFBpEWV9V2i5WBT
	lgGcnrOQAEStv8p0826fJvdmHSfsuVUPNACqxH6k5iGLVbJ402DwYoUV1CxVYvrIv/DpBjx7kVt
	CrJPQ==
X-Received: by 2002:a17:903:4b4c:b0:2bf:2243:d4ee with SMTP id d9443c01a7336-2bf368021a9mr119460275ad.18.1780307802630;
        Mon, 01 Jun 2026 02:56:42 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c4dd4csm102143265ad.78.2026.06.01.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:56:42 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: pabeni@redhat.com
Cc: sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Date: Mon,  1 Jun 2026 09:56:46 +0000
Message-ID: <20260601095646.180085-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
References: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259495-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7F55661D359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 9:26 AM Paolo Abeni wrote:
> I'm wondering if sk_acceptq_removed() should be bounded in
> vsock_remove_pending() ? (even if that change would probably be
> net-next material).

Agreed, that would prevent this class of bug entirely. Happy to prepare
a follow-up patch for net-next once this fix lands, if that would be
useful.

Raf

