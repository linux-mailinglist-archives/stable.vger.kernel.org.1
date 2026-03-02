Return-Path: <stable+bounces-222613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB1eIRCgpWmuCAAAu9opvQ
	(envelope-from <stable+bounces-222613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:34:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FDD1DAF26
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48E91310C488
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A73E0C74;
	Mon,  2 Mar 2026 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODWTOi8d"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ED032142B
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461247; cv=pass; b=M3u60VcVp+L9XMVm38VCvV9ypnn2hJgRlOwOJmNEOpd608uSUoKWKJgGUA+7ImcMDvPwdL51YhXobi8dGqzDcUasH7KXwCikOEjmNxU2zCesQJmXT37n6SeyHiqXQl3cxJkU/QLRDyzYyiEAT0sRZy95PDYfzoBb1QWPYBYqvwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461247; c=relaxed/simple;
	bh=v1iJCitIlusxSvV0ZmYGh6EV90eFcXE9L9mACC4oXLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRJXKwInTG/dIFWctdncuBZ4F4ZQwldtH3eRhMBLWs3uxe5Bl8UEyktW7u00ldMsrWVeZmbCG28btGhyUXsBwYvgih9qCBEOQPWtrDhS6QyKwiPlj5VbRERbAKLLfyTfG5ydqxxSqQGeWzJmSZc/iZDLW1Ev9L9Fn0skqQENEdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODWTOi8d; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bd5658b901so208582eec.3
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 06:20:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772461245; cv=none;
        d=google.com; s=arc-20240605;
        b=dscg05vJf03qMYjE7SbikTuyXTJV65RVKL3TLvGm82E9bNKnSvRVhl3cpAlNbajDS0
         0uWj2C/iaR/RfWDU6irdYO2cU8B5XgBXmVCv1Jx8aZIDmqPdkQ/LlKxlyLbaxmzKD+xe
         0Io+sZqORX0LRO1UhT9hfrCH+5K1HNNPND+KlT3sYx6ufYg9as1KjMqik0b10ORt+TRc
         kcUQDu/sbfZrz558aWb7bEd2C4hAQRPqnBW/pI/0UEFk5eTPApO1wotSgKaa+7v/fF6w
         /ex2L3a3v+E95XA2UFTtJtMm8VmjVyX7lQVwhil4oraCZeRjTXsyf//C+6P6iU5JXFKK
         zHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u8dgdlnRXlNMes5eV5ld7vZ3X2CzhT0OJUL+NBisd6k=;
        fh=QjeR5B6v8nNIwIATbDSIjOO50W9eBKTsXOGEzVBRmMo=;
        b=gmoIFKQ8A8SohsjrNMKomKdvJMFRIrDq5Z/OuN7CbbG3n/S4tJpiuRkJ7fduYoOyl1
         ZvIaUJDLrnmw7jPXdeFFodXsgQImkxRc25WuCNpxngGqpVBYWoF/4hg8XUro264hbHA4
         M4//6vdosgCi4jfjlmEX9hLB5TMt885HX9d8YxP8axw8qUQmexWk6a+ekZZT4fXEFD1m
         ZyEnkNrdX5VwCjhBPdIsqHACIcBBghbC2FnY+jVQ7l98MDjw/FCdX/WwpOWELs2PTPRb
         WPFk8ra6m06j6DBm0J37/bweC/S9mqQuRfwkVm3J9V2+0prykw4qOg3T3cgz2YwwOmpM
         JC6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461245; x=1773066045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8dgdlnRXlNMes5eV5ld7vZ3X2CzhT0OJUL+NBisd6k=;
        b=ODWTOi8djhSnmrTmzpyzAfTvKnr7So3zRqcluaI5l64R/lMyt8PJ1jyQg4GeBirKFR
         zBfxv2VQXsPvfFDXAV0/fBKDGVN459ceP1Xn/z1kNNGGEOyFN5GdjxWK58qEUk2j9rOX
         utzft21XNJfPNj+YWBPz6GiwBF7WevcmN+6CSFGUVw8VSsYPxaxR+wVbOgM7yGLYv/hS
         f1ZYF5ZMFcxX0v5aonQYHE7xYN0+owk7Ro6c0bBf5tATc1x89kdAY2Qt87hauSJfXnxL
         cpE1BZFrLed4oF4XHm6uXEUv/R+v72WVq9K+Xpfiw04/gG5L7hUi314HtocAvU4Xh/JX
         pt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461245; x=1773066045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u8dgdlnRXlNMes5eV5ld7vZ3X2CzhT0OJUL+NBisd6k=;
        b=jACzcWSyiJ7nmmGLMhkUd2o3rxpFdI8I5c9nZrSn0N7ngvVxyfaO1OEbASrW91k7p/
         WdiGXKnvYhlnA7/0lCAVUenVU6YbkyeVRX/Sb9rI17usXiBuSxnIfv0EE+kjrn+UfavX
         sbuCb/SqkXTCNsPZzaHBUJKO8lErEzm18ePnLnBOb5Aci0xKT/0C2y9+OyD95WgvbJYM
         cVGzack+zlGMhRTxJ/jkG6z/+EWh+kbZ8O5WYaudxv6dZ6zpmDiY6tl3q6csyDaGpuKD
         m3WXfSB7i9pkqeAC+olyQbAW4EXXfBSzqwTD3fgkPBi2hy6OA9b854azFVdldbmQOfV5
         SAgw==
X-Forwarded-Encrypted: i=1; AJvYcCVGqT3m5G1aXdu1seqq8/w+tYMHSeyZ8WswhgUqmnAGgp4R6WVoUQzkwNvV82lkCNraBt7T6Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xeuc3zkqf+2v0mTfFC8Wjh+DruTpCG8unWiY1+g8KGMOWmzi
	3mfcOwMMIyOPCVmRsRDqS/A0MKs/4RJDy0hqPtTmfLk9Q91VKACfRUv2zDvvbmSibjmeLZ3g+3q
	z1B6MrFqExdoniLEj4kgYyzhzT9BYU4E=
X-Gm-Gg: ATEYQzyuJeb/mvLbKQaPR8lpCVxnhL26Jgh/L2/mjjRE5ZCyN9n+/xfQuY16rBJuSjk
	+jl9bbt98Dp7uGypOWEzDlEv5YwMApDgwjvhnMWsfeT3qzek4DPPczwpINP4fjFZLPG4LB7mArT
	8ZTPoI+I12trlXnAg2HjPVN4Jk1jf3q+HSoMxo46KtQhOMiJbD7B6OJziF3thPa53HPHDRp0eKk
	HcrQpkPG4/B2StbUlKHOlvVxPZaZXQZ3JHTcV3fUeG57xT6SPLKJVjSunoamtPFc8ji/+0k/dZ1
	Fju6fC54G4uHnjXc6BPdBZ33vvX95JmT5dbw5TnkiyTf6tu3fkl5l6Ub5teJVpuBPFLHlZm1QZh
	d8RwuzfxWhZQz5S72O6n5+bSvDeB95eYeGk9O8Ow=
X-Received: by 2002:a05:7300:dc90:b0:2bd:d8e6:90a9 with SMTP id
 5a478bee46e88-2bde1cf8740mr2816706eec.3.1772461245499; Mon, 02 Mar 2026
 06:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302140424.4097655-1-lossin@kernel.org> <20260302140424.4097655-2-lossin@kernel.org>
 <DGSCXPXGW2SW.D8VR5QI5OVNT@garyguo.net>
In-Reply-To: <DGSCXPXGW2SW.D8VR5QI5OVNT@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Mar 2026 15:20:33 +0100
X-Gm-Features: AaiRm53KptjDkt8bfE05WqYGIUTryLO7FU3MhlZQUv_hDS9KcrKY5zr_tkTNAew
Message-ID: <CANiq72mWrPR32O-1rgs7fz0aJTS2rcjGMd7omwvr2cSQkM9rig@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: pin-init: internal: init: document
 load-bearing fact of field accessors
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 26FDD1DAF26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222613-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 3:14=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
>     Cc: stable@vger.kernel.org # 6.12.y and 6.6.y: need commit 42415d163e=
5d ("rust: pin-init: add references to previously initialized fields")

Yeah, something like that is what I would have probably written. The
docs seem to suggest a format like this:

  Cc: <stable@vger.kernel.org> # 6.6.y, 6.12.y: 42415d163e5d: rust:
pin-init: add references to previously initialized fields
  Cc: <stable@vger.kernel.org> # 6.6.y, 6.12.y, 6.18.y, 6.19.y

i.e. first the prerequisite, then a line without it to indicate "this commi=
t".

Cheers,
Miguel

