Return-Path: <stable+bounces-152597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E62AD80D5
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 04:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398373B8959
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 02:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C871F8BDD;
	Fri, 13 Jun 2025 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqFE/mpa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B631E5B7C
	for <stable@vger.kernel.org>; Fri, 13 Jun 2025 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780780; cv=none; b=GZ2x2bSCah0tlGmc5XfGwOZPPNv+yrxq/C2e2N0V+I8Jo+VBYKmnhvkd9hmlkBWDF7akJOtD2twUWXKwwDFojc+AtsChL0YLG3hLM8wbcO3diiyMLRMI2snultu31itZqAmJKJ751WJZYsFNh9A53JVrozkFy6Q/1QNMJ5Ri+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780780; c=relaxed/simple;
	bh=0n6xKtbuDQY6G+0/L/F9fnARyJe2FFGoyAd3+Bcd5ng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kN5t4LAx96TH5teQLIP+9eBvbpUxbJrML0lD59QgZyZttNhiGeYnDA5oYdBkWkKkVVzCprgNA1/gLyGyu+w4SibXPh2RY6dZAc4OEMtIqqBMwoYbUWT76C/9u9qUvN0ca6PGMaIN7po0ke8Rgq5zjaMu31a1zwVNNaw1udb67Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqFE/mpa; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so1017276a12.1
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 19:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749780778; x=1750385578; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hA5PNUdIZ+JmMrzptJYJdiFK4HF3VPgHYOcvKuhG3Pk=;
        b=gqFE/mpa+zVswzYQtiBKDveUA6yQs61B8j8LKDFLAzQ0Z6BNQpiBPrsyYG/iDEgy8p
         wIzm/muBzHfuVukqFAuT1xYSZQEjXfzNsGgANs/E/j/WYS/5n3Gr7S+mXmFDrv8Beoaw
         eFuxmjxUmxX9NT1SloXa1wX90w1y4yTlvsHuJwVm6YfC1am3kCbPL+Yj68bwNR4BItpA
         o54rUEk7a/WkmXw9nQp49JS6mjVgwF8Uh/4pg/7089+08wLt6NXmKNxcKScm2r6Hbhvy
         GfXnSCqE1DFz1USWdRJXl1Yskw/2NiSMiidlTmmBUGbYN+DOLIOPCFsBVjdUIZutnhzX
         9zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749780778; x=1750385578;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA5PNUdIZ+JmMrzptJYJdiFK4HF3VPgHYOcvKuhG3Pk=;
        b=gP1QDMyjDjyxAx2AfOl1xdzt2jIMe6cPHJ8h26c5jFeZzo4RvllfjNYQWuleCFhQ/1
         RgOIa0MLXotQEdCf7tghnif4dtzcW399dmw8cA98A0LfYGx23M+jjZYiPCN5LQIJGZ9W
         ii1ZwGFWM5Z6ostG/GLSue64CAcdMbntO5LGyBmYvfUh48+mlndSwvoew8SP6iFo045Y
         D8FwsnnapDxM8loHVv1LIumEzSxmYMi+Tb5dIzmenRaa4XAdJxxwgGS+Kz0fLJvTKlg5
         nwShupY1GrOW1wJABzKGz0hY73F+f0Edr8voJhny7mGguY3DT+IjyT4wsYrhePCfdiQV
         EACw==
X-Forwarded-Encrypted: i=1; AJvYcCXKg+RZhpLGDNcLWtcBif3HAunrNmzt8YQBy2upW42Bnh96vF6dfUSBBz5gEYWyqugr1/4AvI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEXB2pazbLFmezdjHypQIssIrR0xZsKFI9WW0/LQb67/na5Zs
	k0FmEIMRYV4zxzt0dB4e6eXXS7LovxH+dloR9xzMbxS2Ttbs8KoxkOA8
X-Gm-Gg: ASbGncsOJbnpk9SPl1Hh7WxvKIUy1q4rcmnmdHD/vR75SBPBh8+tXBcSvtGWQuClZ9Q
	GK6yKrfnMBq4Mn/k9clnF0IYVKr5xMgNc92d90PiUNC2AXRQsAU0h+4bGTN6UhIOoh12DlX5ZQa
	GIaAKLKkdE/9SvcYyhNUyqzlEFhYYazujeuQeHzGV2fdPWJ/U+04U24AYBn5/U2svIY15kDPxbU
	VhCTa7IPcXfs7mYWYzXIvLuahHmvm/8sP1/BPcH/LiJgwEkBEhGFk6+UUT4NBu0rC6o8Cc7hcG9
	Aoxy0BO3vGDfoJGDwHazo/a/kfjfIX5NUT/t7kmZ7g==
X-Google-Smtp-Source: AGHT+IFd0X4fVlfy/Sj7SKCnZ2+k8ZfFwMQcvcYO+UMt1DilGhPBBy1wimHt3DWPorXsAVAVimbFvQ==
X-Received: by 2002:a05:6a21:a343:b0:210:1c3a:6804 with SMTP id adf61e73a8af0-21facec4603mr1757128637.31.1749780777994;
        Thu, 12 Jun 2025 19:12:57 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::f55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe16805c8sm398181a12.44.2025.06.12.19.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 19:12:57 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  stable@vger.kernel.org,  patches@lists.linux.dev,  Ahmed Salem
 <x0rw3ll@gmail.com>,  "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 6.15 05/34] ACPICA: Apply ACPI_NONSTRING in more places
In-Reply-To: <5c210121-c9b8-4458-b1ad-0da24732ac72@kernel.org>
References: <87ecvpcypw.fsf@gmail.com>
	<5c210121-c9b8-4458-b1ad-0da24732ac72@kernel.org>
Date: Thu, 12 Jun 2025 19:12:56 -0700
Message-ID: <877c1gtmmv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jiri,

Jiri Slaby <jirislaby@kernel.org> writes:

> Ugh, indeed.
>
> FTR this is about 70662db73d54 ("ACPICA: Apply ACPI_NONSTRING in more
> places").
>
> To me neither the above, nor struct acpi_db_execute_walk's:
>   char name_seg[ACPI_NAMESEG_SIZE + 1] ACPI_NONSTRING;
> is correct in the commit.
>
> This is broken in upstream/-next too.

Yep, that's right. Wasn't sure if it was best to report here or upstream
ACPICA, since I'm not sure how often that is imported.

Collin

