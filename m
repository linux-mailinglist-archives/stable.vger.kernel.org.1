Return-Path: <stable+bounces-139533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98664AA8006
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 12:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1737A5C9E
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8C21D5CDE;
	Sat,  3 May 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Zw62AhbW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102801C84DD
	for <stable@vger.kernel.org>; Sat,  3 May 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746267884; cv=none; b=Ek0i5DRcURnR415Fo2aFNV05lfPWtUJ3QQcF9wtEPaE9S7QFP40R5BhVT63B4eUoLmwCXYLxiMyzKfEw5sN0qkgWc1RqUqcO1+MYFaaopsRJLvDhn6ih3VjXthZBns62Z/WJAISezAKBn3UbyJ4MdPsTD1eV+snkdY+kEpcDNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746267884; c=relaxed/simple;
	bh=0qCQqJmGg8nHWn43651G41ZQZWqTiD0gQV2dJT64BtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dM38amr9h5j2q1b0/JJjjg5C/6mzPqidS9ljKcvcbGdP/zcQ03Bxwc79sF7aNFOzVzF6kA65cmoryP9cnzMs+Mb11HqF0VI+1jHciOX7b3k9MQ3TU8DMcpfOUMERbDMdZwBuvAy11P/SQ5V6JpDBLPKa1wqkY7db8BVn5TOE6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Zw62AhbW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54e9021d2b5so5029801e87.1
        for <stable@vger.kernel.org>; Sat, 03 May 2025 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1746267881; x=1746872681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0qCQqJmGg8nHWn43651G41ZQZWqTiD0gQV2dJT64BtU=;
        b=Zw62AhbWcIIpboxR+cLFIIEHMQ+SC755mqWxOUPHfYqHIowCO2fLUhCOilnQ2KLOhL
         pFcdx+1E1nXdD5oT9OJhpYYPxF2KgqXad7bKm8x+Gk7txWALOmsn2U67h1JlsYP4xBND
         u4XjzCAvQr7kn8TpXmetcTgOAUxEUPv8PwLEd6pwyKpRPj2f7a8yVVbjVr7sP+zc/4wD
         ng+kQcQnuF0T99QqnXQZzEvYOGYbRuTZ2PtRiaZXkCyk/cVMRwlZPuQan9k9npzUGgSR
         2wBrtidpqgfcLHnVbdrLQi6oFxINId/1oyr4MITBIPefexm8O1Drk/cZoLgZcUkk0IoL
         y9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746267881; x=1746872681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qCQqJmGg8nHWn43651G41ZQZWqTiD0gQV2dJT64BtU=;
        b=hW41RIrL/FXvLdCHRLcgwd5K/sDlO0tsG5APY3p5sca9SBFi+Q9/rwoM8vNWb8GW1t
         QLbKQv/MsoMB2tHyAQhtIwzsMN//YjlEsp7jk72ITZtImwOENkPSBoXzlmUlFlnqBdsl
         kbLDwIxTQTSGO/kIcFEidxF5X3uthGvmeeF/ZKgcZ+gVrC4k4I4YVpf8sowWna6rbHVC
         5vqSOpZ3gvaxI0XdOIQq0mbJK/3Bw5S0DhdiApuaLG3oChFsEM9uvRPZ+ETOquUn3WuK
         1VxGbiNBDaWj/LqWJG38I04Ssm4RW6kCTTYPhs/zHH+Vu7Ulj0XwqZbs32iMZVg3HEwa
         +dEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpXcjnvKWqvcEHRlYnhXbI4xn52H4VafeuQWXa1MT5NShOVAOwIampr/TGUdRMXoZMRyDrJOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHORhEcde6C2Qbhf9LJmPJfN+0GXe/FGGOW+t65hx+KGsSeM1
	YxFjOvQuzUwkvQk9iDst8+S/f65fB1CnKZ9gl90jlcqevhCCheod8AWNBGmjlOeifHo15jXt6pU
	1TnHg5QlLs37vgbiEYAoSrW26mk7acD5g37oq
X-Gm-Gg: ASbGncuyVo7B3Ms1llXZaPAKBp3ovd3F0JBz2zFz3KXX+SLijmtBy0hNMP/CwD33voe
	L/IhLVpmEqf32WSXtm5Dg+xDDJuS0x6scxgcvVJKAaSIA0Bk+4pGf7bMd8uzSnjgvql6RrJYHj9
	kHIGhBF9JlfKvF7Wqf4AQT8Xej2/T369ypldvbM/QFAHpSrfbK4uo2KZ7u
X-Google-Smtp-Source: AGHT+IG5XLjqIeeIPwFlKAkJ3dRCAbqrk9r6ZoG99ElKCSQBWM4Y8aLZBVuXKoVEWRVAq7zXzUH1hRJ/eiftMHR/LTI=
X-Received: by 2002:a05:6512:3b94:b0:549:8c0c:ea15 with SMTP id
 2adb3069b0e04-54ea79f9549mr3087948e87.0.1746267881065; Sat, 03 May 2025
 03:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
 <20250326001122.421996-2-s.gupta@arista.com> <2025032553-celibacy-underpaid-faeb@gregkh>
 <20250325203236.3c6a19f4@batman.local.home> <20250325203723.53d3afde@batman.local.home>
 <2025032554-compile-unlivable-0fb4@gregkh> <20250325204731.24f26003@batman.local.home>
 <CABEuK16RdmvpbK5CpcuYrzdo_1GK-8eUkmb5x1BKk9bPcw3weA@mail.gmail.com>
In-Reply-To: <CABEuK16RdmvpbK5CpcuYrzdo_1GK-8eUkmb5x1BKk9bPcw3weA@mail.gmail.com>
From: Sahil Gupta <s.gupta@arista.com>
Date: Sat, 3 May 2025 05:24:30 -0500
X-Gm-Features: ATxdqUGwOKdIo-Q4V5eiLmHPD-F7dzkF0pGs7QY1PB2DuRqDOrWoKS6Y9LdDxOA
Message-ID: <CABEuK14WgiKDLW-Zdz+RPsgpHXA-VK+Cp1u_Qd5EBo2eRb3npg@mail.gmail.com>
Subject: Re: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64 mcount_loc
 address parsing when compiling on 32-bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>, 
	Kevin Mitchell <kevmitch@arista.com>
Content-Type: text/plain; charset="UTF-8"

Just wondering if this backport is still going to happen. I know this
is fairly bottom of the barrel so I wouldn't be surprised if it
doesn't.

Sahil

