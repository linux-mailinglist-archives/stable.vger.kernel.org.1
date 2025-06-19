Return-Path: <stable+bounces-154783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E16DAE0230
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 12:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC33189CF41
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 10:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A482E221720;
	Thu, 19 Jun 2025 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1xnOLw7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824521D58F
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327220; cv=none; b=PqRc3Ylpo3rjuwAzOmtNmisTCpCC8yCPeAcTgzZK4xov225aaoogfR4kkW5qryYQ05rcC56FSIgdsKkGVChe2hNA6WqORoYgb0YJoHUTnLwlVRBmZveWOljQR165Rva/dq09u39F1t3WctJPDD7XmPgLzuyBX6UJsjp+SLfbDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327220; c=relaxed/simple;
	bh=MBupwdHTfTziQ9of16o5m0czaGGVQK/gtIdY/OjTRmU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Fd9AAS60UgU5oVpc9LUl4jydYOr6QVeHYGd3Ct6TLAkVY27i5RyQJYMvvzHSp1cLxZxaO4pP0W4Den20qqaptAUHcl6ntBpRtIrVNi1mkygHW8/i9P8iOoPvpWw2GjSHfrMYEK+OtOziZm23zZAqYJwk/nQkUISa3U1NlKTKczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1xnOLw7; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b561a861fso4695801fa.0
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750327217; x=1750932017; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tm4foTyim2ipg707kPzzDB1WnJZtpYbYpFHYr7aNbQ0=;
        b=b1xnOLw7ad4C0Y7FoHKohjFyynQ3u2zALciLRElkNg3lvIJDb/ny6krn8VJOzYDJN4
         NJ4S6asyEq6g1J7oBE/V6QPzl0R16Eh96XM2oOC0q0iLXUPxsPxDX/+yG3vtCOuIXBgU
         Cb6nC8qTFfI2m/b37TvqmsL+TSO1trbX1FzSG40/6UJLmVVc71HPj68sfHeTupnVTtQ+
         kzw/a60iVRaqlopjNaham+ZGk7jxt8RYmVxiLsrDwSkXUZFSLzUbgJfMAjc1l6AvjrnZ
         +rZq5AhS45aFvaMWDjZFc75728uQCIXPjpR1InO9lWXl+erOPAyp54jHf8YenNK/GcYz
         BZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750327217; x=1750932017;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tm4foTyim2ipg707kPzzDB1WnJZtpYbYpFHYr7aNbQ0=;
        b=PUfZLNRPAloVqdt9XoZFd8zP9DKrM9wp0O/kttfKEAEDB3k7NXsOTqDwEephkY/7T7
         H8GNxgWNh+nTW1KiTlx/vcv40LwhVe1IE9AUXslMLqLBYD7HCF383K6v6G/gYzivtzGL
         4j/n4napIxXguFgJ5rURDmNNbxpnAEmYKV2jR6/IGTc7+oIOCONLwAdZdrC3kufSE1GU
         Aviw7+/+S5W1j6Naxkiw3dVQbDr6cfwkN+8ohDLQ8shfvA9zVtCn856G5XYuVNtUNFEe
         uFU22D8nso/C1FK0cakTujf5ayZ3MBleHtmdnBn29YeNrfTz2dNkSWHXB8QHjbGVKKhV
         I5FQ==
X-Gm-Message-State: AOJu0Yxb0Jb/Vo/C6gfjBJPame349KnAeCXyOiks8pCR3racJbnEWVXX
	PhwsRePqDltbiPo6sAds2IJqSyaAcWJerVrhahWp1sFUT7MvMX4Y3RTTuCcF35rYZeHePmE/eAb
	DBNFnzyl3NFcaL10XYVroVKtfp7EefFiBivow
X-Gm-Gg: ASbGncv+w9NGOvEcmvYmR8sB8YVYnsrViFWgFMGxswcfwtfszT+kyUF9K0st/NyJ1cH
	96U7+mtEieqwnCFyAFE20SvQcFvDTtcUOWVOcakW+AJqJhy+DGemiyBKGjmhmuFqt1YoTOnZ7f/
	qfD8R3Jt2a+IVaq9i0xUU91al8eld71WNZ0QGXWCZ69XzNE2jutLWQyA==
X-Google-Smtp-Source: AGHT+IHau4OpGzXGOWE1BKEWgonfN9pS+MANbWLW0F3mMdf4XYmwC2iKZJaxbeBL5nn1ZM7TEtMt5EHRpEQjH65MgRI=
X-Received: by 2002:a05:651c:b0b:b0:30c:50fd:9afe with SMTP id
 38308e7fff4ca-32b4a412cdamr71097911fa.9.1750327216210; Thu, 19 Jun 2025
 03:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Thu, 19 Jun 2025 11:59:40 +0200
X-Gm-Features: AX0GCFs0CkMtMJDoPokmlgzCVq8-51Vo7KUdgtS7PWdZc7Ftr1KinMtfIYondHw
Message-ID: <CAA76j91szQKmyNgjvtRVeKOMUvmTH9qdDFoY-QRJWSOTnKap5Q@mail.gmail.com>
Subject: [PATCH v2 6.12.y] Kunit to check the longest symbol length
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Please consider applying the following commits for 6.12.y:

    c104c16073b7 ("Kunit to check the longest symbol length")
    54338750578f ("x86/tools: Drop duplicate unlikely() definition in
insn_decoder_test.c")

They should apply cleanly.

Those two commits implement a kunit test to verify that a symbol with
KSYM_NAME_LEN of 512 can be read.

The first commit implements the test. This commit also includes
a fix for the test x86/insn_decoder_test. In the case a symbol exceeds the
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

