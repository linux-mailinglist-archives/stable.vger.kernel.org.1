Return-Path: <stable+bounces-237892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CYVJHpP3mndqAkAu9opvQ
	(envelope-from <stable+bounces-237892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:30:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD37B3FB3C6
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C574B3034DA5
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBCE3E8C71;
	Tue, 14 Apr 2026 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3np930U"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D9D3E8C67
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176915; cv=none; b=sQyD1ns9y5rIFgUU2fp0qpA1jLFd1n/wfVvZUFMX2fmQ5RODwyj7lrNB4VlqQRDHw2GmKjNoEsOpPJdbLvA5mThLqoOS3ToZbPlDXXFOXrY9Qho9LS6+iJDEdt0DwvT1D5Fp0YgBqOqIMWQJRZzQtcfHgJhS5ImP97KItYt+xT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176915; c=relaxed/simple;
	bh=U4pdr2GkpIWC2vNkg+yEuCLsbuNCTohVBAVAKaDkhlE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=DUrMYa73Bt+n/cQHPzQb/JP7+Kr2pQTpCmOXaAeBc/+6yc4tVsWJP1tXpesVUIpJJ2czJl4oxVq2S1LelB2rCSvx6uLKFyla7L7aJ5hZr9Bk5/PHoOTknhDmKwYrJ0bHWeZIFzxfkkCQ+JMT1WOl3y/SGwHJsTnM0DurN8MbL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3np930U; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-671fe205535so952135a12.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776176913; x=1776781713; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AmVhBhekni6akTViq7AtyVCpriJ3PfrjTpRNvwMcVvA=;
        b=K3np930UZzDo5kYlg7PQvQTwHNfLhn80375amyGWgjR6x3mSqCPYDNz5z6JFFzoJs6
         uRKLkW/OL2yUg1YUIdHuVSqRo/xSloXlH3eyo8vNWiFinJvTyRMCU5XyNY9LpksxslQv
         kA/DN6lTaaBKKF1oAYUqFoyN6BywzGJFnh2xPV/8tSsNJ79i31LdR+HGyTOyyxPr/ERo
         jYix7ICF0Q3c7hP4tpL4xni18iS47/NKRPr0C3MKU5A2Pc76jLPGMAetqA9H1JXwJcWB
         L5WA7GQXeeB9g4KAoTq/gXqwsRq5DJvfR4hpUcYgBhSTzOA7jn0xm5HCmeHglMIQNZ1c
         XHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176913; x=1776781713;
        h=references:in-reply-to:subject:cc:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmVhBhekni6akTViq7AtyVCpriJ3PfrjTpRNvwMcVvA=;
        b=qTTZDHWzBUpKZBFhEiUgDkJV2s66kP92bzmLZPHvqMrP9nWgigrAW/Lk4Z7h5DIHJa
         Drgko6PuU8IPdGrAEdkl+D2Qqor/+alZx+d+vyA7hLzEJCVvgPP1FHFgjT41O8gdGT5J
         dzmyXmpHsEItfTqye3HBHucENphO056FI76FHXnu5IKKwxpr83IYQMrh/x7dsjyOt1X6
         MxEmp4GlSyIXh87PkTc+n9cfRa7YsPp2z7wCnRCyii81SOxnTVJ5Fo+v2rQ2vwY0kqZ9
         0JH+KCdCZLLClIdRirus+sEjsSBHm+HDOhy6xab0xcJZ8FXXweT3E2UAJY+5iHsvmJLt
         yxtg==
X-Forwarded-Encrypted: i=1; AFNElJ9a+VX0b2ZZZppGziqnclPV+OEDjmya2JgqSmYpBgvIPpbvy8vubXmvkfKCbw60gBFWLvV990I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7oHRryVzjsiNY6IYhua9uAOURu7Oi2fhY7iXgcMLHiYfA3K4
	1wLqCgKs0X72+aAz1YcVC8KznQ/3FhCL8E7dLaIx9iaaaJnJFsdXsv8t
X-Gm-Gg: AeBDietyDFePUYALXorJ5sY8XJX7mgJFttPD3wXStozvVFBuZj9aO+h9g//qyMfHhS2
	KquJlEWep17t6bZTX5WfezegIvX1qlwY35cb65BKv75fD+yDPK4Mxi/NdCtZvtmNhEi+0lRRIpZ
	qfxZfntTr46qFC5Z7Hv9xGpvb7smtCctIHa8wENKTxqTs6uasKitWITlYpZG5hExkzb8JkUjBNK
	dn1UcWNXTYUF9gwv9IaQ3B3oRIlskxWNQ7ikJInzGPdyBH2Zwx0PxJ2sir35GLWXB0PnHT+Z1TQ
	RByQ5FAVxy4e25MUkjc7PJN8Fv/Fs9vRxd2d+B5eEjqjnLnAebpDtPJZA25oaIizv42gF2VgOBj
	KObc2fMIVGs0ja1XcrsrXLly33DhkF/l9IQJgbVbXWNCgwXbNzztvH2H7WYyc81NUCbdtMJ11ht
	oLpmSsMfnd0zw1sHEkgE7O7OEV94HzqsW95syLfFd+GWpyYlnDX+tOSGMTyO941rTB8LbeULnw7
	uYjnaI5z7NIOO4ue4TySFzJvr8mY+MC2TIBeTqsws3bgdu8+M9JAOYlwxLsTw==
X-Received: by 2002:a05:6402:4548:b0:66e:2f86:ab1b with SMTP id 4fb4d7f45d1cf-6707903f71fmr6647756a12.8.1776176912385;
        Tue, 14 Apr 2026 07:28:32 -0700 (PDT)
Received: from ahossu.localdomain ([145.94.221.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67205b178f9sm278929a12.29.2026.04.14.07.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:28:31 -0700 (PDT)
Message-ID: <69de4f0f.a70a0220.22ada8.489a@mx.google.com>
Date: Tue, 14 Apr 2026 07:28:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1904756288140883639=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, hansg@kernel.org, stable@vger.kernel.org, hossu.alexandru@gmail.com
Subject: Re: [PATCH] staging: rtl8723bs: fix frame length underflow in OnAuthClient
In-Reply-To: <20260414100804.871764-1-hossu.alexandru@gmail.com>
References: <20260413202824.740653-1-hossu.alexandru@gmail.com> <20260414100804.871764-1-hossu.alexandru@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-237892-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mx.google.com:mid]
X-Rspamd-Queue-Id: BD37B3FB3C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============1904756288140883639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, Apr 14, 2026 at 03:02:00PM +0000, Dan Carpenter wrote:
> Do we know for sure that this is within bounds?  And there is earlier
> code which pokes in pframe as well.  This code is quite complicated.

You're right, I missed that. get_da(pframe) at the top of the function
already accesses pframe+4..+9, and GetPrivacy() reads the FC field,
both without any length check. I'll add an early check against
WLAN_HDR_A3_LEN before any pframe access and send a v2.

Thanks,
Alexandru

--===============1904756288140883639==--

