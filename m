Return-Path: <stable+bounces-71358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC55961BFD
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 04:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB7F1F24A92
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7D288B5;
	Wed, 28 Aug 2024 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eE50MIgn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D291DA32
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811349; cv=none; b=JJ+rZC6dQbfGuv5P7nZvAWwGoKXRe/l1/XR1RDQqkLDwDg7jjFIVBkpjy831l5qrNKK38pIiftngQA/TIcudOK6Jb74JRB6AIbHBPgmklmZz5n5Rnj22tajc6Y4abW5xazdiOAukRf04ayY+FGxrVjuRQhY9zNQgYml/RpMlmyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811349; c=relaxed/simple;
	bh=zwNOl51MqgpZYaovVWnx0LD6mFNlUsxA9axyf9qQSUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGBsxdwTHyqaQw3OQFOBiE2hvKe5r14DjqChXwPzU8w7NKxGZ3rnEIuHu8wrXn5o5KN+n+73afaIHTiQsSPUt+29xqEDdrS5fktdtNMqzvQOFhw3LcTZye9PwvqiF2yU0ED/Y0dp4ot617QmCPYY1pwGndLbPEVwhCBfp2Wys4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eE50MIgn; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E9C353F183
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 02:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724811344;
	bh=zwNOl51MqgpZYaovVWnx0LD6mFNlUsxA9axyf9qQSUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=eE50MIgnYUJMnFxUkwC8GHgQ40fRAIvbbFrIpbKM2NDx1evV0/zkSXpBiNweE5+rJ
	 tqI1bPgCu0IBe4Sh3tWfthou5CZ+GI/PYqD7Mw63LDZ6WkLNQA7FoepGuhoLYPNYhz
	 i358PiCAsuhlizDuz5nuuK0UsULWMSPIFlqGhlC8rg34cYndQ5bcv48K6K3tkyx2NB
	 PrKuCR0zsq9NaZ4Qdn4tiO+Cbze3b//ukQbWw6dd0S/LvNg5lJ43bXE+4V4UNchDvi
	 SuHXaFo6/67s2X8yPUXEO9Ey/eMUI7YSfte2cNVUqG+ipf7HbVKS57Z3MSHEzqMkLC
	 PsJUbfbxua/zA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44fdd97e455so86552211cf.2
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 19:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724811342; x=1725416142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwNOl51MqgpZYaovVWnx0LD6mFNlUsxA9axyf9qQSUA=;
        b=NGJI+4mwkCSU2b5kEDjEWETAKuNuN550PKg/87hm9sYSFIlweieRmK7U+k5Lcj3sWK
         Wl+Zd5+rgOAK3f5IVzp0mbRTzS8yNspcEw48a26SrWvE3AQhbYfyJXlH7mB0VPs1N2tO
         erLjYUA/ZnUOe3OPr6jltmchZpBMjTaT0wVzQyDSEZ48HjiV4ZxVJnW69t0GxbwQwRks
         CFKLyNlQ4ZGoUOuS7ACfgCDLgzKLCEAWwCA9nRNUITrbxe0ASa1BWoDyoAFCgKbuqCDT
         T+VjrbBn+pG9KX9rymx7j7hsyCmOgC+WuMrMM3l8puOfZ5jxHkslEBlrTJwGdT2+FloZ
         F4tg==
X-Gm-Message-State: AOJu0Yzkf1ynfpw3fIe5crCIH8DvXG9Bl78gH/tsTODlm3em+G+uR7gS
	7aaEcgyds1YGdCucubqU0Aw1jBs5s4oeUAwYzXs1txHRGp4dpbr+DaJcTq5bnSWOZh9lwH7PVCg
	VBoun8M/LiB/5u04Mg2WrPr2ubCSX4wmRfubFlCKy8JPUP7UQULG937kl9K3t+Z71EP/Bs3BUsg
	OGgA1F7VC9BFKfXekFkKCjOWh17Majo/FAUKf6Aqupalwm
X-Received: by 2002:a05:6214:3f8f:b0:6b7:ae05:df99 with SMTP id 6a1803df08f44-6c16df10490mr195281286d6.40.1724811342339;
        Tue, 27 Aug 2024 19:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmjZsjCita1Ig4NCBBNRZBW8gw2MM4b34KsmYyF+mNAt8ff7/g0/fBzCZQYrAtV8uwA+C/a6lonKVY8TL+sAE=
X-Received: by 2002:a05:6214:3f8f:b0:6b7:ae05:df99 with SMTP id
 6a1803df08f44-6c16df10490mr195281146d6.40.1724811342010; Tue, 27 Aug 2024
 19:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828020150.2469014-1-koichiro.den@canonical.com> <20240828020150.2469014-2-koichiro.den@canonical.com>
In-Reply-To: <20240828020150.2469014-2-koichiro.den@canonical.com>
From: Koichiro Den <koichiro.den@canonical.com>
Date: Wed, 28 Aug 2024 11:15:31 +0900
Message-ID: <CAMT+LOC+mPNNsT--mR-eCNURAc7kzseN6aZ=MCsOk4Adv0wumg@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM / devfreq: Fix buffer overflow in trans_stat_show
To: koichiro.den@canonical.com
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please disregard this.

