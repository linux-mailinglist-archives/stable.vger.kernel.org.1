Return-Path: <stable+bounces-183851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E2BCB67F
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 04:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BF9B4E12F5
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 02:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB89224245;
	Fri, 10 Oct 2025 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGKJ56yQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D234E1DFE09
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760062946; cv=none; b=TiKSnF6lkeo0qI5c41ZeVDhhLveufAJGSjAdMdwHCBBvYYJLoflGo02xF29/q7QwWEal9EHgPkFcnA3D7S7r71Su+ly2zRE1guMWYCj1QEPNSecjmMcYgH2d9fs3K2j56oGb+EaJRVgZmJVfsryLOKfveuJTkZrKykJjXgaqEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760062946; c=relaxed/simple;
	bh=Poc8CSat8DKSOJybm3/cRmwyiOaA5NMqn/oRePUZbI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXFGoYjeKdCeZS3biaAiplf3TL4pfeeplY4cEXfBQGfn1tWf5zfkJiBg2RL2vLVwdr3UBBDG17sH5WVgd73DEAVTa0cl3ehKACPRu5/gIAL8g1TPEdsrL2hptRhlhf0Xi5QcOxHQ68393YLlxlis9/cQQqW+e9zjseYdny/Cp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGKJ56yQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26a0a694ea8so12142665ad.3
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 19:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760062944; x=1760667744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Poc8CSat8DKSOJybm3/cRmwyiOaA5NMqn/oRePUZbI4=;
        b=NGKJ56yQgJjTan3iftmRVDRP+FxtKTbVXlrWzrp2zcDH6CsTjP9kbWW8YUCSn0wgKh
         UF9/IDGU4g4AldPP7Il6AIERtSTdzTqKd0rwE/lMPO3gjqSqnUXs+RpsWeQonxP/U0LW
         KoeAOmA1pRSGfceQMg5IaQRKfs45vxECBagkDjN/N6/bkcQ//h6bwNcCXEzHqVJk3LPc
         yj2A+MGkSFOCBnrUvq1NCywViXQQzYSCEZM2gLd1lvBdPPbgqFc9OOZcPpznMKzx68DB
         bW4KVlTtfE86AvBa+AyZ5Ygljx7z9UgGCsaolOUseJCTGu9O5gED3VQk+TpVucM5iykP
         YvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760062944; x=1760667744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Poc8CSat8DKSOJybm3/cRmwyiOaA5NMqn/oRePUZbI4=;
        b=NJWJTH8uG4O46XI+z2/JF8IveiOBYEOPGBxOKXHJhS1P+7jFng9XT7ifGSQehO+0vJ
         jm/XkBk9eZ1rwGdCK2YF77uqTb77fpKXLFkFINojlhJqzg28WIMMUbQcwAXIEWxMH8oO
         Q7WNcPz/STfN/I58c7VGg/Nfx3cOV/stS8bzc4guBoF+cO5BX/NRihHQSIGbuGzPeLzL
         QX+rMRE2yyZr+Te3OCY1LoXACr2JAq5yJGaq3Ha/cq216npA0F3bsE77tfkd64T0NEB+
         fgRO9UrGRHck7kKJht8dqxdoaUgqqufraS9g7vrcUsCIXRsZb3gJs7B6QU4gWP+lMy+R
         6qbw==
X-Forwarded-Encrypted: i=1; AJvYcCXtsW9lNJvs+zateImLtDKDttVhYlAJ52LM/0vPIuCxyV9IdhLmBODbiIVDMLMv5gdFmHNdEko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEbmGDrUmxzg/aDaHZtv09h2Ixetg3vLYIERS2gVLO6fP+2OK
	yaGN6ATyG2B+uZH+P/B7JV8sdLz8X9qMkBkKw7o4ZQFZ6QScxOX0IkBd
X-Gm-Gg: ASbGncuzmWHLK2esq8VCsBmpF0TA87sULCKnvwPH8lbZyABNz5c3Cr76nHAlZ0jc8mY
	3Quo0BVWjieT4yCmt/GGtmDOuN9rqMDPLUsQzErp0HLl1qAv9xPr886Onf55RY1kG/Fi2BgjDDz
	E30Ch1ZLl5t9P95rqy6ytg1uVVFPkvePPz08i5MVnAa0JPtCyU7R40S5T30IOK2FKj7GasNkxyG
	c4TBfoxmY32OTmkFyU7i+1hy+KzdlBo8VBoAw38x9M/JNHm6KOOyPk8rG4xoqfclB8DaWOexLlm
	iH+6xRzEhHU+SHqtxVB6sVrI7GbMf1VpY3ChZU+UXlz2CREdfKXa7MOFFf/PrRs6e71HcWq2QNX
	IcwCAmgwKYb4y+m3Xm93ts03jQkoXMI6IMFs3ozMqjimb1sru1svToCCdZoL+2KcaEPfa
X-Google-Smtp-Source: AGHT+IG+Pf+n9YF9gI8OUfcmQ9dndEj32A/PkFqo3oluXmEOwiiZZVb7VASeukYYSqQxTR1LizxeTg==
X-Received: by 2002:a17:902:cec2:b0:25c:2a4c:1ca3 with SMTP id d9443c01a7336-290273448c7mr124825125ad.30.1760062943936;
        Thu, 09 Oct 2025 19:22:23 -0700 (PDT)
Received: from [192.168.1.110] ([59.188.211.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e18557sm41839285ad.39.2025.10.09.19.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 19:22:23 -0700 (PDT)
Message-ID: <28f4950a-e3eb-4a54-b867-67bd269b8407@gmail.com>
Date: Fri, 10 Oct 2025 10:22:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.17-6.12] soc: apple: mailbox: Add Apple A11 and
 T2 mailbox support
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 stable@vger.kernel.org
Cc: Sven Peter <sven@kernel.org>, j@jannau.net, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251009155752.773732-1-sashal@kernel.org>
 <20251009155752.773732-9-sashal@kernel.org>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20251009155752.773732-9-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Sasha Levin 於 2025/10/9 晚上11:54 寫道:
> From: Nick Chan <towinchenmi@gmail.com>
>
> [ Upstream commit fee2e558b4884df08fad8dd0e5e12466dce89996 ]
>
> Add ASC mailbox support for Apple A11 and T2 SoCs, which is used for
> coprocessors in the system.
>
> Reviewed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> Link: https://lore.kernel.org/r/20250821-t8015-nvme-v3-2-14a4178adf68@gmail.com
> Signed-off-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> LLM Generated explanations, may be completely bogus:
>
> ## Backport Analysis: Apple A11 and T2 Mailbox Support
>
> **ANSWER: YES**
>
> This commit should be backported to stable kernel trees (and has already
> been backported as commit 37b630a26d235).
>
> ---
This patch adds support for new hardware which is not just a device ID
addition. None of the hardware that depends on this mailbox is supported
in stable either. Please drop.

Best,
Nick Chan


