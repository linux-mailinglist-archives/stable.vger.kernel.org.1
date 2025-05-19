Return-Path: <stable+bounces-144890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9A8ABC6DC
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 20:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5633A1C62
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FC828937C;
	Mon, 19 May 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlK2aIKl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BDF1EF0BE
	for <stable@vger.kernel.org>; Mon, 19 May 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677724; cv=none; b=cqOCCUSBOdkpuln8ZDpRIUUQv1uhBEO/UW3nHhbPb/5bJ+Tn37yu/kEbRrC/Gjm1fD1gt1JyVFemIgmK1GS3moNJhUo9bL53jTR8lb02n0007N9MxyR9z4u7BdXe0Bl5KSN162aHym4qb6J0IzHcho2zKb9GyHFWc0fczhYIz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677724; c=relaxed/simple;
	bh=fmV6e2SoApJL9fZft1h0EhXTTUFZizOKyTsHJ/sJGdI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sg8MhG7ojBKZqp61Grnc161wUJv29lGaMIbVtdC5kFD1DFoFCyASbg0+Mfh0j68OLIkg8SggOI0LCtUfN+aHj3eOZGVGU/AZUVbFVvUihBr55iMtCP/xqjv6SPNTv+S8EbLSx6gw4Eveg/aX8tVaO1DVMD/W9MI7vj7WZajAX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlK2aIKl; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a35ec8845cso1785469f8f.2
        for <stable@vger.kernel.org>; Mon, 19 May 2025 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747677720; x=1748282520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VPWSW12tztpw2CQM1Lke535S1u5tfd//R9jqCHi/nQ=;
        b=VlK2aIKlPEYWf0lue/teHTQKQwZQJF/69Eng2VF4AT/UqSVCy6GnrP+rIumvQ6wlkr
         3KWjcr00Rz8Eat2yrRd+KXBJmMShoiimMbGgJO1svfHnIpa6ziCvyEjYBfqv76hGdeWc
         C3RE6/Or+vIB7g+/XvxJQThLbfy8yAdZwnqZu/QL1IKG6KMNKsMvC4X8DfDS/YUbTz10
         /BJNroaVFwiTaC7zJC+gReLTtrP4vcn932PmJgtnnReAfiW8kL/+B3JfNNREz/QhqrH7
         C5Z/Ko4ZRdZE9cXsdeQFL33TOD6w7exFy7soNtC855nYhFJNAWWv52GEhP7/2VE0CNPr
         3Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747677720; x=1748282520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VPWSW12tztpw2CQM1Lke535S1u5tfd//R9jqCHi/nQ=;
        b=b+dpVC7EBQvLgD9i3i1jfTtaztiPOEMzpQKOfxOqrZItMCVR+HqV1nLzskHR37Xwjh
         VdImwFjtE8vvxlRr4v48KeT1+Dk49XpnuvBFbG+B76SmfTP+bskawZBZc2Jb/ifxVeTH
         tOoiSuCX4zpsfFdFkOwwRgGpT7BZf0/gTDDy2OD/LIaWO02yAImOahqJmqVjRwBIiV/j
         u0zYEWIMjdhArhHF26Lp2HdZApQFcDbIiUKL4A6pjkhIot0rzY71RFkoVhMZn5cvdpyu
         IxExEUWzZp6/yjTw2bsGbwuVWqHMFmgrrRU4M1GJKK28SrfOMFR8uDMmIKQB14TOG1LX
         /L1w==
X-Forwarded-Encrypted: i=1; AJvYcCWK9n8ZriuW50tvPOl3MKkytAI7W9ZFfvQyQSZIwF/Ue5p6McbIMlISuB7c1iuCMU26pbsWRKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8jQ7Pb1zSk5MogURqn8+5ovpLeELED0uKMYU8j18fUzHTJKF
	6WVM432vhWHLgt/LNubsNLSrMhY2H97mD7prwumVyy+uWcJY8vUfW8UjoO3hLG+LUz8k+zPwUAZ
	gzl5AF5LeFVYKY2samQ==
X-Google-Smtp-Source: AGHT+IFJS5J+PnbHa1RGDDnQqAtZtergrw5iOIz7IkL3LlRlfJiUovmWWT/ojC2/wXOc/jLurPsAKI6k8uRKjLA=
X-Received: from wrbfi18.prod.google.com ([2002:a05:6000:4412:b0:3a3:5c04:8b60])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4310:b0:3a3:69ee:f4ad with SMTP id ffacd0b85a97d-3a369eef6femr6547198f8f.22.1747677719934;
 Mon, 19 May 2025 11:01:59 -0700 (PDT)
Date: Mon, 19 May 2025 18:01:57 +0000
In-Reply-To: <20250517085600.2857460-1-gary@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250517085600.2857460-1-gary@garyguo.net>
Message-ID: <aCtyFZwt4jGXrL54@google.com>
Subject: Re: [PATCH] rust: compile libcore with edition 2024 for 1.87+
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, May 17, 2025 at 09:55:59AM +0100, Gary Guo wrote:
> Rust 1.87 (released on 2025-05-15) compiles core library with edition
> 2024 instead of 2021 [1]. Ensure that the edition matches libcore's
> expectation to avoid potential breakage.
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> Link: https://github.com/rust-lang/rust/pull/138162 [1]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1163
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

