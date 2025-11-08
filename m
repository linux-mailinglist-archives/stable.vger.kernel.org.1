Return-Path: <stable+bounces-192783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5FFC42E45
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 15:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48E904E6DEA
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115B218ACC;
	Sat,  8 Nov 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZNQS4xX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F72135AD
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762612039; cv=none; b=YHJP6eN3GzQCP61WOSVT92C6FqY/5hGuOVK3Y8k2JbruZaW4o0/VJCYVM1YTPdLzfY9tTIrO4fHwCFvFRvj/Xaz3KWeOPXpcVOk9VNjkc4Y0Pn4dP1GHeIOC4ue2nScjN3WkSkZGYJgucoJlHbjcn9faMw7PkpYimArSR0Lei+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762612039; c=relaxed/simple;
	bh=W2pFAdrrujIHPH60g2LJ02jcJTeVppAEeFRsF4rS3KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMGUX1bcreK0w9TPvw1EUWmeD+6Cx+7FbiaSxMDhW1x68VPqUdlIV5YE/PThIhbBIHdRESMU49UKSrynBBNRcSuKTvUa71L+ij0OqOV91ZQfPOso68e0hfUXg9My5qd2mTwlQM644tesDljQOK4bkGLH+fBC6jbX0Ji0RPy0y6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZNQS4xX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE302C19424
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762612038;
	bh=W2pFAdrrujIHPH60g2LJ02jcJTeVppAEeFRsF4rS3KM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hZNQS4xX+FIAVnYnnCck3k8JxrZMxrNO8jc0eppIN2MPomZaVr5Tbb89T+0tiDyT7
	 OQuPynRttG1kdR756HZdNVMZyB06M4MEFWzn2giYRBEcc0GX8s3ms2OAdDPmFEAHwi
	 4nmZSLS5gLit9CxYf5DfXyeF1G93e5TJvDOxtNx757ny7N0hqLlhQrhuXm6td6Otgt
	 3vXvZslIkQqi17KyEEY7oJ1rCvpAYUyctcQd8fmhwu439SvCkPzR7cMUyzf66J6t4G
	 UAKmr3cwcWZ5E4XAIy128KXz8yKK+9VXiWJSk+jRwOw3vPJDkRC+siMO+eWebnYKfr
	 fVphX3zpmGNwQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b72dad1b713so157296666b.2
        for <stable@vger.kernel.org>; Sat, 08 Nov 2025 06:27:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGb2uVAtMJuzrwcSxyFZAXkiEqCuDVoZO9+clXTKi5KTUQ8BsYTK3po6dRTkW6G4fa+5/Sdus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1eAj/6y6Ul7dLRAn23fgfKLSiolMp2iQsxwkp8zooY/gdUfd4
	PuJgcgFKh0qxAAYKyYkJmtEuzZB5gLSRU4ESpYHPeYV+6isYEkBcUQGvVFUHAVMSf2tz/xto0qq
	rIaDrFc0NTChbml90Hb0MQiCtqXav9eU=
X-Google-Smtp-Source: AGHT+IGzJLXtfeICxHuo2c37wMR44TLkjQcvVzIEKwsxIzzxrYdpfnJXIT6ky3rohd4QuriYw5nnuuKSzxsfuLKz4bM=
X-Received: by 2002:a17:907:7fa6:b0:b72:b6ae:266 with SMTP id
 a640c23a62f3a-b72e036bc01mr219881866b.10.1762612037257; Sat, 08 Nov 2025
 06:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104141214.345175-1-pioooooooooip@gmail.com> <20251106065804.363242-1-pioooooooooip@gmail.com>
In-Reply-To: <20251106065804.363242-1-pioooooooooip@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 8 Nov 2025 23:27:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9q2fHmjNAydw_F=JNW_CzM-7XuUpc9_0iqt-0HsGOq6g@mail.gmail.com>
X-Gm-Features: AWmQ_bmQSGmN8Lsi82o0f6Q-0Upe4WhkBnWkazeGpnyQUJBdcFfFzEdQZE64-E4
Message-ID: <CAKYAXd9q2fHmjNAydw_F=JNW_CzM-7XuUpc9_0iqt-0HsGOq6g@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: clear 'encrypted' on encrypt_resp() failure to
 send plaintext error
To: Qianchang Zhao <pioooooooooip@gmail.com>
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, gregkh@linuxfoundation.org, 
	Zhitong Liu <liuzhitong1993@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 3:58=E2=80=AFPM Qianchang Zhao <pioooooooooip@gmail.=
com> wrote:
>
> When encrypt_resp() fails in the send path, we set STATUS_DATA_ERROR but
> leave work->encrypted true. The send path then still assumes a valid
> transform buffer and tries to build/send an encrypted reply.
>
> Clear work->encrypted on failure to force a plaintext error reply.
ksmbd will send a plain text error reply regardless of the
work->encrypted value.
It doesn't seem to make any sense to set this to false.
Thanks.

