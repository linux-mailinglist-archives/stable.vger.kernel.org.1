Return-Path: <stable+bounces-124741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0048A65FC5
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 21:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF4F3A8AEA
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 20:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002D31DDC15;
	Mon, 17 Mar 2025 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZztjcdx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58C1A2567
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244859; cv=none; b=JxSzgrYX5kFGlS9Yj+6Rmkgu61cQfPfSCtuI9gq6f8evLfCf5t+BBDTpmldrPdSoO/w4OzNu04gTnTpvsfePRLEiXSUwZXmztXFKkf6anGqmCvZ6rEXVRMFv0Ugg/YVFi2Ifkx3O1plv7qrZEndpy41AxW/b7+WhYD+Y3glxeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244859; c=relaxed/simple;
	bh=rp1lfBaqG6s+7HUWjxYxVtK40n4J41ToSNlPf05r10s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjhkYaVYz9OGiDrK5U355+R3xs/qha97P/xPSdsotypuBm2a3V0WwJZzFX5zEUUkLMcfCQ5v46XxAaEZ4CYc4WFMd7WzCQv+dKPdi/g5n6gri18RQqPJ51fllAle9Lvx0wTZMVzs7V8zUlZZlEPYTayLyCjdmj/kv+581v6msa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZztjcdx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30144a72db9so797087a91.1
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 13:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742244856; x=1742849656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp1lfBaqG6s+7HUWjxYxVtK40n4J41ToSNlPf05r10s=;
        b=WZztjcdxTv10UXvpFRm6NspaW+LmAYTL5lB9Lz+aZyI8ywPBeG8Ebb1+SUeCEwwSgV
         jAJV7Jkjrc5tvvoPpSzi+rBdU8AmnmaX9P47b/eBUDcTDQ3erXBIMeJXQPZgIL5TmaqC
         qv7r82LiHAmbZK82z0dxlkDVHfn8xK9pWqvmzMkGzueD3JdQkQy9qdYWj4YZvLng9Nls
         ljcxDw2i8aRCez5zej2NfDjNRNwLrzJbEM1CS6ZntOI3UQ9a9zTYTMdJBBb91c5c9sAa
         2FEqPXbcIV37cX4S9W7d9yzg91QR8VQBIMLDyrwISFyJKMS2T7Jq3VHjMGLMxYv9PtsF
         9YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742244856; x=1742849656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp1lfBaqG6s+7HUWjxYxVtK40n4J41ToSNlPf05r10s=;
        b=dCoKt5+GjggoSVbVHOdVuaVvgoyQS067AMuY2NDXLpKw2mxX3I9/6e9eotdqHoaX+o
         hwZbZsI8OhVZlpzoIg7+FL7o/pqKC+ysveFyIv4oi2jHQBHag+8Tpd8DVqiQpQTmgaIM
         5qIOnVktZMbdv6OlJLbu4DIAGLXj177kRPxqCMqv6Ri1dQ/DqL8NoDvljYu/K0J6IFEL
         pCTe5SU+H2zKzes2Xeuc0QE7wa4T65hDBqXwOJmgTd5P0OcrmgM7E5ZLRg9fFA7AZVWE
         cUzinw/wTNwQBKv2F1UhA0px6IRJW+sr6BjU34BmgMnUOrHJjCcAOhaLQtwPDkqnVTbl
         lepQ==
X-Forwarded-Encrypted: i=1; AJvYcCVryISfFF5lEhqG+w0NkoQzIcA/+0rfNofGjKkqz13DDyUPLdktYZypA0Mmu/cDSaA/DahLCgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXucZL8OLMNNSbGl+fewUn+Nzshb3SyOaBmUUAidld395ghwM
	gUR/grnhqf4jhYZCOPfna8NezatH1Tvi5GlCpvVoaZHZZvS5UJLa7yspe7BT2nTRUwE4DHEl6F/
	oNnBJg97MOgCjwApN+CqG+B7Qn6w=
X-Gm-Gg: ASbGnctyzbuqLVFFOTq7WvN/GOYSnuTboL2Q0YM8qL7gzpw21QXO7H7Bok8nnAUCg3o
	N5b3hEE45VULJAo36YaChkwPsP+Y3DK0DgMKh/1+dpMhTQszx4hVk6PkUC2R+tKwyjn7FKG5bew
	/hvI13FQkOx9IK9LiY4EK9rSuzEA==
X-Google-Smtp-Source: AGHT+IF7B0hCKteqyf9oiDWci0FIPMJKpi+4QvSGxqPZp7oDF27+wGEHbp9Pn4YM+Hfu+QemcYOYuseT++3IqDPYWtU=
X-Received: by 2002:a17:90b:4d8d:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-30151c5dfd6mr6661052a91.1.1742244856515; Mon, 17 Mar 2025
 13:54:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025031635-resent-sniff-676f@gregkh> <20250316160935.2407908-1-ojeda@kernel.org>
 <CANiq72mEexdcTSCJuc5SMwMQ3V+hLpV623WEqLNNB5jVRxH+Nw@mail.gmail.com>
 <2025031624-nuttiness-diabetic-eaad@gregkh> <CANiq72m9EcxPcaJ0M9Wb9HVjLEi+g2r59WR8=H7F+ikgQeYGHA@mail.gmail.com>
 <2025031729-dizziness-petunia-c01a@gregkh> <CANiq72kKDNzAtVu60AzcHtGhWm5x3oKGcHCh4tWGrhxeXYRKNA@mail.gmail.com>
In-Reply-To: <CANiq72kKDNzAtVu60AzcHtGhWm5x3oKGcHCh4tWGrhxeXYRKNA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Mar 2025 21:54:03 +0100
X-Gm-Features: AQ5f1JrAvsx_ShebhEqrj9IM-6eHlggaQWlSg9iYfF0itlnRcbwYwnTPRH_bKTU
Message-ID: <CANiq72=vBzBYkq617zpa2StEN9PYshG3cVPKjqC2-Q3KZSpEmw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<Box<T>>`
To: Greg KH <greg@kroah.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:39=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> So I reworded accordingly: I renamed `KBox` and `Box` in the title and

s/and/to/

Anyway, if the policy is to keep titles and original log intact even
in Option 3, I assume one should avoid [ ] comments in the log, and
only use the one-line-before-my-SoB style for [ ], since I assume you
keep the tags.

Cheers,
Miguel

