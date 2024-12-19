Return-Path: <stable+bounces-105319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AB19F8028
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7248C169D53
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B529227561;
	Thu, 19 Dec 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PYubQ9bY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E7226551
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626655; cv=none; b=XdhjG/qb8uk6IU5SsOcJ/mEL22JnVj6RCSkOkjutOK8ImTwEx3DNpw389TBba0qXOQ64LWN21sVFb1gmyjuYucCbg0v2Hn/drg1zYZ43Dllt2QhDG9Goas+WX4Rbg39oSDSCzN5yxBX5Pzn5BLACILaac19/VRBWHiptHn+epOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626655; c=relaxed/simple;
	bh=/WzK4ZNO7fuf8BvKKn1V0JJbMvcNr4d1yJhMfBFo2qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8A5Y0VcpJaqtxwzbnVwscx2WlqsRtPSOfOqDxr5F05oWg0PBu1Y0LQk5lPiQFnoKMKww5gASTc01X10PkSOY+oACs0nnI3i951+lSMhH475qQwjKUTniltROxOLeY0gF5pp/udvhTWUSrGs/L5Xpmd7KmnTd8/gMWBZmjRIUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=PYubQ9bY; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso6752505e9.1
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 08:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1734626652; x=1735231452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/WzK4ZNO7fuf8BvKKn1V0JJbMvcNr4d1yJhMfBFo2qQ=;
        b=PYubQ9bYUfaQrGmQ/fyzNKGXnclKyhGqGa694dXuO1LHpWTbsiFndksbKwGAnvfe2s
         RLrsdgAVmbrcpPxHQ6dQCCqxHbCW/sRuF5MC6cZnK2VSbST3t1KnZj0sIe8X1id9Up0z
         23rlT56oHIs4jBg7xo4ftMS+ltqdntIkoc1tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734626652; x=1735231452;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WzK4ZNO7fuf8BvKKn1V0JJbMvcNr4d1yJhMfBFo2qQ=;
        b=fRrLUx/3vNqOGzOnrypiKHix3g+Pkywk05WHcptYPa6mnD1YpTp5m87WLmHVtTeeNo
         3V+ehuUeGwhOr3uoGAKZzNzj09snHXrSE+0ZgeoMAlQWj/TWN8a2l24PHUsof50IIO9u
         Y/HDRVajcnjjNMdAmNaqm3zFyDo97Vdcn9wZy/hdiyN1jjXPCFw9t88M6neAxPU/+1Mg
         Bkjs1bh+IbKHpUNB0jpas/8SszYfhQW4wQkYojyz4qQ/+BEzTBdtEDQSOEYZ2YtIg6ZE
         1DU1S2q2WRGmos/TW5WQA74jTi9JR4J+rus4E1xIeCdfpac2oQ+uHslicTHDXxD0/fH/
         WgdA==
X-Forwarded-Encrypted: i=1; AJvYcCVFBbPHj0oqNTrbae1nlJQCUxuaGPSCqqGmYxSaNiEwVd5R/o4UnuJiDg7a22JBjItJFY4YVuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymdT4NK6FrriPDDTD3oIvjqWB1hYKHO5bpQmh015pNvGfD3y5k
	krsPaiWsJzqvtIxG9djwq5f3MJa1pL3zU8Czktjbxg9mgGNtetsF2i5NlPM9KQo=
X-Gm-Gg: ASbGncupBPSjBAs58YkMowxuc3kXyocRTkUR6HNV2BKMtP6YgC/eOksjy7Eg+uWTsvg
	14F56dV+ejMqfcutRiDvUg27TeNPzavYXFxBhUQ7UqH6EqeFv9PDVwvnAU+p4YLG4b6tfjxYIny
	zBos3Ewa8AVzN63HwKU3XfAO1W5FZIPQEbtA043E6MbNexfzVJkQNeVNGlXXtoHghMzS7e3F/F3
	FW0vQ5POV+Cf90lu1HhP1KNH+9woo8I2udmSEtj9yhB1U4+8uUbksJzVHwxwV3hDVJd3fQncoi6
	jQLTJlPX4J71+sBVK7+k
X-Google-Smtp-Source: AGHT+IGEPE2HmFwQQoALSPufvuY9OcbgJ6yxjHc1zy4vQSlpAqsTcBReairPrxguFq2h8tr0xiiMgA==
X-Received: by 2002:a05:600c:1d1c:b0:434:fddf:5c06 with SMTP id 5b1f17b1804b1-43662ca2232mr25073075e9.1.1734626651927;
        Thu, 19 Dec 2024 08:44:11 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c84ca21sm1951594f8f.63.2024.12.19.08.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 08:44:11 -0800 (PST)
Message-ID: <099d3a80-4fdb-49a7-9fd0-207d7386551f@citrix.com>
Date: Thu, 19 Dec 2024 16:44:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-6.12.y] XEN: CVE-2024-53241 / XSA-466 and Clang-kCFI
To: sedat.dilek@gmail.com, Juergen Gross <jgross@suse.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: Jan Beulich <jbeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Kees Cook <kees@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
References: <CA+icZUWHU=oXOEj5wHTzxrw_wj1w5hTvqq8Ry400s0ZCJjTEZw@mail.gmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CA+icZUWHU=oXOEj5wHTzxrw_wj1w5hTvqq8Ry400s0ZCJjTEZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/12/2024 4:14 pm, Sedat Dilek wrote:
> Hi,
>
> Linux v6.12.6 will include XEN CVE fixes from mainline.
>
> Here, I use Debian/unstable AMD64 and the SLIM LLVM toolchain 19.1.x
> from kernel.org.
>
> What does it mean in ISSUE DESCRIPTION...
>
> Furthermore, the hypercall page has no provision for Control-flow
> Integrity schemes (e.g. kCFI/CET-IBT/FineIBT), and will simply
> malfunction in such configurations.
>
> ...when someone uses Clang-kCFI?

The hypercall page has functions of the form:

    MOV $x, %eax
    VMCALL / VMMCALL / SYSCALL
    RET

There are no ENDBR instructions, and no prologue/epilogue for hash-based
CFI schemes.

This is because it's code provided by Xen, not code provided by Linux.

The absence of ENDBR instructions will yield #CP when CET-IBT is active,
and the absence of hash prologue/epilogue lets the function be used in a
type-confused manor that CFI should have caught.

~Andrew

