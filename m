Return-Path: <stable+bounces-154797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA47AE0505
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 14:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190D04A443C
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBB8230278;
	Thu, 19 Jun 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1V+so5J"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954022756A
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334470; cv=none; b=uD4ntgJ09sBk5mgwNs3+Fgl4bXCLGgOMZjfv6gM8pHpMRCysF/8dbGknxGC+UhfN6Zg1kBMd1DZmeJN4i+sVen1Qltu5bFO3bro6ai3TFlX4Z7y/vD6W6Q752V5Tp5shSIcvGokWQOcmEBfkeXgjtNS/bnuwWL6PXND2wsWD6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334470; c=relaxed/simple;
	bh=l6BR6Wrlw8nk8bPrPxmwcZG18ikoNjUjooDgXUGZn0Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=d/S5EHqHjWq4j3ZMhydXAlfA7k0QffLskqs/EN7eXAaOhJtAe27g4hFYif30I1dwnxFyXxkywf9AWTL3rfPytuUIGwIdErPDtgWUh6QB85dOHuSVccDvlWP9aKha2C4iPmUAEg0KNrMKbACIv/wdoA41ETUpAT/j/VsjWtPMYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1V+so5J; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so5868301fa.0
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750334467; x=1750939267; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=69AM7nnDm5+d3NZtjArdkH+uwLdSHNkH3VQUjxXy+I4=;
        b=G1V+so5JDCXkR5oyawW01SeXMeE6CO1/DmBRcP83GQxIT0uUA86PJEzkPaUwmea97H
         018QBLvprr5a1BVQPgWUvv//yKvgXhIfdU4C8iAaqrBlDs/MPYJ3phL+O7p0buONp4G0
         pnEJIPtwG6S5osncYvUXTAEGRWO5VDn6Gu5P4wjtuoBksV2iPFSkFZn2SCvriNitmEaz
         QG+gGN09yQF63g4EoZPt8P7aDdtFvif/KaaZY5tfzIIZrltVM6+GrOyxM1hzAOEG3kh/
         BqnVs4KcHup1KQpCByPgegc+Q6Oih81ZbpPsaEXLM28AxmkGNVkf3DSo0VmrXWiMGyJy
         DOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750334467; x=1750939267;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69AM7nnDm5+d3NZtjArdkH+uwLdSHNkH3VQUjxXy+I4=;
        b=I8fDEmuWg6Iitd/PoMMp7LeB9EEAV5CS7YjlqWGuRDSS2ppwkS/6f+9EyOtxWzdbqV
         YLI3HivDmPgsPEzpCvE1rtDuuzrLrpDhUIvy/g5RJGwdECDNBdHHVgztca+n+ALf9vP1
         MZLpAN/SqnM2Jv2yVbCyWAlSM7ijvcu7Wi937PFr02ExUhXQld0guVshymiFd/r6IThH
         ikkMVH1683YgZh8pPbLM32CVoQTHwZcGVhCoxbZCPz/cc0JViJ/577UGRwBF+LSeHi5R
         /m7pom9RVAKnRBD7hwCFaOceb1eGbhgySSy2DW/3tuybIxTxfzWzQIZow6bB8GoCsxKT
         DDMQ==
X-Gm-Message-State: AOJu0YxlfWtyohKuX9z4NXCys0KSN8SzPh93Yy1ALIOgJM07z5CkTUb9
	He+nWEcAYeusmleldu3Pm37zHAN/IkhCoDQhcpc+hodAXgsCU5S+i9f6YY+A9jqbyWIULo457MC
	HKd9gX+zuiBQYBjI84KFSG6wk8KipoyqelQ==
X-Gm-Gg: ASbGncvZNO+1k6UtWTnTZDzKtzMhKv++YHRdl05bEL5ctUMabggPXzVjNXtCixR5RHt
	Uwt3pJOs9jSE97jRSrTI2mtI7HWX2Hf3o8b+W4wDjyp3FSF41Sayf7hUoOqIK2b+IWKZ7ZYLszk
	LEWVTy++trTZPIlOOFJHAIfuBcfou+dt8R14nK7nQqs4s=
X-Google-Smtp-Source: AGHT+IGQ5sGUIsT5LYSZI0Q3XNXoD3jb13yDO3v7lzlh4VoKNdweD3gYwm9FORoDnh/t7yM3CY+C+DZXgTM/GiID5K4=
X-Received: by 2002:a05:651c:3046:b0:32b:7614:5724 with SMTP id
 38308e7fff4ca-32b76145f88mr20098121fa.5.1750334465889; Thu, 19 Jun 2025
 05:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Thu, 19 Jun 2025 14:00:29 +0200
X-Gm-Features: AX0GCFtxBRh_-oJu3EejpNY-zPPxJeXK5tWahxilq_ekMlY8oYqXwq43XWP-r0I
Message-ID: <CAA76j91PrdB4c=W9p7p7YwXyH9tWPfDcUfRBX3SrVj9mdMd8Jg@mail.gmail.com>
Subject: Backport of `Kunit to check the longest symbol length` to 6.12
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Please consider applying the following commits for 6.12.y:

    c104c16073b7 ("Kunit to check the longest symbol length")
    f710202b2a45 ("x86/tools: Drop duplicate unlikely() definition in
insn_decoder_test.c")

They should apply cleanly.

Those two commits implement a kunit test to verify that a symbol with
KSYM_NAME_LEN of 512 can be read.

The first commit implements the test. This commit also includes a fix
for the test x86/insn_decoder_test. In the case a symbol exceeds the
symbol length limit, an error will happen:

    arch/x86/tools/insn_decoder_test: error: malformed line 1152000:
    tBb_+0xf2>

..which overflowed by 10 characters reading this line:

    ffffffff81458193:   74 3d                   je
ffffffff814581d2
<_RNvXse_NtNtNtCshGpAVYOtgW1_4core4iter8adapters7flattenINtB5_13FlattenCompatINtNtB7_3map3MapNtNtNtBb_3str4iter5CharsNtB1v_17CharEscapeDefaultENtNtBb_4char13EscapeDefaultENtNtBb_3fmt5Debug3fmtBb_+0xf2>

The fix was proposed in [1] and initially mentioned at [2].

The second commit fixes a warning when building with clang because
there was a definition of unlikely from compiler.h in tools/include/linux,
which conflicted with the one in the instruction decoder selftest.

[1] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/
[2] https://lore.kernel.org/lkml/320c4dba-9919-404b-8a26-a8af16be1845@app.fastmail.com/

I will send something similar to 6.6.y and 6.1.y

Thanks!
 Best regards,
   Sergio

