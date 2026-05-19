Return-Path: <stable+bounces-249677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO+AE4W6DGrdlQUAu9opvQ
	(envelope-from <stable+bounces-249677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:31:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF083584335
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388ED3068919
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7A93B27D6;
	Tue, 19 May 2026 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F12NdEY5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E173B2FD4
	for <stable@vger.kernel.org>; Tue, 19 May 2026 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218997; cv=none; b=VCUt1y2HkfJ2cUbaCVWRs0Mom5mO21h4x93aXSqzQoVsP0NDBpCdWoo22LpWSHQK3CL3HsG1mLOxK9mByijvxNsDWuUKSPc3/WUuGnQw3ui0cwOtHLbXjeUO4U1Ac3jHy/eHYkQ6n3iSV/tm0rsnl/rlwRgh4we1WfcKCWtPE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218997; c=relaxed/simple;
	bh=YPcRiw4Tsr2KvMmATm06qRml6/4p3sbblnDe0qTV42Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9ciaJQbQnydCew8YTCcrbA7izueJkaNQnyoy1xnYwF4C0gymXF4eDG4nwOEK58WfsYveB6X41rSUVwY9kKEPCif8Ht1BUKT9cp2UfU5KEpbD8kz1F3zr5mGAZ851yhfR9LIV69wONjzq4K/2LsfgOsywo01Kb9XCT4t8bReAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F12NdEY5; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2b458ca2296so29156705ad.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 12:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218995; x=1779823795;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HOwWa+Njguq/yZzIYzDdMRRevQFxklUNPfoFyUumtAI=;
        b=l7NEgarjI1e7FtL06sSGqLsPainbZ8DsGGbhypxJCRXjjDxPIzVUQI+LpNYXcNFlAz
         JjyIY9cmfwLHoPNsmYPuvuWzx7MER6uqEZHI0bboNDkzNSfDOH2pPwTT4lTWRw6LK4Ng
         rFTFS+5Ejh+6JvcUGTVV2h0IaNsSy2aO5v3Wfqk6XMMgZJBLwbVTlnJLJvLFvLogUCOM
         DSkl5RNYcVfBoSTo7044wC+zfZW1GLzmB7ZQ/rccqsR4JW1Ht2/OKFP0HELYWhnUNbUP
         Ljc3ft0nXTO9fz6COBrAFjdaKWfzF4hSRe3K778sjNVbXk8NQGm2p7nV9KIDHDEmyOo0
         sSwg==
X-Gm-Message-State: AOJu0Yx8G5YH55fVnxFk19gNCmyR+Lh/50EAkJyiCW2fgziWUJlcxGeJ
	DJIVIAKqVaz0f07t8rjsgMWGWGP6Q3U3luB1hEAE+dCqPuWqShdQ8tqoUAMeDRappMwZJF1Vcea
	EjqKO5QjGiSn+RnfRWanYye0F/TM8GySGU9pK23k6BxSygyBT1TJBMpkqwNNjQCJkiwAFbIBV0w
	9m4cNnCkzWQKmbChJIwx6TyQSZ7rCi8qT8KDgAJBF6dpl+0Mf8fYF6O335ViwX1BSrt4mbAUnVi
	qVT3ECEupvnN14X
X-Gm-Gg: Acq92OGIqIgstPX31R9K5BBHHVcjklqEVPkAKRRx0KageFwEmYTWSXbUw7lb/vdLhwJ
	fR5LAL1DMZO/AxifNNmITctOdSe21oflQ9d//C+qUNrD9Np5lb3eEUckFPMY4jKcVP67yXkm46B
	9UJTZZNq2uZz0wEqRuEwaPR67jDuqn1J7b/ZRsnojzcHAk+w2NYLnMOX2DmKvoj+JaxJUR1rm99
	dx5ZCGq6ZLlP++CImb2KF9HZANb064Fe9wYg2dA0tfvcE+66xx8dNg1IGgSfi8C8nCzN5YhUD1P
	90HDQwzKqSGxfsAsYViSik/MtN9JnZ5wO+EEJJIzWSekQaWDnuZFB0n9IdPX4DUHlMJoIR1TCk7
	m9SHxHCTU7D7M/VL7oCDQFmWlWeAdgO8U8UFEqaKXqieWOkcq53QcX3tQbEW+0n/euzbusIdSIG
	KQFy7M6/DOradUClesq73oa/alp2EoyINSM+JIYgjCrdwp92aqVSBp/hJYrG5eYw==
X-Received: by 2002:a17:903:2c04:b0:2b0:c45a:bc2 with SMTP id d9443c01a7336-2bd7e851025mr223439925ad.16.1779218995406;
        Tue, 19 May 2026 12:29:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2bd5c065b2bsm13847085ad.21.2026.05.19.12.29.54
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 12:29:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45e73a4f1dfso2528762f8f.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779218993; x=1779823793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HOwWa+Njguq/yZzIYzDdMRRevQFxklUNPfoFyUumtAI=;
        b=F12NdEY5w/jRp9DG94zgThPn4WGv5d/FoQarefXLkWGC7qS/fZB0JiX95AvVpbfLRR
         wBVn9D6xnMPSU1XBDh4RdaH1N5thSUYDyUFvo9zEVH9Gfqqg0aVIOYHWUaLAcfCqSEy+
         KKFeXZaQ0cSBXZr0H+YKpqXuOJifLhHE8kLgk=
X-Received: by 2002:a05:6000:2c0f:b0:45e:9323:63ad with SMTP id ffacd0b85a97d-45e93236594mr661958f8f.36.1779218993486;
        Tue, 19 May 2026 12:29:53 -0700 (PDT)
X-Received: by 2002:a05:6000:2c0f:b0:45e:9323:63ad with SMTP id ffacd0b85a97d-45e93236594mr661909f8f.36.1779218993060;
        Tue, 19 May 2026 12:29:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm49304372f8f.32.2026.05.19.12.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 12:29:52 -0700 (PDT)
Message-ID: <5b6063d2-a57f-4a8a-9b1f-9cc8ab4cf175@broadcom.com>
Date: Tue, 19 May 2026 12:29:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.1 0/3] perf build fixes
To: Ian Rogers <irogers@google.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
 "open list:BPF [MISC]" <bpf@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>,
 bcm-kernel-feedback-list@broadcom.com
References: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
 <CAP-5=fUuhNRj2Dwz9FmMnWKwXjM3RCFV1oQKO4e3X20EOHstEg@mail.gmail.com>
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
In-Reply-To: <CAP-5=fUuhNRj2Dwz9FmMnWKwXjM3RCFV1oQKO4e3X20EOHstEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-249677-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EF083584335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 11:55, Ian Rogers wrote:
> On Tue, May 19, 2026 at 11:51 AM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> This patch series contains "perf" build fixes specific to 6.1. We have
>> seen occasional build failures in our CI looking like these:
>>
>> util/parse-events-bison.c: In function 'yy_symbol_print':
>> util/parse-events-bison.c:901: error: unterminated #if
>>    901 | #if YYDEBUG
>>        |
>> util/parse-events-bison.c:1020:62: error: '_p' undeclared (first use in this function)
>>   1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _parse_state, scanner);
>>        |                                                              ^~
>> util/parse-events-bison.c:1020:62: note: each undeclared identifier is reported only once for each function it appears in
>> util/parse-events-bison.c:1020:64: error: expected ')' at end of input
>>   1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _parse_state, scanner);
>>        |                         ~                                      ^
>>        |                                                                )
>>   1021 |   YYFPRINTF (yyo, ")");
>>        |
>> util/parse-events-bison.c:1020:3: error: too few arguments to function 'yy_symbol_value_print'
>>   1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _parse_state, scanner);
>>        |   ^~~~~~~~~~~~~~~~~~~~~
>> util/parse-events-bison.c:991:1: note: declared here
>>    991 | yy_symbol_value_print (FILE *yyo,
>>        | ^~~~~~~~~~~~~~~~~~~~~
>>
>> which are resolved by these patches.
> 
> Lgtm, but the changes should be unnecessary as perf from Linux 7.1
> should run on Linux 6.1 and with more and better features.

That's a bit harder to ship logistically for us and likely for others as 
well where we expect a single source to build the kernel and its 
companion tools.
-- 
Florian

