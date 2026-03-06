Return-Path: <stable+bounces-223376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO58I6IUq2lzZwEAu9opvQ
	(envelope-from <stable+bounces-223376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 18:53:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC2226772
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB461300A63A
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BE36D514;
	Fri,  6 Mar 2026 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyEXxgFL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420035E94A
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819615; cv=none; b=mDJANbn6XiA+OJsumz0h+35K3LKv8U42YjpQrMscJezEVC+WFBY3uAiRN3OE14mRlnDNXs9jDBVNhXIPmQ5CmQeR+kLrYwzGhwFiHVIsttib2fI/nt4sXiJQNU1f66LH15dM0woC1yzM9q2pzVEJtFnzAvSr9zRAf0g/hLi3PGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819615; c=relaxed/simple;
	bh=KP67p1NSYqM6ZCSNa4TuYu4+6IIAoh022RAVK5yTzZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmvfWcpb43PrMduh4Atg+1F0QVZ209Jep55xqmggGyFP4ulpJeQ1M8q0tOSs/EVZIAiHVIWRQ6500M7B4YzzFqFYniOCxjwunql1Iy18gNh3osBkXqZgF0iB2/w53CVKlPPSCSheahjXky1A/K9c0Dt3FDzJaTtEqAvyneiWnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyEXxgFL; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50698970941so114821211cf.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 09:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772819613; x=1773424413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KP67p1NSYqM6ZCSNa4TuYu4+6IIAoh022RAVK5yTzZ8=;
        b=OyEXxgFL0zLoeIg3ERqlNkQyDysyQ47BVV/RhUIWQsaQ0SFwAxX7GvdMZgustrFxnL
         L/7OXtrlrjYzF1dtjMQTBAx/76mGr+MrrYST1WAZdzIK7eIVEdhdTK46ISyypL3b1/9b
         feYspMl1qhCjEcsEV9x95aNTP4vX+h85MJHqrnCjB9eBo/v4vTgVZLWk0wW+RZ1N7gjH
         mtSK9hQkTinPO6Gy0vKj/l4Z1c2cQ8/G5kTZXEh7fVbijQ2yLSqgdlmxFXcaYx9i/TNZ
         Sw6S6AgdXleiO+mNiQPhZf81UOSexU/6jOtaXRY0nayQF068DZbSXlMtnMSkmkmyjfom
         Fx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772819613; x=1773424413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KP67p1NSYqM6ZCSNa4TuYu4+6IIAoh022RAVK5yTzZ8=;
        b=jqwmmJZf7g559z4jn9gF+4IoR2VV3/sRcE8YEJ+V2XVytp2c+2Lkh7FzH1nijZ4dQC
         5+d2pshipI4K5VzfsGZAimQu4kxkOXqYlTTmNY5kaW65oZoOfpymTwlEYrtcLI4tNc+5
         1g1cOVq1iXk0Qt2wZSYDQ75tln2xwXC4bgjQ9nEBt6lvWx1ZaaVnxI+qt5n11wTEZovr
         HpfOivMGV/L7GYaDGRvljzLRh2p4IAT64NX8Xdm5NMgpJnACx3gHxhzqhZQb3tN34Inn
         ovAb4pLDFC7D0SMcqIe5ECmwPTg0GmxenuZGXwpfDsqes9Ag82dihrmpJyxW/iZXjSsX
         BbAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL/NhQSylMu8ZoAoV9YpD5sPPyZIF8R0oS44XfNGcCap/Gr3R5gAj4p84GQHWkQBL+Osl+Q8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2taT6e8mEF7b3C0Yef2U5pLMoDrY7e4lzOQ19TqXd7L2uWKs
	A+bv7NV0kBLJi+qP3exlwuCoxbbc5AXSsQkl2BYCMo/NVA0beRfppUhB8nq/zHzK
X-Gm-Gg: ATEYQzyyWHQMTV4dLl5NtfF+nJ0SAVahbbMb0f1oPioVlTn8GNXAUxWtVh8a5VkwSPi
	ptjBpnlyPMB3Uel1HTi+4Q7TSbeVaIkAKgOY0d8JPrGRLkRVa35Wb7IO7jnlTxoso+n37V/Q0f+
	GqdOrhE+lAb0q9zQFXP9VQaPrY7RsXc7i0qVewG6Yy7sW1Q9tpa90qd3/Bc4qpSJVCFEpfyFvrx
	6CmIRPYuQiBr7GcERhHUM5vy5PEH80IiY73F3MIxA+5B3nbbMs/TLRlMCDPNUZKEcqqlHCcHT/r
	NFG+o0dpyIANymVKMlJ0LTgnG+p4sqpweX0AysOu1oof/farFs6A28+4jE4EfBQvpiS5t/ywst/
	QFoGxxhOMMU98WOEUl5aqgolWEnfEORI1gDuS47v75QIlKJnw4XRljTSdiZMC0XTqPJy2DkrDM/
	cqRv6cj9TU1wYIeu19NFt9iRvf/SKvA1bJuGyNmqA=
X-Received: by 2002:a05:622a:1914:b0:4ee:1e82:e3f4 with SMTP id d75a77b69052e-508f499f5f0mr40813091cf.64.1772819613021;
        Fri, 06 Mar 2026 09:53:33 -0800 (PST)
Received: from [10.69.74.8] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f66da78asm18026411cf.31.2026.03.06.09.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 09:53:32 -0800 (PST)
Message-ID: <ab537961-2ff3-44b7-aeaa-4df0a86333d7@gmail.com>
Date: Fri, 6 Mar 2026 09:53:16 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y 0/2] Fix incorrect backport of nvme-fc ioerr_work
 cancel_work_sync()
To: Jaskaran Singh <jsingh@cloudlinux.com>, stable@vger.kernel.org,
 james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, "justin.tee@broadcom.com"
 <justin.tee@broadcom.com>
References: <20260223172241.291649-1-jsingh@cloudlinux.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20260223172241.291649-1-jsingh@cloudlinux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DCBC2226772
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223376-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justintee8345@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.858];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Action: no action

For this patch set,

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin


