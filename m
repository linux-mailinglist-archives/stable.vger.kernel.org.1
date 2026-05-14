Return-Path: <stable+bounces-247136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC4LJoKCBWo5XwIAu9opvQ
	(envelope-from <stable+bounces-247136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:06:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110E53F11B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4103301A28A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17E3ACF13;
	Thu, 14 May 2026 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L8rWrR7R"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A53911D5
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745982; cv=none; b=hcCc8JgmYYLzV2SFuai/tfjAUkRgWHH7XygcREAyR0Jo0JVS4bU5m0EcahAr5j0tWit3TFe5t65LvufJVV/qcQTyodFqNIQ5wVh22Ly4dUiwyKh6WfXw/KkLoqBoiiYaRvhFuB2USk/YfrOIwzszUHcRXjx34dJOS+qJvaajbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745982; c=relaxed/simple;
	bh=93eSD/kBmjnUPehl5bOd1PkcsxFoeb+z/4IrjvzFW5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb/Qkjtwh9PD3mlhQQFF6/efp238QAzN5MfYyp5AfevDzxOy85ebGhmWqSef33js99f0FrYWX8R9+PHL5R9FVJ2FeBXfw51tRJ3zifskdO066PRyfJBj4fziOEhh/mm0KZIJWf6oYNWmdnR0nS3v01qIBR2OSLNrUyIA0etJn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L8rWrR7R; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so6650797f8f.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778745979; x=1779350779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sEeUOyNcRID3I5ygd6MigioVnL/EYNN2mZD8yeALKU=;
        b=L8rWrR7RvpXY6Mm7WLNxziaUCQPbtl0onuZ38AlVVdcsoFJtkbmHEzKqR8ZAUKXwlK
         E1FW1Mp7cxxZEfZXIqeyWZBLbxdsAu42e7B0xhbrB/kEGd8TUGinMCH4goPAoFttDuaA
         IiQ4eHSjcsstI1tTrtxCoLh+YmNxN5mpKolh7HogRsXxvgRIQIYLH1UIUA3YEMnQF7U/
         lflhv+v85wS4hPkS4zboNuq/IVCxUDVbFT6zEkZewI0/XYyD8dNn5+iJjcTv6zCQ0fNq
         WfhbyTzKK8aBm1RKUR7fkaeDuuuNtVLt9eWvo/u0im8XDVmtGtKR6bt10D7CeCpq9CGF
         tRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745979; x=1779350779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sEeUOyNcRID3I5ygd6MigioVnL/EYNN2mZD8yeALKU=;
        b=hRYrWHnteXMvjhfS/oJ4OlspSNHOio1wevYDQ7nBgQ6wWllPyWulUWP/CI41tt+qkz
         MaQ2PIUWAmTJgLin/BDoaZAU73WQzB0DPS2U0h6SR8W095RYOoXGeCo9MdEgS9b4Lo++
         Gci2iJ6dLfL+6g++gTLL9jvw1X9ptPDX1cGtQrin4Xe9U8XECQSsUCQJWXubOMpq0sOa
         NCgiRFzB4Flpp86R3VH7rBC1cZT6RApsIqqBAN3UeiEWwS7Itammjh5vN590tmp9zSno
         JXuV2AUCdWroXXElvxmnKcKCaz25F3dgmOLWVE2k6KMB2v1KlOycPTYUMKlsMvaCR7uo
         vNBw==
X-Forwarded-Encrypted: i=1; AFNElJ+EFI2vfDUrrihyeSNyxWW7VVOK6Vv8JwM3cbugEIVoNuqAr0/aQQblLvOS71Jswit7lQxEPu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5zEGe18xAcstZzE+txUesWhMB4pAv6EQA8u7RGDfy1cT4bKRc
	JSMfqLRvW2ePyJdrb0g9FPOs3Y1/DK9/m3HXHHZ/Lk2nhpbCohBISo38zbclwJlhBNE=
X-Gm-Gg: Acq92OHxxF//LrImyIaQTUJIdWxXSNcDVYThrB5rDfec38amzyOEUZS/VUKPKKTLi+S
	iVeV1PNGGPD508ZW3W45KdBjZgmDPGdQEjdh4fTJyM3Epy7862jqRY9yCmH35uBSivk6PdXqcng
	bxWUw0L1mdgOtO4NTWSPAsJHd+oOt/NBGQNjTU8PrFC+kW5PDzOxGIoU62+ophy0kEoaQkjQP9K
	eL0+/nJJYrgT5ZP87QhZ+jqF0qzIeiiDFbOPn3z4dR98+se6blXdGZYeJjfHhiqvyoubY5ch9vl
	Q0Uww2O3gdkiUq+Frl0oMU6tUlWyouSJKAPnpe2NOMU2Y1qIG7/l1vS8iQfIEQaRIdcpgrV8p+6
	45wXAm5UCdbm3TodiwpJRPSZ7qmcXOQ5EwWACI4KRLwFjg6pqJftUZrUcc2ufhr6+JjwS+3CfHp
	i3Fk7R8xFcFpbOocnYUqRtgzjdDX2+pV8CKX1T7XPU5z7w
X-Received: by 2002:a05:6000:2dca:b0:43c:fd7e:72eb with SMTP id ffacd0b85a97d-45c5aa655a4mr10646538f8f.41.1778745979153;
        Thu, 14 May 2026 01:06:19 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm4787290f8f.37.2026.05.14.01.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 01:06:18 -0700 (PDT)
Message-ID: <5bfa28de-9d37-45c2-8c0f-e93b36119910@suse.com>
Date: Thu, 14 May 2026 10:06:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] params: bound array element output to the caller's
 page buffer
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Daniel Gomez <da.gomez@samsung.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 Aaron Tomlin <atomlin@atomlin.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
 <20260507082103.94473-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260507082103.94473-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0110E53F11B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[samsung.com,google.com,kernel.org,atomlin.com,yandex.ru,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247136-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 10:21 AM, Pengpeng Hou wrote:
> param_array_get() appends each element's string representation into the
> shared sysfs page buffer by passing buffer + off to the element getter.
> 
> That works for getters that only write a small bounded string, but
> param_get_charp() and similar helpers format against PAGE_SIZE from the
> pointer they receive. Once off is non-zero, an element getter can
> therefore write past the end of the original sysfs page buffer.
> 
> Collect each element into a temporary PAGE_SIZE buffer first and then
> copy only the remaining space into the caller's page buffer.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1:
> - drop the incorrect Fixes tag; as Petr pointed out, the issue appears
>   to predate mainline git history
> - add Petr's Reviewed-by
> - avoid rewriting the previous separator if the page buffer has no room
>   to copy any bytes from the next element

I'm confused by this change. Didn't the simpler v1 already have this
behavior?

-- 
Thanks,
Petr

