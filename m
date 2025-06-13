Return-Path: <stable+bounces-152598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C39AD80DF
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 04:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053EC1897C15
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8631EF36C;
	Fri, 13 Jun 2025 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0YTr+Fx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970B1EA7CE
	for <stable@vger.kernel.org>; Fri, 13 Jun 2025 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781048; cv=none; b=brU9HFKcAb3DhwL9/uL2//WqbM8wF0QXNDB5GGLmG4uM7WhTXO4HYRCrv5EMefoJSYRpNOp8phFqrfZLarwQBMDwJjBJjnBwN0ICpG2oHk7QidwpPqPs/Fay40K+1A4w/OeNhSiMf7aYJsyWZFf/nbzb6UPw5rTmZXxKdacLxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781048; c=relaxed/simple;
	bh=NUDxPMataEvCFbMf4ol6/OGJGbZ5DtNd4C4vpmftFMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c0tJ4mgb0eqRSePt2mLEj+NSWTVQ84SP2ejJ6NFQ2/YICBFPC5M7j4mYAc2zpnoBA+q09oFfn/ORcuUGu4V2XSVpcGELXyZfHn21zIvJ8eXk8h0KX9w+ymp2uqzEYIQzXWUgqhoPyQ8pS+6uUTy8Td8O7O0qDFQ3uRUhscuQvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0YTr+Fx; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2fd091f826so1237209a12.1
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749781046; x=1750385846; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NUDxPMataEvCFbMf4ol6/OGJGbZ5DtNd4C4vpmftFMA=;
        b=d0YTr+FxYWKbe1iu3M8B0gxVUjpPLMqoeS6jlErZut/QtUKPjrCQgV15teM+US9kor
         r1ypEhVoAXAA34XfgLN4ucHZ/9Isq644S17MN7eqlkMExHi7jm4mi0tfRAzY5XIV/hL8
         B2w4V10A4JW+MpnPUXz6xKjbGT+yr+hS1J1T8oxJlcJF9HRXPsw7zN8WFxcVlQuTL3x8
         tbkHdrhArwCgCAKIdxSO4je1t5SOPOqL+0ufD5YdTF5/aOdot3/x/iap++syTxCurefg
         1+TFGqM/nYf7xR/LSQDGzTsQbzRrXto2+Hr4so1MihhXjLqMQ0xn1K1sOiucs1dU3GP0
         YhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749781046; x=1750385846;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUDxPMataEvCFbMf4ol6/OGJGbZ5DtNd4C4vpmftFMA=;
        b=ERVsbgXYTzFa+H7YtulXAA0RnAVaoefBvKW3wDe7ee78w/YSrcUYCNZkqZlfT9DDbk
         p1O5d1iIFrM2Q0Azf3J855nEOnbcA/vBIiSOM7BWnORoMx3D1MIqb45+2N7BlawR4wAw
         eeRLbMkvdcd7Nqw+ExsiEdmRWN21Y3h/+3b+EB8YvNDQPGGCrkKhgJNCqb5YNLXnNs5A
         13OxvkNSVwWJHhqGd8iXFRtA86rth3LFYwk8MxeDgpvRzWJ7Zh3jqgBed9TVJydic2YD
         T5qC+6GL78WpfuyAfplZi6IWmr0gp9jz/6XccAvdmKpHDKwGsw7KuQMObbIuNyagPVzn
         pe8w==
X-Forwarded-Encrypted: i=1; AJvYcCUYlmHi/jl78T1ZO7u9QxCUCX59T7QbeVpUUAWgfXSjfhOJvMuKN1SkwVYO8RUkAWD47+NeJwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXQmnvlKdnBinsPep6bqaPMSnVtQles//oPQK6eehudQSXxmQ
	jmFc4L+t7hWHvpKVYaxwgdRPiiQnncWB72VrZdSbvV5NXo1XaZ6t+kcU2DbWmA==
X-Gm-Gg: ASbGncubUpCMUeUvHSSPXi8F9ER5Y/4Btdfr+yqVwGtUMfuVOo80txvsxspPrKrJb2T
	RYRsOgBgPgK6X2hMEtFVtuHHmKvf+gmCn78o3aSxqP538bW99RuWf3PwoxmiRGoCRfYjWVVLijz
	z2j24K2hjfYF7qV1Dz5Ul/unDSrqYHQC9Y8Nl7JUo6L2CbABLQ2MhnvHdNbVihPGVyOI6jlTbsF
	BnazSSNP4kM1Q6Qp9XZOAVnnTdPvQeB7ckjsPx5piW6sQ9Cxmfv8Fle0bS9ptbFUMhgsfFCm+bH
	1xKt6YuF3DCGcVAunQ5RdiTW69yCNZxZAC/xdGGqxQ==
X-Google-Smtp-Source: AGHT+IEw5WjanWEDLG1X7eGAa5C3gNbnzr6H4t+9xgEgCh4Bs6rTuwlJibxIHRYrLNDWh6Unpvc6nA==
X-Received: by 2002:a05:6a20:a11b:b0:21f:54e0:b0a3 with SMTP id adf61e73a8af0-21faee4e610mr1073126637.2.1749781046083;
        Thu, 12 Jun 2025 19:17:26 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::f55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1639f44sm412874a12.4.2025.06.12.19.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 19:17:25 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Ahmed Salem <x0rw3ll@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  stable@vger.kernel.org,
  patches@lists.linux.dev,  "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 6.15 05/34] ACPICA: Apply ACPI_NONSTRING in more places
In-Reply-To: <3nobung2ragvykho52thb2pouxgjatmh5cjtc2vh3aro72lkk4@bp45zihoq6v5>
References: <87ecvpcypw.fsf@gmail.com>
	<5c210121-c9b8-4458-b1ad-0da24732ac72@kernel.org>
	<3nobung2ragvykho52thb2pouxgjatmh5cjtc2vh3aro72lkk4@bp45zihoq6v5>
Date: Thu, 12 Jun 2025 19:17:24 -0700
Message-ID: <87zfecs7uz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ahmed Salem <x0rw3ll@gmail.com> writes:

> Thank you so much, Collin, for shedding light on this issue!
>
> This is now reverted in upstream ACPICA commit a6ee09c ("acpidump: drop
> ACPI_NONSTRING attribute from FileName") [1], and pending merge.
[...]
> Thank you so much, Jiri, for the attention to the other issue.
>
> The above issue is now reverted in upstream ACPICA commit 4623b33
> ("Debugger: drop ACPI_NONSTRING attribute from NameSeg") [2], and pending
> merge.
>
> Rafael, the upstream PR [3] is ready. My apologies to
> everyone, and thank you so much for the review and efforts!

No problem. I'm sure many others made similar mistakes while attempting
to pacify -Wunterminated-string-initialization warnings introduced by
GCC 15 on existing code.

Thanks for the quick fix to ACPICA.

Collin

