Return-Path: <stable+bounces-250246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEvjJdTlDWqm4gUAu9opvQ
	(envelope-from <stable+bounces-250246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:48:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B115592793
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9961230A1961
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AFA3D3D1C;
	Wed, 20 May 2026 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GwGMNYlj"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29236A352
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294910; cv=none; b=ucKTpBT5Pl4+sArvaZWTm0Ujub2PUL0dGT8EiOgjUU46iJ5KbBaZhT1jFqezIrnv7oQ+HcYY2OcxhY1f+GybCCpMM0XmYuvS+R3DH/mYqMUdZNCXNnpeB9b8yd3MuQG+s/oVYp4XvG4XhwkRTVAImwS4x/CcUiwG/MKUZul3uJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294910; c=relaxed/simple;
	bh=3lGRAEnQMtX4zERAKSIZdMRkPZ+RvRXWmkS38F/ap7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdDP8xpk8+ETa3k41YCxsbU46Q72QmeFPPAPonpc4yX5RxJFLFOKFDBsZx+xVgGrc4gwdYWnmANAfvZZU2RFGUbOc3N80xJn5xZI3HZxu26aJFndfoCul2Hfs4oFHBRFUTrBo+gKNKrvxtU5G4KeHZuOUtdFlDk6uPftJEronAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GwGMNYlj; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-1329fc4bf77so641683c88.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294908; x=1779899708;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k1YJJ1YFmprPS6ntzC8PQrKknM/3MWPFYqmao9X/xvo=;
        b=re+/tJy8/fDk/6TGw6qCXCLdWDWWXvGWLfd71f98i+ZmbmK8IsDtnSa1y1XA0DkOWg
         7zihyXFq7D1/boY6mmIsHV+LKDmQS2ASm/z0ypE18pQRwbYT+NnEmM+4hZMy/nfZq8BT
         bwfyH0mNZRTggRh8YD51AsUpDNXehNnwIUq0eI0a2Jtiop/qh1YRmeK9zm5DbkBt9MeL
         DJ337hiWHWSIuimpg3SkdPDqRG1KU+cO9XP5uOaoUJwPpFQP9Mgj3LEGX90U8LcRot09
         yMnWGceaFVty9uNSRqWMYW6xsKKLqF+ydSFA5rRD8xgMqAzhQWA8X/u1fKYy5sd0EjZJ
         GmVg==
X-Gm-Message-State: AOJu0YxjKos2UhSlutuIyOyRroxvjiDIWBQgXOaVCls3JXAi/vXllyXC
	w2S8XNgnHHrAS7he5mDbclsbvNJtp+JJU/GClG0oek1SNrSK7mRF7daH+/QbDVF+PheryQD3Yx4
	5Uur6gHBY2W1wgfDludKvnpYyMk11OduxIgEHE5feNrfkaogOEyStUXOo38dvwf3emwRgZFvyRe
	eOF44iA6nqQ2cMk8HuGQncRvwLwa+OjH9h8sEt5hxh/pw4QMG92EK/04tvcxAcg8/QmhacYL6Fd
	0uuMYioLsC6MdJT
X-Gm-Gg: Acq92OG3XcgEt9V77MWlhQOt3jn+lZveIO2J1fR8twYNzxUiJwqNf/lZMwKjTNT45q6
	WsVuju28Hk9Kj6l6+Ww/sasLva03aHuUj8dygKx5g1xwJ0dhK+e3IWmXg1RuKBHGGC0Fk3ZLKTo
	EU+1ZUDS79pJ43FHcrUkzzAjvm0XzjlmAdND7CTc2l3fDy99K/aE0mCx7qBspPUtV8XIqQpwL3l
	ap7k9jrC4soBBuLw5RTfnTHERXbkdpaVP4ZdMUDTbXpcpSnFjnVtj6ml3dXBe7uHTvLqcnLVTSi
	7wMX0OHEoYfIZdad8YQhXEqjfmwx8Kx8oD8x6d6sMzJWzNOR1S5iFmpJ7LXfIMp6GQYHNWwKEEV
	kf+Z5hG/iwaUWmodN2Y6YR18FocK2ARdjaLSDiUPKpLCJeCXoVg8w8aoIKxjn2rFJ3mnQfv3oGO
	WIa9pgu3YheEhesByCZqotxVM+EPucQVLitoLbueEKDAmUR0vCzO7ExOhmZO6/mfyF
X-Received: by 2002:a05:7022:438a:b0:11a:e426:911a with SMTP id a92af1059eb24-13504627246mr11252058c88.15.1779294907925;
        Wed, 20 May 2026 09:35:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-134cc127865sm2337149c88.6.2026.05.20.09.35.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2026 09:35:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1353a6f29deso1238170c88.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779294905; x=1779899705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k1YJJ1YFmprPS6ntzC8PQrKknM/3MWPFYqmao9X/xvo=;
        b=GwGMNYljw6jBdzJepJMLbeQNNXO5dD9AGOQAnHSzthnCgY8wOt3+6Nir+1jpOdLoNN
         3WLo08ybTjH6mC/GtGPE3EVZpaetLUoqwdTaPuEAJjrJoYvvrV5RmuVX9FIBfXI0+REZ
         jph+oeSQzt/7hFtxGYwdc/DV/2UaKeKgmZveE=
X-Received: by 2002:a05:7022:607:b0:133:3c47:932e with SMTP id a92af1059eb24-1350494e402mr11987647c88.28.1779294905370;
        Wed, 20 May 2026 09:35:05 -0700 (PDT)
X-Received: by 2002:a05:7022:607:b0:133:3c47:932e with SMTP id a92af1059eb24-1350494e402mr11987597c88.28.1779294904668;
        Wed, 20 May 2026 09:35:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm27311954c88.1.2026.05.20.09.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 09:35:04 -0700 (PDT)
Message-ID: <6541a5f4-a150-44b9-af27-8712cdafc1ae@broadcom.com>
Date: Wed, 20 May 2026 09:35:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.1 v2 5/5] perf build: Remove
 -Wno-unused-but-set-variable from the flex flags when building with clang <
 13.0.0
To: stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
 "open list:BPF [MISC]" <bpf@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>,
 bcm-kernel-feedback-list@broadcom.com
References: <20260520163320.3073037-1-florian.fainelli@broadcom.com>
 <20260520163320.3073037-6-florian.fainelli@broadcom.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260520163320.3073037-6-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-250246-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5B115592793
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 09:33, Florian Fainelli wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> clang < 13.0.0 doesn't grok -Wno-unused-but-set-variable, so just remove
> it to avoid:
> 
>    error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
>    make[4]: *** [/git/perf-6.5.0-rc4/tools/build/Makefile.build:128: /tmp/build/perf/util/pmu-flex.o] Error 1
>    make[4]: *** Waiting for unfinished jobs....
> 
> Fixes: ddc8e4c966923ad1 ("perf build: Disable fewer bison warnings")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/ZNUSWr52jUnVaaa%2F@kernel.org/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Change-Id: I8db8a372d1e83d26fbe8beda2bcf4d1a871a2b80

Argh, sorry the Change-Id snuck in there, let me know if you need me to 
resubmit.
-- 
Florian

