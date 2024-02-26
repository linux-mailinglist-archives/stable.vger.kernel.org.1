Return-Path: <stable+bounces-23670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D60F867332
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 12:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115831F252C6
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5211D54F;
	Mon, 26 Feb 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K++EOJnY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F22CCD5
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947243; cv=none; b=WeYXENerP+4MYJtSvnts5LOwNFNk/T07yV7Xh5gCv3dDgLuSewosVn4xTWQCFL75LYUI0RU+3zodYkdg2OQhsevqJSFk0ToE1/3gnVZ8hLbUIEKv4ppL5QIe7XJTOMXScGmweVq/rwLOIpDc0iMp4SWkGscmqN/8EHcRr8cVHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947243; c=relaxed/simple;
	bh=d0kydW1Yxuo1MsG4YJurMo9qxI32GA5maZXnljWXEGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/Kp6PT0+eh4YZjRpXL+GIX9g6DLBITT8k3XIGXSfxqhT3BSjARGcy5onadNuP19jYJspE5K2D5DXKDew+ehsb7B6xv4J7zAgk7jbFBG9hKGcK3LrnYhvipWFyWE7pqbrbqJ5VMUm/ANKR5O5dWSK929h1LgTD5t9ajntyaWOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K++EOJnY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso2178707b3a.2
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708947240; x=1709552040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wdsp0gMDY9ztgsqYmpfOLfIwYX7WF34YfJrpayCYhWs=;
        b=K++EOJnYUCNPr0CYwYChswGetVdU8ZYqtdMelvpfIiCYLsZX0Vr+hv2l9zThbiPMS2
         eC+7nM4BgXJHsFYUAwQGgNJQd1ImXPUaoKNmxqZBjMBb/cL5nwnSPk9sugyb5Jo9N0e7
         fO+aV0SBAPxcPvaS3K+r6zPDOuOCGquieNrtKW9cyk0Uu0iZnpwKkD+u901UbKwWewi0
         gtNspoHsbDKSD8IDtghmjEKoz0LoSNWpIM7h72iRbczvkBqiF6PLOxFOPFMLgLawdPG0
         21nMkvT3gBd7dYJhCHXN1jvperYQAl3FM0XWBQ4ih+Zea8zFIWSJ/PRRbRkyTLMERdRh
         rnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947240; x=1709552040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wdsp0gMDY9ztgsqYmpfOLfIwYX7WF34YfJrpayCYhWs=;
        b=r7TXFqHUMlfqT6S0GC0J0jqfklcUvlmKP+jH4n8aIc8SyU1PbWfoCLLdmuEU1efg6r
         MBjfQLSbTHqLEucHT75wAFddhmpShrgWPZIwvwFUvtbJXZuo1YNRsEx+mlQLoxI1aLs+
         4mkNOILXCBBD2eSoRQzpDqT3co3KCtXhVfJK1b4l9mL/GLH40JYlh5Lx3+bS8aiJJqwP
         CLLYkTbglvhuMqoBA4TfPSNmrJglXdD4dNuS524Vf+cQt6dn4zRWZA2U5pEYC8SCxBdc
         n7Ru5jr9Fe5EJrsyLldkvkw9fXLs3yaiTTmEXpI1eC8CVSe8wxherP7g4DUTKe+avQvx
         DiGg==
X-Forwarded-Encrypted: i=1; AJvYcCXVDiDhEl2OZgUBgobiAw+Ftc2ruDl/hJVloF/QevG8qzJkfU+5H7KqZSq2x9pwZZk7z18JvsraQgF0jkL9HFRlqrcvdYlH
X-Gm-Message-State: AOJu0Ywr44EDKVF8/XpCFAhc8RBhk4h4HlA1KFJJGzPd3MLlK0MXcSin
	HigBUM+c9oL0751bKoadyBjWFhWvDwcKsiIhucYUHh/2cWQU7PBqjcyYD883Jow=
X-Google-Smtp-Source: AGHT+IFrqop9IWtx6Qj69nWqO1n/SWu8DT5ggnEUyrLz2QTvgJxjukIRIrGPsQX+Am24ajuetLPWRg==
X-Received: by 2002:a05:6a21:1693:b0:1a1:3dc:6686 with SMTP id np19-20020a056a21169300b001a103dc6686mr801467pzb.59.1708947240327;
        Mon, 26 Feb 2024 03:34:00 -0800 (PST)
Received: from [10.74.73.182] ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id d20-20020a170903209400b001dc95205b56sm2320016plc.53.2024.02.26.03.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:33:59 -0800 (PST)
Message-ID: <f516eb83-c393-af67-803f-4cf664865cf8@bytedance.com>
Date: Mon, 26 Feb 2024 19:33:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] Support intra-function call validation
To: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
 gregkh@linuxfoundation.org, stable@vger.kernel.org,
 alexandre.chartre@oracle.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240226094925.95835-1-qirui.001@bytedance.com>
From: qirui <qirui.001@bytedance.com>
In-Reply-To: <20240226094925.95835-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This issue only occurs in 5.4 LTS versions after LTS 5.4.250 (inclusive), and this patchset is based on commit 6e1f54a4985b63bc1b55a09e5e75a974c5d6719b (Linux 5.4.269)

On 2/26/24 5:49 PM, Rui Qi wrote:
> Since kernel version 5.4.250 LTS, there has been an issue with the kernel live patching feature becoming unavailable. When compiling the sample code for kernel live patching, the following message is displayed when enabled:
> 
> livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack
> 
> After investigation, it was found that this is due to objtool not supporting intra-function calls, resulting in incorrect orc entry generation.
> 
> This patchset adds support for intra-function calls, allowing the kernel live patching feature to work correctly.
> 
> Alexandre Chartre (2):
>    objtool: is_fentry_call() crashes if call has no destination
>    objtool: Add support for intra-function calls
> 
> Rui Qi (1):
>    x86/speculation: Support intra-function call validation
> 
>   arch/x86/include/asm/nospec-branch.h          |  7 ++
>   include/linux/frame.h                         | 11 ++++
>   .../Documentation/stack-validation.txt        |  8 +++
>   tools/objtool/arch/x86/decode.c               |  6 ++
>   tools/objtool/check.c                         | 64 +++++++++++++++++--
>   5 files changed, 91 insertions(+), 5 deletions(-)
> 

