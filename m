Return-Path: <stable+bounces-38016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421128A0039
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 21:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733591C229EA
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 19:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC07180A6F;
	Wed, 10 Apr 2024 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeqkVP/Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA71134CC2
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775776; cv=none; b=VyZ+ax7wxMfMTl1zNYafUTVz4il01OZx89TB58FjGmT7Pj/L7eNN+ACNuz74RJnQn32xcfBPLobYWlROWq7IQFiD0RuToOFQrmdbo6JHNXiiBlc5z2xqZtqozj4pIlDEIuxtKEgpLuPpsTR1wK99yS5wsZjhEL97NchHwTg2+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775776; c=relaxed/simple;
	bh=rcson0HIWpMY/Eo7CQk/xSTDyifnEqHArIQzBD8MLGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pF6p1yUj4fM25jH6RyRQfuGVa2C0L/OnBit2/VKbIRH3TCy2hmYySoSepKRyhqi0dpUExB+F6Vy9SPSawms6vBFpsL8t76Y54VJybqN6o9RJSejE92ba7Y9v9oIR808ZqyRGZMqVgJEKyeIRyBJJOWV8Ch+gMNxi8NJ0GXHmKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeqkVP/Z; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso9999077a12.3
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712775772; x=1713380572; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fnTK0VljTiID9eF3fp8HQQoO6TG3murWizIgGbMC1jI=;
        b=YeqkVP/ZHUkm5RqBGPxZKXPmJZ/NIZ52guHYzYj+e2l2FYlyetZfHDt0KP4d5+U/s5
         IYDNAztCobDBPxTWQ+nLCADYiTGWpyvPD9kuxP4KYlUNHGCp5HdN5v6wG8wT3shTdXXs
         G5vZe0Ji5P+lPwNdTzGXMpYCNjRkPgbCR4Ps0lmtvsjZvi8xpXTmtILZ9nBbiBneQ49Y
         6FRrghDBKEnRZsH06ACYWoL2uOVeBDP0bH4c0ssTxvM03UGuYs5JaT9t20bzysQMup6T
         IEEP8APsfSExbF6OPRsMESnyXOeVlIpt8RoCBW4PYTOB7tWH41eaHlfg5aRXDTtwTYgF
         eEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775772; x=1713380572;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnTK0VljTiID9eF3fp8HQQoO6TG3murWizIgGbMC1jI=;
        b=Q6ey1G+BOl0lxPL+MHUUH7DOwbheVuVkjsSgqAz6s3EJeTTe7yJibYE3Z8yo0lH4Ap
         ycf9kYLtjDpehbt/ALVvgNcp7IuovSFghmRwkOmW9H4ZZDfD3eIqFJ1DqVD9W9fhXfVh
         sC3adDafv+ozeD9b6UoEKtomw1AwcQ2VBWhxpP4RwK64IJb/hlw+DT1BPwAerKTxDgbv
         wMIXvUgattjkPej7XgaxdYqexiCai2ha7Ai/7dOs4BlummDsjHRiaZLm+spDUef6Pi3G
         HfKD2f/eTW4dTkuUc3k6wMaPkhudQN8ePzBomcEGPHkew5OKIND6wRBgwu2xSU8BOS1F
         OLIA==
X-Gm-Message-State: AOJu0YxLPwJzcCA1F0FSRuechkQJcqMd1JbJUX78qXVQnQ2Eqj/3JXVa
	4XbZNjl/KoKF+3Xguv+VkPgQ9hGRCQ+97vbQvLqaX3bboRc2u+sxdSd09H03lzM=
X-Google-Smtp-Source: AGHT+IEcJPLwr463Wir3eQZDc7L+FRRobSqQ9mFH+CqCzCieSL3wmRcoITI0dHXDlABn0gdYcIn8Vg==
X-Received: by 2002:a50:9b1e:0:b0:56e:2daf:1ed9 with SMTP id o30-20020a509b1e000000b0056e2daf1ed9mr2688182edi.23.1712775772308;
        Wed, 10 Apr 2024 12:02:52 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id ee42-20020a056402292a00b0056e637f188fsm3657148edb.11.2024.04.10.12.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 12:02:51 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id DC4DFBE2EE8; Wed, 10 Apr 2024 21:02:50 +0200 (CEST)
Date: Wed, 10 Apr 2024 21:02:50 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Backport of 67c37756898a ("tty: n_gsm: require CAP_NET_ADMIN to
 attach N_GSM0710 ldisc") to older stable series? (at least 6.1.y)
Message-ID: <ZhbiWp9DexB_gJh_@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg, Sasha, Thadeu,

Today there was mentioning of 

https://www.jmpeax.dev/The-tale-of-a-GSM-Kernel-LPE.html

a LPE from the n_gsm module. I do realize, Thadeu mentioned the
possible attack surface already back in

https://lore.kernel.org/all/ZMuRoDbMcQrsCs3m@quatroqueijos.cascardo.eti.br/#t

Published exploits are referenced as well through the potential
initial finder in https://github.com/YuriiCrimson/ExploitGSM .

While 67c37756898a ("tty: n_gsm: require CAP_NET_ADMIN to attach
N_GSM0710 ldisc") is not the fix itself, it helps mitigating against
this issue.

Thus can you consider applying this still to the stable series as
needed? I think it should go at least back to 5.15.y but if
Iunderstood Thadeu correctly then even further back to the still
supported stable branches.

What do you think?

Regards,
Salvatore

