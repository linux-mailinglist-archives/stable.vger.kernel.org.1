Return-Path: <stable+bounces-136851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE28A9EEAD
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49973AAB7C
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F9125F780;
	Mon, 28 Apr 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z0d03kS9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3538F9C
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838857; cv=none; b=EwPbxg2vvOfnTp/WmrAmABXVktLy/mMlivrRbY7xNASA84miRdXD81QQN71Pf2GfAl9Ldl5lhBhJW08xMHkI8tRd+KZCTygCaRBrb3UU98TQ7J4cSTceQmc2NKySwLdGEx8joIPyUY2Wt/46lU5Toj6oaTiNDCCJ9OIVzottI00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838857; c=relaxed/simple;
	bh=pT7Lb0rIA9RX/6XmXsuzjDLX6SFxNWdjnqw3cJgacWA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uCggpH9IsWH8apbIBvfH/e2IgNXEYiVrZXy9S0hXBoZVqkbVjNN9Eavj1c3HVyEQ+uRnccnxY4FOAcrhNxChBSWs2/B5n4HL7BL9b+PlqE7VUR6QLqYKClaNCoqf+tUrjSqU23YsY2c4gHnX0YdkJgnryYAXLvWyBGU5fsJwe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Z0d03kS9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso5525802f8f.0
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745838852; x=1746443652; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bk8kiJzMGD0sLHcBZ4NnEUHdjmAsZ9rXiSZdO0lCLWU=;
        b=Z0d03kS95wWzFBGDa76/ounKrMzLOvGjxlBh2BrhM/sweEZACzdDWN2tD+N8BWcDL7
         gaTuTLR9bcKzE9rr9SH3wUXBC1GVFka9BaLktSoRnTs5VX+PUStmAJ5aJ47D60/ZcRmn
         Egwy5wpdG60twizzxJY2UcMwReQju5mfgseD2XP3zH67dVuZcJvVn4WfUp2jOjS9gvfj
         1mFNAwfWyDj6b/31jDlKjMM+kcBnjRft77Le24SRAFJWW1YOnkpaEnZ22i11KT1vwrTd
         ddABK1E9fYQRhBU7Hleg5SDJmnh/Bhvv7/DE66G+itKRb/ZlucYGPh4SOZgh/biRzKUo
         Gpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745838852; x=1746443652;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bk8kiJzMGD0sLHcBZ4NnEUHdjmAsZ9rXiSZdO0lCLWU=;
        b=Rz8Uc9uEfdYjat8oEpTf7avntnPfDcQgmmNbLbU8PE3qcB2OpzxCVSSMUZA94OS3ap
         rFpSeJS5aq2RA1A4Xwi1B6/nYleMlw9bjqsiMHTTL/pm/qGqgNbT7l/uzQem9Pl14d3n
         qRoU5T/tNmM0bKN3GAJ3Kk3pZmAT8kuDvCc506c9XivKe8Gx246WcOQyu3fL9z0BRiqA
         q8OK1lUgIjFVh1J5c+5R3km4F6ID4RjLiagviqUBn8ZdPoHSM9HmjYmYoVUC1wriBtk+
         1K1zxKRY6RyS1ky0WQ8Run2LqckpsphWT+knZKMeRsfOl1ukxIMv0IoFaBUMC0JpDMMj
         KV+A==
X-Gm-Message-State: AOJu0YyjZY/ovQ7EFIyR04PP+e0oHHHp6KzgI9DNxBxANKQeYbBymIhv
	Gr5xVW0Ks1yLlqv5Sjf8cJeaXEFSWHUvd88s27/zaHFUvmhPYNNx2/Yf/w==
X-Gm-Gg: ASbGncs2KmQMFOAxka57ie9kL/Zha6Qtk88tPTlGkovBBqneej/wmGKZdmTvQaSRGnV
	ah3Suikg07dYBfWeRX2nXZjFGfn/kVnoWO+I5zvKC9RvXwbejpXnn8bFELkmx288co4bAfE69NL
	KIeijUPArPtR7oiYalpLv37T3AFKPLTbtUjo+MtxQcTrhyS+VnnQXmvw0JS9EAYsmsBF/aQdpcV
	WFASg2kqzxo5Lw5FDOQ42/0dbl1d0Evp2ovDSIzsXVQ4GHk/RXAYvBwHo7HTpFZiqRRxa/Idp5X
	owJF4Afi9KAXRbiEijRGL5nD5sVMSHj0VqiiHOUqA1I6PW0j5lY=
X-Google-Smtp-Source: AGHT+IFXl4AuGPQPUNAr7EAbqddw6n6n0HtiO4Ev25lcxZfgt8Jjzc5K7H23/wW1yrws6YVDmPfAuw==
X-Received: by 2002:a5d:64a4:0:b0:39a:ca59:a61d with SMTP id ffacd0b85a97d-3a074f42de3mr8894582f8f.47.1745838852393;
        Mon, 28 Apr 2025 04:14:12 -0700 (PDT)
Received: from [192.168.1.10] ([176.25.125.185])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a073c8c973sm10865267f8f.5.2025.04.28.04.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 04:14:11 -0700 (PDT)
Message-ID: <fb4cce81-1e36-4887-a1e0-0cfd1a26693e@googlemail.com>
Date: Mon, 28 Apr 2025 12:14:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: en-GB
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com
From: Chris Clayton <chris2553@googlemail.com>
Subject: GCC 15 and stable kernels
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

I've built the four stable kernels that were released on 25 April. I found that to successfully build with GCC-15, each
of them required backports of one or both of two upstream commits. Those commits are:

Title		Commit						Author	
nonstring 	9d7a0577c9db35c4cc52db90bc415ea248446472  	Linus
gnu11		b3bee1e7c3f2b1b77182302c7b2131c804175870	Alexey Dobriyan

6.14.4 and 6.12.25 required only nonstring. 6.6.87 required only gnu11, 6.1.35 required both.

Additionally, chasing down why my new Bluetooth mouse doesn't work, I also had cause to build 5.15.180 and found that it
needed gnull.

I have TO dash out now, but I could send you a zip archive of the patches later today, if that would help.

Chris

