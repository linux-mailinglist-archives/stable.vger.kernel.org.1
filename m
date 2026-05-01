Return-Path: <stable+bounces-242471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNU0DHvc9GmfFQIAu9opvQ
	(envelope-from <stable+bounces-242471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 19:01:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C39664AE437
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 19:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 370DD3004625
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03BD3FAE0A;
	Fri,  1 May 2026 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzzsJh/s"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30BF3F1658
	for <stable@vger.kernel.org>; Fri,  1 May 2026 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654904; cv=none; b=TBTg1CL7HSZWgF4GtnsCa3V2nFeoPeLZhGVvCPp/O3B6ac29VBRoptZGDSf4Ve1WcZ+7HS8mSiMYBtLQI2s0g0gp8QGFtvMR+nTFCaAPU0xihOJihyNaXjpUQWnrzRv1HAPeHQ/kzwOKyE4Dyskt5FU49LE7JnwcxiMgpg8mfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654904; c=relaxed/simple;
	bh=064idbmQIFqz04QrVYQYZzDXbFXPCliJXULxXIEQVro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWlBiIflk+v7YBycTzLehMk/+VNx32ZwBbqiE3vvD12pS9VyHCaE2iH1ylo/iBwGGaigqsuoqg/syoQbFlbPlSqW9nDiQxjoqOY3p8G/7IQsvgUa5PICUDwkyrh8sA1kSGSj7rEnc2dGYIzF3nWporxugfJkc7udMfWWooIH5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzzsJh/s; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a40b2d26a1so1793609e87.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777654900; x=1778259700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=064idbmQIFqz04QrVYQYZzDXbFXPCliJXULxXIEQVro=;
        b=KzzsJh/scavAcz1GG6L1MY9xnAutWZAsGaBCQloYXkgMw600fcaUVbhU+4wTFX2r1e
         5Li2vyl+yW9/VKqyjnbNES6diU55RKPG8xta7nUdQFfBTBLrWN2/yY/lcMob0OYfkzO1
         bAqdWcn6XQd8zzdgQ4sEwulTrrZ1de0Ro2uR4qNUwQvEQRVG9I5HHolrVyfFFQ5/ISov
         yXBNvfH9y3Td26QW3Zs/CR/qATpl8FSWUhh4jp8c7rMH0wYJNr9+FaAeax/85OGTUaYx
         e6fDXiDq+/PZ+/dsSaOPtzCBrWEyASXwNec6y2GkN63e9XZy+khlByV3oJx5UDl/48EH
         pesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654900; x=1778259700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=064idbmQIFqz04QrVYQYZzDXbFXPCliJXULxXIEQVro=;
        b=beuh3fKhVgLZji+BMaNUoUD4IDyKk+iEE9LINo1qp+zCurWzaO4ZVHTj4JpeTq1jbH
         oMWRzp9MrB8Atq5V7JPSmXtYyH4yzgresQzKXjDtmbYG2i1TK2JBb6Y/g6ItM/bzJaYl
         wrZ2jLM+HUh0fki63cb5yLYU2qOGTGbAl/r2ThS5jO0QAzwA/gGLRK7XZ0oLZ+q4AC7i
         B00Pyd3fV5T2quJavhngbCxZGKF27GAFe3cjTjaI72UvtpNQK0T45JY7gVQbFx0TE1Xz
         GuiEzujbXAn6Ez3TwCnSoVKB9kU6YdPqU/aTDRN03f2QlYWbzgZWd51aU7XdZ0N/rEvu
         Hm2A==
X-Forwarded-Encrypted: i=1; AFNElJ/gVlTZSkNWLqIcffNX1pa2XAqPa5e8Jsr7MPEPTIYb9BlQbIbDqxlEhWAYhz5ji8F+PWy++zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1yQeQ8Bs1fXfm7MzLNdqek95YJwFnZKBAqdrrDtkrlgym01M
	S2xwaP/fx7lRqZNO9UdBtihn5vlsJHioFXh7ln9qm1AbngPmbuA4AZmY
X-Gm-Gg: AeBDietkZQ1/UrdDFv0pVj3r7FFELRyF7iX0PE6VGAtlWTrKjC2HEcYzYdFFTOewmOt
	o2MiFmGdEglqEsjhLbhMJa4kzM8YtcEXToDi9rcTn5MI0ljLxOH+n4eIN98KIAVTF4334kllPln
	crU9+cj/QCodmE1SNZYm5K+lNC5y6VSS6oNMBDSpw8Ll/e8lp101uIvTRmdmcKpELjhQwLa9Ian
	sAf4Am/aTG80FAZ8UVTZk8IQfh1teaphvRmFk7R1zujHW8HgQpZKK6z6y9omC9kOG4OTrIwmA6b
	BxJQo3rklncy3B99ZUnEcEp07/P59qP+gaLfiU4hV51JYv3xwDIWismkN7pxVdN7LE6KeJTpasx
	Rfkh34Yvo0UvAH5V4LeJZFMPg0vZgZiBCU1dZKBCHAUZBcmgd69ytKZRzZs5/VjYJiUwvk3Fo8L
	1N4JRZRe3LlZuq+eoCn/mUXCte4T2b315Oe92Si3g75PCe3/F7Rt/4OQmsUwNlyuHMLKBTbFw=
X-Received: by 2002:a05:6512:3d94:b0:5a4:1904:711c with SMTP id 2adb3069b0e04-5a8522e3765mr3276021e87.29.1777654899294;
        Fri, 01 May 2026 10:01:39 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c2330easm632749e87.37.2026.05.01.10.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:01:38 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: matttbe@kernel.org
Cc: martineau@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	fw@strlen.de
Subject: Re: [PATCH] selftests: mptcp: add test for IPv6 subflow SLAB placement
Date: Fri,  1 May 2026 20:01:36 +0300
Message-ID: <20260501-reply-mptcp-v6-initcall@vebohr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <44e564f8-d059-407b-8f5e-a149dd76dea3@kernel.org>
References: <20260501151454.211598-1-vebohr@gmail.com> <44e564f8-d059-407b-8f5e-a149dd76dea3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C39664AE437
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242471-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi Matt,

Thanks for the review (and for cc'ing Florian - same mistake twice, noted).

You're right on both. The 755 thing is on me, and i'm convinced the
standalone script is too much for what's essentially a one-time init
ordering issue - the fix commit is the safety net here.

Withdrawing the patch.

One question if you don't mind: if something similar came up again and
a test *was* warranted, which existing script would be the natural
home? mptcp_join.sh seemed closest since it exercises the accept path,
but i'm not sure if checking /proc/slabinfo fits there or if there's a
better mechanism for that kind of thing.

Vastargazing

